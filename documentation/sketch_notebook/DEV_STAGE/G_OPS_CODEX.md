# G_OPS_CODEX - C10-S03A-R3C Operational Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex materialization evidence
Unit: C10-S03A-R3C decisive local proof completion
Branch: `intermid-cycle-recovery`
Baseline SHA: `ecfea32c3d72d9a8de74893df7ad29929dcc5ee1`
Final SHA: pending materialization commit
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, loopback HTTP, disposable PostgreSQL, synthetic identities only

## Result

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3C_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: the R3C producers are fail-closed and still incomplete. The authorization race producer reports missing required race cases; the migration-006 lifecycle/ACL probe proves only a subset; no full Fastify/PostgreSQL-backed Flutter producer or successful aggregate exists.

## Changed Paths

- `clients/markei_flutter/test/infrastructure/http_device_enrollment_transport_file_test.dart`
- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/proof/aggregate.ts`
- `services/markei_sync_api/src/proof/migration_006_probe.ts`
- `services/markei_sync_api/src/proof/producer.ts`
- `services/markei_sync_api/test/proof_aggregate.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No dependency or lockfile version changed. Migrations 001-006, Drift schema v7, J/D/E/F, A/B/C, methodology and permanent memory were not edited.

## Materialized Evidence

- Added a shared proof producer schema with exact required case inventories for authorization race, migration-006 lifecycle/ACL, JWKS state machine, route inventory, Flutter HTTP/file-backed and static-regression producers.
- Added a fail-closed proof aggregator that rejects missing, duplicate, malformed, unknown, partial, skipped or false producer cases.
- Extended the hosted-local harness to emit a machine-readable partial `authorization-race` producer instead of allowing its partial diagnostics to be mistaken for success.
- Added a migration-006 probe that checks the already migrated disposable database for readiness function shape, security-definer properties, ACLs and runtime denials without editing migrations.
- Added a real Flutter loopback HTTP/file-backed Drift test using `HttpDeviceEnrollmentTransport`, `HostedEnrollmentCoordinator`, `DriftHostedIdentityRepository`, a real pending outbox row and a temporary SQLite file.

## Producer Results

Hosted-local disposable PostgreSQL harness:

```text
AUTHORIZATION_RACE_MATRIX=partial
ROUTE_AUTHORIZATION_INVENTORY=true
LEAST_PRIVILEGE_HTTP=true
R3_LOCAL_SECURITY_PROVED=false
```

Authorization producer subset passed:

- `owner-target-revoke`
- `foreign-target-denial`
- `cross-account-target-denial`
- `conflicting-enrollment-request-hash`

Authorization producer missing required cases include membership disable/remove, external identity disable, actor-device revoked before every protected route class, owner/member status, self revoke denial, concurrent target revoke, equivalent enrollment concurrency, response-loss replay, process restart replay, serialization exhaustion and denied-no-state-advance.

Migration-006 probe subset passed:

- exact ledger identity/checksum
- no-argument function shape
- owner/security-definer/stable/search-path properties
- qualified ledger lookup/no dynamic SQL
- `PUBLIC` execute denial
- runtime execute on ready function only
- old parameterized probe denial
- direct ledger denial
- runtime DDL/role-admin denial

Migration-006 producer missing required cases: fresh 001-006, upgrade 001-005-006, duplicate runner behavior, disposable failure-copy rollback, canonical hash proof, migrator owner authority, hostile shadowing resistance and absent/tampered ledger fails-closed proof.

Flutter HTTP/file-backed proof added and passed 3 focused cases:

- real HTTP success with file-backed enrollment, duplicate replay and pending outbox preservation
- real HTTP conflict/malformed/unavailable failure persistence without local fact/outbox loss
- slow response body exceeding the absolute deadline returns a closed unavailable outcome

## Validation Results

- `git fetch origin`: passed.
- `git pull --ff-only`: passed.
- Required controlling commit ancestor check for `ecfea32c3d72d9a8de74893df7ad29929dcc5ee1`: passed.
- `git status --short --branch` before editing: clean on `intermid-cycle-recovery`.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 30 tests.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `npm run test:hosted-local`: completed with partial diagnostics shown above.
- `npm exec tsx -- src/proof/migration_006_probe.ts`: exited nonzero with `MIGRATION_006_LIFECYCLE_ACL=partial`.
- `dart format --set-exit-if-changed lib test`: passed, 0 changed.
- `flutter analyze`: passed, no issues.
- `flutter test test/infrastructure/http_device_enrollment_transport_file_test.dart`: passed 3 tests.
- `flutter test`: passed 61 tests, 2 existing lab-gated skips; existing Drift multiple-database debug warnings appeared in unrelated sync tests.
- `flutter build apk --debug`: passed.
- `flutter build windows --release`: passed.
- `python -m unittest discover -s tests`: passed 5 tests.
- `git diff --check`: passed with Git line-ending warning only.

## Remaining Blockers

- Complete deterministic authorization/revocation race matrix with barriers and before/after no-state-advance comparisons.
- Complete migration-006 lifecycle proof for fresh/upgrade/duplicate/failure-copy/owner/shadowing/tamper cases without editing migrations.
- Produce a full real Flutter HTTP/file-backed Drift gate against loopback Fastify/disposable PostgreSQL where required.
- Run one aggregate over every required machine-readable producer and emit success only when all required cases are true.

## Boundary And Teardown

No Auth0, Neon, Render or public hosted service was contacted. No provider credential, private helper file, `.vscode/settings.json`, `documentation/NEON_DOC.md` or `documentation/NEON_SESSION.ps1` was read or modified. The disposable PostgreSQL container was used only for local proof and is reported in teardown validation. Provider proof, MCG-03, MCG-04, permanent-memory promotion and Cycle 10 closure were not started.
