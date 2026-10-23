# Core Caraya Regression Tests

## Verified Baseline

Five native LabVIEW tests, **24 assertions**, pass locally with LabVIEW
26.3.1f1 (2026 x64) and Caraya **1.4.4.148**. The same suite passes through
the repository's LabVIEW CI/CD Toolkit runner and installed LabVIEWCLI `RunVI`
operation. No MCP server, code generator, Python, or g-cli is required to run it.

**GitHub Windows-container/headless execution and clean-checkout dependency
resolution are not yet verified.** Local execution reused the installed development
environment; it is not proof that the worker image contains every dependency.

## Coverage

| Native test | IDs | Assertions | Contract exercised |
|---|---|---:|---|
| [Incoming measurement error](unit/Test%20Incoming%20Measurement%20Error.vi) | `BUF-003` | 3 | Standard Measurement buffered read preserves incoming error status, code 73099 and distinctive source. |
| [Plugin requirements](unit/Test%20Plugin%20Requirements.vi) | `PLG-ROLE-001` | 2 | Standard Measurement reports the exact ordered roles: Cell Voltages, Pack Temperatures, Something Else; no error. |
| [Measurement iterations](unit/Test%20Measurement%20Iterations.vi) | `ITER-001` through `ITER-003` | 7 | Increment once, not done before limit, done exactly at limit; reset preserves desired count and GUID, clears current count; no error. |
| [Buffer preview](unit/Test%20Buffer%20Preview.vi) | `HAL-BUF-001` | 7 | Hardware buffer read returns `[11,22,33,44]`, repeated preview returns identical data without consuming the queued element; reads, queue status and release succeed. |
| [Empty hardware buffer](unit/Test%20Empty%20Hardware%20Buffer.vi) | `BUF-002` | 5 | A valid empty queue produces error 5100, stays empty, and can be inspected and released successfully. |

Tests call production methods, not replicas of their logic. Each queue fixture
owns and releases its queue even after the expected application error. Caraya
assertions do not share that expected-error wire or depend on earlier assertions
passing. No actors, network listeners or physical hardware are launched.

The [test-only subclass](fixtures/Measurement%20Test%20Harness/Measurement%20Test%20Harness.lvclass)
owns the iteration test so it can call protected methods without changing
production visibility. Its native `Read Compatible Hardware Types` override
satisfies the abstract parent-class contract; the suite does not acquire hardware.

This slice does **not** yet cover three-waveform aggregation, full buffer writes,
bounded queue overflow, dynamic factory loading, plugin conformance, reservations,
actor shutdown, malformed network messages, TCP disconnects, or TDMS readback.
Error preservation alone does not prove absence of acquisition side effects.
See the [risk register and implementation backlog](../docs/AUTOMATED-TESTING-PLAN.md).

## Run Locally

Install the framework's [source dependencies](../SOURCE-DEPENDENCIES.md),
LabVIEW 2026 x64, LabVIEWCLI, and Caraya 1.4.4.148 into that LabVIEW installation.
Enable the local TCP VI Server on port 3363, or supply `-PortNumber`.

From the repository root in PowerShell:

```powershell
.\tests\Invoke-CoreTests.ps1
```

Paths can be overridden with `-LabVIEWPath` and `-CliPath`. Use `-ResultsPath`
to retain a report elsewhere and `-TimeoutSeconds` to override the 180-second
CLI deadline. Concurrent wrapper runs against one checkout are rejected.

Alternatively, open [Measurement Utility Tests.lvproj](Measurement%20Utility%20Tests.lvproj)
and run [Run Tests.vi](Run%20Tests.vi). It supplies an explicit five-test inventory
to Caraya, disables the interactive results dialog, and constructs paths relative
to itself. It writes `core-results.xml` next to the runner. When running manually,
also validate the report:

```powershell
.\tests\Assert-CoreReport.ps1 -ReportPath .\tests\core-results.xml
```

Do not rely only on the VI finishing or the CLI exit code.

## Toolkit / GitHub Windows Containers

The existing [Toolkit manifest](../.github/labview-ci.yml) enables Caraya under
`config.unitTests.tools.caraya`, with the test location `tests` and a command
override calling [Invoke-CoreTests.ps1](Invoke-CoreTests.ps1).
The override uses LabVIEWCLI rather than unverified g-cli extension flags.
The native entry point has the connector required by the installed `RunVI`
operation: string-array input and integer/string outputs. Caraya errors map to
the CLI return code and message.

The [Windows workflow](../.github/workflows/unit-tests-windows-container.yml)
continues to launch the Toolkit runner inside the worker container. The override
passes `-Headless`; reports are copied to
`ci-out\unit-tests\results\caraya-0.xml` for the existing artifact/Pages pipeline.
Source, fixture, test script and test configuration changes trigger this workflow.

The wrapper deletes prior reports before invocation. It fails on CLI errors,
timeout, missing/malformed reports, failures, errors, skipped assertions, empty
suites, incorrect counts, or any mismatch with
[expected-core-tests.json](expected-core-tests.json). The workflow also fails
the job and `CI / Unit Tests` status if execution fails or zero tests are reported.
Raw JUnit is copied before validation when available, including on assertion failure.

The watchdog terminates **only the CLI process it started**. It cannot guarantee
that an in-process LabVIEW VI stops after a timeout: discard the disposable CI
container. Locally, investigate the owned run before rerunning; the wrapper does
not kill a user's LabVIEW session. Workflow time limits provide an outer bound.
Case-level actor/network watchdogs remain future work.

## Harness Checks And Maintenance

These checks need only Windows PowerShell, not LabVIEW:

```powershell
.\tests\Test-Harness.ps1
```

They validate a passing report, reject 16 invalid-report variants (including a
missing file, malformed XML, DTDs, missing/duplicate assertions, skips and
failures), and exercise the canonical nested Toolkit configuration parser,
command quoting and block boundaries.

Local native failure-path validation used a disposable bad-assertion fixture:
Caraya reported two failures, rather than silently succeeding. That fixture is
not part of the committed/discovered passing suite.
Separate local probes confirmed that the Toolkit rejects a runner exiting 7 and
a runner exiting 0 without JUnit. A synthetic sleeping CLI executable also proved
the wrapper's timeout, owned-process termination and stale-report deletion. This
does not establish cancellation of a hung native VI or container behavior.

When adding a test:

1. Add a native Caraya VI with stable assertion labels and explicit resource cleanup.
2. Add its path to the native runner, relative to the runner, exactly once.
3. Update the expected inventory and this coverage table in the same change.
4. Run both the native wrapper and harness checks. Verify the new assertion can
   fail, restore it, then rerun the green suite.
5. Verify the GitHub container result and preserve raw failure evidence before
   claiming the new contract is protected in CI.

Do not recursively discover every VI under `tests`: fixtures and the runner are
not independent tests. Keep Caraya out of production dependency declarations.
