<!-- TEMPORAL_MARKER:C10-S01B-INVESTIGATION-2026-07-14 -->
# A_OPERATIONAL — C10-S01B Local Synchronization Convergence Completion

Sequence: FLX-INV-02  
Role: Operational [O]  
Branch: `intermid-cycle-recovery`  
Inspected HEAD: `1af8137e3f7db2d5ee3ecdf3796ae62808e0717c`  
Required ancestor: `1af8137e3f7db2d5ee3ecdf3796ae62808e0717c`  
Evidence date: 2026-07-14  
Authority: candidate/proposed/provisional Operational staging only; no source, provider, permanent-memory or methodology mutation.

## 1. Methodology retained

Loaded root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md` and `CHAT_PROTOCOL.md` in the full canonical route. Retained:

- Operational owns execution boundaries, dependencies, commands, validation, failure handling, rollback and stop gates.
- `A_OPERATIONAL.md` is a functional stage, not canon or materialization authority.
- PRC-01 keeps candidate, proposed, provisional, implemented and validated distinct.
- Code existence requires repository inspection; synchronization requires real upload/download/convergence evidence.
- G/H/I are observational evidence and cannot promote themselves.
- Only this A stage may change in this round; unrelated and untracked work, including `.vscode/`, must remain untouched.
- Live Neon cannot substitute for disposable local proof.

Repository comparison reported the required commit and branch as identical. No divergence was observed through the GitHub repository view. Connector inspection cannot establish a local worktree status, unresolved local conflicts or host process state; publication therefore relies on branch/blob concurrency checks rather than a local checkout.

## 2. Inspected source and evidence

Controlling notebook evidence:

- `[M]_STAGE/J_MAIN_STAGE.md`
- `DEV_STAGE/D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
- `DEV_STAGE/G_OPS_CODEX.md`, `H_DDC_CODEX.md`, `I_DSN_CODEX.md`
- prior `DEV_STAGE/A_OPERATIONAL.md`

Implementation evidence inspected directly or through the materialization commit:

- `services/markei_sync_api/src/http/app.ts`
- `services/markei_sync_api/src/application/sync_service.ts`
- `services/markei_sync_api/src/application/auth.ts`
- `services/markei_sync_api/src/postgres/database.ts`
- `services/markei_sync_api/migrations/001_init.sql`
- `infra/sync_lab/**`
- `contracts/shared_beta/v3/**`
- `clients/markei_flutter/lib/application/sync/**`
- `clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart`
- Drift schema v5, identity and Purchase repository changes
- `clients/markei_flutter/tool/sync_lab.dart`
- `clients/markei_flutter/test/sync/**`
- repository scripts, lockfiles and ignore rules reported in G/H/I.

## 3. Exact current execution boundary

### Implemented and evidenced

- Protocol-v3 identities, status/failure vocabulary and Dart/TypeScript canonical-hash parity exist.
- Drift schema v5 contains installation metadata, durable submissions, submission membership and inbox records.
- Installation→current Device selection is explicit; ambiguous migration stops without silent reset.
- Local Purchase registration still commits Purchase, SyncEvent and PendingEvent atomically.
- Outbox leasing creates a durable SubmissionId/request hash and reuses an `unknown` submission.
- Upload-result persistence maps accepted, duplicate, unknown and failed outcomes into durable local state.
- PostgreSQL migration creates Accounts, Devices, cursor state, Submissions, Events and acknowledgements.
- Upload service checks authenticated Device identity, Account/Event identity, content hash, exact sequence, duplicate Event and duplicate Submission behavior within one database transaction.
- Runtime DDL denial and one cross-Account RLS insertion denial were probed locally.
- Existing static/unit/local tests, Flutter builds and PostgreSQL migration probes passed as recorded by G.

### Stubbed, direct-replay or partial

- `GET /v1/sync/events` returns an empty page with `nextCursor: null`; it performs no authentication, query, limit enforcement or PostgreSQL read.
- `POST /v1/sync/acknowledgements` returns a fixed duplicate-like status; it performs no authentication, monotonic check or database write.
- No Flutter HTTP `SyncTransport` adapter connects application use cases to the Fastify API.
- The two-Device harness replays a page directly into Drift; it does not execute HTTP→API→PostgreSQL→API→Drift.
- `DriftRemoteEventApplier` records inbox and cursor state but does not materialize the remote immutable Purchase aggregate, Product, Store, People/payment references or derived-list invalidation.
- `greatestContiguousAppliedCursor()` selects the highest applied cursor, not a proven contiguous prefix; a gap can be acknowledged incorrectly.
- Upload is not covered by a database-backed HTTP integration test against a running migrated PostgreSQL instance.
- Timeout-after-server-commit is represented locally as an unknown-outcome retry, not proven across process/network boundaries.
- PostgreSQL serialization retry, pool exhaustion, crash phases and full Account-isolation paths are absent or partial.
- Normal API runtime intentionally refuses fixture authentication, but no bounded loopback lab entrypoint injects fixture auth for an executable cross-process story.

Operational classification: C10-S01 is implemented as a strong scaffold and locally validated in bounded layers; C10-S01B convergence remains provisional and incomplete.

## 4. Shortest safe second-implementation scope

The minimum safe materialization should add only the missing vertical path and its proof:

1. Complete PostgreSQL-backed download and acknowledgement services.
2. Add authenticated Fastify schemas/routes for bounded download and monotonic acknowledgement.
3. Add a loopback-only fixture-auth lab entrypoint and deterministic Account/two-Device seeding.
4. Add a Flutter HTTP `SyncTransport` adapter with typed timeout/HTTP/protocol mapping.
5. Complete remote `purchase.registered` aggregate application in one Drift transaction with inbox and cursor.
6. Replace highest-cursor acknowledgement with contiguous-prefix calculation.
7. Add one cross-process system harness using two isolated Drift files, API and disposable PostgreSQL.
8. Add targeted failure injection and database-backed integration tests.
9. Correct migration/role/RLS defects discovered by those tests; do not configure Neon.

Do not add production auth, background scheduling, edits/deletes, snapshots, retention, deployment or UI redesign.

## 5. Proposed checkpoint sequence

### CP1 — Server read/ack correctness

- Implement `downloadAfter(auth, after, limit)` ordered by `server_cursor`, scoped to Account, excluding or including origin events only by an explicit Main decision.
- Enforce integer/opaque cursor parsing, positive bounded limit and deterministic `nextCursor` semantics.
- Implement acknowledgement upsert as monotonic maximum for the authenticated Account/Device.
- Reject acknowledgement beyond the greatest existing Account cursor and unknown/revoked Device.

Exit: database-backed route tests prove upload→download→ack for two fixture Devices.

### CP2 — Local complete apply

- Decode only `purchase.registered` payload v3.
- Validate Account, event type/version, aggregate identifiers and content hash before mutation.
- Reuse existing local Purchase registration/application primitives where possible, but suppress creation of a new outbound event when applying remote facts.
- Insert Product/Store/reference facts idempotently under the collision policy.
- Commit fact application, inbox record and cursor advancement atomically.
- Recompute or invalidate derived Lists after commit.

Exit: remote Purchase facts and Lists survive reopen; duplicate replay creates no duplicate facts or outbound event.

### CP3 — HTTP transport and lab entrypoint

- Implement `HttpSyncTransport` using one pinned Dart HTTP client already approved or newly pinned narrowly.
- Map connection refusal, timeout-before-response and malformed response to `unknownOutcome` only where server commit is unknowable.
- Add test-only loopback fixture auth selected by an explicit lab environment flag; default/deployable runtime must continue to refuse fixture auth.
- Start API as a host Node process against Compose PostgreSQL for easiest process kill, response delay and socket fault injection.

Exit: Flutter use cases execute through real HTTP without direct replay.

### CP4 — Cross-process convergence proof

- Create two isolated Drift files with one Account and distinct Devices.
- A registers offline, uploads, receives an injected timeout after server commit, retries the same SubmissionId and receives the stored result.
- B downloads bounded pages, atomically applies the Purchase, acknowledges contiguous cursor, and both clients reopen.
- Compare immutable Purchase/Product/Store/reference facts and derived Lists deterministically.

Exit: complete HTTP→API→PostgreSQL→API→Drift convergence passes.

### CP5 — Resilience and pre-Neon hardening

- Add serialization transaction retry with bounded attempts and jitter-free deterministic test control.
- Cover pool acquisition timeout/exhaustion and API unavailability.
- Expand RLS/constraint probes for select/update/insert and wrong Account/Device paths.
- Re-run migration from empty database and verify runtime role cannot DDL or bypass Account scope.

Exit: C10-S01B local evidence green; MCG-01 remains a separate human gate.

## 6. Executable local convergence story

Recommended topology:

```text
Docker Compose: PostgreSQL 18 only
Host process: Node 24 Fastify API on 127.0.0.1
Host test process: Flutter/Dart system harness
Local data: two temporary Drift files
Auth: deterministic loopback-only fixture verifier
```

PostgreSQL-only Compose is the shortest safe choice for C10-S01B because API restart, kill, delay and timeout-after-commit injection are simpler and faster from the host test runner. Adding the API to Compose may be reconsidered for CI parity after the local proof; it is not required to establish convergence.

Proposed orchestration:

```text
docker compose -f infra/sync_lab/compose.yaml up -d --wait
npm --prefix services/markei_sync_api run migrate:lab
npm --prefix services/markei_sync_api run seed:lab
npm --prefix services/markei_sync_api run start:lab
flutter test test/sync/http_postgres_two_device_system_test.dart
npm --prefix services/markei_sync_api run probe:privileges
npm --prefix services/markei_sync_api run probe:isolation
docker compose -f infra/sync_lab/compose.yaml down --volumes
```

Script names are proposed and must match the eventual package scripts. The harness should own API-process teardown and temporary Drift deletion even after failure.

## 7. Fixture and fault-injection matrix

| Case | Injection | Required evidence |
| --- | --- | --- |
| Account/two Devices | deterministic SQL seed; no production auth | authenticated A/B accepted; wrong Account denied |
| committed upload timeout | commit transaction, delay/drop response once | same SubmissionId retry returns stored result; one Event/cursor |
| repeated SubmissionId | same ID/hash then changed hash | equivalent stored result; terminal hash conflict |
| sequence gap | submit expected+1 | typed rejection; no Event/cursor/submission mutation |
| duplicate/reordered download | repeat and reverse page items | one fact/inbox; contiguous cursor does not skip gap |
| crash before apply | throw before transaction | no inbox/fact/cursor mutation |
| crash during apply | throw inside transaction after partial writes | full rollback; retry succeeds |
| crash after apply | terminate after commit before ack | reopen retains facts/inbox; ack resumes safely |
| serialization failure | force SQLSTATE 40001 once | whole transaction retries with bounded count |
| pool exhaustion | hold all pool clients past acquire timeout | typed retryable service-unavailable; no unsafe duplicate |
| unavailable API | stop/refuse loopback connection | local registration remains; submission stays retryable |
| revoked/unknown Device | mutate fixture state | upload/download/ack denied without data disclosure |
| Account isolation | select/insert/update under wrong session Account | zero rows or policy denial for every path |

## 8. Migration corrections before Neon

Likely required corrections, provisional until integration tests run:

- Add foreign keys from `submissions`, `sync_events` and `device_acknowledgements` to `(account_id, device_id)` and Accounts where missing.
- Add explicit checks for supported `event_type`, `payload_version`, non-empty batches and bounded payload sizes at the API/schema boundary.
- Enable/force RLS, or otherwise prove equivalent scoped access, on every Account-owned runtime table, not only `sync_events`.
- Ensure runtime role cannot mutate Accounts/Devices enrollment state unless a dedicated administrative path is intended.
- Add indexes for `(account_id, server_cursor)` download and acknowledgement validation.
- Use forward-only migration ledger/checksum and transactionally fail on partial migration.
- Avoid role creation inside provider migrations where the migration role cannot create roles; separate bootstrap grants from schema migration for Neon portability.
- Set transaction-local Account identity before every scoped query and reset it through transaction completion.
- Configure statement, lock and pool-acquisition timeouts explicitly in the lab.

No destructive rewrite or downgrade is permitted. Disposable server databases may be recreated; local Drift facts must not be reset.

## 9. Smallest validation command matrix

```text
git diff --check
flutter analyze
flutter test test/sync test/infrastructure/local_database_migration_test.dart \
  test/infrastructure/local_device_identity_repository_test.dart \
  test/local_purchase_repository_test.dart
npm --prefix services/markei_sync_api run format:check
npm --prefix services/markei_sync_api run lint
npm --prefix services/markei_sync_api run typecheck
npm --prefix services/markei_sync_api test
npm --prefix services/markei_sync_api run test:postgres
npm --prefix services/markei_sync_api run test:system
npm audit --prefix services/markei_sync_api --omit=dev
python -m unittest discover tests
flutter build windows --release
flutter build apk --debug
docker compose -f infra/sync_lab/compose.yaml down --volumes
```

Full repository validation remains appropriate before publication; the focused matrix should run first for rapid checkpoints.

## 10. Rollback and stop gates

Rollback checkpoints:

- API routes can be disabled while local-only operation remains functional.
- HTTP transport remains opt-in/injected; default application composition stays local-only until acceptance.
- Server lab is disposable and removed with volumes.
- Local schema corrections are additive; representative copies are preserved before migration tests.
- Unknown submissions and PendingEvents remain durable through process failure.

Stop immediately on:

- branch divergence, conflicting A-stage update or unexpected changed path;
- secret or payload leakage;
- runtime role DDL or cross-Account access;
- cursor advancement without committed fact/inbox application;
- acknowledgement over a gap;
- retry using a new SubmissionId after unknown outcome;
- duplicate creating a second fact/event/cursor;
- local migration reset/data loss;
- fixture auth reachable outside loopback test mode;
- unbounded retry, pool wait, batch size, memory or cost;
- loss of local-only startup and Purchase registration.

## 11. C10-S01B versus MCG-01

C10-S01B completion requires only disposable local evidence:

- real database-backed upload/download/ack routes;
- complete remote Purchase apply;
- Flutter HTTP transport;
- timeout-after-commit idempotency;
- two-Device cross-process convergence and reopen;
- bounded serialization/pool/unavailable-service behavior;
- comprehensive Account-isolation and migration-role probes;
- clean teardown and preserved local-only fallback.

MCG-01 begins only after those gates pass. MCG-01 concerns isolated Neon branch/database selection, role creation, provider-compatible migration, limits/cost review, secret storage and redacted acceptance evidence. A live provider is not part of C10-S01B and cannot repair missing local proof.

## 12. Unresolved Main decisions

- Whether a downloading Device receives its own events or the API filters by origin Device.
- Exact bounded download page size and payload/body limits.
- Cursor wire representation and response semantics when a page is empty.
- Collision behavior for stable Product/Store/reference facts beyond exact-equivalent reuse.
- Whether remote apply should call a dedicated no-outbox repository method or a shared aggregate writer with an explicit origin mode.
- Whether API-in-Compose is required later for CI after host-process proof.
- Whether migration bootstrap owns role creation or MCG-01 human provisioning owns it.
- Exact retry counts/timeouts and which protocol failures map to retryable unknown outcome.
- Scope of RLS versus mandatory server-scoped SQL on all Account-owned tables.

## 13. Confidence and evidence boundaries

- **High confidence:** download and acknowledgement endpoints are placeholders; source inspection is direct.
- **High confidence:** no Flutter HTTP transport and no complete Purchase application are present in the inspected implementation/materialization inventory.
- **High confidence:** current two-Device proof is local direct replay, not cross-process convergence; G states this explicitly.
- **High confidence:** current contiguous acknowledgement calculation is unsafe under gaps because it selects the greatest applied cursor.
- **Medium-high confidence:** PostgreSQL-only Compose plus host API is the shortest fault-injectable topology; this is an Operational hypothesis, not accepted architecture.
- **Medium confidence:** listed migration corrections are required before Neon; final set depends on database-backed route/isolation tests.
- **Low/unknown confidence:** host-specific process commands and tool availability after commit; GitHub inspection cannot execute the local lab.

## 14. Recommended second implementation

Authorize one bounded C10-S01B materialization containing CP1–CP5 only. Treat CP4 cross-process convergence as the decisive acceptance gate. Keep sync disabled by default and preserve local-only operation. On green evidence, write G/H/I and return to Main with status:

```text
C10-S01B_LOCAL_CONVERGENCE_PROVED
MCG-01_NOT_STARTED
```
