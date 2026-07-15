# G_OPS_CODEX - C10-S03A-R1 Operational Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex materialization evidence
Unit: C10-S03A-R1 local security correction
Branch: `intermid-cycle-recovery`
Baseline SHA: `8b84c4442e2e7be2a28fc1b34bdc60d45256d25d`
Final SHA: pending materialization commit
Authority: `J_MAIN_STAGE.md`, `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
Evidence boundary: local-only repository, generated loopback JWKS, disposable PostgreSQL, synthetic identities only

## Changed paths

- `clients/markei_flutter/lib/application/hosted_auth_ports.dart`
- `clients/markei_flutter/lib/application/hosted_enrollment_coordinator.dart`
- `clients/markei_flutter/lib/infrastructure/local/hosted_identity_repository.dart`
- `clients/markei_flutter/lib/infrastructure/remote/http_device_enrollment_transport.dart`
- `clients/markei_flutter/test/infrastructure/hosted_identity_repository_test.dart`
- `services/markei_sync_api/src/application/hosted_authorization.ts`
- `services/markei_sync_api/src/application/jwt_verifier.ts`
- `services/markei_sync_api/src/hosted_local_harness.ts`
- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/test/hosted_auth.test.ts`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No files were deleted. Migrations 001-004 were not modified. No migration 005 was added. No dependency version changed.

## Implementation evidence

- Replaced hosted protected-route authorization flow with `HostedAuthVerifier.authorizeOperation`, which verifies JWT outside the database transaction and resolves active identity, active membership, active enrollment and active Device inside the same serializable transaction used by the protected operation callback.
- Added route-policy inventory for 8 protected sync/recovery routes.
- Added bounded JWKS retrieval around `jose`: token byte ceiling, JWKS byte ceiling, timeout, cache max age, refresh cooldown, redirect refusal, duplicate/conflicting `kid` rejection and parallel refresh coalescing.
- Updated hosted-local harness to require separate `LAB_MIGRATOR_URL` and `LAB_RUNTIME_URL`; migrator applies migrations/seeding and runtime is the only Fastify database authority.
- Harness synthetic topology: 2 Accounts, 2 external identities, 3 installations and 3 enrolled Devices.
- Harness denial evidence: cross-Account Device use denied; revoked Device denied; conflicting enrollment replay denied without accepted mutation.
- Flutter lab seam added: `LabAuthenticationSession`, `LabAccessTokenSource`, `HostedEnrollmentCoordinator`, `HttpDeviceEnrollmentTransport`, `DriftHostedIdentityRepository`, `DriftHostedSyncGuard`.

## Validation results

- `git fetch origin`: passed.
- `git pull --ff-only`: already up to date.
- Required staging commit ancestor check: passed.
- `npm install`: passed; 0 vulnerabilities; local dependency refresh added missing `jose` package to `node_modules`.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 21 tests.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `npm run test:hosted-local`: passed on fresh disposable PostgreSQL with separate migrator/runtime roles.
- Hosted-local diagnostics emitted:
  - `LOCAL_TRANSACTION_AUTHORIZATION=true`
  - `LEAST_PRIVILEGE_HTTP=true`
  - `TWO_ACCOUNT_ISOLATION=true`
  - `JWKS_FAILURE_FLOOR=true`
  - `FLUTTER_HOSTED_LAB=true`
- `dart format --set-exit-if-changed lib test`: passed.
- `flutter analyze`: passed.
- `flutter test test/infrastructure/hosted_identity_repository_test.dart`: passed 4 tests.
- `flutter test`: passed 56 tests, 2 lab-gated tests skipped; pre-existing Drift multi-database warnings appeared in unrelated sync tests.
- `flutter build apk --debug`: passed.
- `flutter build windows --release`: passed.
- `python -m unittest discover -s tests`: passed 5 tests.
- `git diff --check`: passed with line-ending warnings only.
- Added-line secret/readiness scan: no matches.
- Disposable PostgreSQL container `markei-c10-s03a-r1-pg`: stopped and removed.

## JWT/JWKS case count

Automated hosted-auth tests now cover 16 named JWT/JWKS and route-policy cases, including valid token, malformed bearer, oversized token, wrong issuer/audience/algorithm, expired/not-yet-valid token, missing subject, missing/unknown `kid`, invalid signature, cached-key outage, uncached outage, malformed/oversized JWKS, conflicting key IDs, redirect refusal and parallel refresh coalescing.

## Blockers and exclusions

The result is reported as:

```text
C10-S03A_R1_PARTIAL
```

Blocker: CP4's full barrier/hook race matrix is not exhaustively materialized as named tests. The implementation uses serializable transactions with bounded retry and locks enrollment/Device rows, but membership removal and revocation racing every protected operation still need explicit barrier-level proof.

No Auth0, Neon, Render or public hosted service was contacted. No provider credential or private helper file was read.
