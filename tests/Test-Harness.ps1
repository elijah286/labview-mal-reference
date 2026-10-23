$ErrorActionPreference = 'Stop'
$temporary = Join-Path ([System.IO.Path]::GetTempPath()) ("caraya-harness-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $temporary | Out-Null
try {
    $inventory = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'expected-core-tests.json') -Raw | ConvertFrom-Json
    $fixture = New-Object System.Xml.XmlDocument
    $null = $fixture.AppendChild($fixture.CreateElement('testsuites'))
    foreach ($entry in $inventory.PSObject.Properties) {
        $suite = $fixture.CreateElement('testsuite')
        $suite.SetAttribute('name', $entry.Name)
        $suite.SetAttribute('tests', [string]$entry.Value.Count)
        $suite.SetAttribute('failures', '0')
        $suite.SetAttribute('errors', '0')
        foreach ($name in $entry.Value) {
            $case = $fixture.CreateElement('testcase')
            $case.SetAttribute('name', $name)
            $null = $suite.AppendChild($case)
        }
        $null = $fixture.DocumentElement.AppendChild($suite)
    }
    $path = Join-Path $temporary 'report.xml'
    $fixture.Save($path)
    & (Join-Path $PSScriptRoot 'Assert-CoreReport.ps1') -ReportPath $path
    $mutations = [ordered]@{
        'zero suites' = { param($d) $d.DocumentElement.RemoveAll() }
        'missing suite' = { param($d) $null = $d.DocumentElement.RemoveChild($d.SelectSingleNode('//testsuite')) }
        'missing assertion' = { param($d) $n = $d.SelectSingleNode('//testcase'); $null = $n.ParentNode.RemoveChild($n) }
        'duplicate assertion' = { param($d) $n = $d.SelectSingleNode('//testcase'); $null = $n.ParentNode.AppendChild($n.CloneNode($true)) }
        'renamed assertion' = { param($d) $d.SelectSingleNode('//testcase').SetAttribute('name', 'wrong') }
        'failure element' = { param($d) $null = $d.SelectSingleNode('//testcase').AppendChild($d.CreateElement('failure')) }
        'error element' = { param($d) $null = $d.SelectSingleNode('//testcase').AppendChild($d.CreateElement('error')) }
        'skipped element' = { param($d) $null = $d.SelectSingleNode('//testcase').AppendChild($d.CreateElement('skipped')) }
        'failure count' = { param($d) $d.SelectSingleNode('//testsuite').SetAttribute('failures', '1') }
        'error count' = { param($d) $d.SelectSingleNode('//testsuite').SetAttribute('errors', '1') }
        'skipped count' = { param($d) $d.SelectSingleNode('//testsuite').SetAttribute('skipped', '1') }
        'incorrect count' = { param($d) $d.SelectSingleNode('//testsuite').SetAttribute('tests', '999') }
        'invalid count' = { param($d) $d.SelectSingleNode('//testsuite').SetAttribute('tests', 'invalid') }
    }
    foreach ($mutation in $mutations.GetEnumerator()) {
        $copy = $fixture.CloneNode($true)
        & $mutation.Value $copy
        $copy.Save($path)
        $rejected = $false
        try { & (Join-Path $PSScriptRoot 'Assert-CoreReport.ps1') -ReportPath $path }
        catch { $rejected = $true }
        if (-not $rejected) { throw "Validator accepted $($mutation.Key)." }
    }
    foreach ($bad in @('<testsuites>', '<!DOCTYPE testsuites [<!ENTITY x "bad">]><testsuites>&x;</testsuites>')) {
        Set-Content -LiteralPath $path -Value $bad
        $rejected = $false
        try { & (Join-Path $PSScriptRoot 'Assert-CoreReport.ps1') -ReportPath $path }
        catch { $rejected = $true }
        if (-not $rejected) { throw 'Validator accepted malformed XML or a DTD.' }
    }
    Remove-Item -LiteralPath $path
    $rejected = $false
    try { & (Join-Path $PSScriptRoot 'Assert-CoreReport.ps1') -ReportPath $path }
    catch { $rejected = $true }
    if (-not $rejected) { throw 'Validator accepted a missing report.' }

    $root = Split-Path -Parent $PSScriptRoot
    $runnerPath = Join-Path $root '.github\labview\run-unit-tests.ps1'
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($runnerPath, [ref]$null, [ref]$null)
    $function = $ast.Find({ param($n)
        $n -is [System.Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -eq 'Read-UnitTestTools'
    }, $true)
    . ([scriptblock]::Create($function.Extent.Text))
    $tools = Read-UnitTestTools (Join-Path $root '.github\labview-ci.yml')
    if ($tools.Count -ne 1 -or $tools[0].tool -ne 'caraya' -or
        $tools[0].locations[0] -ne 'tests' -or $tools[0].command -notmatch 'Invoke-CoreTests.ps1') {
        throw 'Canonical config.unitTests was not parsed correctly.'
    }
    $config = Join-Path $temporary 'config.yml'
    @'
config:
  unitTests:
    tools:
      caraya:
        enabled: true
        command: powershell -File "{dir}\Invoke-CoreTests.ps1"
        locations:
          - "tests"
      disabled:
        enabled: false
  unrelated:
    tools:
      not-a-test:
        enabled: true
'@ | Set-Content -LiteralPath $config
    $tools = Read-UnitTestTools $config
    if ($tools.Count -ne 1 -or $tools[0].tool -ne 'caraya' -or
        $tools[0].command -ne 'powershell -File "{dir}\Invoke-CoreTests.ps1"') {
        throw 'Parser crossed the unitTests boundary or damaged command quoting.'
    }
    Write-Host 'Harness checks passed: positive report, 16 rejected report variants, canonical config and block boundaries.'
} finally {
    Remove-Item -LiteralPath $temporary -Recurse -Force
}
