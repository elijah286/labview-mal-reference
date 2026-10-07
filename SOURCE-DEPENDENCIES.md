# Dependencies And Setup

Target environment: LabVIEW 2026, Windows 64-bit. Local operation is user-verified;
clean-checkout runtime/deployment testing remains pending. The public snapshot
contains author-authorized components and recovered OpenG source with notices.
Recovered NI CVT/LNA/TCP/package-GUID sources are obtained separately, not
republished. Cloning and the preparation script run no package installers.

## Source Baseline

The original application, framework, API and configuration repositories remain
under `components/`. Existing local source changes were preserved. Recovered
GitHub source is pinned to these revisions:

| Repository | Revision |
| --- | --- |
| elijah286/GUID-API | 940ea14380ceff960bf6171224dc3cc64a84babf |
| elijah286/Hardware | 689f19916900d3d9fc665a8599f69486e889983e |
| elijah286/TestStand-MAL-API | c01550b9549dc266cd64b0c4efe39f2eec4efd39 |

Hardware source includes the DAQ class and simulated instrument implementations.
Its package requires Common Components >=4.0.4.62, unlike the separate recovered
5.3 sample bundle. Declared requirements are not native compatibility proof.
The 5.3 payloads remain isolated under ignored recovery storage.

## Vendored Dependencies

The local recovery originally contained 1132 files from eleven pinned packages.
Only the OpenG source tree is included in this public snapshot; recovered NI trees
and their examples/project wizards remain local and Git-ignored. Notices are under
`vendor/package-notices/`. The following versions describe the recovery baseline,
not a recommendation to install every older package blindly in LabVIEW 2026.

| Dependency | Version |
| --- | --- |
| OpenG appcontrol | 4.1.0.7 |
| OpenG array | 4.1.1.14 |
| OpenG error | 4.2.0.23 |
| OpenG file | 4.0.1.22 |
| OpenG lvdata | 4.2.0.21 |
| OpenG string | 4.1.0.12 |
| OpenG variantconfig | 4.0.0.5 |
| GUID Generator package payload | 1.0.2.2 |
| TCP helpers | 1.0.0.3 |
| Linked Network Actor | 1.2.0.19 |
| Current Value Table | 3.3.0.13 |

The root project uses the GUID-API GitHub source. The recovered package GUID
copy is retained for comparison, not selected as another root-project member.
CVT, Linked Network Actor and TCP helper source must be obtained under their
applicable terms. Original-author permission does not override these package terms.

## Populate External Dependencies

Run [Prepare-ExternalDependencies.ps1](tooling/Prepare-ExternalDependencies.ps1)
before opening this project, using a source tree you are authorized to use:

```text
vi.lib/NI/Current Value Table/Current Value Table.lvlib
vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor.lvlib
vi.lib/National Instruments/<other authorized dependency folders>
```

The script copies only those two explicit external trees, preserves their folder
layout, checks CVT/LNA entrypoints and refuses different existing files. Inspect
your supplied tree first and include only the intended packages. It does not
download software, confer permission, or modify shared LabVIEW installations.

```powershell
./tooling/Prepare-ExternalDependencies.ps1 -SourceRoot 'D:/Authorized-LabVIEW-Dependencies'
./tooling/Prepare-ExternalDependencies.ps1 -SourceRoot 'D:/Authorized-LabVIEW-Dependencies' -CheckOnly
```

These external trees remain Git-ignored. Do not force-add them. Native VI binary
links may still reference historical recovery/installation locations even when
manifest links are correct. Resolve them natively in LabVIEW, verifying qualified
owners, connectors and execution state; do not substitute guessed stubs.

## External Prerequisites and Remaining Work

- LabVIEW 2026 64-bit, built-in Actor Framework and standard NI libraries remain
  installation prerequisites; they are not replaced by older vendored copies.
- DAQmx is installed under NI LVAddons; its driver/runtime is not replaced by VI
  source vendoring. NI System Configuration remains required; the repaired local
  path uses Initialize Session instead of network Find Systems. Runtime startup
  returned error 0 while NI Network Discovery remained stopped. Exact installed
  driver versions still need a portable environment capture.
- OpenG ZIP 5.0.9 is obtained separately. Its x64 DLL header and concrete Path
  callee were checked; archive round-trip and deployment remain untested.
- Project/library Item URLs have been mapped to exact local source paths, but
  encoded class inheritance and binary VI call links still require native checks.
- Historical plugin/log settings remain machine-specific. Configure local plugin
  directories, explicit real/simulated devices, channel mappings and writable TDMS
  storage through configuration interfaces. Do not guess flattened class values.
- Automatic run-on-open was disabled. Open the server launcher panel and run it
  deliberately only after dependency/configuration checks.

SystemLink/Skyline upload is disabled in the local logger; TDMS remains. Remote and
TestStand sources are optional references, not verified workflows. Startup does not
establish acquisition, logging readback, bounded fault shutdown, connected hardware
or executable-build acceptance. See [README.md](README.md) for current status and
[dependency-lock.json](dependency-lock.json) for the recorded source/package baselines.