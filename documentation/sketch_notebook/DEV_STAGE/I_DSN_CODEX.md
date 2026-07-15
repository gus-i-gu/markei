# I_DSN_CODEX - C10-S03A-R3C Design Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex design/architecture evidence
Unit: C10-S03A-R3C decisive local proof completion
Branch: `intermid-cycle-recovery`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: local architecture only; provider proof deferred

## Result

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3C_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: proof architecture now fails closed, but decisive producer coverage is incomplete.

## Dependency Direction

Retained:

- `jose` owns JWT/JWK cryptography.
- Markei JWT adapter owns issuer/audience policy, bounded JWKS retrieval, normalized key revision and cooldowns.
- Fastify owns route lifecycle; Markei owns typed descriptors and inventory proof.
- PostgreSQL owns migrations, transactions, locks, ACLs and RLS context.
- `package:http` owns raw HTTP mechanics.
- Markei Flutter transport owns attempt deadline, byte ceiling, redirect refusal and closed outcome translation.
- Drift v7 owns durable local hosted identity state.

No dependency, lockfile, migration or Drift schema change was made.

## Proof Architecture Added

`services/markei_sync_api/src/proof/producer.ts` defines the required producer and case inventory. Producers are explicit, versioned and case-addressable.

`services/markei_sync_api/src/proof/aggregate.ts` validates producer schema, exact case sets, duplicates, unknown producers, unknown cases, skipped/partial/false cases and missing producers before emitting success.

`services/markei_sync_api/test/proof_aggregate.test.ts` proves the aggregator accepts complete synthetic evidence and rejects incomplete or malformed evidence. This is infrastructure proof only; it does not substitute for real producer execution.

## Migration-006 Evidence Architecture

`services/markei_sync_api/src/proof/migration_006_probe.ts` connects to disposable migrator/runtime pools supplied by lab environment variables and checks the already migrated local database. It intentionally does not edit migrations 001-006.

The probe currently covers function shape, security-definer metadata, fixed search path, SQL-body safety, ACLs and runtime denials. It does not yet orchestrate fresh/upgrade/duplicate/failure-copy/shadowing/tamper lifecycle matrices, so it correctly exits partial.

## Authorization/Race Evidence Architecture

The hosted-local harness now emits a structured `authorization-race` producer. Existing route inventory and least-privilege diagnostics remain separate from the race matrix. Missing cases are represented as false with `missing-case-result`, preserving the E distinction between observed subset and decisive matrix completion.

The remaining design gap is a barrier-driven matrix that snapshots facts/events, cursors/acknowledgements, recovery state, Device/enrollment rows and security-event counts before and after every denied/losing path.

## Flutter HTTP/File-Backed Evidence

The new Flutter test uses:

- temporary `LocalDatabase.file`
- real `LocalPurchaseRepository` to create authoritative local facts and one pending outbox event
- real `DriftHostedIdentityRepository`
- real `HostedEnrollmentCoordinator`
- real `HttpDeviceEnrollmentTransport`
- loopback `HttpServer`

It proves success/replay distinction, closed failure persistence, outbox/fact preservation across close/reopen and a slow-body absolute-deadline case. It does not yet prove the full R3C Fastify/PostgreSQL-backed gate or every timeout/redirect/ownership variant.

## Versions Retained

- PostgreSQL migrations 001-006 unchanged.
- Event payload v3 unchanged.
- Cursor `c10b:*` unchanged.
- Recovery snapshot format 1 unchanged.
- Hosted enrollment contract v1 unchanged.
- Drift schema v7 unchanged.
- Existing dependency and lockfile versions unchanged.

Provider proof, MCG-03, MCG-04 and Cycle 10 closure were not started.
