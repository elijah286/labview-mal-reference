param([string]$RepositoryRoot, [switch]$CheckOnly)

$ErrorActionPreference = 'Stop'
if (-not $RepositoryRoot) {
    if (-not $PSScriptRoot) { throw 'Pass RepositoryRoot when invoking this script through a scriptblock.' }
    $RepositoryRoot = Split-Path -Parent $PSScriptRoot
}
$RepositoryRoot = [IO.Path]::GetFullPath($RepositoryRoot).TrimEnd('\')
$snapshotPath = Join-Path $RepositoryRoot 'evidence\source-copy.json'
$githubSnapshotPath = Join-Path $RepositoryRoot 'evidence\github-sources.json'
$deltaPath = Join-Path $RepositoryRoot 'docs\source-delta.json'
$layoutPath = Join-Path $RepositoryRoot 'docs\source-layout-map.json'
$layoutMoves = if (Test-Path -LiteralPath $layoutPath) { (Get-Content -LiteralPath $layoutPath -Raw | ConvertFrom-Json).moves } else { @() }

function Get-CurrentLayoutPath([string]$Path) {
    foreach ($move in $layoutMoves) {
        if ($Path -eq $move.from -or $Path.StartsWith($move.from + '/', [StringComparison]::OrdinalIgnoreCase)) {
            return $move.to + $Path.Substring($move.from.Length)
        }
    }
    return $Path
}

function Get-FileDigest([string]$Path) {
    $nativePath = if ($Path.StartsWith('\\?\')) { $Path } else { '\\?\' + $Path }
    $stream = [IO.File]::OpenRead($nativePath)
    $algorithm = [Security.Cryptography.SHA256]::Create()
    try { return ([BitConverter]::ToString($algorithm.ComputeHash($stream))).Replace('-', '') }
    finally { $stream.Dispose(); $algorithm.Dispose() }
}

function Get-RelativeSourcePath([string]$Path) {
    $prefix = $RepositoryRoot + '\'
    if (-not $Path.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw 'Snapshot member is outside the specified reference root.'
    }
    return $Path.Substring($prefix.Length).Replace('\', '/')
}

function Test-LocalArtifact([string]$Path) {
    return $Path -match '(?i)(\.UserState/|(^|/)(builds|logs)/|\.(aliases|lvlps|lvuser|lvps|vipc|vip|exe|zip|tdms|tdms_index)$|(^|/)(Thumbs\.db|Desktop\.ini|\.DS_Store)$)'
}

$baseline = @{}
$snapshotOrigin = 'initial-local-and-pinned-archive-snapshots'
if ((Test-Path -LiteralPath $snapshotPath) -and (Test-Path -LiteralPath $githubSnapshotPath)) {
    $snapshot = Get-Content -LiteralPath $snapshotPath -Raw | ConvertFrom-Json
    foreach ($record in $snapshot.files) {
        $relativePath = Get-CurrentLayoutPath ('components/' + $record.repository + '/' + $record.relativePath.Replace('\', '/'))
        if (-not (Test-LocalArtifact $relativePath)) { $baseline[$relativePath] = $record.sha256 }
    }
    $githubSnapshots = Get-Content -LiteralPath $githubSnapshotPath -Raw | ConvertFrom-Json
    foreach ($repository in $githubSnapshots) {
        foreach ($record in $repository.files) {
            $relativePath = Get-CurrentLayoutPath (Get-RelativeSourcePath $record.path)
            if (-not (Test-LocalArtifact $relativePath)) { $baseline[$relativePath] = $record.sha256 }
        }
    }
} elseif (Test-Path -LiteralPath $deltaPath) {
    $previousDelta = Get-Content -LiteralPath $deltaPath -Raw | ConvertFrom-Json
    foreach ($record in $previousDelta.files) {
        $relativePath = Get-CurrentLayoutPath $record.path
        if ($record.beforeSha256 -and -not (Test-LocalArtifact $relativePath)) { $baseline[$relativePath] = $record.beforeSha256 }
    }
    $snapshotOrigin = 'retained-relative-baseline-from-source-delta'
} else { throw 'No recorded baseline available; refusing to invent a source comparison.' }

$current = @{}
$sourceRoots = if ($layoutMoves.Count) { @('source', 'templates', 'provenance/upstream') } else { @('components') }
foreach ($sourceRoot in $sourceRoots) {
    $directory = Join-Path $RepositoryRoot $sourceRoot
    if (-not (Test-Path -LiteralPath $directory)) { continue }
    foreach ($file in Get-ChildItem -LiteralPath $directory -Recurse -File) {
        $relativePath = Get-RelativeSourcePath $file.FullName
        if (-not (Test-LocalArtifact $relativePath)) { $current[$relativePath] = Get-FileDigest $file.FullName }
    }
}
$paths = @(@($baseline.Keys) + @($current.Keys) | Sort-Object -Unique)
$records = @(
    foreach ($relativePath in $paths) {
        $before = $baseline[$relativePath]
        $after = $current[$relativePath]
        $change = if (-not $before) { 'added' } elseif (-not $after) { 'missing' } elseif ($before -ne $after) { 'changed' } else { 'unchanged' }
        [pscustomobject][ordered]@{path=$relativePath;change=$change;beforeSha256=$before;currentSha256=$after}
    }
)
$summary = [ordered]@{}
foreach ($change in @('added','changed','missing','unchanged')) {
    $summary[$change] = @($records | Where-Object {$_.change -eq $change}).Count
}
$report = [ordered]@{
    schemaVersion = 1
    recordedAtUtc = [DateTime]::UtcNow.ToString('o')
    scope = 'Application/framework/plugin source, templates and upstream provenance, excluding personal IDE state and package archives'
    baselineOrigin = $snapshotOrigin
    caveat = 'Disk snapshot only; unsaved IDE edits and causal attribution are not established by hashes.'
    summary = $summary
    files = $records
}
if (-not $CheckOnly) {
    $report | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $deltaPath -Encoding UTF8
    $lines = New-Object 'Collections.Generic.List[string]'
    $lines.Add('# Source Delta Inventory')
    $lines.Add('')
    $lines.Add('Generated disk comparison against the recorded local-source and pinned-archive snapshots.')
    $lines.Add('Native VI hashes show differences, not their meaning; use CHANGES.md and native review for attribution.')
    $lines.Add('Personal IDE state and package archives are excluded. Unsaved IDE edits are not represented.')
    $lines.Add('')
    $lines.Add(('Added: {0}; changed: {1}; missing: {2}; unchanged: {3}.' -f $summary.added,$summary.changed,$summary.missing,$summary.unchanged))
    $lines.Add('Full before/current SHA256 records: [source-delta.json](source-delta.json).')
    $lines.Add('')
    $lines.Add('| Change | Repository-Relative Path |')
    $lines.Add('| --- | --- |')
    foreach ($record in $records | Where-Object {$_.change -ne 'unchanged'}) {
        $lines.Add(('| {0} | {1} |' -f $record.change,$record.path.Replace('|','&#124;')))
    }
    $lines | Set-Content -LiteralPath (Join-Path $RepositoryRoot 'docs\SOURCE-DELTA.md') -Encoding UTF8
}

$findings = New-Object 'Collections.Generic.List[string]'
foreach ($relativeDocument in @('README.md','CHANGES.md','THIRD-PARTY-NOTICES.md','SOURCE-DEPENDENCIES.md','docs\PUBLICATION.md','docs\SOURCE-LAYOUT.md','docs\MEASUREMENT-PLUGIN-REPAIR.md')) {
    $documentPath = Join-Path $RepositoryRoot $relativeDocument
    $text = Get-Content -LiteralPath $documentPath -Raw
    foreach ($match in [regex]::Matches($text, '\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value
        if ($target -match '^(https?://|#)') { continue }
        $target = [Uri]::UnescapeDataString(($target -split '#',2)[0])
        if (-not (Test-Path -LiteralPath (Join-Path (Split-Path -Parent $documentPath) $target))) {
            throw ('Broken documentation link: ' + $relativeDocument + ' -> ' + $target)
        }
    }
}
[xml]$project = Get-Content -LiteralPath (Join-Path $RepositoryRoot 'Measurement Utility Reference.lvproj') -Raw
foreach ($item in $project.SelectNodes('//Item[@URL]')) {
    $url = $item.GetAttribute('URL')
    if ($url -match '(?i)(AppData/Local/Temp|LabVIEW-Projects/MCP Test1|(^|/)recovery/)') {
        $findings.Add(('Project item is machine-local or ignored: {0} -> {1}' -f $item.GetAttribute('Name'),$url))
    }
}
$cvtNotice = Join-Path $RepositoryRoot 'vendor\package-notices\ni_lib_cvt\license'
if (Test-Path -LiteralPath $cvtNotice) {
    $notice = Get-Content -LiteralPath $cvtNotice -Raw
    if ($notice -match 'Any source code provided by NI to You is confidential') {
        $ignorePath = Join-Path $RepositoryRoot '.gitignore'
        $rules = @(Get-Content -LiteralPath $ignorePath | ForEach-Object {$_.Trim()})
        foreach ($excluded in @('vendor/labview/vi.lib/', 'vendor/labview/project/', 'vendor/labview/examples/')) {
            if ($rules -notcontains $excluded) { $findings.Add('Missing recovered NI source exclusion: ' + $excluded) }
        }
    }
}
if (@($records | Where-Object {$_.path -match 'Create Stop Event After Fault\.vi$'}).Count -ne 1) {
    $findings.Add('Expected new shutdown-event helper is missing or ambiguous in the component inventory.')
}
Write-Output ('Source inventory: ' + ($summary | ConvertTo-Json -Compress))
Write-Output 'PASS: source hashes and documentation relative links checked. This is not native runtime validation.'
foreach ($finding in $findings) { Write-Output ('PUBLICATION BLOCKER: ' + $finding) }
if ($findings.Count) { throw ('PUBLICATION HELD: {0} recorded findings; no source upload performed.' -f $findings.Count) }