# I_DSN_CODEX - DIAG-01 Design Evidence

Sequence: FLX-ORD-01 - Ordinary Sequence
Role: Codex design evidence
Unit: C10-GCM02-S12-DIAG-01
Branch: `cycle10-intermid-grimoire`
Authority: D/E/F synchronized DIAG-01 staging
Evidence boundary: repository inspection and local validation only

## Boundary Findings

- repository-proven: the Closure Diagnostics command boundary is read-only and local. It reads runner status plus the diagnostics repository snapshot and performs no provider request or queue mutation.
- repository-proven: hosted readiness and ordinary Sync remain independent top-level actions.
- repository-proven: unknown Retry, failed/notApplied inspection, explicit failed/notApplied recovery, and history clear remain independent action boundaries.
- repository-proven: ERR-04 ordinary Sync and controlled recovery separation was not modified.
- repository-proven: no API, database schema, migration, registry, generator, or provider-facing implementation changed.

## Operation Group Model

- repository-proven: lifecycle declarations are grouped by parent operation fingerprint when available, with attempt fingerprint fallback and an explicit unknown-operation fallback.
- repository-proven: groups are projected in repository snapshot order, preserving the newest-first ordering supplied by local diagnostics.
- repository-proven: compact phase summaries are deterministic per group and keyed by phase plus ordinal.
- repository-proven: result-bearing declarations replace earlier pre-result declarations for the same phase in compact view, while every raw declaration remains available below the group.
- repository-proven: terminal declarations are retained in compact summaries and determine the operation status before phase-local pre-result rows.
- repository-proven: failed/error/blocked outcomes remain status-bearing and are not hidden by grouping.

## State And Projection Invariants

- repository-proven: Diagnostics does not invoke Sync, Retry, recovery, enrollment, logout, history clear, or hosted connection checks.
- repository-proven: queue-state and Next Device sequence values are displayed from the local snapshot and are not changed by the Diagnostics UI action.
- repository-proven: Last successful Sync predicate remains in existing diagnostics source; DIAG-01 did not alter it or allow hosted readiness to advance it.
- repository-proven: the ordinary Sync 35000 ms client deadline remains unchanged.
- test-validated: focused widget tests verify the consolidated control, local-only diagnostics behavior, operation grouping, pre-result/result pairing, raw preservation, and genuine failure visibility.
- test-validated: full Flutter tests and Flutter analyze passed after the projection change.

## Remaining Risks

- unavailable: live Windows terminal output and hosted/provider behavior were not validated.
- unavailable: second-device convergence and provider row contents remain outside this Flutter-only projection correction.
- inferred: if a future diagnostic source produces lifecycle rows without stable operation or attempt fingerprints, they will be grouped under `unknown-operation`; that fallback is explicit but less informative.

## Terminal Markers

```text
DIAGNOSTICS_COMMAND_BOUNDARY=READ_ONLY
DIAGNOSTICS_SUBCHECKS=SEPARATELY_PROJECTED
OPERATION_GROUP_MODEL=DETERMINISTIC
PHASE_PAIRING=TRUTHFUL
TRUE_FAILURE_RETENTION=PASS
RAW_EVENT_PRESERVATION=PASS
HOSTED_READINESS_BOUNDARY=SEPARATE
ORDINARY_SYNC_BOUNDARY=SEPARATE
NO_SCHEMA_API_PROVIDER_EXPANSION=PASS
GATE_12_7=PASSED_PRIOR_SCOPE
GATE_12_8=NEXT_READ_ONLY
GCM02=OPEN
```
