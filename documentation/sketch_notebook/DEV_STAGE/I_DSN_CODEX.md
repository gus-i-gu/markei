# I_DSN_CODEX — C10-GCM02-S12-ERR-02

Unit: C10-GCM02-S12-ERR-02 — Step 12 Diagnostic Runtime Completion
Evidence class: repository-proven and test-validated locally unless marked otherwise.

## Ownership and Dependency Direction

- repository-proven: `contracts/shared_beta/diagnostics_v1/diagnostics.registry.json` remains the single hand-maintained diagnostic owner.
- repository-proven: Dart, TypeScript and Markdown projections remain generated; no runtime code parses J or generated Markdown as a source of truth.
- repository-proven: Flutter runtime uses the Dart projection for UI meaning and API runtime uses the TypeScript projection/domain types.

## Parent and Child Identity Model

- repository-proven: `sync_attempts` remains the parent operation ledger.
- repository-proven: `sync_diagnostic_events` remains the ordered child timeline and is extended additively in Drift v12.
- repository-proven: one top-level ordinary Sync action creates one operation identity and one public operation fingerprint.
- test-validated: child events receive deterministic ordinals and distinct full correlation identities with 12-hex fingerprints.
- repository-proven: scoped HTTP transport receives child correlation identity through a zone-scoped internal boundary, while public/UI surfaces receive only fingerprints.

## Evidence State Machine

Repository-proven axes are persisted independently:

```text
local mutation
provider contact
trusted response
provider transaction
local result persistence
terminal outcome
```

Design consequences:

- repository-proven: request-start without trusted provider outcome records `unknown` and preserves identity.
- repository-proven: local result persistence failure is separate from provider result.
- repository-proven: terminal summaries can reference causal child evidence instead of replacing it.
- repository-proven: HTTP status alone is not modeled as proof of provider commit state.

## Projection Boundaries

- repository-proven: API catch-all failures create one internal typed diagnostic event and project it separately to public API output and internal lifecycle evidence.
- test-validated: public output omits full correlation ID, exception class, SQLSTATE, messages, stack traces, SQL, payloads and raw IDs.
- test-validated: internal lifecycle evidence retains permitted sanitized exception class, last proved phase and provider transaction outcome.
- repository-proven: public 500 remains `retryable=false`.

## Detector and Cause Attribution

- repository-proven: ordinary Sync emits representative AUT, BND, REC, QUE, TRN, UPL, DNL, ACK, LDB and OBS diagnostics at reachable source boundaries.
- repository-proven: API upload protocol failures map wrong account, hash mismatch, sequence gap, binding and database failures to narrower MKS codes.
- repository-proven: `MKS-UPL-012` is no longer the generic protocol failure code.
- inferred: the full 159-code catalogue includes non-reachable or not-yet-emitted definitions; this unit does not claim universal runtime reachability.
- repository-proven: detector component is not treated as automatic pathogenic cause.

## Migration Boundary

- repository-proven: v12 migration is forward-only and additive to the v11 diagnostic ledger.
- test-validated: disposable migration fixtures from v1, v2, v7, v8 and v9 reopen successfully under v12.
- repository-proven: v12 does not modify submissions, pending events, cursors, purchases or hosted PostgreSQL.
- provider-unvalidated: no hosted migration exists or was applied.

## Failed/notApplied Boundary

- repository-proven: `Inspect failed/notApplied recovery` remains read-only and network-free.
- repository-proven: failed/notApplied execution remains absent from UI and source.
- repository-proven: unknown Retry remains isolated to unknown-outcome submission semantics.

## Terminal Markers

```text
DIAGNOSTIC_SINGLE_OWNER=PRESERVED
OPERATION_CHILD_MODEL=IMPLEMENTED
EVIDENCE_STATE_MACHINE=IMPLEMENTED
PROJECTION_BOUNDARIES=VALIDATED
DETECTOR_CAUSE_ATTRIBUTION=VALIDATED
FAILED_RECOVERY_EXECUTION=ABSENT
GATE_12_7=HELD
GCM02=OPEN
```
