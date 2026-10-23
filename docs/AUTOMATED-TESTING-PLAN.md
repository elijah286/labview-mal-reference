# Automated Regression Testing Plan

## Recommendation And Scope

Use **Caraya for native LabVIEW tests**, executed headlessly by the **LabVIEW
CI/CD Toolkit in Windows containers on GitHub Actions**. Start with deterministic,
hardware-free tests, then add actor/network integration and built-application
acceptance. Keep physical-device qualification separate from pull-request gates.

This document is the implementation and maintenance roadmap. The
[first core suite](../tests/README.md) is now implemented: five native Caraya
tests and 24 passing assertions, verified locally through LabVIEWCLI and the
existing Toolkit runner. Windows-container/headless and clean-checkout validation
remain pending. The supported baseline is LabVIEW 2026, Windows x64.
Linux CI activities already exist, but they do not establish Linux
runtime support for this framework or its drivers.

Caraya is appropriate for assertions, hierarchical tests, and headless suite
reporting. It does not by itself supply hardware simulation, transport fault
injection, actor supervision, or a timeout that can interrupt a hung VI. Those
fixtures and process-level watchdogs must be part of the harness. Keep assertions
in test code initially; do not introduce a production dependency on Caraya.

## What The Repository Already Has

- [Toolkit installation manifest](../.github/labview-ci.yml): version 4.18.4,
  LabVIEW 2026, Windows/Linux activities, including unit tests.
- [Windows unit-test workflow](../.github/workflows/unit-tests-windows-container.yml):
  runs on `windows-2022`, launches the worker using Docker, mounts the checkout at
  `C:\workspace`, generates reports, uploads artifacts, publishes to Pages, and
  posts `CI / Unit Tests`.
- [Unit-test runner](../.github/labview/run-unit-tests.ps1) and
  [report builder](../.github/labview/build-unittest-report.py): existing execution
  and JUnit-reporting infrastructure to extend, not replace.
- [Tooling package manifest](../.github/labview/vipm/ci-tooling.packages.json):
  requests Caraya `1.4.4.148`. Requested installation is not proof that the
  resulting worker can load and execute it.
- [Measurement plugin repair evidence](MEASUREMENT-PLUGIN-REPAIR.md): native factory
  loading and a small buffered-data fixture were checked, including error 5100
  for an empty buffer and preservation of incoming error 73099. These checks
  need to become committed, repeatable tests.
- [Runtime status](../README.md#current-verification) and
  [dependency setup](../SOURCE-DEPENDENCIES.md): clean-checkout execution,
  acquisition/log readback, bounded shutdown, and executable deployment remain
  unverified. External NI dependencies are intentionally not all in Git.

### Initial Implementation And Remaining Gate Validation

- The manifest now enables `config.unitTests.tools.caraya`. The parser handles
  that nested schema and preserves command quoting; PowerShell harness tests
  cover both behavior and block boundaries.
- A repository-owned native suite runner uses the installed LabVIEWCLI `RunVI`
  connector contract, not speculative g-cli flags. Local Toolkit execution
  produces five suites and 24 passing assertions.
- The core wrapper deletes old reports, enforces a CLI deadline and checks the
  exact suite/assertion inventory. Runner errors, zero tests and partial results
  cannot produce a successful workflow status. Test/harness/config changes now
  trigger the Windows workflow.
- A disposable native bad-assertion fixture produced two failures. Report
  validation also rejects 16 negative report variants.
- **Still pending:** actual worker-image/headless execution, clean dependency
  resolution, a deliberately hung native run, container disposal, and end-to-end
  GitHub failure/status/artifact checks. The local watchdog stops its CLI process,
  not arbitrary LabVIEW execution. M0/M1 are only partially complete.

The core suite covers integer-array queue previews, not the planned three-waveform
aggregation fixture. Dynamic factories, network fault injection, reservations,
actor lifecycle and deployment remain backlog items, not covered contracts.

## Risk Register And Required Tests

The entries below identify failure hypotheses and acceptance contracts, not
confirmed defects in binary VI diagrams. XML class inventories and prior native
evidence identify the entry points; each VI still needs native diagram inspection
when its tests are authored.

| Priority / area | Likely failure | Initial targets | Required observations |
| --- | --- | --- | --- |
| P0: dynamic discovery | Missing directories, wrong ancestry, broken override/dependency, duplicate names, stale cross-links, incomplete installation | [Parse Paths and Directories for Classes](../source/framework/Controller/Parse%20Paths%20and%20Directories%20for%20Classes.vi), [Load Measurements from Disk](../source/framework/Controller/Methods/Load%20Measurements%20from%20Disk.vi), [Load Additional Measurement](../source/framework/Controller/Load%20Additional%20Measurement.vi) | Load a valid fixture from a runtime path absent from static test dependencies; reject/quarantine invalid entries with path and cause; no half-registered plugin or acquisition side effects; valid plugins remain usable. |
| P0: hardware selection | Wrong device type, wrong role/order, missing device, duplicate selection, resource contention | [Find and Validate Measurement and Device Selection](../source/framework/Controller/Methods/Find%20and%20Validate%20Measurement%20and%20Device%20Selection.vi), [Reserve Hardware for Measurement](../source/framework/Controller/Methods/Reserve%20Hardware%20for%20Measurement.vi), [Apply Device Order to Hardware Array](../source/framework/Hardware/Apply%20Device%20Order%20to%20Hardware%20Array.vi) | Match roles and types exactly; reject invalid requests before I/O; exclusive hardware has one owner; failure/stop releases reservations; queued work eventually advances. Test allowed multiplexing separately. |
| P0: actor lifecycle | Child fails before ready, lost ACK, dead enqueuer, duplicate Stop, orphaned actors or blocked waits | [Controller](../source/framework/Controller/Controller.lvclass), [Measurement](../source/framework/Measurement%20Actor/Measurement.lvclass), [Server Controller](../source/application/Server/Controller/Server%20Controller.lvclass) | Explicit ready/terminated observations; failed startup rolls back; Stop during each lifecycle phase terminates children and releases resources within a deadline; subsequent start works. A disappearing window is not termination evidence. |
| P0: buffered acquisition | Empty/released queue, missing channel buffers, stale samples, unexpected shape, error overwritten | [Standard Measurement](../source/plugins/measurements/Standard%20Measurement%20Plugin/Standard%20Measurement%20Plugin.lvlib), [Read Data from Buffer](../source/framework/Hardware/Read%20Data%20from%20Buffer.vi) | Exact samples, channels, timestamps and intervals; finite error on missing data; preserve incoming error; specify latest-data/consumption semantics; bounded behavior for queue capacities 1 and greater. |
| P0: network handshake | Unreachable server, occupied port, half-open peer, malformed GUID, missing/delayed ACK, disconnect during negotiation | [Initialize Listener](../source/application/Server/Listener/Initialize%20Listener.vi), [Send GUID to Server Listener](../source/application/Client/Client%20Controller/Send%20GUID%20to%20Server%20Listener.vi), [Wait for ACK from Client Proxy LNA](../source/application/Client/Client%20Controller/Wait%20for%20ACK%20from%20Client%20Proxy%20LNA.vi) | Every wait bounded; diagnostic identifies operation/peer; no phantom client registration; failed connection resources released; listener accepts a healthy peer afterward. |
| P0: network payloads | Partial TCP reads, combined frames, truncation, invalid length/type/class, incompatible serialized data | [Client LNA](../source/application/Client/Client%20LNA/Client%20LNA.lvlib), [Client Proxy LNA](../source/application/Server/Client%20Proxy%20LNA/Client%20Proxy%20LNA.lvlib), authorized LNA/TCP dependencies | Fragment/coalesce byte delivery, truncate/disconnect, inject invalid and over-limit payloads; obtain one correct message or an explicit bounded failure, never partial dispatch, unbounded allocation, or an indefinitely blocked actor. |
| P0: remote execution | Duplicate/replayed launch, lost completion, disconnect after work starts, wrong client/results association | [Run Measurement Remotely on Client](../source/application/Server/Controller/Run%20Measurement%20Remotely%20on%20Client.vi), [Receive Results Object](../source/application/Client/Client%20Controller/Receive%20Results%20Object.vi) | Correlate request, measurement and client IDs; distinguish accepted/running/completed from unknown outcome; no automatic duplicate execution; unrelated clients remain operational. |
| P1: plugin transfer | Corrupt/truncated ZIP, missing class closure, conflicting class version, unwritable temporary location, unsafe archive paths | [Zip up measurement definition](../source/application/Server/Controller/Zip%20up%20measurement%20definition.vi), [Unflatten Measurement Data and Store as Zip](../source/application/Client/Client%20Controller/Unflatten%20Measurement%20Data%20and%20Store%20as%20Zip.vi) | Round-trip a known plugin and dependencies; reject invalid transfer without activation; keep extraction inside a per-run directory; remove incomplete files; retain previously usable plugin. |
| P1: configuration | Historical absolute paths, missing/corrupt keys, invalid flattened classes, unsupported schema, invalid numeric settings | [Configuration](../source/configuration/Configuration.lvlib), [Step Configuration](../source/framework/Measurement%20Actor/Configuration/Step%20Configuration.lvclass) | Temporary portable configuration round-trips; validate before launch; report missing/unsupported data explicitly; no silent substitution of real hardware or mutation of supplied application settings. |
| P1: logging/results | Unwritable/full storage, file lock, disk error, loss at shutdown, waveform/metadata mismatch | [Logger](../source/framework/Logger/Logger.lvlib), [Logging](../source/framework/Logging/Logging.lvlib), [Results](../source/framework/Results/Result%20Actor.lvlib) | Write and independently reopen TDMS; verify channels, values, units, timing and measurement IDs; flush/close on Stop; persistence failure is visible; never advertise a missing log as saved. |
| P1: public API | Unknown measurement ID, invalid operation order, stopped controller, bad configuration, timeout | [Controller API](../source/api/controller/Controller%20API.lvlib) | Same validation/error contracts as local controller entry points; bounded responses; no success-shaped result for a rejected operation. Optional TestStand qualification comes later. |
| P1: deployment | Development machine satisfies missing dependencies; x86 DLL; dynamic plugin omitted from build | [Reference project](../Measurement%20Utility%20Reference.lvproj), built application and plugin output | Clean worker load and simulated run; explicit runtime dependency closure; packaged plugin discovered from deployment layout, not development paths; controlled process exit and readable log. |
| P2: UI/environment | Headless dialog, invalid user event/reference, UI masks failed initialization, discovery service unavailable | [Server UI](../source/application/Server/UI/Server%20UI.lvlib), [Generic UI Actor](../source/framework/User%20Interface/Generic%20UI%20Actor.lvlib) | Core suites need no panels/dialogs; initialization failures propagate without deadlock; desktop-only panel behavior tested separately; local operation does not require network discovery. |

For network tests, TCP delivers an ordered byte stream: test split/combined reads,
not fictitious TCP packet reordering. Application-message duplication, stale
responses and reconnect behavior are separate scenarios. First record the current
LNA framing/serialization contract, then inject faults at the appropriate layer.
Where transport code lives in an authorized external dependency, test through its
public boundary; add a minimal adapter only if needed for deterministic injection.

## Test Architecture

Proposed layout (to be created during implementation):

```text
tests\
  Measurement Utility Tests.lvproj
  unit\                 Pure logic, configuration, validation, buffer behavior
  contracts\            Shared hardware and measurement plugin conformance
  integration\          Actor lifecycle, loopback networking, TDMS
  fixtures\             Fake plugins, recording hardware, scripted peer, data
  runners\              Headless suite entry points and native harness helpers
```

- Give each test a stable ID and explicit arrange/act/assert/cleanup sequence.
  Use Caraya Define Test before assertions and a headless Define/Destroy Test Suite
  lifecycle. Return suite failure and runner infrastructure failure distinctly.
- Maintain an expected test-ID inventory per suite. Check discovered and executed
  IDs, not only a nonzero aggregate: losing half a suite must fail CI.
- Run independent cases even after a preceding assertion fails. Do not wire the
  first test's failed error cluster so that it bypasses the rest of the suite.
  Check expected application errors as data on a separate assertion path.
- Make recording/faulting hardware subclasses and a measurement fixture that can
  fail at initialize/configure/acquire/close, return known waveforms, and expose
  call order/counts. Use public dispatch interfaces; add only small testability
  seams where real coupling prevents isolation, preserving default behavior.
- Register queues, TCP connections, files, reservations, actors and temporary
  directories with fixture cleanup as they are created. Cleanup must execute
  even with an incoming error. Preserve the primary error and report cleanup
  errors too. Assert no remaining fixture-owned resources after each case.
- Use a temporary configuration and plugin directory per run. Never edit the
  checked-in application INI, shared driver settings, or developer device setup.
  Physical I/O is opt-in; a fake is not certification of a real driver.
- For dynamic-load tests, stage plugin classes outside the statically linked
  harness and launch in a fresh LabVIEW process where class caching could hide a
  failure. Verify loaded class identity and resolved paths. Keep deliberately
  broken fixtures outside normal mass-compile/build discovery.
- Use a scripted LabVIEW loopback peer with readiness signaling and an
  OS-assigned available port. Use events/queues and deadlines, not arbitrary
  sleeps. Bound payload size, retries, queue pressure, and test runtime.
- Actor tests use ready and final-ACK/termination evidence through public
  framework contracts or a minimal supervisory seam. On timeout, capture state
  and fail; do not label an aborted actor as successful cleanup.

### Reusable Plugin Conformance

Every new hardware or measurement plugin must supply a conformance entry point,
fixture configuration, required roles/types, supported environment/dependencies,
and expected fault behavior. Run the shared suite against each plugin, not merely
one representative subclass. Include a template-generated plugin in integration
tests so template drift is caught.

Hardware contracts cover initialize/configure/read-or-write/close, invalid
settings, timeout/error propagation, runtime-class preservation and repeat
initialization. Measurement contracts cover required hardware roles, valid and
invalid configuration, lifecycle order, data shape, result identity, buffering,
early Stop and cleanup after failure. Verify the Standard Measurement's three
roles explicitly: Cell Voltages, Pack Temperatures, and Something Else.

Do not mandate artificial success from abstract base methods or force every
driver to support the same optional capability. Declare supported capabilities
and make unsupported operations explicit. Document error codes/source and
cleanup/idempotency behavior while inspecting each native implementation.

## Toolkit And GitHub Container Integration

### 1. Prove The Harness And Environment First

Use the existing Toolkit Windows worker and workflow. Provision authorized
CVT/LNA/TCP dependencies, OpenG ZIP x64, required NI runtimes, Caraya and its
chosen runner at image build/setup time. Check package installation and native
load/execution; do not assume optional VIPM installation succeeded. Keep licensed
sources and credentials out of public artifacts and Git.

Pin the validated worker content tag/digest and package set for gating runs.
Record Toolkit version, image digest, LabVIEW build/bitness, package/driver
versions and source SHA in results. Test worker upgrades before repinning.
Use the repository's dependency preparation mechanism for excluded source and
test native resolution in a fresh checkout with no recovery/developer paths.

First execute one passing and one deliberately failing Caraya case in the real
container, then a deliberately hung child process. Confirm headless operation,
JUnit content, exit/status mapping and watchdog behavior. Verify or install the
actual Caraya CLI extension before adopting its command. If it is incompatible,
use a repository-owned native suite VI called through a validated Toolkit
command override/LabVIEW CLI operation. Do not invent CLI flags or maintain a
parallel CI system.

The intended configuration is `config.unitTests.tools.caraya` with
`enabled: true`, explicit nonoverlapping test locations and a validated `command`
only where necessary. Fix/test the parser against that schema first. Do not
enable whole-checkout recursive discovery, which could run historical examples,
intentional bad fixtures, or helper VIs twice.

### 2. Make The Gate Fail Closed

Extend the existing runner/workflow/reporting contract so the job **and**
`CI / Unit Tests` fail on:

- Missing tool, invalid configuration, broken/unloadable test, runner exception,
  nonzero runner result, process timeout, malformed/missing/stale JUnit, or a
  required suite that did not finish.
- Zero executed tests, missing expected test IDs, an unexpectedly skipped
  required case, assertion failure, teardown failure or leaked fixture resources.

Clean only the current run's output before execution. Produce structured
infrastructure errors as well as test failures. Reporting/publication must run
after test failure without converting it into success; upload raw JUnit and logs
with `always()` even when friendly-report generation fails. A successful report
page is not evidence of successful execution.

Test these branches with deliberate failure injection in the harness itself.
Verify the status is attached to the exact tested SHA, including pull requests
and manual dispatch; the existing workflow's checked-out SHA must match its
reported status. Decide explicitly whether PR merge results or head revisions
are gated. Fork PRs need a least-privilege execution/reporting path; do not run
untrusted PR code with privileged credentials to obtain status publication.

Include production/test VIs, classes, controls (`.ctl`), projects/libraries,
configuration, fixture data, dependency manifests, runner and workflow changes
in triggers. Require the stable unit-test check in branch protection once the
baseline passes; confirm it is emitted for every PR that requires it.

### 3. Separate Lanes And Bound Execution

Initial budgets below are acceptance targets, to calibrate on the actual worker;
they are not measured current behavior:

| Lane | When / environment | Initial execution budget, excluding image pull/setup |
| --- | --- | --- |
| Unit + plugin contracts | Every relevant PR; Windows container; no physical devices | 2 seconds per ordinary case; 5 minutes per suite |
| Actor/network/TDMS integration | Every relevant PR once stable; Windows container | 2-second injected I/O timeout; 5-second actor teardown; 10 minutes total |
| Repetition/fault matrix | Nightly or scheduled dispatch; Windows container | 50 start/stop and connect/disconnect cycles per selected scenario; 20 minutes total |
| Built-app/plugin smoke | Release and build/dependency changes; compatible clean Windows runtime environment | 10 minutes after build |
| Hardware and desktop UI | Manual/release; dedicated labeled runner, explicit devices | Device-specific limits; never an implicit public-container requirement |

Set both workflow `timeout-minutes` and a shorter per-suite child-process
watchdog. An assertion about elapsed time cannot rescue a VI that never returns.
After a hang, retain diagnostics, terminate only that test's process/container,
and run later suites in fresh processes. Do not kill unrelated LabVIEW sessions.
Avoid retries that turn a first failure green; record any diagnostic rerun
separately with its original failure.

Use the existing Toolkit JUnit merger, artifact upload, Pages dashboard and
commit status. Add case ID, duration, expected/actual error, failing operation,
plugin qualified name/path, fixture seed and correlation ID to diagnostics.
Sanitize configuration/logs; never publish acquired customer data or credentials.

Caraya's published documentation does not promise tests built into executables.
Keep Caraya in the development-environment worker and drive built-app acceptance
from outside the application, checking process outcome, results and logs.

## Ordered Implementation Backlog

| Milestone | Deliverable | Exit criterion |
| --- | --- | --- |
| M0: trustworthy harness | Validated worker/Caraya invocation, canonical config parser, suite inventory, watchdog and fail-closed Toolkit reporting | Passing fixture succeeds; failing, hung, undiscovered, broken and missing-tool/report fixtures all fail both job and status; raw artifacts survive failure; clean-checkout run uses no developer paths. |
| M1: first native regression slice | Committed Caraya project, deterministic fixtures, buffered-data and incoming-error tests | Reproduce three waveforms with samples `[1,2,3,4]` and 1 ms intervals; empty buffer gives 5100 within the deadline; incoming 73099 preserved with no acquisition side effects; all resources released. |
| M2: plugin/HAL contracts | Runtime-path plugin fixture, shared conformance suite, template-generated sample | Valid plugin loads; wrong ancestor, missing dependency, duplicate identity and missing required role are rejected diagnostically; resource contention and failure rollback covered. |
| M3: lifecycle and persistence | Headless actor supervisor fixtures, recording hardware, temporary config and TDMS fixtures | Stop before ready/during configure/acquire/after fault is bounded; repeat start succeeds; data is read back exactly; write failure is observable; nightly 50-cycle checks leave no fixture resources. |
| M4: communications | Scripted loopback peer, listener/client integration and serialization/transfer fixtures | Lost ACK, fragmentation, truncation, oversized/invalid payload, disconnect during launch and corrupt plugin transfer fail finitely; healthy peer still works; result/client association is correct. |
| M5: delivery and adoption | Built-app smoke, contributor checklist, required PR check, nightly lane | Packaged dynamic plugin and simulated acquisition/TDMS pass from clean deployment paths; every registered plugin has a shared-contract result; branch protection and report links verified. |

M0 precedes all gating; M1 establishes a small useful baseline before expanding.
M2 and M3 build on its fixtures. M4 needs validated dependency and lifecycle
behavior. M5 requires those contracts, but hardware-specific qualification can
remain an independent opt-in lane. Do not defer all useful tests until full
application automation is available.

### First PR-Suite Test Inventory

Start with these named scenarios, splitting parameterized cases into stable IDs:

1. Standard buffered data matches samples, timing and three-channel order.
2. Empty buffer returns 5100 finitely.
3. Incoming 73099 is preserved and no hardware operation starts.
4. Valid plugin loads dynamically from an isolated runtime directory.
5. Wrong ancestor and missing dependency fail without registration.
6. Duplicate plugin identity is reported deterministically.
7. Required hardware roles/types and explicit ordering are validated.
8. Exclusive reservation contention and rollback do not leak ownership.
9. Failed actor startup and normal Stop both produce termination evidence.
10. Configuration round-trip uses only temporary portable paths.
11. TDMS round-trip verifies actual data; unwritable output is reported.
12. Missing ACK and peer disconnect are bounded and allow a healthy reconnect.

### First Cases To Author In Caraya

Start with the following executable specifications. IDs identify scenarios,
not assertion counts. The fixture must own all objects it creates; failed
assertions must not bypass cleanup. The two-second case deadline is enforced by
the harness, not by an assertion after a potentially blocked call.

| ID | Arrange / act | Assertions |
| --- | --- | --- |
| `BUF-001` | Construct the Standard Measurement and three fixture-owned buffers. Supply distinguishable known waveforms, including `[1,2,3,4]` with `dt = 0.001`; invoke buffered-data reading. | No error; exactly three expected waveforms in the expected channel order; sample arrays, `t0` and `dt` unchanged; concrete measurement class preserved; buffers released by teardown. Use different channel values so a channel swap cannot pass. |
| `BUF-002` | Construct valid empty buffers; request buffered data. | Error 5100 before the case deadline; no successful-data publication or acquisition side effect; cleanup completes. Check error status and code, with a meaningful source, not only a nonzero code. |
| `BUF-003` | Supply incoming error 73099 with a distinctive source string; invoke acquisition using recording fixture dependencies. | Incoming status/code/source preserved; no hardware acquisition or actor launch; no new resource ownership. Keep the expected application error separate from Caraya's assertion error chain. |
| `BUF-004` | Read a valid waveform set, then exercise the documented empty-buffer failure path on the resulting measurement. | Error remains observable; a failed read cannot publish the preceding successful data as a new successful acquisition. Native inspection must establish whether stored latest data is retained or cleared; assert that contract separately. |
| `PLG-001` | Stage a valid fixture plugin in a temporary directory outside the statically linked test hierarchy; discover/load it in a fresh application instance. | Qualified class identity and resolved path match the staged fixture; one registry entry; no device initialization merely from discovery. |
| `PLG-002` | Stage a class with the wrong parent alongside the valid fixture; perform discovery. | Invalid class is not registered; its path and failure cause are observable; valid fixture remains discoverable; no actors/hardware started. |
| `PLG-003` | Stage a plugin with one required dependency deliberately absent, using a fresh process so cached classes cannot satisfy it. | Explicit load failure, no partial registration or leaked references; report names the failing plugin/dependency where LabVIEW exposes it. |
| `HAL-001` | Use three recording fake devices satisfying Cell Voltages, Pack Temperatures and Something Else; submit them in a deliberately shuffled order. | Selection validates and mapping/order matches the measurement's declared roles; no substitution; validation itself performs no device I/O. |
| `HAL-002` | Parameterize one missing role and one wrong-type device per required role. | Each invalid selection is rejected before configure/acquire; no reservation remains after rejection; diagnostic identifies the unsatisfied requirement. |
| `HAL-003` | Reserve one exclusive fake device for measurement A; request it for B; complete/stop A and process B. | No overlapping ownership or I/O; B is queued or explicitly rejected according to the documented controller contract; release makes the device available again. Do not accept an unspecified mixture of both behaviors. |

Before those application tests gate PRs, add harness probes: `HAR-001` passes,
`HAR-002` intentionally fails an assertion, and `HAR-003` intentionally hangs in
an isolated child process. Also simulate missing discovery, missing/malformed
JUnit and missing tooling. Run these as harness-validation scenarios, not as
permanently failing cases inside the ordinary regression suite. They prove that
an incorrect or absent test cannot produce a green status.

Inspect the native method diagrams while authoring each case, record existing
behavior, and resolve any contract ambiguity explicitly. In particular, do not
invent error numbers for invalid plugins/hardware or assert a generic simulated
DMM satisfies the Standard Measurement's roles. Introduce a narrowly scoped
recording fake or adapter only where current public interfaces cannot expose the
required observation.

Known legacy behavior may initially fail these contracts. Capture the failure,
triage it and make surgical production fixes with regression tests. Keep any
temporary quarantine visible with an owner and expiry; never redefine a hang,
silent error or omitted suite as a pass simply to establish a green baseline.

## Ongoing Maintenance And Definition Of Done

- Every plugin PR runs shared conformance plus its own success, invalid-input,
  injected-fault and cleanup tests. Every bug fix adds a reproducer.
- Review changes to public connectors, ancestry, messages, flattened data,
  configuration and package closure for backward-compatibility tests. Store
  small versioned serialization fixtures generated natively; do not hand-edit
  flattened LabVIEW class strings.
- Separate deterministic fake tests from actual driver tests. Re-run the latter
  when driver/runtime versions change; simulation cannot validate physical timing,
  electrical behavior or real disconnect handling.
- Track required risk scenarios, executed IDs, failures, skips, durations and
  flakiness. Do not claim diagram/branch coverage from assertion counts or VI
  Analyzer results. Start with explicit risk coverage rather than a fabricated
  percentage target.
- Accept each milestone only with reproducible local/native and container
  evidence, stable IDs, finite deadlines, verified cleanup, retained diagnostics
  and documented fixture setup. Preserve execution evidence for release SHAs.
- Coordinate changes to installed Toolkit files with upstream updates so a
  reconfiguration cannot silently restore zero-test success or erase local gates.
  Keep repository suites/configuration distinct from generated Toolkit tooling.

## References

- [Caraya usage and headless suite lifecycle](https://github.com/JKISoftware/Caraya#automated-tests).
- [LabVIEW CI/CD Toolkit](https://github.com/ni/LabVIEW-CI-CD-Toolkit);
  this checkout records `v4.18.4`. Local installed scripts are the basis for the
  integration gaps above, not an assumption about later upstream versions.
- [Toolkit VIPM worker setup](../.github/labview/vipm/README.md).
- [Source dependency and licensing requirements](../SOURCE-DEPENDENCIES.md).
