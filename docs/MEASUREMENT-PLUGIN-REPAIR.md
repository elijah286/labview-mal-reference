# Measurement Plugin Repair

October 7, 2026: recovered Standard Measurement from the legacy author-packaged
ni_lib_standard_measurement_plugin_system-1.0.0.3 archive. Its package metadata
names Elijah Kerry as packager, NI as copyright holder, and has blank license
metadata. The existing author authorization covers this author's source; no new
blanket license is applied or separately supplied third-party terms overridden.
Original archive and pre-adaptation copies remain local.

## Changes

- Added the Standard Measurement library/class and six current methods under
  components/Measurements, with a Measurement Plugins project folder.
- Corrected imported class/library membership paths and saved the resolved parent.
  No installed framework or shared library was replaced.
- Recreated Acquire with NI's native override provider to match the current base
  method's connector pane, reentrancy, and mandatory parent call.
- Added atomic Read Buffered Data: at most three buffers, existing 1 ms previews,
  zero retries, latest-waveform storage, and Preserve Run-Time Class using the
  original input object as type witness.
- Preserved obsolete Generate outside the runnable class; the current base does
  not expose that method. Original imported sources are preserved in recovery.
- Replaced the stale Mac measurement path with this local checkout's plugin folder.
  Hardware/channel mappings and serialized logger settings are unchanged.

## Verified

All six methods compile in the exact reference project's application instance.
The native factory loads the class with no error. An isolated native fixture
stores three waveforms with exact samples [1,2,3,4] at 1 ms intervals, then releases
its capacity-one queue. Empty-buffer handling returns error 5100 finitely;
incoming acquisition error 73099 is preserved without launching actors.

Live application startup logs Step loaded: Standard Measurement, and the Step
dropdown contains it. Normal close after dismissing the menu returned plugin
methods to idle; this is not an exhaustive actor-tree termination check.
All six saved plugin diagrams fit 1920 x 1080, largest 1057 x 251. Native diagram
images and the live application UI were inspected.

## Limits

Required hardware roles remain Cell Voltages, Pack Temperatures, and Something
Else. A generic simulated DMM does not automatically satisfy them. No complete
measurement actor run, logging round-trip, or physical-device test passed here.
VI Analyzer execution is unverified: installed components found, selected tests
none, exclusions none. Explicit checks are not VI Analyzer or certification.
Clean-checkout runtime and executable builds remain unverified.

Machine-specific tooling, screenshots, fixtures, and recovery archives remain
outside the publication. Native source and this report are included.