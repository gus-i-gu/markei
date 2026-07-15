# G_OPS_CODEX - C10-S03A-R3B Operational Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex materialization evidence
Unit: C10-S03A-R3B local contract and decisive-proof completion
Branch: `intermid-cycle-recovery`
Baseline SHA: `8a219e63dc1b8c7f9b044ed1c3ba99649250ca69`
Final SHA: pending materialization commit
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, loopback services, disposable PostgreSQL, synthetic identities only

## Result

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3B_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: the existing hosted-local producer still reports `AUTHORIZATION_RACE_MATRIX=partial` and `R3_LOCAL_SECURITY_PROVED=false`. Full migration-006 lifecycle/ACL proof, real Flutter HTTP/file-backed Drift proof, complete deterministic authorization/revocation race evidence and final truthful aggregation remain incomplete.

## Changed Paths

- `clients/markei_flutter/lib/application/hosted_auth_ports.dart`
- `clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart`
- `clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart`
- `clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart`
- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/application/jwt_verifier.ts`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/test/hosted_auth.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No dependency or lockfile version changed. Migrations 001-006 were not edited. No permanent memory, methodology, A/B/C, J or D/E/F file was modified.

## Corrections Materialized

- Device status now returns the locked target Device row status (`active | revoked`) rather than enrollment state.
- Fastify actual route inventory comparison moved to readiness via `onReady`; direct late routes and encapsulated plugin routes now reject readiness/injection before service.
- JWKS lookup now consumes at most one eligible refresh for an unknown-key lookup, installs per-key negative cooldown whenever the requested key remains absent, and fingerprints only normalized public RSA/RS256 signing material.
- JWKS validation rejects private key material, unsupported key type/use/algorithm, malformed fields and duplicate `kid`.
- Flutter transport now preserves success status (`device-enrolled` versus `duplicate-equivalent`) through `DeviceEnrollmentResult`.
- Coordinator maps `device-enrolled` to `applied`, maps `duplicate-equivalent` to duplicate-equivalent, and persists replay conflict/unavailable/unknown outcomes instead of leaving durable state as `enrolling`.
- HTTP transport now uses a per-attempt owned client by default, one attempt deadline, remaining-time checks for send/body reads, byte ceiling, redirect refusal and closed failure mapping. Borrowed clients remain caller-owned and are not closed.

## Producer Evidence

Hosted-local producer on disposable PostgreSQL:

```text
AUTHORIZATION_RACE_MATRIX=partial
ROUTE_AUTHORIZATION_INVENTORY=true
LEAST_PRIVILEGE_HTTP=true
R3_LOCAL_SECURITY_PROVED=false
```

TypeScript/JWT/route producer:

- `npm test`: passed 27 tests.
- New named coverage includes expired unknown-key one-refresh behavior, changed-set-missing-key cooldown, ignored JWK metadata, private-key rejection, readiness rejection of injected direct route, late direct route and encapsulated plugin route.

Flutter unit producer:

- `flutter test`: passed 58 tests, 2 lab-gated skips.
- New named coverage includes duplicate-equivalent distinct success and replay persistence for conflict, service-unavailable and unknown-outcome.

## Validation Results

- `git fetch origin`: passed.
- `git pull --ff-only`: passed.
- Required controlling commit ancestor check for `8a219e63dc1b8c7f9b044ed1c3ba99649250ca69`: passed.
- Accepted R3 baseline ancestor check for `a995bd1385d5754f0a278b05df1c1f8f8431ec45`: passed.
- `git status --short --branch` before editing: clean on `intermid-cycle-recovery`.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 27 tests.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `npm run test:hosted-local`: completed with partial diagnostics shown above.
- `dart format --set-exit-if-changed lib test`: passed after formatting changed 2 files, then passed with 0 changed.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed 58 tests, 2 lab-gated skips; existing Drift multiple-database debug warnings appeared in unrelated sync tests.
- `flutter build apk --debug`: passed.
- `flutter build windows --release`: passed.
- `python -m unittest discover -s tests`: passed 5 tests.
- `git diff --check`: passed with line-ending warnings only.

## Remaining Missing Producers

- Complete deterministic authorization/revocation race matrix with before/after no-state-advance comparisons.
- Complete migration-006 fresh/upgrade/duplicate/failure-rollback/owner/ACL/shadowing/tamper lifecycle proof.
- Real `HttpDeviceEnrollmentTransport` proof against loopback Fastify with file-backed Drift, real facts and pending outbox.
- Aggregator consuming all machine-readable producers and emitting `R3_LOCAL_SECURITY_PROVED=true` only when every required case is present and true.

## Boundary And Teardown

No Auth0, Neon, Render or public hosted service was contacted. No provider credential, private helper file, `.vscode/settings.json`, `documentation/NEON_DOC.md` or `documentation/NEON_SESSION.ps1` was read or modified. Provider proof, MCG-03, MCG-04, permanent-memory promotion and Cycle 10 closure were not started.
