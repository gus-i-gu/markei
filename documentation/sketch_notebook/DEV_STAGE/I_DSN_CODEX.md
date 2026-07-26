# I_DSN_CODEX — ERR-04 Design Evidence

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex design evidence
Round or unit: C10-GCM02-S12-ERR-04 within C10-GCM02-S12-SYNC-01
Branch: `cycle10-intermid-grimoire`
Authority: D/E/F synchronized ERR-04 staging
Evidence boundary: repository inspection and local validation only

## Boundary Changes

- repository-proven: the ordinary Sync command boundary is separated from the controlled failed/notApplied recovery command boundary. `HostedSyncCoordinator.run()` begins ordinary upload after authentication and binding.
- repository-proven: controlled recovery still owns candidate revalidation, failed-to-recovered transition, exact batch lease, one upload, and stop-after-upload-result-persistence through `FailedNotAppliedRecoveryCoordinator` and `NativeAuthClosureRunner.recoverFailedNotAppliedCandidate()`.
- repository-proven: ordinary Sync can reuse upload/download/acknowledgement primitives without calling the controlled recovery use case.
- repository-proven: the `recoverFailedNotApplied` field remains in `HostedSyncCoordinator` only for constructor compatibility; it is not part of the ordinary runtime dependency chain.

## State And Sequence Invariants

- test-validated: file-backed failed/notApplied rows remain `failed` after ordinary coordinator runs.
- test-validated: ordinary coordinator with only failed/notApplied work performs zero uploads and leaves the failed submission unchanged.
- test-validated: ordinary pending work still uploads through the normal pending lease path.
- test-validated: explicit failed/notApplied recovery tests still validate one bounded transition, one exact lease, one upload, no download, no acknowledgement, no automatic repetition, and no `MKS-UI-004` for eligible preflight.
- repository-proven: no schema or migration change was introduced.

## Identity And Evidence Model

- repository-proven: every top-level ordinary Sync action receives a random operation ID and sanitized operation fingerprint.
- repository-proven: phase events receive distinct child correlation IDs and sanitized 12-hex fingerprints through `_DiagnosticOperationRecorder`.
- repository-proven: HTTP transport continues to propagate the full client child correlation identity through `x-correlation-id` and parent operation identity/fingerprint through `x-operation-id` and `x-operation-fingerprint`.
- repository-proven: the API now generates its own Fastify request ID independently of `x-correlation-id`, preserving server request ownership.
- repository-proven: API lifecycle projection contains both `clientChildCorrelationFingerprint` and `serverRequestFingerprint`; `correlationFingerprint` remains server-request-owned for backward compatibility.
- test-validated: API protocol tests prove both fingerprints are separately present, 12-hex sanitized, and not populated with injected raw header text.

## Projection Architecture

- repository-proven: aggregate Closure attempt rows no longer infer absent provider contact or missing response headers from parent-row nulls.
- repository-proven: child/phase evidence remains the source for contact, trusted response, local mutation, and result-persistence axes.
- repository-proven: server-request success is not projected as aggregate client Sync success; the UI retains the explicit `Server request: not aggregate success` declaration.
- inferred: a fuller local aggregate summary could be derived from all child rows in a later unit, but ERR-04 intentionally avoids migration or broad diagnostic refactoring.

## Validation Summary

- test-validated: focused Flutter tests cover ordinary/controlled recovery separation, pending upload preservation, lifecycle line schema/redaction, sink failure isolation, and aggregate wording.
- test-validated: local sync tests cover file-backed failed-state immobility and existing explicit recovery invariants.
- test-validated: API protocol tests cover paired client-child/server-request lineage and redaction.
- test-validated: full Flutter and full API suites passed.
- unavailable: broad API format check remains blocked by unrelated pre-existing `test/sync_diagnostics_registry.test.ts` formatting; changed TypeScript files passed targeted Prettier.
- unavailable: no live provider, hosted assay, deployment, or user database action was performed.

## Terminal Markers

```text
ORDINARY_CONTROLLED_RECOVERY_BOUNDARY=SEPARATED
FAILED_STATE_INVARIANT=VALIDATED
SEQUENCE_REPLAY_INVARIANT=VALIDATED
CLIENT_OBSERVER_ARCHITECTURE=BOUNDARY_STABLE
CLIENT_SERVER_LINEAGE=VALIDATED
AGGREGATE_PHASE_EVIDENCE_MODEL=TRUTHFUL
NO_DIAGNOSTIC_PROVIDER_CALL=PASS
NO_SCHEMA_MIGRATION=PASS
GATE_12_7=HELD
GCM02=OPEN
```
