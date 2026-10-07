# Changes From Upstream

This document identifies the baselines used to assemble this updated reference and
separates saved changes from runtime proof. It does not claim parity with the
NIWeek 2018 5.3 distribution or a complete modernization of every historical VI.

## Source Baselines

| Source | Recorded Revision | Use |
| --- | --- | --- |
| [HAL-MAL-Application](https://github.com/elijah286/HAL-MAL-Application) | eb3159c9df4435ce516614e132b18cc6d7fb8489 | Application/controller/UI examples |
| [MAL-Framework](https://github.com/elijah286/MAL-Framework) | 540237f1f43ecaf66b270921ba14ad5fa93db729 | Common framework and templates |
| [MAL-Framework-API](https://github.com/elijah286/MAL-Framework-API) | b4a05236f84b2c21ce65274b90fe99859cdc42cb | Controller integration API |
| [Extensible-Config-Dialog](https://github.com/elijah286/Extensible-Config-Dialog) | fa8d5e6042bc43c61b1745967a508a82e50207c9 | Configuration classes/dialogs |
| [GUID-API](https://github.com/elijah286/GUID-API) | 940ea14380ceff960bf6171224dc3cc64a84babf | GUID source |
| [Hardware](https://github.com/elijah286/Hardware) | 689f19916900d3d9fc665a8599f69486e889983e | DAQ and simulated instruments |
| [TestStand-MAL-API](https://github.com/elijah286/TestStand-MAL-API) | c01550b9549dc266cd64b0c4efe39f2eec4efd39 | Optional integration examples |

The first four were copied from local worktrees, not freshly cloned clean commits.
The initial 963-file SHA256 snapshot records exactly what was copied. Git revisions
were recorded later; the MAL-Framework worktree included a modified aliases file.
The other three repositories were obtained as pinned archives. See
[dependency-lock.json](dependency-lock.json) for archive hashes and recorded state.
Do not call the initial snapshot a byte-identical checkout of those seven commits.

## Organization And Links

- Added one consolidated source-navigation project; retained the component layout
  rather than merging or renaming same-name classes with different qualified owners.
- Repaired copied manifest member and containing-library paths in 135 manifests
  during recovery. The initial path-repair verification excluded only the intended
  fields when comparing XML. Later native saves are separate changes.
- Mapped 1058 installed-library manifest references to local source targets during
  the initial vendoring pass. This is historical scope, not a current portability
  guarantee: the present root project again lists temporary tools and recovery paths.
- Disabled the copied server launcher's Run When Opened setting. Opening source
  must not launch actors implicitly.
- Targeted LabVIEW 2026 x64. No change of original package version numbers is used
  to imply backward compatibility or compatibility with the separate 5.3 bundle.

## Saved Native Repairs

The subsequent Standard Measurement recovery adapts a legacy 5.3 measurement
plugin to this reference's current parent contract. It adds bounded buffered-data
reads and preserves runtime class before the mandatory acquisition parent call.
Native compiler, factory, synthetic-data, fault/timeout, saved-diagram and live
Step-menu checks passed. See [Measurement Plugin Repair](docs/MEASUREMENT-PLUGIN-REPAIR.md)
for exact changes and the remaining hardware, logging and lifecycle limits.

Paths in this table are relative to the repository root. Native backups were kept
locally before edits. Compilation checks were performed in the named reference
project, not inferred from an add-on application instance.

| Subject | Exact Change | Verification / Limit |
| --- | --- | --- |
| components/Hardware/DAQ/config/DAQ Configuration.lvclass and components/Hardware/DAQ/DAQ .lvclass | Added the classes to the Hardware.lvlib membership they already declared | Native ownership/compiler disagreement cleared |
| components/MAL-Framework/user.lib/Common Components/Hardware/HW Config/HW Configuration.vi | Recovered the missing native member from Common Components 4.0.4.62; no guessed stub or installed-library overwrite | Recovery SHA256 C5EB77F3C6B3E697667D4D383F9FEB0B8CF6F99E6861D6CB0B698CC8E60E8144; recovered length 20092 bytes |
| components/Hardware/DAQ/config/DAQ Configuration.lvclass | Appended string field IO Channels; retained existing fields/members | Configuration UI and read/store methods compiled; routing and persistence round-trip not established |
| HW Configuration.vi and DAQ configuration read/store methods | Temporarily rebound stale IPE selections and restored their intended IO Channels selection | Native connectors/event controls and surrounding wires retained |
| DAQ configure.vi | Replaced the missing legacy Read Configuration call with existing Read HW Config Class.vi after an exact unresolved-call guard | Native executable-state check passed |
| DAQ construct.vi | Replaced the missing legacy Write Configuration call with existing Write HW Config Class.vi; retained parent constructor chain | Constructor and DAQ class saved; selected 17-subject compiler check passed at that checkpoint |
| Logger actor/class and remote methods | Removed copied AMQP field and Skyline configure/upload/cleanup dependencies; retained local TDMS operations | Direct disabled remote requests return 73002; upload is not implemented by this update |
| ZIP builder | Replaced existing ZIP call with the installed OpenG ZIP Path instance | Native call/pane links passed; archive round-trip untested |
| Controller/Stop Core.vi | Replaced Send Disable UI with Send Normal Stop to the UI enqueuer | Saved and executable; not a complete shutdown proof |
| User Interface/Stop Core.vi | Removed immediate Destroy User Event after generating its stop notification | Matching after-join cleanup is still pending; this is a partial lifetime correction |
| Server/UI/Actor Core.vi and base Controller/Actor Core.vi | Inserted Register For Events into startup error-dataflow ordering | Both compiled; ordering alone did not resolve the reported startup failure |
| Controller/Create Stop Event After Fault.vi and Initialize.vi | Added fault-safe event creation using a fresh creation error input; merged the original initialization error first | Helper connector check passed; native helper diagram 526 x 169; full failure/cleanup path not verified |
| Controller/Scan for Devices on System.vi | Replaced nisyscfg Find Systems.vi with Initialize Session.vi for the same explicit local target; detected network-system list was unused | One native swap, no lost wires reported; fresh initialization trace code 0 with Network Discovery stopped; user subsequently confirmed operation |

The decisive runtime diagnosis was error -2147467259 in Find Systems.vi. This
was captured from the actual actor call chain. It is not a conclusion based on
reserved VI execution states or default front-panel error indicators.

## Dependency Changes

- Recovered eleven dependency payloads as local native source with package specs
  and notices retained; installers/hooks were not run by the recovery tooling.
- Used the GitHub Hardware source requiring Common Components >=4.0.4.62 rather
  than silently substituting the official 5.3 plugins requiring >=5.3.0.70.
- OpenG ZIP 5.0.9 was installed separately in the development environment. Its x64
  DLL header and concrete Path callee were checked. It is not a bundled driver.
- NI-DAQmx and NI System Configuration remain external NI prerequisites, including
  their current LVAddons installation layout. System Configuration was not removed.
- The local startup correction does not start NI Network Discovery, change any
  Windows service, or remove the optional remote integration source.

Package versions and license scope are recorded in
[Source Dependencies](SOURCE-DEPENDENCIES.md) and
[Third-Party Notices](THIRD-PARTY-NOTICES.md).

## Experiments And Development Artifacts

These are explicitly not completed features:

- Generic UI Actor Core's fallback While Loop was removed as a diagnostic
  experiment, but the same runtime symptom persisted. The original diagram was
  restored natively from its backup on October 7, preserving the current panel
  and connector pane. It is not a permanent redesign of UI inheritance.
- A forwarding-only inherited-UI rewrite was proposed but not applied. Do not
  advertise single-UI-owner refactoring as shipped behavior.
- Record Actor Fault.vi was temporarily inserted in Controller Actor Core's
  initialization error wire to diagnose startup. It was removed natively before
  publication, its error wire reconnected, and the controller compiled afterward.
  The published application has no dependency on that trace or diagnostic VI.
- A separate icon-editing pass was partial. Its ledger records 140 immediate
  icon readbacks, deferred running VIs, and non-icon resource changes in selected
  saves. Complete saved-resource verification did not pass. Do not describe the
  current source as a completed icon-only refresh or attribute every binary
  difference to the functional repairs above.
- Configuration-dialog files in the original worktree changed after package/IDE
  activity; their cause is unverified. No user changes were automatically reverted.
- Historical Mac paths, example device mappings, and flattened logger settings
  remain in the bundled configuration. They were not replaced with guessed values.
- No executable release, complete simulation/log-readback suite, remote/TestStand
  acceptance, or production safety certification is included.

## Reviewing Native Differences

Native VI binaries do not produce a useful line diff. Review a change using its
qualified VI identity, connector pane, front panel, native diagram, error behavior,
and tests. Manifest XML and an initial file hash establish provenance, not
functional equivalence after a LabVIEW save.

The [Source Delta Inventory](docs/SOURCE-DELTA.md) and
[before/current hashes](docs/source-delta.json) list component file differences
against recorded snapshots. Regenerate with
[Audit-Publication.ps1](tooling/Audit-Publication.ps1). This disk comparison does not
pretend to explain every native re-save or concurrent change.

## Initial Publication Cleanup

Repository: `elijah286/labview-mal-reference`, published under the original author's
authorization. The closed root project was cleaned of temporary tooling, unrelated
EMA entries and recovery-package paths. CVT/LNA entries now use documented external
locations. Recovered NI source payloads, private IDE state, archives, backups and
machine-specific recovery tools are excluded from Git, not deleted locally.
Native binary links and machine-specific plugin configuration still require
clean-checkout/native testing.