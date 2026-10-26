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

## CI Build Scope

This repository is a Windows 64-bit development reference, not a qualified binary
release. The root project now defines one Windows development build,
**Measurement Utility EXE**; the regression-test project has no build
specifications. The 21 specifications originally discovered by the Toolkit's
default recursive binary-build runner belong to these inherited projects:

| Project | Specifications | Intended status here |
| --- | --- | --- |
| source/application/Networked Measurement System.lvproj | 5: client/controller EXEs, testing-only client EXE, server/client installers | Historical application packaging |
| source/application/Server/Build Tools/Networked Measurement System.lvproj | 3: server/client EXEs, controller installer | Historical build-tools project |
| source/configuration/Configuration Dialog Actor.lvproj | 2: configuration source distributions | Upstream component packaging |
| source/configuration/Basic Configuration Dialog/Config Dialog Example.lvproj | 1: example EXE | Configuration example |
| source/plugins/hardware/Sample Hardware.lvproj | 8: seven device distributions and one installer | Upstream hardware packaging |
| templates/measurement/Source/Measurement/Measurement Prototype.lvproj | 2: measurement distribution and installer | Template packaging, not a deployed measurement |

These specifications belong in the retained source history/reference, but are
**not supported CI release targets**. The CI configurator originally installed
the `builds` capability for both Windows and Linux without an explicit selection;
the runners defaulted to building every discovered specification on source
changes. The supported root project had no build specification at that time.
That is why the dashboard showed all 21 entries.

### Observed Failures

The [Windows run for commit 6d69ccd](https://github.com/elijah286/labview-mal-reference/actions/runs/39891985990)
reported **0 built, 21 failed**, confirmed by its
[summary](https://elijah286.github.io/labview-mal-reference/builds/6d69ccd2857a5e9b5e076f9009ae7e43681c97ff/summary.json)
and [full LabVIEW log](https://elijah286.github.io/labview-mal-reference/builds/6d69ccd2857a5e9b5e076f9009ae7e43681c97ff/builds.log).
`ExecuteBuildSpec exited 2` is the CLI process exit code, not a diagnosis.
LabVIEW started and connected successfully; its operation reported error code 1
with these underlying failures:

- Application/example EXEs loaded broken VIs. Missing callees included OpenG
  variant-configuration/file helpers, GUID generation, LNA/TCP helpers, CVT types,
  and hardware/session helpers. Missing parent classes also caused cascading
  class-conflict and protected-access diagnostics.
- The build-tools EXEs, hardware distributions, and measurement-template
  distribution reported missing source files or build items. Configuration
  distributions reported missing dependencies of included VIs, including an
  OpenG VI still linked to the ignored `recovery/packages` tree. Some inherited
  build destinations also retain the original developer's `/Z/Documents` paths.
- Application installers failed in Application Builder's directory/distribution
  initialization; hardware/template installers could not generate previews of
  their dependent distributions. The log does not establish one common root
  cause for every installer.

This is not evidence that the supported local launcher or the separate Caraya
suite failed. Historical projects and build inputs have not been qualified after
source relocation, and a clean CI worker does not inherit this machine's installed
or ignored dependencies. See [Dependencies And Setup](../SOURCE-DEPENDENCIES.md);
do not publish restricted NI sources to make a build pass.
The [Linux run for the same commit](https://github.com/elijah286/labview-mal-reference/actions/runs/39891986001)
was cancelled, not a second confirmed set of 21 LabVIEW build failures.

### Current Policy And Future Releases

The `builds` activity and both binary-build workflows remain removed.
[The CI manifest](../.github/labview-ci.yml) keeps `config.builds.runAll: false`
and now allowlists only
`Measurement Utility Reference.lvproj::Measurement Utility EXE::windows`.
Historical native specifications, Toolkit build helpers, unit tests, and analysis
workflows remain unchanged. Existing failed reports remain historical evidence on
GitHub Pages; local changes do not rewrite old statuses or deploy themselves.

The new root build starts the supported server controller and explicitly includes
the three simulated hardware classes and Standard Measurement. Its output is
`builds/Measurement Utility`. The launcher passes its directory to the controller,
so the packaged relative plugin paths are resolved against the application
directory, not against a configuration filename or the shell's working directory.
[Prepare-MeasurementUtilityBuild.ps1](../tooling/Prepare-MeasurementUtilityBuild.ps1)
must run after building to generate a fresh simulated-only configuration from the
actual built classes. See [Windows build instructions](../README.md#build-the-windows-application).
The target preserves diagrams/front panels after an observed OpenG
diagram-stripping error 1502; it is not an optimized production build.
The controller's UI launcher leaves Actor Framework's development-only
**Open Actor Core front panel?** input at FALSE: TRUE returns an error in the
runtime engine. The UI's existing `Initialize UI` method opens its production
front panel explicitly in both development and runtime execution.

The local 2026 Q3 x64 native build completed successfully. Distribution preparation
and resolution of all four relative plugin paths also passed after copying the
complete output to another directory. The hardware-free regression report passed
8 suites / 44 assertions. These checks do not establish executable acceptance.
The initial Windows error 1114 was reproduced with a dependency-free 2026 Q3
executable, then traced with a native debugger to an execution access violation
in the unloaded shared NI error-reporting client during runtime initialization.
The installed `lvrt.dll` matches the cached NI package.

The preparation script's explicit `-DisableNIErrorReporting` switch applies NI's
documented application-only `NIER=False` workaround. Both the probe and this
application then load the 2026 runtime. After removing the development-only actor
panel launch flag, the actual Measurement Task Manager opens and reports Standard
Measurement, Simulated DMM, Simulated Function Generator and Simulated Scope loaded.
Selecting Standard Measurement updates the three device roles. Normal UI close
exits the process, restart works, and a complete relocated distribution passes
these checks when launched from `C:\Windows`. The temporary inspection listener
and remote debugging are disabled in the final distribution.
The preparation fixtures cover relative paths, missing/duplicate plugins,
application-scoped NIER insertion/replacement, idempotence, unrelated-setting
preservation, invalid INI rejection and unchanged source configuration: 42
assertions pass. The native regression suite was rerun after the UI fix, with
all 8 suites / 44 assertions passing. No acquisition or clean-machine installer
qualification was performed.
No runtime repair or shared NI component changes were performed, and the running
LabVIEW 2027 instance was not controlled.

Before re-enabling binary builds:

1. Qualify the root Windows EXE and its packaged dynamic plugins, configuration,
   output paths, shutdown behavior and runtime dependencies for the intended
   deployment. Add an installer only when its runtime/driver contents and
   redistribution terms have been established.
2. Provision authorized dependencies in the worker and validate from a clean
   checkout with LabVIEW 2026 Q3 64-bit. Successful local source execution is not
   executable/installer acceptance.
3. Re-enable the Toolkit `builds` capability for Windows only, retain the explicit
   root-EXE allowlist with `runAll: false`, and run the distribution preparation
   step before publishing artifacts. Do not enable Linux release builds without
   separate platform qualification.