# I_DSN_CODEX — R04C04 Design Evidence

- Authority marker: C10-MCG02-R04C04_20260717T154951Z
- Controlling staging SHA: 8311829e0317a559f740f4ff1772c004561b21b5
- Baseline SHA: 8311829e0317a559f740f4ff1772c004561b21b5
- Actual implementation window: 2026-07-17T15:57:00Z to 2026-07-17T16:17:12Z
- Implementation tree before report replacement: 3cd366421042a00b68177358f13d07b4351cac3e
- Final commit status: pending before commit.
- Evidence environment: local Node/Fastify proof harness, Docker PostgreSQL 18, synthetic JWKS.
- Result classification: R04 authorization design proof complete; R05/provider boundaries retained.

## Architecture

- Dependency direction remains production-to-inert barrier and proof-to-lab controller; no public barrier route was added.
- R04C04 added a closed `authorization_case_sets.ts` boundary for the R04C04 cases and denied-no-state-advance source set.
- Existing scenario facade now executes response-loss replay, process-restart replay, serialization retry exhaustion and derived denial aggregation after R04C01/R04C02 results.
- Response-loss and restart proofs use real hosted enrollment and enrollment-status routes with durable PostgreSQL state as the replay authority.
- Retry exhaustion uses the existing bounded transaction wrapper and a lab-only `beforeCommit` SQLSTATE 40001 injection after protected writes.
- Authorization producer now waits for a real SQL round trip after `pg_isready`, preventing transient PostgreSQL startup termination before provisioning.

## Retained Contracts

- Migrations 001-006 unchanged.
- Producer schema version 1 and exact 28 authorization case IDs retained.
- Hosted enrollment contract v1, JWT RS256, recovery format 1, cursor family and event payload v3 retained.
- No dependency, lockfile, Drift, Flutter, UI, methodology, A/B/C, J or D/E/F changes.

## Production Deviations

No production authorization, locking, retry, Account scoping or route contract was weakened. The only operational correction was producer-lab readiness tightening for disposable PostgreSQL setup.

## Aggregate

R04 orchestrator acceptance now requires authorization true, all other server producers true, Flutter structurally valid and false only for `not-yet-r05`, and global security false due to R05/provider deferral.
