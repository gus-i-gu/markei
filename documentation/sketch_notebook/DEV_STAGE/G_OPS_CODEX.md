# G_OPS_CODEX — ERR-04 Operational Materialization Evidence

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex operational evidence
Round or unit: C10-GCM02-S12-ERR-04 within C10-GCM02-S12-SYNC-01
Branch: `cycle10-intermid-grimoire`
Baseline / inspected HEAD: `a5d198daff698a14ba932579dd867de716ed1038`
Authority: D/E/F synchronized ERR-04 staging
Writable surfaces: task-relevant Flutter/API source and tests; G/H/I reports
Evidence boundary: repository inspection and local validation only

## Operational Changes

- repository-proven: `HostedSyncCoordinator.run()` no longer invokes the failed/notApplied recovery use case during ordinary Sync. The former `failed-recovery` phase and unconditional `recoverFailedNotApplied()` call were removed from the ordinary path.
- repository-proven: the `RecoverFailedNotApplied` constructor dependency remains in `HostedSyncCoordinator` for compatibility with existing composition/test call sites, but ordinary `run()` does not read or call it.
- repository-proven: ordinary Sync still performs authentication, Device binding, ordinary pending upload, download/apply, acknowledgement, and terminal persistence.
- repository-proven: explicit failed/notApplied recovery remains available only through `NativeAuthClosureRunner.recoverFailedNotAppliedCandidate()` and the separate confirmed UI action.
- repository-proven: `NativeAuthClosureRunner` now accepts an injectable `NativeClosureLifecycleSink`; the default sink emits compact one-line JSON through `debugPrint`.
- repository-proven: lifecycle output includes `client-operation` and `client-phase` scopes, operation kind, result/native codes, MKS code where relevant, phase, operation/correlation fingerprints, 35000 ms ordinary-Sync deadline, elapsed band, provider/trusted-response/local-mutation/result-persistence states, and safe next action.
- repository-proven: lifecycle sink failures are caught and cannot change Closure behavior.
- repository-proven: Closure aggregate attempt wording now says aggregate HTTP status/headers are not applicable and points to child requests instead of saying status not observed or headers not received.
- repository-proven: API lifecycle events retain `declarationScope=server-request` and now expose both `clientChildCorrelationFingerprint` from the propagated client header and `serverRequestFingerprint` from Fastify/server request ownership. Existing `correlationFingerprint` remains server-request-owned for compatibility.
- repository-proven: Fastify request IDs are independently generated instead of reusing `x-correlation-id`.

## Changed Paths

- `clients/markei_flutter/lib/application/hosted_sync_coordinator.dart`
- `clients/markei_flutter/lib/app/native_auth_closure_runner.dart`
- `clients/markei_flutter/lib/app/pages/native_closure_page.dart`
- `clients/markei_flutter/test/app/native_closure_diagnostics_test.dart`
- `clients/markei_flutter/test/sync/local_sync_application_test.dart`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/test/protocol.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

## Validation Evidence

- test-validated: `dart format clients/markei_flutter/lib/application/hosted_sync_coordinator.dart clients/markei_flutter/lib/app/native_auth_closure_runner.dart clients/markei_flutter/lib/app/pages/native_closure_page.dart clients/markei_flutter/test/app/native_closure_diagnostics_test.dart` completed.
- test-validated: `dart format clients/markei_flutter/test/sync/local_sync_application_test.dart` completed.
- test-validated: `flutter test test/app/native_closure_diagnostics_test.dart` passed: 21 tests.
- test-validated: `flutter test test/infrastructure/native_auth_composition_test.dart test/sync/local_sync_application_test.dart test/infrastructure/http_sync_transport_device_header_test.dart test/infrastructure/closure_diagnostics_repository_test.dart` passed: 59 tests.
- test-validated: `flutter test` passed: 194 tests passed, 4 skipped lab/provider harnesses.
- test-validated: `flutter analyze` passed with no issues.
- test-validated: `npm exec prettier -- --write src/http/app.ts test/protocol.test.ts` completed.
- test-validated: `npm exec prettier -- --check src/http/app.ts test/protocol.test.ts` passed for changed TypeScript files.
- test-validated: `npm run lint` passed.
- test-validated: `npm run typecheck` passed.
- test-validated: `npm run build` passed.
- test-validated: `npm test -- test/protocol.test.ts` passed: 58 tests.
- test-validated: `npm test` passed: 58 tests.
- test-validated: `node scripts/generate_sync_diagnostics.mjs --check` passed.
- test-validated: `npm run diagnostics:check` from `services/markei_sync_api` passed.
- unavailable: repository-root `npm run diagnostics:check` failed because the repository root has no `package.json`; the service package script and direct node generator check passed.
- unavailable: broad `npm run format:check` in the API package still fails only on pre-existing unrelated `test/sync_diagnostics_registry.test.ts`; changed TypeScript files passed targeted Prettier check.

## Operational Risks And Exclusions

- unavailable: no live Windows, Android, Render, Auth0, Neon, hosted readiness, ordinary Sync, Retry, recovery, deployment, or user-database action was performed.
- provisional: default lifecycle output is debug/assay terminal output from the Closure runner; release UI projection remains the durable user-facing surface.
- repository-proven: no schema migration was introduced.
- inferred: the compatibility-retained `recoverFailedNotApplied` coordinator dependency can be removed in a later cleanup if Main authorizes broader constructor churn.

## Terminal Markers

```text
ORDINARY_SYNC_IMPLICIT_RECOVERY=REMOVED
FAILED_WORK_IMMOBILE_DURING_ORDINARY_SYNC=VALIDATED
EXPLICIT_RECOVERY_ENTRYPOINT=PRESERVED
CLIENT_TERMINAL_LIFECYCLE_LOGS=IMPLEMENTED
SERVER_REQUEST_LIFECYCLE_LOGS=PRESERVED
AGGREGATE_CHILD_PROJECTION=CORRECTED
CLIENT_SYNC_DEADLINE_35S=PRESERVED
AUTOMATIC_RETRY=ABSENT
LIVE_PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD
GCM02=OPEN
```
