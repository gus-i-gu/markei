# G_OPS_CODEX — C10-S02 Operational Evidence

Sequence: FLX-INV-02 -> Main D/E/F -> Codex materialization report
Role: Codex materialization evidence
Round or unit: C10-S02 disposable local retention, snapshot and rebootstrap proof
Branch: `intermid-cycle-recovery`
Baseline / inspected HEAD: `dee41af3a24bf85e4dcd7db40d3e1179bf0a7471`
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, disposable Docker PostgreSQL 18 lab, Flutter/Drift, loopback Fastify, synthetic fixtures only

## Source stage files

- `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Files changed

- `clients/markei_flutter/lib/application/sync/sync_ports.dart`
- `clients/markei_flutter/lib/domain/sync/sync_event.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.g.dart`
- `clients/markei_flutter/lib/infrastructure/local/sync/local_recovery_repositories.dart`
- `clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart`
- `clients/markei_flutter/test/infrastructure/local_database_migration_test.dart`
- `clients/markei_flutter/test/sync/real_convergence_harness_support.dart`
- `clients/markei_flutter/test/sync/real_recovery_harness_test.dart`
- `contracts/shared_beta/recovery_v1/README.md`
- `contracts/shared_beta/recovery_v1/fixtures/recovery_manifest.valid.json`
- `contracts/shared_beta/recovery_v1/recovery_snapshot.schema.json`
- `services/markei_sync_api/package.json`
- `services/markei_sync_api/migrations/003_retention_snapshot_recovery.sql`
- `services/markei_sync_api/src/application/recovery_service.ts`
- `services/markei_sync_api/src/application/retention_policy.ts`
- `services/markei_sync_api/src/application/sync_service.ts`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/src/lab.ts`
- `services/markei_sync_api/src/recovery_lab.ts`
- `services/markei_sync_api/test/protocol.test.ts`

## Files created

- `contracts/shared_beta/recovery_v1/*`
- `services/markei_sync_api/migrations/003_retention_snapshot_recovery.sql`
- `services/markei_sync_api/src/application/recovery_service.ts`
- `services/markei_sync_api/src/application/retention_policy.ts`
- `services/markei_sync_api/src/recovery_lab.ts`
- `clients/markei_flutter/lib/infrastructure/local/sync/local_recovery_repositories.dart`
- `clients/markei_flutter/test/sync/real_recovery_harness_test.dart`

## Files deleted

- None.

## Implementation summary

- Added recovery snapshot format 1 contracts and fixture hash parity while keeping `purchase.registered` payload version 3.
- Added forward-only PostgreSQL migration `003_retention_snapshot_recovery.sql`; 001/002 were not edited.
- Added explicit retention policy and clock injection; normal runtime has no cleanup route.
- Added Device retention classification, snapshot build/publication, cleanup planning/execution and rebootstrap session services.
- Added Fastify capabilities and rebootstrap routes.
- Added lab-only `npm run lab:recovery` worker CLI for snapshot/cleanup; no Flutter endpoint performs physical cleanup.
- Added additive Drift schema v6 recovery session/chunk progress and fresh-target snapshot apply adapters.
- Added disposable recovery harness proving snapshot, cleanup, cursor expiry, interrupted/resumed chunk transfer, corrupt chunk rejection, catch-up, acknowledgement, reopen comparison and local-change blocking.

## Commands run and results

- `git fetch origin intermid-cycle-recovery`: passed.
- `git merge-base --is-ancestor dee41af3a24bf85e4dcd7db40d3e1179bf0a7471 HEAD`: passed.
- Baseline `flutter test test/sync/local_sync_application_test.dart test/sync/v3_contract_test.dart`: passed 6 tests.
- Baseline `npm test`: passed 3 tests.
- `dart run build_runner build --delete-conflicting-outputs`: passed; Drift output regenerated.
- `npm run typecheck`: passed.
- `flutter analyze`: passed.
- Focused `flutter test test/sync/local_sync_application_test.dart test/sync/v3_contract_test.dart test/infrastructure/local_database_migration_test.dart`: passed 10 tests.
- Lab `MARKEI_RUN_SYNC_LAB=1 flutter test test/sync/real_recovery_harness_test.dart`: passed 1 test; terminal diagnostic `RECOVERY_CONVERGED=true`.
- `dart format --set-exit-if-changed lib test`: passed after formatting.
- Full `flutter test`: passed 52 tests, 2 lab-gated tests skipped.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 5 tests.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `python -m pytest`: failed, `No module named pytest`.
- `python -m unittest discover -s tests`: passed 5 tests.
- Disposable PostgreSQL migration/RLS/role probe: passed; 003 replayed idempotently, 5 new tables present, runtime RLS saw 1 scoped Device, runtime DDL denied, recovery worker Device revoke denied.
- `flutter build windows --release`: passed, built `build\windows\x64\runner\Release\markei.exe`.
- `flutter build apk --debug`: passed, built `build\app\outputs\flutter-apk\app-debug.apk`.
- `git diff --check`: passed with line-ending warnings only.
- Final `docker compose ps -a`: no sync lab containers.
- Final `docker volume ls --filter name=markei_sync_lab_pg`: no sync lab volume.

## Counts and ranges

- Recovery harness devices: A/B/C.
- Server events created: 3 synthetic `purchase.registered` v3 events.
- Snapshot cut: `c10b:2`.
- Cleanup blocked before C lease expiry: deleted 0.
- Cleanup after C lease expiry: deleted 2.
- Events retained after cleanup: 1 later event.
- Recovered fresh target facts after catch-up/reopen: 3 purchases.
- Corrupt snapshot apply target facts: 0 purchases.

## Instructions completed

- Local-only retention, snapshot, cleanup, cursor-expiry and rebootstrap proof.
- Synthetic fixtures only.
- No Neon/Auth0/Render/provider access.
- Cleanup disabled in normal HTTP composition.
- Recovery report files replaced only after materialization.

## Instructions skipped or excluded

- `pytest` was unavailable on host; unittest discovery was used and passed.
- Full runtime acceptance is local lab only; no provider behavior claimed.
- Cycle 11 UI/UX work was not implemented.

## Failures or blockers

- No terminal blocker remains for C10-S02 local proof.

## Unresolved risks

- Production retention durations, scheduler/worker hosting, object storage, provider backup integration, auth/enrollment, Device replacement and database swap remain deferred.
- The lab snapshot builder folds the append-only v3 event slice; it is not a production normalized snapshot store.

## Suggested functional follow-up

- Main/functional chats should reconcile C10-S02 evidence before MCG-01/C10-S03.

Terminal state:

```text
C10-S02_LOCAL_RECOVERY_PROVED
MCG-01_EVIDENCE_NOT_RECONCILED
```
