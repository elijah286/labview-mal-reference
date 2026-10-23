param(
    [Parameter(Mandatory = $true)][string]$ReportPath,
    [string]$InventoryPath = (Join-Path $PSScriptRoot 'expected-core-tests.json')
)
$ErrorActionPreference = 'Stop'
$settings = New-Object System.Xml.XmlReaderSettings
$settings.DtdProcessing = [System.Xml.DtdProcessing]::Prohibit
$settings.XmlResolver = $null
$reader = [System.Xml.XmlReader]::Create($ReportPath, $settings)
try {
    $report = New-Object System.Xml.XmlDocument
    $report.XmlResolver = $null
    $report.Load($reader)
} finally { $reader.Dispose() }

$inventory = Get-Content -LiteralPath $InventoryPath -Raw | ConvertFrom-Json
$expected = @($inventory.PSObject.Properties | ForEach-Object {
    $suite = $_.Name
    $_.Value | ForEach-Object { "$suite/$_" }
})
if ($expected.Count -eq 0 -or @($expected | Select-Object -Unique).Count -ne $expected.Count) {
    throw 'Expected test inventory is empty or contains duplicates.'
}
if ($report.DocumentElement.Name -ne 'testsuites') { throw 'Expected a Caraya testsuites document.' }
$suites = @($report.SelectNodes('/testsuites/testsuite'))
if ($suites.Count -ne @($inventory.PSObject.Properties).Count) { throw 'Missing or unexpected test suites.' }
$actual = @()
foreach ($suite in $suites) {
    $cases = @($suite.SelectNodes('./testcase'))
    if ($cases.Count -eq 0 -or [int]$suite.GetAttribute('tests') -ne $cases.Count) {
        throw "Empty suite or inconsistent test count: $($suite.GetAttribute('name'))"
    }
    foreach ($attribute in @('failures', 'errors', 'skipped')) {
        $value = $suite.GetAttribute($attribute)
        if ($value -and [int]$value -ne 0) { throw "Suite has ${attribute}: $($suite.GetAttribute('name'))" }
    }
    foreach ($case in $cases) {
        if ($case.SelectNodes('./failure|./error|./skipped').Count -gt 0) {
            throw "Non-passing assertion: $($case.GetAttribute('name'))"
        }
        $actual += "$($suite.GetAttribute('name'))/$($case.GetAttribute('name'))"
    }
}
if ($actual.Count -ne $expected.Count -or
    @($actual | Select-Object -Unique).Count -ne $actual.Count -or
    @(Compare-Object -ReferenceObject $expected -DifferenceObject $actual -CaseSensitive).Count -ne 0) {
    throw 'Assertion inventory mismatch (missing, duplicate, renamed or unexpected assertions).'
}
Write-Host "Caraya core suite: $($suites.Count) suites, $($actual.Count) assertions passed."
