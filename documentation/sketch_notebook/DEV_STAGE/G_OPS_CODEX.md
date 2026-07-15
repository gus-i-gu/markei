# G_OPS_CODEX — C10-S01 Codex Operational Evidence

Sequence: FLX-ORD-01
Role: Codex materialization
Unit: C10-S01 Disposable Local Synchronization Proof
Branch: `intermid-cycle-recovery`
Baseline HEAD: `0ee329a0f2eb8bb1ade304c754bf00d3e4854d3a`
Source stages: `[M]_STAGE/J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Terminal status: `WAITING_FOR_MCG_01`

## Changed Path Inventory

Created:

- `.gitignore`
- `contracts/shared_beta/v3/**`
- `clients/markei_flutter/lib/domain/sync/canonical_json.dart`
- `clients/markei_flutter/lib/application/sync/**`
- `clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart`
- `clients/markei_flutter/test/sync/**`
- `clients/markei_flutter/tool/sync_lab.dart`
- `services/markei_sync_api/**`
- `infra/sync_lab/**`

Modified:

- `clients/markei_flutter/lib/domain/sync/sync_event.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.g.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_device_identity_repository.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/test/infrastructure/local_database_migration_test.dart`
- `clients/markei_flutter/test/infrastructure/local_device_identity_repository_test.dart`
- `clients/markei_flutter/test/local_purchase_repository_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Pre-existing untracked `.vscode/settings.json` was preserved and not staged.

## Dependency Versions

- Dart `3.12.2`; Flutter `3.44.6`.
- Node `v24.18.0`; npm `11.16.0`.
- Docker Desktop `4.82.0`, engine `29.6.1`; PostgreSQL image `postgres:18`.
- API dependencies pinned in `services/markei_sync_api/package-lock.json`: Fastify `5.10.0`, `pg` `8.16.3`, TypeScript `5.9.3`.

## Commands And Results

- `git fetch origin intermid-cycle-recovery`: pass.
- `git pull --ff-only origin intermid-cycle-recovery`: pass, already up to date.
- `git merge-base --is-ancestor 0ee329a0f2eb8bb1ade304c754bf00d3e4854d3a HEAD`: pass.
- Baseline `flutter analyze`: pass.
- Baseline `flutter test`: pass.
- Baseline `python -m unittest discover tests`: pass, 5 tests.
- `dart run build_runner build --delete-conflicting-outputs`: pass; option reported removed/ignored by current build_runner; generated Drift output.
- `dart format --output=none --set-exit-if-changed lib test tool`: pass after `tool/` existed; initial baseline reported missing `tool`.
- `flutter analyze`: pass.
- `flutter test`: pass, 52 tests. Drift emitted debug reopen warnings in the two-file harness; assertions passed.
- `npm install`, then `npm install fastify@5.10.0`: pass; final `npm audit --omit=dev`: 0 vulnerabilities.
- `npm run format:check`, `npm run lint`, `npm run typecheck`, `npm test`: pass.
- `docker compose -f infra/sync_lab/compose.yaml up -d --wait`: pass after correcting PostgreSQL 18 mount to `/var/lib/postgresql`.
- SQL migration via container `psql`: pass.
- Runtime DDL denial probe: pass by expected failure, `permission denied for schema public`.
- RLS cross-Account insert probe: pass by expected failure, row violates RLS policy.
- `flutter build windows --release`: pass, built `build/windows/x64/runner/Release/markei.exe`.
- `flutter build apk --debug`: pass, built `build/app/outputs/flutter-apk/app-debug.apk`.
- `git diff --check`: pass; Git reported CRLF conversion warnings only.
- Secret scan over changed/untracked implementation files: no credential values found; only variable names, comments and ignored secret paths matched.
- `docker compose -f infra/sync_lab/compose.yaml down --volumes`: pass; disposable container and volume removed.

## Local Two-Device Counts

Executable Flutter harness: `test/sync/two_device_system_harness_test.dart`.

- local01 Purchases after offline registration: 1.
- local01 Submission retry after unknown outcome: same `SubmissionId`.
- local02 applied inbox records after replaying same Event page twice: 1.
- local02 greatest contiguous applied cursor: `1`.
- Reopen check: local01 Purchases 1, local02 inbox 1.

This harness validates the local Drift side. Full cross-process API/PostgreSQL upload/download convergence remains partial in this materialization.

## Fault-Injection Results

Covered by automated tests/probes:

- API unavailable while local registration continues.
- Unknown outcome retries same SubmissionId.
- Duplicate inbox event is ignored.
- Acknowledgement waits for committed local cursor.
- v4→v5 migration, fresh v5, reopen, ambiguous-device migration failure, no earliest-device selection.
- Cross-language v3 hash parity.
- Fixture-auth escape prevention.
- Runtime-role DDL denial.
- Cross-Account RLS denial.

Partially covered or deferred:

- Full server serialization retry, pool exhaustion, crash-phase simulation and cross-process timeout-after-commit are not fully implemented.
- Remote apply currently records inbox/cursor evidence; complete Purchase aggregate fact application from downloaded payload is not fully materialized.

## Provider And Artifact Boundary

Neon, production authentication and deployment were not used. No provider secrets were requested. Generated lab secret file stayed ignored. Disposable Docker resources were torn down.

## Remaining Risks

The local proof is useful but incomplete against the full D/E/F floor: server integration tests are thin, the API upload path is not yet exercised against the running container by automated tests, and remote aggregate application needs completion before MCG-01 can be treated as fully satisfied.

WAITING_FOR_MCG_01
