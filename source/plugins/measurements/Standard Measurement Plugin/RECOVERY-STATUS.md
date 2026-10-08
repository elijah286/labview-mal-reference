# Standard Measurement Recovery

## Latest Result: Repaired

The user confirmed that the reorganized application works on October 7, 2026.
All six plugin methods passed exact-path compilation after relocation. Read the
root docs/STRUCTURE-CHANGES.md for that update and clean-checkout limitations.
Runtime data/timeout tests below were measured before relocation; they were not
repeated as a full measurement actor run after the final user confirmation.

The acquisition compiler blocker was repaired on October 7, 2026 by replacing
the helper's downcast with Preserve Run-Time Class, using the original object
as the runtime-type witness. All six methods now compile in the exact reference
project instance, including Acquire and Read Buffered Data.

Fresh native verification passed factory loading, three exact synthetic
waveforms [1,2,3,4] at dt 0.001 seconds, capacity-one queue cleanup, empty-buffer
error 5100, and incoming acquisition error 73099. Actual application startup
logs Step loaded: Standard Measurement and its Step menu contains the plugin.
Normal close after dismissing the menu returned plugin methods to idle. All six
saved diagrams fit 1920 x 1080; the largest is 1057 x 251.

The measurement path now points to this local checkout's source/plugins/measurements.
Required hardware roles remain Cell Voltages, Pack Temperatures, and Something
Else. Existing simulated instruments do not automatically satisfy that mapping.
Full measurement actor execution/stop, logging readback, and physical hardware
remain unverified. VI Analyzer was not run: installed components found, API/license
execution unverified, selected tests none, exclusions none. Explicit checks are
not VI Analyzer or certification. See the root docs/MEASUREMENT-PLUGIN-REPAIR.md.

## Earlier Checkpoint (Superseded)

Recovered locally on October 7, 2026 from the archived
`ni_lib_standard_measurement_plugin_system-1.0.0.3` payload. This plugin declares
Common Components >= 5.3.0.70; the current reference uses the older framework
contracts. It is not a drop-in compatible plugin.

At this earlier checkpoint the measurement search configuration was unchanged
and acquisition was broken. The latest results above supersede that blocker;
the historical details below are not the current plugin state.

## Preserved And Changed

- The archived package remains unchanged under recovery/packages.
- The initial import preserved all six VI files byte-for-byte and corrected only
  class/library member paths. Initial hashes are in
  evidence/measurement-plugin-import.json; they describe the initial import,
  not the subsequently adapted native files.
- The original imported class and methods are preserved under
  recovery/standard-measurement-before-adaptation.
- The newer Acquire override had incompatible connector terminals, reentrancy,
  and mandatory parent-call requirements. Generate has no corresponding method
  in the current base class. Both original files were preserved in recovery.
- Acquire was recreated with NI's native override provider for the current
  Measurement base class. A separate Read Buffered Data operation was added
  using the current buffered hardware API, a maximum of three hardware inputs,
  the existing 1 ms preview timeout, and zero retries.
- No installed framework or shared library was replaced. No source was committed
  or pushed. No application search-path change was made.

## Native Results

The Measurement Task Manager was closed normally, without Abort or restarting
LabVIEW. A fresh project-context check after that close showed the hardware-role
query executable. Its finite native run returned no error and the legacy roles
Cell Voltages, Pack Temperatures, and Something Else.

Earlier native checks, in Measurement Utility Reference.lvproj/My Computer:

| Method | Executable State |
| --- | --- |
| Configure | 1: executable |
| Measure | 1: executable |
| Close | 1: executable |
| Read Compatible Hardware Types | 1: executable |
| Read Buffered Data | 1: executable |
| Acquire | 0: broken |

Acquire calls Read Buffered Data before the required Call Parent Class Method,
with the error wire routed through both. LabVIEW reports runtime type propagation
and unconditional-parent-call errors. Marking the helper terminals as dynamic
dispatch and refreshing the caller did not resolve those errors. Further edits
were stopped at the bounded repair retry limit.

The workspace tools contain measurement-plugin-state-*.json, native exports,
and compiler screenshots. Those state checks are not acquisition tests.

## Earlier Remaining Gates (Superseded In Part)

Resolve the acquisition runtime-type propagation contract before configuring
discovery or running a measurement. Then validate native class loading through
the application's loader, nonempty simulated data, incoming faults and empty
buffer timeouts, logger readback, and normal measurement stop. Saved diagram
size, native UI inspection, and VI Analyzer execution also remain pending.
Connected-device behavior remains unverified.

Only Standard Measurement was located in these staged measurement payloads.
The INI names Temp Monitor, Acquire Temperature, and Diode IV are configuration
section names, not evidence that separate concrete plugin classes were recovered.