$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$prepare = Join-Path $root 'tooling\Prepare-MeasurementUtilityBuild.ps1'
$sourceConfiguration = Join-Path $root 'source\application\Measurements.ini'
$sourceHash = (Get-FileHash -LiteralPath $sourceConfiguration).Hash
$temporary = Join-Path ([System.IO.Path]::GetTempPath()) ('mur-build-tests-' + [guid]::NewGuid())
$plugins = @(
    'Simulated DMM.lvclass',
    'Simulated Function Generator.lvclass',
    'Simulated Scope.lvclass',
    'Standard Measurement.lvclass'
)
$runtimeText = "[Measurement Utility]`r`nserver.tcp.enabled=False`r`ncustom=value`r`n`r`n[Other]`r`nNIER=True`r`nkeep=yes`r`n"
$checks = 0

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
    $script:checks++
}

function New-Fixture([string]$Name) {
    $directory = Join-Path $temporary $Name
    $null = New-Item -ItemType Directory -Path (Join-Path $directory 'data')
    [System.IO.File]::WriteAllText((Join-Path $directory 'Measurement Utility.exe'), '')
    foreach ($plugin in $plugins) {
        [System.IO.File]::WriteAllText((Join-Path $directory "data\$plugin"), '')
    }
    [System.IO.File]::WriteAllText((Join-Path $directory 'Measurement Utility.ini'), $runtimeText)
    return $directory
}

function Assert-Rejected([string]$Directory, [string]$MessagePattern, [switch]$DisableNIErrorReporting) {
    $failure = $null
    try { & $prepare -BuildDirectory $Directory -DisableNIErrorReporting:$DisableNIErrorReporting }
    catch { $failure = $_ }
    Assert-True ($null -ne $failure -and $failure.ToString() -match $MessagePattern) "Expected rejection matching '$MessagePattern'; got '$failure'."
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $Directory 'Measurements.ini'))) 'An invalid build received a success-shaped plugin configuration.'
}

$null = New-Item -ItemType Directory -Path $temporary
try {
    $directory = New-Fixture 'portable'
    & $prepare -BuildDirectory $directory
    $configuration = [System.IO.File]::ReadAllText((Join-Path $directory 'Measurements.ini'))
    $paths = [regex]::Matches($configuration, '(?m)^(?:HW|Msmt) Paths \d = "([^"]+)"')
    Assert-True ($paths.Count -eq 4) 'Expected exactly four plugin paths.'
    foreach ($index in 0..3) {
        $path = $paths[$index].Groups[1].Value
        Assert-True ($path -eq ('data/' + $plugins[$index])) "Incorrect relative plugin path: $path"
        Assert-True (Test-Path -LiteralPath (Join-Path $directory $path.Replace('/', '\')) -PathType Leaf) "Plugin does not resolve: $path"
    }
    Assert-True ($configuration -match 'FindMeasurementsInAppData = "FALSE"' -and $configuration -match 'FindHardwareInAppData = "FALSE"') 'AppData discovery was not disabled.'
    Assert-True ($configuration -notmatch '\[Temp Monitor\]|Logger Config|Execution Settings') 'Source measurement presets leaked into the package.'
    $runtime = Join-Path $directory 'Measurement Utility.ini'
    Assert-True ([System.IO.File]::ReadAllText($runtime) -ceq $runtimeText) 'Default preparation modified runtime settings.'

    Remove-Item -LiteralPath $runtime
    & $prepare -BuildDirectory $directory
    Assert-True (-not (Test-Path -LiteralPath $runtime)) 'Default preparation created an application INI.'
    [System.IO.File]::WriteAllText($runtime, $runtimeText)
    & $prepare -BuildDirectory $directory -DisableNIErrorReporting
    $expected = $runtimeText.Replace("[Measurement Utility]`r`n", "[Measurement Utility]`r`nNIER=False`r`n")
    Assert-True ([System.IO.File]::ReadAllText($runtime) -ceq $expected) 'NIER insertion changed unrelated settings or sections.'
    & $prepare -BuildDirectory $directory -DisableNIErrorReporting
    Assert-True ([System.IO.File]::ReadAllText($runtime) -ceq $expected) 'NIER preparation is not idempotent.'
    foreach ($key in @('NIER=True', 'nier = True', '  NIER = True')) {
        [System.IO.File]::WriteAllText($runtime, $runtimeText.Replace("custom=value`r`n", "custom=value`r`n$key`r`n"))
        & $prepare -BuildDirectory $directory -DisableNIErrorReporting
        Assert-True ([System.IO.File]::ReadAllText($runtime) -ceq $runtimeText.Replace("custom=value`r`n", "custom=value`r`nNIER=False`r`n")) "Failed to replace '$key' without changing other sections."
    }
    [System.IO.File]::WriteAllText($runtime, $runtimeText.Replace('[Measurement Utility]', '[measurement utility]'))
    & $prepare -BuildDirectory $directory -DisableNIErrorReporting
    Assert-True ([System.IO.File]::ReadAllText($runtime) -ceq $expected.Replace('[Measurement Utility]', '[measurement utility]')) 'Application section matching is not case-insensitive.'

    $directory = New-Fixture 'missing-plugin'
    Remove-Item -LiteralPath (Join-Path $directory "data\$($plugins[0])")
    Assert-Rejected $directory 'Expected exactly one built.*found 0'
    $directory = New-Fixture 'duplicate-plugin'
    $null = New-Item -ItemType Directory -Path (Join-Path $directory 'data\duplicate')
    [System.IO.File]::WriteAllText((Join-Path $directory "data\duplicate\$($plugins[0])"), '')
    Assert-Rejected $directory 'Expected exactly one built.*found 2'
    $directory = New-Fixture 'missing-executable'
    Remove-Item -LiteralPath (Join-Path $directory 'Measurement Utility.exe')
    Assert-Rejected $directory 'Missing:'
    $directory = New-Fixture 'missing-support'
    Rename-Item -LiteralPath (Join-Path $directory 'data') -NewName 'not-data'
    Assert-Rejected $directory 'support directory is missing'
    $directory = New-Fixture 'missing-runtime-ini'
    Remove-Item -LiteralPath (Join-Path $directory 'Measurement Utility.ini')
    Assert-Rejected $directory 'Measurement Utility.ini' -DisableNIErrorReporting

    $invalidSettings = [ordered]@{
        'missing-section' = "[Other]`r`nNIER=True`r`n"
        'duplicate-section' = $runtimeText + "[Measurement Utility]`r`nNIER=True`r`n"
        'duplicate-section-case' = $runtimeText + "[measurement utility]`r`nNIER=True`r`n"
        'duplicate-nier' = $runtimeText.Replace("custom=value`r`n", "NIER=True`r`n  nier = False`r`n")
    }
    foreach ($entry in $invalidSettings.GetEnumerator()) {
        $directory = New-Fixture $entry.Key
        $runtime = Join-Path $directory 'Measurement Utility.ini'
        [System.IO.File]::WriteAllText($runtime, $entry.Value)
        $pattern = if ($entry.Key -eq 'duplicate-nier') { 'Duplicate NIER settings' } else { 'Expected exactly one.*section' }
        Assert-Rejected $directory $pattern -DisableNIErrorReporting
        Assert-True ([System.IO.File]::ReadAllText($runtime) -ceq $entry.Value) 'Rejected settings were modified.'
    }
    Assert-True ((Get-FileHash -LiteralPath $sourceConfiguration).Hash -eq $sourceHash) 'Preparation modified source Measurements.ini.'
    Write-Host "Build preparation checks passed: $checks assertions."
} finally {
    Remove-Item -LiteralPath $temporary -Recurse -Force
}
