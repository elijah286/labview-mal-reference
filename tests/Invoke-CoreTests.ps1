param(
    [string]$ResultsPath = (Join-Path $PSScriptRoot 'core-results.xml'),
    [string]$LabVIEWPath = 'C:\Program Files\National Instruments\LabVIEW 2026\LabVIEW.exe',
    [string]$CliPath = 'C:\Program Files (x86)\National Instruments\Shared\LabVIEW CLI\LabVIEWCLI.exe',
    [ValidateRange(1, 65535)][int]$PortNumber = 3363,
    [ValidateRange(1, 3600)][int]$TimeoutSeconds = 180,
    [switch]$Headless
)
$ErrorActionPreference = 'Stop'
$report = Join-Path $PSScriptRoot 'core-results.xml'
$runner = Join-Path $PSScriptRoot 'Run Tests.vi'
foreach ($path in @($CliPath, $LabVIEWPath, $runner)) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Required file missing: $path" }
}
$destination = [System.IO.Path]::GetFullPath($ResultsPath)
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
$lock = [System.IO.File]::Open((Join-Path $PSScriptRoot '.core-tests.lock'),
    [System.IO.FileMode]::OpenOrCreate, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)
try {
    if (Test-Path -LiteralPath $report) { Remove-Item -LiteralPath $report }
    if ($destination -ne $report -and (Test-Path -LiteralPath $destination)) {
        Remove-Item -LiteralPath $destination
    }
    $arguments = @('-OperationName', 'RunVI', '-VIPath', "`"$runner`"",
        '-LabVIEWPath', "`"$LabVIEWPath`"", '-PortNumber', $PortNumber,
        '-LogToConsole', 'TRUE')
    if ($Headless) { $arguments += '-Headless' }
    $process = Start-Process -FilePath $CliPath -ArgumentList $arguments -NoNewWindow -PassThru
    try {
        $null = $process.Handle
        if (-not $process.WaitForExit($TimeoutSeconds * 1000)) {
            Stop-Process -Id $process.Id -ErrorAction Stop
            throw "LabVIEW CLI timed out after $TimeoutSeconds seconds. Discard the CI container; the VI may still be running."
        }
        $process.WaitForExit()
        $process.Refresh()
        $exitCode = $process.ExitCode
    } finally { $process.Dispose() }
    if ((Test-Path -LiteralPath $report) -and $destination -ne $report) {
        Copy-Item -LiteralPath $report -Destination $destination -Force
    }
    if ($exitCode -ne 0) { throw "LabVIEW CLI failed with exit code $exitCode. See the CLI log and raw JUnit report." }
    & (Join-Path $PSScriptRoot 'Assert-CoreReport.ps1') -ReportPath $report
} finally { $lock.Dispose() }
