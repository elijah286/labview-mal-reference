param(
    [string]$BuildDirectory = (Join-Path (Split-Path -Parent $PSScriptRoot) 'builds\Measurement Utility'),
    [switch]$DisableNIErrorReporting
)
$ErrorActionPreference = 'Stop'
$directory = (Resolve-Path -LiteralPath $BuildDirectory -ErrorAction Stop).Path.TrimEnd('\')
$executable = Join-Path $directory 'Measurement Utility.exe'
if (-not (Test-Path -LiteralPath $executable -PathType Leaf)) {
    throw "Build the root project's 'Measurement Utility EXE' specification first. Missing: $executable"
}
$plugins = @(
    'Simulated DMM.lvclass',
    'Simulated Function Generator.lvclass',
    'Simulated Scope.lvclass',
    'Standard Measurement.lvclass'
)
$support = Join-Path $directory 'data'
if (-not (Test-Path -LiteralPath $support -PathType Container)) {
    throw "The build's support directory is missing: $support"
}
$classes = @(Get-ChildItem -LiteralPath $support -Recurse -File -Filter '*.lvclass')
$paths = foreach ($name in $plugins) {
    $matches = @($classes | Where-Object Name -eq $name)
    if ($matches.Count -ne 1) {
        throw "Expected exactly one built '$name' under '$support'; found $($matches.Count). Rebuild into a clean output directory."
    }
    $matches[0].FullName.Substring($directory.Length + 1).Replace('\', '/')
}
if ($DisableNIErrorReporting) {
    $runtimeConfiguration = Join-Path $directory 'Measurement Utility.ini'
    $runtimeText = [System.IO.File]::ReadAllText($runtimeConfiguration)
    $sections = [regex]::Matches($runtimeText, '(?ims)^[ \t]*\[Measurement Utility\][ \t]*\r?\n(?<settings>.*?)(?=^[ \t]*\[|\z)')
    if ($sections.Count -ne 1) {
        throw "Expected exactly one [Measurement Utility] section in '$runtimeConfiguration'; found $($sections.Count)."
    }
    $settings = $sections[0].Groups['settings']
    $nier = [regex]::new('^[ \t]*NIER[ \t]*=[^\r\n]*(?:\r?\n|$)', [System.Text.RegularExpressions.RegexOptions]::Multiline -bor [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    if ($nier.Matches($settings.Value).Count -gt 1) {
        throw "Duplicate NIER settings in '$runtimeConfiguration'."
    }
    $line = 'NIER=False' + [Environment]::NewLine
    $updated = if ($nier.IsMatch($settings.Value)) { $nier.Replace($settings.Value, $line) } else { $line + $settings.Value }
    $runtimeText = $runtimeText.Substring(0, $settings.Index) + $updated + $runtimeText.Substring($settings.Index + $settings.Length)
    [System.IO.File]::WriteAllText($runtimeConfiguration, $runtimeText, [System.Text.UTF8Encoding]::new($false))
    Write-Host 'Disabled NI crash reporting for this EXE only; shared NI settings and application logging are unchanged.'
}
$configuration = @(
    '[General]',
    'HW Paths.<size(s)> = "3"',
    'FindMeasurementsInAppData = "FALSE"',
    'FindHardwareInAppData = "FALSE"',
    ('HW Paths 0 = "{0}"' -f $paths[0]),
    ('HW Paths 1 = "{0}"' -f $paths[1]),
    ('HW Paths 2 = "{0}"' -f $paths[2]),
    'Msmt Paths.<size(s)> = "1"',
    ('Msmt Paths 0 = "{0}"' -f $paths[3]),
    '',
    '[Server Settings]',
    'Context Name = "ServerController"',
    'Listener Port = "6341"'
)
$destination = Join-Path $directory 'Measurements.ini'
[System.IO.File]::WriteAllLines($destination, $configuration, [System.Text.UTF8Encoding]::new($false))
Write-Host "Prepared $executable"
Write-Host "Wrote portable, simulated-only plugin configuration: $destination"
Write-Host 'Distribute the entire build directory, not just the EXE. This is not a runtime/driver installer.'
