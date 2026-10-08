# Publication Snapshot

Repository: [elijah286/labview-mal-reference](https://github.com/elijah286/labview-mal-reference).
Prepared October 7, 2026 as an active-development source reference under the
original author's authorization, not a stable executable or certified lifecycle release.

## Reorganized Source Update

The user confirmed operation of the reorganized version on October 7, 2026 and
authorized its publication. Runtime source is grouped by responsibility; templates
and upstream package metadata are separate. Read the
[Structure Change Report](STRUCTURE-CHANGES.md) and [Source Layout](SOURCE-LAYOUT.md).
The root project was saved and closed through MCP before publication-only path
cleanup. Restricted NI dependency source remains ignored and supplied separately.
This local working confirmation is not a fresh automated full-app run or evidence
that original-source cross-links are absent in a clean checkout.

## Distribution Decisions

1. The author created the new repository as `elijah286/labview-mal-reference`.
  Never put tokens, passwords or credential exports into source or documentation.
2. Establish third-party source redistribution rights. Elijah Kerry, the original
  author, explicitly authorized republication of his original component sources
  on October 7, 2026. The separately bundled CVT/LNA terms restrict source
  disclosure and GUID/TCP package license fields are blank. See
  [Third-Party Notices](../THIRD-PARTY-NOTICES.md).
  Recovered NI dependency trees and their examples/wizards are excluded from Git;
  notices and external setup instructions are retained. A downstream license for
  the author's own source remains a separate decision.
3. Clean-checkout testing is still pending. This initial source snapshot is not a
  zero-setup installer or a reproducible-runtime acceptance claim.

A fresh remote Git checkout was verified with repository-local `core.longpaths=true`.
Committed files matched the local snapshot hashes, exclusions were retained, and
the documentation/source audit ran successfully. This is a structural checkout
check, not a clean-machine native LabVIEW run. Windows users should use the short
clone destination and long-path command shown in the README.

## Cleanup And Remaining Work

- Stop the reference application through its normal path and verify termination.
  Do not kill the IDE, discard unrelated unsaved work, or use a successful source
  checksum as proof that the actors stopped.
- The temporary Record Actor Fault.vi call was removed natively, its error wire
  reconnected, and the controller compiled after cleanup. Raw diagnostics stay local.
- The named project was closed natively before saved-manifest edits. Temporary
  tooling and unrelated EMA listings were removed; CVT/LNA root entries now point
  to the documented, separately supplied external dependency folders.
- Check existing binary VI links as well as Item URLs when resolving external
  dependencies in a clean checkout. Preserve ownership and connector contracts.
- Remove machine-local runtime paths and use the configuration API to provide a
  documented local example. Do not invent devices or edit flattened class data.
- Retain notices and record the exact installed driver/library versions. Exclude
  package installers, archives, personal LabVIEW state, logs, crash captures, backup
  VIs, and source from other workspace tasks.
- Complete a current source-delta/hash inventory, accounting for functional
  repairs, native re-saves, and the incomplete icon-editing pass. Initial recovery
  hashes do not describe every current native binary change.
- Test a clean checkout in the target environment: UI operation, configured
  simulation, log readback, Stop/fault/repeat-start behavior, and native dependency
  resolution. Treat hardware and remote/TestStand tests separately.

## Publishing This Development Snapshot

Create a new, empty repository rather than overwrite an upstream repo. Do not
initialize an unrelated remote README/license and then force-push over it. Review
the exact staged file list and rights before the initial commit. Set the intended
default branch explicitly once its owner agrees.

The repository description should identify it as an actively developed, updated
LabVIEW HAL/MAL/Actor Framework reference. Link the original article and source
baselines. Do not label a development snapshot a stable release, claim official NI
support, or mark shutdown/hardware verification as complete without those tests.

After pushing, verify the remote URL, default branch, committed file list, README
rendering/relative links, and intended visibility. Record the new URL in the local
handoff and confirm that no restricted source, credentials, personal state, recovery
archives, or machine-specific probe paths were included.