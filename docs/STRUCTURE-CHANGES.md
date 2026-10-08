# Structure And Link Change Report

## Result

On October 7, 2026 the user reported that the reorganized application works and
authorized publishing this version. That local observation supersedes the earlier
startup-failure checkpoint, but does not certify a clean clone, every device,
logging readback, or complete actor lifecycle. No final automated application run
was performed after that confirmation.

## Physical Organization

The source no longer mirrors seven unrelated repository/package directory trees.
It follows application and ownership boundaries. The exact mapping is retained in
[source-layout-map.json](source-layout-map.json), and the current tree is described
in [Source Layout](SOURCE-LAYOUT.md).

- Application code moved from HAL-MAL-Application/Source/Framework to source/application.
- Common Components moved to source/framework; native class and library names retained.
- Configuration dialogs moved to source/configuration; controller API to source/api/controller.
- Concrete hardware and measurement plugins moved to source/plugins/hardware and measurements.
- GUID support moved to source/support/guid; optional TestStand code to source/integrations/teststand.
- Templates moved to templates/measurement; remaining upstream packaging metadata and READMEs
  moved to provenance/upstream. Third-party vendor layout and exclusions stayed separate.

Whole owning subtrees were moved rather than splitting method files arbitrarily.
The initial move preserved bytes for 842 native files. Subsequent native saves
and manifest repairs are separate changes; the initial hash result does not prove
byte identity of the final snapshot. Original/recovery archives remain local.

## Manifest And Project Repair

The first migration generated directory-relative URLs, which caused missing-member
searches and selection of archived or original-repository copies. A fresh isolated
LabVIEW library probe measured the real native convention: a same-directory member
is saved as ../Member.vi. Native library/class member URLs use the manifest file
as the path base; root-project Document entries use the containing directory.

Relocated manifests were reconstructed from committed source identities and the
move map, not whichever file a search happened to find. This pass mapped 2,100
references. Thirty-eight unresolved historical/example references were recorded;
they include old EV Battery/CompactDAQ examples, DLL names, and an external LNA
parent. No guessed replacements or disconnected typedefs were introduced.

The root project was rebuilt from published membership with explicit relocated
paths. Its tree now opens normally. CVT and LNA project entries use the documented
vendor/labview dependency locations; restricted dependency source is still excluded
from Git and supplied separately. No production build specification was added.

Native VI binaries can contain additional owner, class-data, typedef and callee
links. Correct XML is necessary but does not establish complete native closure.
During investigation LabVIEW still loaded duplicate framework libraries from the
original sibling MAL-Framework checkout. A native conflict report was retained
locally. Those originals were neither renamed nor edited without approval.
This successful local run is not evidence that every such dependency is portable.

## Plugin Repair Retained

The prior Standard Measurement recovery is included. Acquire matches the current
parent pane/reentrancy contract and calls Read Buffered Data before its mandatory
parent call. Preserve Run-Time Class maintains the runtime subclass through the
helper. Buffer reads are limited to three hardware roles with existing 1 ms preview
timeouts and zero retries. See [Measurement Plugin Repair](MEASUREMENT-PLUGIN-REPAIR.md).

The measurement search path was updated to this checkout's source/plugins/measurements
folder. It is still machine-specific; hardware paths, example device mappings and
flattened logger settings were not replaced with guessed values.

## Verification And Diagnostics

- Six relocated plugin methods passed state 1 in the exact reference project and new paths.
- Latest read-only launcher, server-controller core and Server UI core checks passed state 1.
  Their idle states and closed panels do not prove actor termination or successful startup.
- The user subsequently confirmed that the application works. Exact device/logging scope
  was not specified; do not infer connected-hardware qualification from that statement.
- Before relocation, native factory loading, exact synthetic waveform data [1,2,3,4]
  at 1 ms, queue cleanup, finite timeout error 5100 and injected error 73099 passed.
- Six saved plugin diagrams fit 1920 x 1080; largest 1057 x 251. Those diagram checks
  do not cover every VI in the framework.
- No final full dynamic-load, actor stop/restart, logger round-trip or clean-machine run
  was completed. VI Analyzer execution is unverified; selected tests/exclusions: none.

Member Save As and a sender rebind were diagnostic attempts, not shipped behavior.
The rebind removed a sender membership before failing with a same-name collision;
that membership was restored from its backup and verified exactly once. No new
Send Reference Results to UI.vi was generated, no caller was retargeted to it, and
the original repository sender hash remained unchanged. Failed helper probes and
runtime traces stay outside the publication. No IDE kill/restart or forced actor
Abort was issued by the repair tooling.

## Publication Scope

This is an active-development source update, not an executable or certification
release. Original notices, pinned provenance and the existing CI pipeline are
preserved. The source audit now maps historical baseline paths to the new layout
and scans source, templates and upstream provenance instead of the obsolete
components tree. Source inventories distinguish actual absence from a folder move.
Private IDE state, TDMS output, recovery packages, temporary native tooling and
restricted NI dependency source remain excluded.