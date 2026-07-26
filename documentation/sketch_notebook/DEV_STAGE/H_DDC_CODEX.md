# H_DDC_CODEX - Step 12 Diagnostic Meaning Projection

Sequence: FLX-ORD-01 - Ordinary Sequence
Unit: C10-GCM02-S12-ERR-01
Role: Codex didactic report
Evidence boundary: observational explanation only; no didactic promotion or methodology edit was performed.

## Meaning Model

- repository-proven: the Sync diagnostic registry is now the single hand-maintained code list for 159 `MKS-*` diagnostics; Dart, TypeScript and Markdown are generated projections.
- repository-proven: registry entries distinguish detector component from proved cause domain. Boundary-adjacent Auth0, Render, Neon, PostgreSQL or HTTP components are not named as causes unless evidence proves them.
- repository-proven: public UI/log visibility is constrained by each entry's forbidden sensitive fields: tokens, passwords, payload JSON, connection strings, full hashes, private URLs, stack traces and SQL are rejected by validation.
- repository-proven: `documentation/SYNC_DIAGNOSTICS.md` explains layers, severity, outcomes, phases, causal attribution, native-code mappings, safe actions, retry policies, generic-500 unknown-outcome behavior and privacy/redaction.

## UI Projection

- repository-proven: the Closure UI label now says `Retry unknown-outcome submission`; this preserves the fact that the existing action only accepts an isolated unknown-outcome submission.
- repository-proven: blocked unknown retry for failed=2/unknown=0 now projects as `MKS-UI-001` with outcome `blocked`, local mutation `none`, provider contact `not-started`, and safe action to inspect failed/notApplied evidence.
- repository-proven: the page separates current action result from last ordinary Sync result, last successful Sync and recent diagnostics timeline.
- repository-proven: blocked/error/unknown actions show MKS code, title, meaning, outcome, last proved phase, mutation/contact state, safe action and operation fingerprint.
- repository-proven: sanitized expandable technical details expose only counts, sequence ranges, booleans, fingerprints and sanitized exception class.

## Failed Versus Unknown

- repository-proven: unknown-outcome retry remains identity-preserving and eligible only for isolated unknown work.
- repository-proven: failed/notApplied inspection is separate, read-only, current-device scoped, and emits no recovery/transmission callback.
- repository-proven: ordinary Sync still includes failed recovery followed by upload/download/acknowledgement; therefore ordinary Sync remains semantically distinct from read-only inspection.
- inferred: Main should preserve terminology that `Inspect failed/notApplied recovery` is evidence gathering, not authorization to recover.

## Error Semantics

- test-validated: request-start without trusted provider outcome after a committed local lease becomes `unknownOutcome`; local submission identity is preserved.
- test-validated: scoped local result-persistence miss is a typed invariant, not a silent no-op.
- test-validated: public unexpected API 500 stays sanitized as `service-unavailable` with `outcome: unknown` but is not retryable solely because it is HTTP 500.
- unavailable: live provider logs, Auth0 behavior, Render behavior and Neon transaction evidence were not contacted and remain outside this report.

DIAGNOSTIC_MEANING_PROJECTION_IMPLEMENTED
GENERATED_DOCUMENTATION_VALIDATED
CURRENT_AND_HISTORICAL_RESULTS_SEPARATED
FAILED_NOT_APPLIED_INSPECTION_READ_ONLY
NO_PROVIDER_AUTHORIZATION
GATE_12_7_HELD
GCM02_OPEN
