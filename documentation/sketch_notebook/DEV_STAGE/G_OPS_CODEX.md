# G_OPS_CODEX — C10-GCM02-S12-ERR-02

Unit: C10-GCM02-S12-ERR-02 — Step 12 Diagnostic Runtime Completion
Branch: `cycle10-intermid-grimoire`
Observed starting HEAD: `d56c3a6d9f39c6a9812f7e274ea0a8134a602716`
Required ancestry: `0636c54e139fc92b16d1e11b2672d61f42f02f1b`
Evidence class: repository-proven and test-validated locally unless marked otherwise.

## Repository Safety

- repository-proven: branch was `cycle10-intermid-grimoire`.
- repository-proven: `0636c54e139fc92b16d1e11b2672d61f42f02f1b` is an ancestor of HEAD.
- repository-proven: local HEAD and `origin/cycle10-intermid-grimoire` had `0 0` divergence after fetch.
- repository-proven: initial worktree was clean.
- repository-proven: D/E/F contained `C10-GCM02-S12-ERR-02` and `ACTIVE — CODEX IMPLEMENTATION AUTHORIZED`.
- repository-proven: no provider, deployment, live Sync, Retry, Repair, Enroll, or user database operation was performed.

## Source Changes

- repository-proven: `HostedSyncCoordinator` now accepts a phase recorder and emits typed child evidence for authentication, binding, failed recovery, upload, download, acknowledgement and terminal branches.
- repository-proven: `UploadPendingEvents`, `DownloadAndApplyEvents`, and `AcknowledgeAppliedCursor` record phase-specific evidence and preserve provider result versus local result-persistence state.
- repository-proven: `NativeAuthClosureRunner.hostedSyncProbe` creates one random top-level operation identity per ordinary Sync action, assigns deterministic child ordinals, records distinct child correlation identities, and persists terminal causal summaries.
- repository-proven: `HttpSyncTransport` uses scoped child correlation IDs for protected HTTP requests when the diagnostic recorder provides them.
- repository-proven: Drift schema advanced to v12 with additive diagnostic envelope fields and migration ledger id `v11-to-v12-diagnostic-envelope-v1`.
- repository-proven: Closure diagnostics snapshot includes a recent diagnostic child timeline.
- repository-proven: Native Closure UI renders trusted-response and result-persistence state and exposes a recent diagnostic timeline.
- repository-proven: API unexpected errors now derive public and internal projections from one typed internal diagnostic event.
- repository-proven: public API diagnostic failures expose correlation fingerprints rather than full correlation IDs and omit exception class, SQLSTATE, messages, stack traces, SQL, payloads and raw IDs.
- repository-proven: `MKS-UPL-012` was removed as the generic API protocol failure code; upload, download, acknowledgement, binding and database conditions now map to narrower representative codes.

## Ordinary Sync Phase Coverage

Test-validated phase order in `native_closure_diagnostics_test.dart`:

```text
authentication
binding
failed-recovery
upload-lease
upload-transport
upload-provider
upload-result-persistence
download-transport
download-provider
download-local-apply
acknowledgement
terminal
```

Repository-proven: each recorded child carries diagnostic version 1, operation fingerprint, correlation fingerprint, ordinal, MKS code, native code, outcome, last proved phase, mutation/contact/trusted-response/provider-transaction/result-persistence state, retryability and safe action.

## Commands and Validation

Commands run:

```text
git branch --show-current
git rev-parse HEAD
git status --short
git remote -v
git fetch origin cycle10-intermid-grimoire
git merge-base --is-ancestor 0636c54e139fc92b16d1e11b2672d61f42f02f1b HEAD
git rev-list --left-right --count HEAD...origin/cycle10-intermid-grimoire
flutter pub run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed lib test
flutter analyze
flutter test test/infrastructure/closure_diagnostics_repository_test.dart
flutter test test/infrastructure/local_database_migration_test.dart
flutter test test/app/native_closure_diagnostics_test.dart
flutter test test/sync/local_sync_application_test.dart
flutter test test/sync/sync_diagnostic_registry_test.dart
flutter test test/infrastructure/native_auth_composition_test.dart
node scripts/generate_sync_diagnostics.mjs
node scripts/generate_sync_diagnostics.mjs --check
npm run diagnostics:check
npm run typecheck
npm run format:check
npm run lint
npm run build
npm test -- protocol.test.ts
flutter test
npm test
```

Results:

- test-validated: `flutter analyze` passed.
- test-validated: focused Flutter diagnostics/recovery/migration/sync suites passed.
- test-validated: `flutter test` passed with 184 passing tests and 4 lab-gated skips.
- test-validated: API format, lint, typecheck, build and full `npm test` passed with 58 passing tests.
- test-validated: registry generation and check mode passed; generated projections still derive from the single registry.
- host-unavailable: Windows release build, Android validation, Render, Auth0, Neon and live end-to-end convergence were not run and are not claimed.

## Residual Risks

- provider-unvalidated: no hosted provider evidence was collected in this unit.
- inferred: not every one of the 159 catalogue codes is runtime-reachable; this unit validates representative reachable branch attribution and preserves the registry as single owner.
- repository-proven: failed/notApplied inspection remains read-only; failed/notApplied execution remains absent.

## Terminal Markers

```text
ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED
PARENT_CHILD_CORRELATION=IMPLEMENTED
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED
REACHABLE_MKS_ATTRIBUTION=VALIDATED
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
DIAGNOSTIC_SINGLE_OWNER=PRESERVED
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD_FOR_RECONCILIATION
GCM02=OPEN
```
