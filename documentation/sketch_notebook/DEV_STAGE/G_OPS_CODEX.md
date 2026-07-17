# G_OPS_CODEX — R04C04 Operational Evidence

- Authority marker: C10-MCG02-R04C04_20260717T154951Z
- Controlling staging SHA: 8311829e0317a559f740f4ff1772c004561b21b5
- Required implementation ancestry: 4f8c1567521ffb7deb93541a3af7f4a713986058
- Baseline remote/local SHA: 8311829e0317a559f740f4ff1772c004561b21b5
- Actual implementation start: 2026-07-17T15:57:00Z / 2026-07-17T12:57:00-03:00
- Actual implementation end: 2026-07-17T16:17:12Z / 2026-07-17T13:17:12-03:00
- Implementation tree before report replacement: 3cd366421042a00b68177358f13d07b4351cac3e
- Final commit status: pending before commit; Main may reconcile final commit SHA.
- Evidence environment: Windows host, Docker Desktop linux/amd64, disposable postgres:18-alpine, loopback-only Fastify/JWKS.
- Result classification: R04 authorization producer proved; global R3 remains false because Flutter R05 is deferred.

## Changed Paths

- Production/proof harness: `services/markei_sync_api/src/hosted_local_harness.ts`
- Proof producer: `services/markei_sync_api/src/proof/authorization_producer.ts`
- Proof scenarios: `services/markei_sync_api/src/proof/authorization_slice_scenarios.ts`
- Proof case set: `services/markei_sync_api/src/proof/authorization_case_sets.ts`
- Focused tests: `services/markei_sync_api/test/authorization_r04c01.test.ts`
- Reports: G/H/I only.

No A/B/C, J, D/E/F, methodology, migrations, dependencies, lockfiles, Flutter/UI, provider files, or permanent memory were changed.

## Preflight And Teardown

- Docker preflight before mutation: Client/Server available, Server OS Linux, postgres:18-alpine started on loopback, `pg_isready` accepted, `SELECT version()` returned PostgreSQL 18.4, preflight container removed, filtered inventory empty.
- Final R04C04 inventory: `docker ps -a --filter name=markei-c10-mcg02-r04c04 --format "{{.Names}}"` returned exit 0 and empty stdout.
- Secret scan over changed files found only synthetic loopback PostgreSQL URLs in the disposable producer.
- Provider/private helper files were not read.

## Authorization Results

All 28 producer schema v1 cases executed from ScenarioResults and passed.

- Cases 1-19: all expected 403 denials or 200 allowed target outcomes with state invariants true.
- Case 20: concurrent target revoke produced one transition and one security event.
- Case 21: independent repeat revoke was duplicate-equivalent with no second event.
- Case 22: self-revoked actor was denied later protected work.
- Cases 23-24: equivalent enrollment converged; conflicting enrollment preserved first result and failed closed.
- Case 25: response-loss query replay recovered the committed enrollment result; counts device=1, enrollment request/result=1, event=1.
- Case 26: process-restart replay recovered persisted result through composition B; no first-process cache used.
- Case 27: retry exhaustion observed 3 bounded attempts, returned typed `service-unavailable`, and rolled back protected state.
- Case 28: derived from the closed denial source set; every source result existed once, passed, and carried `stateInvariant=true`.

## Validation

- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: 46 passed, 0 failed.
- `npm run build`: passed.
- `npm audit --omit=dev`: 0 vulnerabilities.
- `npm exec tsx -- src/proof/authorization_producer.ts`: passed, `AUTHORIZATION_RACE_PRODUCER=true`, `AUTHORIZATION_CASES_TRUE=28`.
- `npm exec tsx -- src/proof/migration_006_probe.ts`: passed.
- `npm exec tsx -- src/proof/jwks_producer.ts`: passed.
- `npm exec tsx -- src/proof/route_inventory_producer.ts`: passed.
- `npm exec tsx -- src/proof/static_regression_producer.ts`: passed.
- `npm exec tsx -- src/proof/flutter_producer.ts`: expected nonzero; false cases were only `not-yet-r05`.
- `npm exec tsx -- src/proof/r3d1_orchestrator.ts`: passed with `PROOF_PIPELINE_INTEGRITY=true` and `R3_LOCAL_SECURITY_PROVED=false`.
- `git diff --check`: passed.

Migration hashes 001-006: F48A9E5D..., 32A0215E..., B5BA5798..., 3B4826EA..., E99F20BC..., 7B83DC34....

## Exclusions

R05 Flutter completion, provider proof, deployment, MCG-03/MCG-04, and Cycle 10 closure were not started.
