# I_DSN_CODEX — R05 Design Evidence

- Authority marker: C10-MCG02-R05_20260717T162323Z
- Controlling staging SHA: a24000be31582b6b704ee825919ebff3e84bbd2f
- Baseline SHA: a24000be31582b6b704ee825919ebff3e84bbd2f
- Actual implementation window: 2026-07-17T16:23:23Z to 2026-07-17T16:56:50Z
- Implementation tree before report replacement: a04661cc5aca35050c69286605a71bbcfb635ba5
- Final commit status: pending before commit.
- Evidence environment: local Flutter proof, file-backed Drift, loopback Fastify/JWKS, PostgreSQL 18.
- Result classification: R05 final local aggregate complete; provider boundary retained.

## Architecture

- Dependency direction remains Flutter application ports -> coordinator -> transport/repository implementations; no provider SDK was added.
- `flutter_http_file_backed_proof_test.dart` owns file-backed Drift fixtures, local deterministic HTTP edges and closed `R05_CASE` evidence.
- `flutter_producer.ts` owns the loopback hosted Fastify/JWKS/PostgreSQL fixture, passes synthetic origin/tokens through environment variables, validates exact case records and emits `makeProducerResult`.
- `r3_local_orchestrator.ts` is the final aggregate entrypoint requiring all six producers true and `aggregateProofResults(...).passed=true`.
- The previous R04 orchestrator remains as an authorization-era diagnostic and was not weakened.

## Transport And State Design

- Existing `HttpDeviceEnrollmentTransport` provides absolute request deadline, redirect refusal, bounded response body handling, owned-client closure and borrowed-client preservation.
- The proof uses a lab-only wrapper that lets the real transport commit enrollment and then returns unknown, proving Flutter persistence and replay behavior without throwing inside the hosted transaction.
- Drift invariants checked: purchases, sync events and pending outbox survive conflict, unavailable, malformed, timeout, response loss, close/reopen and local registration while remote is unavailable.
- Token proof scans Drift file bytes and retained state/outcome text; producer diagnostics redact bearer-shaped text.

## Retained Versions And Deviations

Retained: migrations 001-006, Drift schema v7, enrollment contract v1, event v3, cursor `c10b:*`, recovery format 1, JWT RS256, producer schema v1, dependencies and lockfiles.

Production deviation: none to Flutter transport/coordinator contracts. Lab-only correction: migration producer now waits for a real SQL `select 1` after `pg_isready`, matching the R04C04 authorization-producer readiness hardening.

No Auth0, Neon, Render, UI redesign, deployment, permanent memory, methodology or staging authority changes were made.
