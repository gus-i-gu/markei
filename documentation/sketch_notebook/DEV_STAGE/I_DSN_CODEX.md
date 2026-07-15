# I_DSN_CODEX - C10-S03A-R3B Design Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex design/architecture evidence
Unit: C10-S03A-R3B local contract and decisive-proof completion
Branch: `intermid-cycle-recovery`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: local architecture only; provider proof deferred

## Result

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3B_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: the bounded contract corrections are implemented and locally tested, but decisive proof architecture remains incomplete.

## Dependency Direction

Retained:

- `jose` owns JWT/JWK cryptography.
- Markei JWT adapter owns issuer/audience policy, bounded JWKS retrieval, normalized key revision and cooldowns.
- `package:http` owns raw HTTP mechanics.
- Markei transport owns attempt deadline, client ownership, byte ceiling and closed outcome translation.
- Drift v7 owns durable local hosted identity state.
- Fastify owns route lifecycle; Markei app builder owns typed route policy and readiness equality.
- PostgreSQL owns migrations, transactions, locks and RLS context.

No dependency, lockfile, migration or Drift schema change was made.

## HTTP Client Ownership And Deadline

`HttpDeviceEnrollmentTransport` now defaults to per-attempt owned clients through a factory. Each attempt captures one deadline and closes the owned client in `finally`. A borrowed client may still be supplied for tests/composition and is never closed by transport. Body consumption uses `StreamIterator.moveNext().timeout(remaining)` so each read is bounded by the same absolute deadline instead of a renewable inactivity timeout.

The remaining unproved part is real loopback slow-trickle/cancellation evidence against the actual HTTP stack and file-backed Drift.

## Enrollment Result Model

`DeviceEnrollmentResult` carries the server success status. The coordinator persists `device-enrolled` and `duplicate-equivalent` distinctly and maps them to `applied` and duplicate-equivalent outcomes. Replay conflict, unavailable and unknown results are persisted through existing Drift v7 state strings without schema change.

## JWKS State Machine

JWKS lookup now uses one refresh budget per lookup. Expired-cache refresh consumes that budget. If the requested key remains absent, the per-key negative cooldown is installed even when the semantic key set changed. Normalization rejects private material and unsupported keys, then hashes only:

```text
kty, kid, use, alg, n, e
```

This prevents provider metadata from becoming semantic rotation.

## Fastify Readiness Inventory

Route capture remains rooted in `onRoute`. Exact inventory comparison now runs in `onReady`, after direct and encapsulated registrations materialize and before ready/listen/inject proceeds. Health routes and automatic HEAD are the only normalization exceptions. Tests cover valid inventory and three invalid readiness cases.

## Device Status Projection

`HostedIdentityService.deviceStatus()` now returns `target.deviceStatus`, not `target.enrollmentState`. `replaced` remains internal to enrollment workflow and cannot be emitted as public Device status by this endpoint.

## Proof Architecture Status

Completed local producer subsets:

- TypeScript/JWT/route: 27 passing tests.
- Flutter unit: 58 passing tests, 2 lab-gated skips.
- Hosted-local: route inventory true, least privilege true, authorization race matrix partial, aggregate false.
- Static/build: server format/lint/typecheck/build, audit, Flutter analysis/builds and Python regressions passed.

Missing decisive producers:

- full authorization/race matrix with deterministic barriers and state snapshots;
- full migration-006 lifecycle/ACL/shadowing/tamper proof without migration edits;
- real Flutter HTTP/file-backed Drift lab against loopback Fastify;
- aggregator that validates exact producer schemas/cases and emits success only when every case is true.

## Versions Retained

- PostgreSQL migrations 001-006 unchanged.
- Event payload v3 unchanged.
- Cursor `c10b:*` unchanged.
- Recovery snapshot format 1 unchanged.
- Hosted enrollment contract v1 unchanged.
- Drift schema v7 unchanged.
- JWT algorithm RS256 retained.

Provider proof, MCG-03, MCG-04 and Cycle 10 closure were not started.
