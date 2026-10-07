# Third-Party Notices And Source Publication

This repository assembles source from multiple origins. No root MIT, BSD, or other
new license is applied to all of it. Original notices and applicable grants govern
their respective files; attribution does not replace permission.

## Original Example And Components

The Measurement Utility / Measurement Abstraction Framework architecture is
credited to Elijah Kerry, CLA. Its original reference materials are linked in
[README.md](README.md), and exact source baselines in [CHANGES.md](CHANGES.md).
Elijah Kerry identified himself as the original framework author and explicitly
authorized republication of his work on October 7, 2026. That author authorization
resolves the permission question for his original component sources. It does not
select a license for downstream users or override separately supplied third-party
package terms. A downstream license for the author's source should be selected
before describing the assembled reference as generally reusable open-source code.

## Recovered Packages

Standard Measurement Plugin (System) 1.0.0.3 was packaged by Elijah Kerry and
records NI copyright with blank license metadata. It is included under the
existing authorization for the author's original example source, not under a
newly invented MIT/BSD grant. See [Measurement Plugin Repair](docs/MEASUREMENT-PLUGIN-REPAIR.md).

| Family | Version | Local Notice | Publication Assessment |
| --- | --- | --- | --- |
| OpenG appcontrol | 4.1.0.7 | vendor/package-notices/oglib_appcontrol/license | BSD-family terms; preserve the actual notice and conditions |
| OpenG array | 4.1.1.14 | vendor/package-notices/oglib_array/license | BSD-family terms; preserve notice and conditions |
| OpenG error | 4.2.0.23 | vendor/package-notices/oglib_error/license | BSD-3-Clause recorded in package metadata |
| OpenG file | 4.0.1.22 | vendor/package-notices/oglib_file/license | BSD-family terms; preserve notice and conditions |
| OpenG lvdata | 4.2.0.21 | vendor/package-notices/oglib_lvdata/license | BSD-family terms; preserve notice and conditions |
| OpenG string | 4.1.0.12 | vendor/package-notices/oglib_string/license | BSD-3-Clause recorded in package metadata |
| OpenG variantconfig | 4.0.0.5 | vendor/package-notices/oglib_variantconfig/license | BSD-family terms; preserve notice and conditions |
| NI GUID Generator payload | 1.0.2.2 | vendor/package-notices/national_instruments_lib_guid_generator/package.spec | License metadata blank; explicit grant not confirmed |
| NI TCP/IP helpers | 1.0.0.3 | vendor/package-notices/national_instruments_lib_tcp___ip_functions/package.spec | License metadata blank; explicit grant not confirmed |
| NI Current Value Table | 3.3.0.13 | vendor/package-notices/ni_lib_cvt/license | Source disclosure restricted under the bundled terms |
| NI Linked Network Actor | 1.2.0.19 | vendor/package-notices/ni_lib_linked_network_actor/license | Source disclosure restricted under the bundled terms |

The CVT and Linked Network Actor notices are headed "NATIONAL INSTRUMENTS SOFTWARE
LICENSE TERMS (SAMPLE CODE)", dated February 1, 2012. In particular, sections 2-4
limit disclosure and distribution, allow specified binary-object distribution with
applications subject to conditions, and identify source code as confidential. The
local notices do not establish permission to upload those sources to a public repo.
An alternate applicable grant or written authorization would need to be recorded
before doing so. A private third-party hosted repository is not automatically an
exception to the source-disclosure conditions.

The section headed "Unreleased Code" describes the NI code's status. It should not
be misread as a separate blanket prohibition triggered merely by the new reference
being under active development; the source-disclosure restrictions are the relevant
publication concern here.

## Installed Prerequisites

LabVIEW and its built-in Actor Framework, NI-DAQmx, NI System Configuration, and
optional TestStand installations remain governed by their own product terms. They
are not redistributed as part of this source reference. OpenG ZIP 5.0.9 is obtained
separately; adding its source or DLL to this repository would require retaining and
reviewing that distribution's own notices and architecture requirements.

The missing HW Configuration.vi was recovered from the Common Components 4.0.4.62
payload. Recovery proves origin and identity, not public redistribution rights.
Its grant must be covered by the source-publication review too.

## Publication Decision

Republication of the author's original work is authorized. This public snapshot
excludes recovered NI payload source under vendor/labview/vi.lib and its recovered
examples/project wizards. Local copies remain Git-ignored; obtain dependencies
under their own terms as described in [Source Dependencies](SOURCE-DEPENDENCIES.md).
Notices are retained. Native relinking/clean-checkout testing remain necessary.
Do not delete original notices or apply a blanket license to third-party files.