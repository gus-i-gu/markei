# I_DSN_CODEX - Step 12 Diagnostic Registry And Recovery Boundaries

Sequence: FLX-ORD-01 - Ordinary Sequence
Unit: C10-GCM02-S12-ERR-01
Role: Codex design report
Evidence boundary: architecture/materialization observation only; no provider action, recovery execution, Gate 12.7 authorization, or source promotion was performed.

## Ownership And Dependency Direction

- repository-proven: `contracts/shared_beta/diagnostics_v1/diagnostics.registry.json` owns diagnostic definitions; generated Dart, generated TypeScript and Markdown depend on it.
- repository-proven: generator validation enforces 159 unique codes, source-reference existence, closed vocabulary, sensitive-field bans and stale output detection.
- repository-proven: Flutter UI and API can use typed lookup from generated projections; the registry remains the only hand-edited diagnostic list.
- repository-proven: local diagnostic persistence is additive Drift v11: `sync_attempts` remains the parent operation row and `sync_diagnostic_events` stores ordered child diagnostics.

## Responsibility Boundaries

- repository-proven: UI responsibility is presentation, action naming, lock release and current-action state retention.
- repository-proven: diagnostics repository responsibility is local read-only evidence gathering, queue counts, current binding checks, failed/notApplied candidate inspection and sanitized diagnostic child-event persistence.
- repository-proven: local outbox responsibility is lease, identity preservation, result persistence, failed/notApplied validation and recovery requeue. Recovery execution still exists only inside ordinary Sync/coordinator flow.
- repository-proven: transport responsibility is protocol/HTTP mapping; no provider-contact inference is promoted without trusted response evidence.
- repository-proven: hosted API responsibility is route-scoped protected operation validation, transaction-scoped writes and sanitized public failures.

## State Machine Findings

- repository-proven: ordinary coordinator ordering remains authentication -> binding guard -> failed recovery -> upload lease -> upload transport/provider/result persistence -> download -> local apply -> acknowledgement -> terminal projection.
- repository-proven: unknown retry and failed/notApplied recovery are intentionally distinct mechanisms. Unknown retry preserves one unknown submission identity; failed/notApplied recovery supersedes failed submission identity before pending upload and is not exposed as an execution action in this unit.
- test-validated: failed/notApplied inspection validates exactly one current-device candidate, membership, contiguous sequences, request-hash equality, member-state compatibility, no accepted members, no active overlap and next-sequence match without mutation/network.
- test-validated: mixed failed recovery member states block and roll back.
- test-validated: after a committed upload lease, transport exceptions persist an unknown result rather than stranding uploading rows.
- test-validated: provider upload validates complete submission before writes; later-member failure does not create provider events, submissions, cursor movement or device-sequence movement.
- test-validated: duplicate-only local download pages advance the contiguous cursor transactionally.

## Implementation Drift And Remaining Boundaries

- inferred: the largest remaining architectural ambiguity is semantic authorization for Gate 12.7 execution, not source capability. The UI now exposes inspection evidence but no recovery execution callback.
- unavailable: live provider transaction correlation, Auth0/Render/Neon behavior and user database state were intentionally not observed.
- provisional: future Main reconciliation can decide whether Gate 12.7 uses ordinary Sync, a new confirmed failed/notApplied recovery action, or additional provider/log evidence.

## Gate 12.7 Authorization Packet Skeleton

- candidate diagnostic code: PENDING
- candidate fingerprint: PENDING
- member count: PENDING
- first Device sequence: PENDING
- last Device sequence: PENDING
- next Device sequence: PENDING
- request-hash equality: PENDING
- current Account/Device binding: PENDING
- no unrelated active work: PENDING
- provider action authorization: PENDING
- local mutation authorization: PENDING
- operator command/action: PENDING

This skeleton is not authorization.

DIAGNOSTIC_REGISTRY_SINGLE_OWNER_IMPLEMENTED
DETECTOR_CAUSE_BOUNDARY_VALIDATED
UNKNOWN_OUTCOME_SAFETY_PRESERVED
FAILED_NOT_APPLIED_PREFLIGHT_NON_MUTATING
FAILED_NOT_APPLIED_EXECUTION_ABSENT
PROVIDER_ACTION_ABSENT
GATE_12_7_HELD
GCM02_OPEN
