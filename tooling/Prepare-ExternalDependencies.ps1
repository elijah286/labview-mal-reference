[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$SourceRoot,
    [string]$RepositoryRoot,
    [switch]$CheckOnly
)

$ErrorActionPreference = 'Stop'
if (-not $RepositoryRoot) { $RepositoryRoot = Split-Path -Parent $PSScriptRoot }
$RepositoryRoot = [IO.Path]::GetFullPath($RepositoryRoot)
$SourceRoot = [IO.Path]::GetFullPath($SourceRoot).TrimEnd('\')
$destinationRoot = Join-Path $RepositoryRoot 'vendor\labview'
$folders = @('vi.lib\NI', 'vi.lib\National Instruments')
$required = @('vi.lib\NI\Current Value Table\Current Value Table.lvlib', 'vi.lib\NI\Actors\Linked Network Actor\Linked Network Actor.lvlib')
foreach ($entry in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $SourceRoot $entry) -PathType Leaf)) { throw ('Dependency entrypoint missing: ' + $entry) }
}
$files = @(
    foreach ($folder in $folders) {
        $sourceFolder = Join-Path $SourceRoot $folder
        if (Test-Path -LiteralPath $sourceFolder -PathType Container) { Get-ChildItem -LiteralPath $sourceFolder -Recurse -File }
    }
)
$plan = @(
    foreach ($file in $files) {
        $relative = $file.FullName.Substring($SourceRoot.Length + 1)
        $destination = Join-Path $destinationRoot $relative
        $exists = Test-Path -LiteralPath $destination
        if ($exists -and (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash) {
            throw ('Different dependency already present; no files copied: ' + $relative)
        }
        [pscustomobject]@{source=$file.FullName;destination=$destination;exists=$exists}
    }
)
if (-not $CheckOnly) {
    foreach ($entry in $plan) {
        if ($entry.exists) { continue }
        [void][IO.Directory]::CreateDirectory((Split-Path -Parent $entry.destination))
        Copy-Item -LiteralPath $entry.source -Destination $entry.destination
        if ((Get-FileHash -LiteralPath $entry.source -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $entry.destination -Algorithm SHA256).Hash) {
            throw ('Copied dependency hash mismatch: ' + $entry.destination)
        }
    }
}
Write-Output ('Checked {0} files; already present {1}; check-only {2}.' -f $plan.Count,@($plan | Where-Object exists).Count,$CheckOnly.IsPresent)
Write-Output 'No installers/shared libraries modified. Resolve native VI links in LabVIEW before running.'