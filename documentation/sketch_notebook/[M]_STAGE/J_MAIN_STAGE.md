# J_MAIN_STAGE — Cycle 10 Local Convergence Completion Reconciliation

> Sequence: FLX-INV-02 A/B/C investigation → Main reconciliation → D/E/F materialization
> Unit: C10-S01B — Local synchronization convergence completion
> Status: RECONCILED; D/E/F CODEX AUTHORITY PREPARED; MCG-01 NOT STARTED
> Branch: `intermid-cycle-recovery`
> Reconciled HEAD: `1d5c0b6006831c62320d535ed3c99364d790a465`
> Materialized baseline: `1af8137e3f7db2d5ee3ecdf3796ae62808e0717c`
> Inputs: current A/B/C, prior D/E/F, G/H/I and inspected implementation
> Authority: human-supervised Main synthesis

---

<!-- ROUND_MARKER:C10-S01B-RECONCILIATION-2026-07-14 -->

## 1. Purpose and evidence state

C10-S01 produced a substantial synchronization scaffold, not the complete proof required by its
former exit criteria. This J preserves the validated foundation and activates one corrective unit
that completes the disposable local vertical slice before any Neon mutation is accepted.

PRC-01 classification:

- implemented and locally validated: protocol v3/hash parity, Drift v5, Installation→Device,
  durable Submission retry identity, inbox/cursor bookkeeping, upload transaction foundation,
  migration/role probes, local-only fallback and platform builds;
- partial: server route validation, Account isolation and database-backed upload evidence;
- stubbed/missing: real download, durable acknowledgement, Flutter HTTP transport, complete remote
  Purchase application, cross-process convergence and bounded serialization retry;
- deferred: live Neon, production auth, API deployment, retention/rebootstrap and Cycle 11 UI/UX.

G/H/I remain observational evidence. D/E/F below are the controlling authority for C10-S01B.

## 2. Reconciled defects

Repository inspection and A/B/C agree that:

1. `GET /v1/sync/events` returns an empty placeholder and does not authenticate or query Postgres.
2. `POST /v1/sync/acknowledgements` returns a constant result and does not persist an ack.
3. No Flutter `SyncTransport` HTTP adapter exists.
4. The current two-file harness directly replays a page and bypasses HTTP/PostgreSQL.
5. Remote apply inserts inbox/cursor records but not Store/Product/Purchase/Item/reference facts.
6. Greatest-cursor lookup does not prove a contiguous applied prefix.
7. Server transaction execution has no bounded serialization/deadlock retry.
8. Route schemas, body/page limits and database-backed endpoint tests are incomplete.
9. Migration 001 lacks required composite FKs, complete RLS/grant coverage and scoped context.
10. Normal runtime correctly refuses fixture auth, but no explicit loopback lab entrypoint exists.

These defects prevent the words `facts applied`, `acknowledged`, `converged` and `synchronized` from
being used as completed product claims.

## 3. Main decisions

### 3.1 Unit boundary

C10-S01B completes only the local `purchase.registered` v3 path:

```text
two isolated Drift databases
→ Flutter HTTP transport
→ loopback Fastify child process
→ disposable PostgreSQL 18
→ loopback Fastify child process
→ Flutter HTTP transport
→ complete remote Drift aggregate apply
```

Docker Compose runs PostgreSQL only. The system harness owns a host Node API child process so it can
inject delays, terminate safely and prove timeout-after-commit recovery. The Flutter test process
may own both isolated Drift files; API and PostgreSQL boundaries must remain real.

### 3.2 Contract closure

Keep event type `purchase.registered` and payload version 3. Close every aggregate sub-schema with
bounded fields and `additionalProperties: false`. The event must contain complete immutable Store,
Product, Purchase and Item snapshots. A referenced Person or Payment Method must carry its complete
immutable reference snapshot; otherwise it is explicitly null. Bare foreign IDs are invalid.

Update valid/invalid fixtures and recompute canonical Dart/TypeScript hashes together. Preserve the
documented canonical UTF-8 JSON and SHA-256 rule.

### 3.3 Cursor and page policy

Use a versioned opaque cursor token owned by the API. Clients compare tokens only for equality and
never perform arithmetic. Download returns every Account event, including the requesting Device's
own events, ordered by server cursor with a bounded default 25 and maximum 100.

An empty page preserves the supplied cursor. A non-empty page returns the final event cursor. Local
apply requires a contiguous ordered page from the committed cursor; gap/reorder stops with no fact,
inbox or cursor mutation. The Account stream begins from an explicit origin token.

### 3.4 Remote aggregate application

Implement a dedicated `purchase.registered` remote applier. Do not reuse a registration path that
creates new IDs or an outbound SyncEvent. Equivalent stable Store/Product/reference/Purchase facts
are reused; same identity with different immutable content is a terminal conflict and the whole
page rolls back. Do not auto-merge Products or reassign visible codes.

Facts, Items, inbox entries and the page-end cursor commit once in one Drift transaction. Lists are
query-derived: after commit the harness requeries and compares them; acknowledgement means facts,
inbox and cursor committed, not that every Device or projection consumer has observed the change.

No durable quarantine table or Drift schema v6 is authorized. Typed failure plus rollback and
test-owned diagnostics are sufficient for this unit.

### 3.5 API and Postgres hardening

Add forward-only `002_coordination_hardening.sql`; do not rewrite published migration 001. Migration
002 adds composite FKs, indexes, checks, revoked default privileges and Account RLS/policies across
runtime coordination tables. Runtime may read Account/Device enrollment state and update only the
sequence/cursor/submission/event/ack fields required by sync; it may not provision Accounts/Devices,
perform DDL or manage roles.

Every sync transaction derives Account/Device from `AuthVerifier`, sets transaction-local database
context on its checked-out connection, retains explicit Account predicates and fails closed when
context is absent. The transaction runner retries SQLSTATE `40001` and `40P01` only, with at most
three total attempts and one overall deadline. Unknown commit outcomes preserve SubmissionId.

### 3.6 Authentication and transport

Add an explicit loopback-only lab entrypoint that injects fixture claims from synthetic aliases.
Fixture auth must require a test/lab-only composition, refuse non-loopback binding and remain
unreachable from the normal entrypoint. No production provider, enrollment endpoint or real token
format is selected.

Add one narrowly pinned Dart HTTP dependency and an infrastructure adapter with injected base URI,
token source/client, timeouts and response-size cap. It never logs headers, tokens, URLs containing
credentials or payloads. Retrying remains an application decision; unknown upload retries use the
same SubmissionId and identical request hash.

## 4. Required executable proof

The decisive story is:

1. provision synthetic Account plus Device A/B through migration-owned lab seed;
2. A registers one complete Purchase offline;
3. A uploads through HTTP and Postgres commits once;
4. the lab drops/delays the first response after commit;
5. A persists unknown and retries the same SubmissionId/request hash;
6. the server returns the stored equivalent response and owns one Event/cursor;
7. B downloads the page through HTTP;
8. B validates and atomically applies the complete aggregate/inbox/cursor;
9. replay and reordered/gapped cases create no duplicate or cursor skip;
10. B acknowledges its committed contiguous cursor through HTTP;
11. both Drift files reopen;
12. Purchase/Store/Product/Item/reference facts and derived Lists compare deterministically.

Direct event replay remains useful unit evidence but cannot satisfy this system gate.

## 5. Failure and security floor

Codex must cover:

- malformed/unknown/oversized requests and closed schema rejection;
- wrong Account, unknown/revoked Device and fixture-auth escape prevention;
- same Submission/Event hash replay versus identity/hash conflict;
- DeviceSequence duplicate/gap and concurrent submission;
- cursor origin, empty page, paging, gap, reorder and duplicate delivery;
- crash before/inside/after local apply and after commit/before acknowledgement;
- serialization/deadlock retry and exhaustion;
- pool acquisition timeout and API unavailable while local save continues;
- runtime DDL denial and SELECT/INSERT/UPDATE cross-Account denial on every runtime table;
- migrations 001→002, fresh database, partial-failure behavior and deterministic teardown.

Any secret/payload leak, cross-Account access, cursor-without-facts commit, acknowledgement over a
gap, outbox echo, duplicate business effect, local reset or fixture-auth escape stops publication.

## 6. Semantic and privacy contract

Tests and typed results must distinguish:

```text
saved locally → waiting upload → uploading → server accepted
download received → facts applied → acknowledged by this Device
duplicate-equivalent | conflict | not-applied | unknown outcome
```

`server accepted` is not peer application. `acknowledged` is not all-Device convergence.
Synchronization is not backup, export or provider recovery. Diagnostics expose codes, redacted
aliases, counts, cursors, timings and hashes only. Learner/KANBAN maturity remains unchanged.

## 7. Exclusions and manual boundary

Codex must not contact or configure Neon, deploy the API, select production authentication, create
real Accounts/Devices, implement retention/snapshots/rebootstrap, background sync, edits/deletes,
UI status surfaces, pairing, Analytics or any Cycle 11 visual work.

No human action is expected unless Docker/Node/Flutter tooling cannot run. Provider credentials are
never requested. MCG-01 begins only after Main reconciles successful C10-S01B evidence.

## 8. Reporting and terminal state

After materialization Codex replaces G/H/I with exact changed paths, commands, counts, failures,
deviations, secret scan and teardown evidence. Success requires the real vertical slice, not stubs.

Successful terminal report:

```text
C10-S01B_LOCAL_CONVERGENCE_PROVED
MCG-01_NOT_STARTED
```

If any decisive gate remains partial, report `C10-S01B_PARTIAL` with the exact blocker and do not
claim MCG-01 readiness.
