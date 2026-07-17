# G_OPS_CODEX — R05 Operational Evidence

- Authority marker: C10-MCG02-R05_20260717T162323Z
- Controlling staging SHA: a24000be31582b6b704ee825919ebff3e84bbd2f
- Required implementation ancestry: bddccba29e208ad423d9adfc95b99ed969ade71e
- Baseline remote/local SHA: a24000be31582b6b704ee825919ebff3e84bbd2f
- Actual implementation start: 2026-07-17T16:23:23Z / 2026-07-17T13:23:23-03:00
- Actual implementation end: 2026-07-17T16:56:50Z / 2026-07-17T13:56:50-03:00
- Implementation tree before report replacement: a04661cc5aca35050c69286605a71bbcfb635ba5
- Final commit status: pending before commit; Main may reconcile final commit SHA.
- Evidence environment: Windows host, Flutter 3.44.6, Dart 3.12.2, Docker Desktop linux/amd64, disposable postgres:18-alpine, loopback Fastify/JWKS.
- Result classification: R05 local Flutter HTTP/file-backed proof complete; provider proof pending.

## Changed Paths

- Flutter focused proof: `clients/markei_flutter/test/infrastructure/flutter_http_file_backed_proof_test.dart`
- Flutter producer: `services/markei_sync_api/src/proof/flutter_producer.ts`
- Final local aggregate: `services/markei_sync_api/src/proof/r3_local_orchestrator.ts`
- Lab readiness correction: `services/markei_sync_api/src/proof/migration_006_probe.ts`
- Reports: G/H/I only.

No A/B/C, J, D/E/F, methodology, permanent memory, migrations, Drift schema, dependencies, lockfiles, UI, provider configuration or deployment files changed.

## R05 Case Results

All 16 `flutter-http-file-backed` cases passed from closed `R05_CASE` records:

- `device-enrolled-applied`: true; file-backed purchases=1, syncEvents=1, pendingEvents=1, hostedStates=1.
- `duplicate-equivalent-distinct`: true; duplicate-equivalent retained as a distinct outcome.
- `conflict-persists-facts-outbox`: true; no server Device installed, facts/outbox retained.
- `unavailable-persists-facts-outbox`: true; no server Device installed, facts/outbox retained.
- `malformed-oversized-redirect-fail-closed`: true; three malformed/oversize/redirect edges checked.
- `response-loss-unknown-outcome`: true; hosted commit was followed by locally persisted unknown outcome without invented Device truth.
- `query-replay-same-request-id`: true; replay used same enrollment request ID and recovered persisted truth.
- `close-reopen-preserves-state`: true; same Drift file reopened with identity/facts/outbox intact.
- `normal-response-before-deadline`: true.
- `stalled-headers-timeout`: true.
- `slow-trickle-total-deadline`: true.
- `owned-client-closed-on-timeout`: true.
- `borrowed-client-preserved`: true.
- `late-response-no-durable-mutation`: true.
- `local-registration-while-api-unavailable`: true; purchases=2, syncEvents=2, pendingEvents=2 after local registration.
- `token-not-persisted-or-logged`: true; exact synthetic token absent from Drift file bytes and retained state/outcome text.

Hosted producer evidence: `R05_HOSTED_COUNTS devices=5 enrollmentRequests=5 securityEvents=5`.

## Validation

- `flutter pub get`: passed.
- `dart format --set-exit-if-changed lib test`: passed.
- `flutter analyze`: passed.
- `flutter test`: 62 passed, 2 skipped.
- `flutter build apk --debug`: passed.
- `flutter build windows --release`: passed.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: 46 passed.
- `npm run build`: passed.
- `npm audit --omit=dev`: 0 vulnerabilities.
- `npm exec tsx -- src/proof/flutter_producer.ts`: `FLUTTER_HTTP_FILE_BACKED_CASES_TRUE=16`, producer true.
- Authorization, migration, JWKS, route and static producers: true.
- `npm exec tsx -- src/proof/r3_local_orchestrator.ts`: `PROOF_PIPELINE_INTEGRITY=true`, `R3_LOCAL_SECURITY_PROVED=true`.
- `git diff --check`: passed.
- Tracked/staged credential scan: no private-key, API-key, bearer-token, client-secret or password hits; broad URL scan showed only synthetic loopback PostgreSQL lab coordinates.
- Protected Python regressions: passed through static producer.
- Migration hashes 001-006: F48A9E5D..., 32A0215E..., B5BA5798..., 3B4826EA..., E99F20BC..., 7B83DC34....
- Final disposable inventory: `docker ps -a --filter name=markei-c10 --format "{{.Names}}"` returned empty.

## Exclusions

Chrome/web runtime acceptance was not required. Auth0, Neon, Render, deployment, MCG-03/04, pruning/promotion and Cycle 10 closure were not started.
