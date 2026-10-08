# Source Layout

**Development snapshot, user-confirmed working on October 7, 2026.** The rebuilt
project opens with a populated tree and all six relocated Standard Measurement
methods passed exact-path compilation. The user subsequently confirmed local
application operation. This is not a clean-machine runtime or full lifecycle
qualification. See [Structure Change Report](STRUCTURE-CHANGES.md) for measured
path conventions, intermediate cross-link failures, and remaining portability limits.

The physical source tree now follows responsibility and ownership, rather than
the directories of the upstream package repositories. Qualified native library
and class names are unchanged; methods remain beside their owning class.

| Directory | Responsibility |
| --- | --- |
| source/application | Server/client orchestration, UI, listeners and local INI |
| source/framework | Reusable controller, measurement, HAL, logging and UI abstractions |
| source/configuration | Extensible configuration classes and dialogs |
| source/api/controller | Controller integration API |
| source/plugins/hardware | Concrete DAQ and simulated instrument implementations |
| source/plugins/measurements | Concrete measurement workflows, including Standard Measurement |
| source/support/guid | Source-local GUID support |
| source/integrations/teststand | Optional TestStand integration |
| templates/measurement | Measurement templates, not deployed plugins |
| provenance/upstream | Upstream packaging metadata and original component READMEs |
| vendor | Third-party source/notices; restricted NI sources remain ignored |
| tooling | Portable repository maintenance utilities |
| docs | Architecture, setup, changes and verification scope |

Recovery archives and machine-specific native evidence remain local and ignored.
The root project is the supported source-navigation entry point. Legacy component
projects and templates are historical examples, not equivalent supported launchers.

See [source-layout-map.json](source-layout-map.json) for the exact old-to-new mapping.
Local plugin paths are configured in
[Measurements.ini](../source/application/Measurements.ini). Review these paths and
native binary dependencies for another machine; XML validation is not runtime proof.