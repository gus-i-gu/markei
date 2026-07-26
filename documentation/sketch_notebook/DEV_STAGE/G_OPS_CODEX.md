# G_OPS_CODEX — C10-GCM02-S12-ERR-03

Unit: C10-GCM02-S12-ERR-03 within sequence C10-GCM02-S12-SYNC-01
Evidence class: Codex observational report

## Operational Result

- repository-proven: Work was performed in the isolated worktree `H:\Users\Gus\source\repo\markei-sync01` on detached `HEAD` at authorized baseline `0932956dac69ec20d0de994fab7354ee9dea711d`.
- repository-proven: Initial fetch, ancestry, remote-alignment, D/E/F synchronization, and clean-worktree checks passed before editing.
- repository-proven: No D/E/F, J, methodology, permanent-domain, hosted migration, provider configuration, or user database files were modified.
- repository-proven: No live hosted request, ordinary Sync, Retry, recovery execution, deployment, Auth0, Render, or Neon action was performed.

## Source Changes

- repository-proven: `HttpSyncTransport` now has an explicit hosted ordinary-Sync default timeout of 35 seconds and propagates `x-operation-id`, `x-operation-fingerprint`, `x-correlation-id`, and `x-declaration-scope` through protected requests.
- repository-proven: `NativeAuthClosureRunner` creates one operation identity per top-level ordinary Sync action, wraps coordinator execution in operation scope, records terminal client-operation declarations, and maps ordinary Sync terminals to `sync-completed`, `sync-no-new-events`, `sync-rejected`, `sync-server-timeout`, or `sync-failed`.
- repository-proven: `HostedSyncCoordinator` maps request-start/no-trusted-response failures to `sync-failed`; trusted not-applied rejection branches map to `sync-rejected`; `sync-server-timeout` remains reserved for a proved server-owned timeout.
- repository-proven: Closure diagnostics last-success lookup now requires `operationKind=ordinary-sync`, `outcomeClass=completed`, `resultCode in (sync-completed, sync-no-new-events)`, and non-null `completedAt`.
- repository-proven: Closure UI now labels the list as `Recent Closure attempts`, keeps readiness distinct from Sync success, and exposes compact client-operation declaration fields in the Sync overview.
- repository-proven: API lifecycle logs now emit server-request declarations with explicit `declarationScope=server-request`, `operationKind=server-request`, result code, route class, sanitized operation fingerprint, and sanitized correlation fingerprint.
- repository-proven: The diagnostic generator and registry test now use `documentation/ERR_DIAGNOSTICS.md`; `SYNC_DIAGNOSTICS.md` was not restored.

## Timing And Timeout Evidence

- repository-proven: Client configured deadline is `35000ms`, owned by the client.
- repository-proven: No 25-second server deadline was implemented because this round did not prove a database-wide cancellation/rollback primitive beyond existing transaction rollback boundaries. A Promise race while database work continues remains prohibited.
- repository-proven: Client timeout before trusted response is represented as `sync-failed` with unknown provider transaction evidence, not `sync-server-timeout`.

## Validation Commands

- test-validated: `node scripts/generate_sync_diagnostics.mjs` completed.
- test-validated: `npm run diagnostics:check` passed.
- test-validated: deterministic second generator check passed by rerunning `npm run diagnostics:check` after generation.
- test-validated: `dart format --set-exit-if-changed ...` passed after formatting rewrites.
- test-validated: `flutter analyze` passed with no issues.
- test-validated: focused Flutter tests passed: `flutter test test\app\native_closure_diagnostics_test.dart test\infrastructure\http_sync_transport_device_header_test.dart test\infrastructure\closure_diagnostics_repository_test.dart test\infrastructure\native_auth_composition_test.dart`.
- test-validated: full Flutter suite passed: 190 pass, 4 skipped lab-gated tests.
- test-validated: targeted API Prettier check on changed TypeScript files passed.
- test-validated: `npm run lint`, `npm run typecheck`, `npm run build`, and `npm test` passed; API tests: 58 pass.
- unavailable: full API `npm run format:check` remains blocked by 37 pre-existing repository formatting warnings outside this unit.

## Residual Operational Risks

- provisional: `sync-server-timeout` is reserved but not currently emitted by a server-owned deadline because authoritative cancellation/rollback semantics were not implemented.
- unavailable: Windows release validation, Android validation, Render validation, Auth0 validation, Neon validation, live provider validation, and live end-to-end convergence were not performed.

ORDINARY_SYNC_TERMINAL_VOCABULARY=IMPLEMENTED
CLIENT_OPERATION_DECLARATION=IMPLEMENTED
SERVER_REQUEST_DECLARATION=IMPLEMENTED
LAST_SUCCESSFUL_SYNC_FILTER=CORRECTED
HOSTED_READINESS_SEPARATION=VALIDATED
CLIENT_SYNC_DEADLINE_35S=IMPLEMENTED
SERVER_TIMEOUT_ROLLBACK=NOT_IMPLEMENTED_WITH_REASON
AUTOMATIC_RETRY=ABSENT
LIVE_PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD
GCM02=OPEN
