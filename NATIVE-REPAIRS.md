# Native Repair Ledger

## Current Development Snapshot: October 7, 2026

This ledger's later sections record historical recovery checkpoints. The current
user-observed local example works after replacing unused network Find Systems
with Initialize Session for the explicit local target. A native trace captured
the original -2147467259 discovery failure and subsequently returned code 0 with
NI Network Discovery still stopped. See [CHANGES.md](CHANGES.md) for the updated
subject-level change ledger and [README.md](README.md) for verification limits.

The temporary controller startup recorder was removed natively before publication;
its error wire was retained and the cleaned controller compiled. The unsuccessful
generic UI fallback-loop removal experiment was restored from its original native
diagram, preserving the current panel/connectors. Registration ordering and fault-safe
stop-event creation are saved changes, not a completed bounded lifecycle proof.

The root project was closed before portable Item URL cleanup and exclusion of
temporary and unrelated-workspace listings. Recovered NI dependency sources are
not distributed in public Git. Developer backups/raw evidence named below are
local records and are intentionally absent from a clone. Historical claims that
those repairs were pending or that the application remained running are not
current state claims. No clean-checkout runtime or new executable-build acceptance
is established by this publication preparation.

All modifications are confined to this reference copy. Historical source-copy
hashes establish original provenance, not current native readiness or binary
equivalence after these authorized changes. Server UI startup has now been exercised;
no measurement or hardware acquisition was started.

## SystemLink Disabled

The copied actor logger's AMQP field and Skyline configure/upload/cleanup calls
were removed natively. Class identity, connector panes and local TDMS operations
were retained. Direct remote requests return error 73002; startup remote setup
does not enqueue that request. Original implementations and live edits were backed
up under recovery/systemlink-original-20261004. TDMS cleanup error wiring remains
an inherited issue; runtime logging, readback and fault tests have not passed.

## ZIP Call Relink

The ZIP builder's existing call was replaced natively with the installed OpenG
Path instance under lvzip/lvzip.llb/subVI. Native export confirms the original
root/archive/include-subdirectories/error wires were retained. The installed
callee and builder are now executable in project context; no archive round-trip
test was run. Backup: evidence/Zip builder before pane repair.vi.

## DAQ Configuration Ownership

Native MCP lvai_add_to_library added components/Hardware/DAQ/config/DAQ
Configuration.lvclass to the Hardware folder in the declared Hardware.lvlib.
Saved membership was verified and the compiler ownership-disagreement error
disappeared. Original class/library copies remain in timestamped evidence
backups. The root project's standalone class listing was not edited while open.

## Missing Native Configuration Member

Recovered the absent components/MAL-Framework/user.lib/Common Components/Hardware/
HW Config/HW Configuration.vi from staged Common Components 4.0.4.62. No package
installation or existing-file overwrite. Length: 20092 bytes. SHA256:
C5EB77F3C6B3E697667D4D383F9FEB0B8CF6F99E6861D6CB0B698CC8E60E8144.
Native export identifies Hardware.lvlib:DAQ Configuration.lvclass:HW Configuration.vi,
matching the compiler's missing member. Provenance: evidence/daq-missing-member-recovery.json.
Initial field/callee errors cleared after native AddItem also relinked the concrete
DAQ .lvclass to Hardware.lvlib. Read Sample Rate.vi, DAQ read, and Initialize New
Category Display.vi pass exact-context checks. Both class ownership repairs are
recorded in evidence/daq-*-membership-native-edit.json. This is not runtime proof.

## Remaining Configure Link

DAQ configure's missing old Read Configuration accessor was replaced natively with
Read HW Config Class.vi after a corrected guard verified the project, ten calls,
and the single unresolved call at index six. The VI passed native executable-state
checks. Native save-copy backups preserve the prior diagram.

## Server UI Startup Repair

2026-10-05: the native Error List identified DAQ .lvclass:construct.vi as the root
broken dependency of Server UI Actor Core. The constructor referenced a missing
legacy Write Configuration accessor. Native export verified that the existing
Hardware.lvclass:Write HW Config Class.vi matched its class/configuration/error
terminals. Inventory found two calls, one unresolved at index zero (error 1099).
Guarded native Replace retained the input wires and the output-to-parent chain.
The constructor and DAQ class were saved. Backup: recovery/DAQ construct before
writer repair-*.vi. No application diagram was regenerated.

All 17 subjects in evidence/current-project-dependencies.json passed exact-context
executable-state checks before startup, with zero inspector errors. This is a
bounded set, not an assertion that every source/plugin VI is executable.

The five-second project-instance startup observer confirmed launcher completion.
Subsequent native checks reported Server UI and both server/base controller actor
cores in execution state 3 (running). Server UI panel-open=true; its exact native
window was foregrounded and captured as Measurement Task Manager. Evidence:
missing-ui-constructor-repair.json, missing-ui-construct-after.xml,
missing-ui-observed-startup.json, missing-ui-runtime-*.json,
missing-ui-running-window.json and missing-ui-running-server-panel.png.
The application remains running for user inspection; no measurement was started.

The measurement/device lists are empty. The configured plugin paths still name
old Mac directories. Discovery/initialization, measurement execution, hardware,
logging, graceful stop/fault handling and build acceptance remain unverified.

## Current Verification

2026-10-04 focused IO Channels repair supersedes previous configuration-field
blockers. The legacy DAQ UI and serializers required an IO Channels string that
was absent from the copied DAQ configuration class and current ancestors. Native
MCP appended that field only to DAQ Configuration.lvclass, preserving the other
three fields and all ten members. No default device/channel was invented; the
restored string defaults empty. Native save-copy and configuration-folder backups
are under recovery/io-channels-before-*.

Existing IPE border nodes retained stale bindings. The native InPlaceClusterNode
Element Names[] property was validated, then the IO Channels entry was temporarily
selected as Sample Rate and restored, forcing rebinding without changing diagram
connections or regenerating the Event Structure. The setter terminal is ElementNms[].
Both UI borders and the read/write configuration methods were repaired. Owning
class saved; all three methods pass exact-context state 1 with empty linker errors.
Evidence: io-class-field-restored.json, io-ui-after-class-save.json,
io-read-parameters-after-repair.json, io-store-parameters-after-repair.json,
io-ui-after-repair.xml, io-channels-repaired-diagram.png. No UI execution, file
round-trip, device/channel-routing or acquisition validation occurred.

UI preservation comparison retained all 52 exported element identities, wiring
attributes, connector metadata and call targets. The original source snapshot
audit no longer passes: Configuration Dialog settings/project, several accessors
and Update Config message/method files differ. Their cause is unverified; no
automatic rollback was performed. The IO repair targeted reference-copy paths.

The broad readiness counts below are historical, before this focused repair and
the user's additional VIPM installations. They are not a fresh project-wide gate.

evidence/current-project-dependencies.json completes 17 exact-context inspections
with zero inspector errors. Seven pass: launcher, both ZIP methods, logger Create
New File/Write Data/Stop Core, and DAQ read. Ten fail: eight Actor Core methods,
logger Pre Launch Init, and DAQ configure. The intermediate all-broken cascade
cleared after concrete DAQ ownership relinking. No build, UI acceptance, VI Analyzer,
diagram-size acceptance, simulation or hardware success is claimed.