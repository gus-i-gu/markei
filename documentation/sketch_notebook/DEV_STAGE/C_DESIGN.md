# C_DESIGN — Cycle 10 Retention, Snapshot and Recovery Investigation

> Sequence: FLX-INV-02 investigative/speculative round
> Role: Design/Architecture [D]
> Branch / inspected HEAD: `intermid-cycle-recovery` / `36b7b22b20e3b308b7b800514f6828a91ea49fcd`
> Authority: investigation and Main handoff only
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX OR PROVIDER MUTATION

## 1. Methodology retained

The full route `INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL`
was read after both AGENTS files. Design may analyze ownership, invariants, topology, security and
alternatives. Under PRC-01, repository structure is implemented evidence only within its inspected
boundary; tests validate only named behavior; provider documentation does not approve a Markei
policy. Every conclusion below remains candidate, proposed or provisional. Only C may be replaced.
No source, migration, permanent memory, Main stage, report, Neon resource or secret may change.

## 2. Current architecture and round delta

Accepted C10-S01B path:

```text
Drift A → injected HttpSyncTransport → authenticated Fastify API
→ serializable PostgreSQL transaction → Account event stream
→ Fastify/API → HttpSyncTransport → atomic Drift B Purchase apply → acknowledgement
```

Implemented: append-only `purchase.registered` v3; closed immutable Purchase/Product/Store/Item
facts; Account-scoped ordered cursor; per-Device monotonic acknowledgement; bounded transaction
retry; RLS and explicit Account predicates; atomic facts/inbox/cursor apply; replay equivalence.

Newly confirmed missing: an earliest available cursor, Device lease/last-seen semantics, snapshot
identity or payload, cleanup watermark/ledger, resumable rebootstrap, local recovery session,
Account deletion state and protocol compatibility registry. Current `cursor-expired` is used when an
acknowledgement exceeds high-water; it does not yet mean an incremental cursor was retained away.
Lists remain rebuildable projections and must not enter an authoritative snapshot.

## 3. Required invariants

1. Events and snapshots are immutable, Account-scoped and authorized from verified claims.
2. `highWaterCursor` is the greatest committed Account event cursor.
3. A complete snapshot declares exactly one `coveredThroughCursor ≤ highWaterCursor`.
4. `earliestIncrementalCursor` is the first retained event cursor; every earlier missing event is
   covered by one durable, compatible, integrity-verified snapshot.
5. Cleanup may delete cursor `x` only when a durable snapshot covers `x`, policy permits deletion,
   and no protected active Device requires incremental delivery of `x`.
6. Device acknowledgement is evidence of one Device’s committed facts, not snapshot durability.
7. Rebootstrap never destroys unsent local Events; it preserves and later replays them with their
   original EventId, DeviceSequence, SubmissionId semantics and content hash.
8. Snapshot apply plus cursor installation is atomic, or restartable through an inactive staging
   database; acknowledgement occurs only after snapshot commit and post-snapshot catch-up.
9. Provider backup/PITR recovers infrastructure state; an application snapshot restores protocol
   facts to a client. Neither substitutes for the other.

## 4. Alternative A — slowest active Device blocks retention

**Model.** Extend Account stream state with high-water and cleanup watermark; Device rows gain
status, last-seen and acknowledgement. Delete only through the minimum acknowledgement of all
non-revoked Devices. No snapshots are required for ordinary recovery.

- Server/API: authenticate Device, renew lease, expose retention floor, serialize cleanup against
  upload/ack; dormant Devices remain blockers unless Main revokes them.
- Drift: incremental download only; existing atomic page apply remains sufficient.
- Races/transactions: cleanup locks Account retention state and recomputes the minimum; an ack or
  new Device enrollment concurrent with cleanup must serialize. Never trust a supplied ack beyond
  server high-water.
- Failure/recovery: crash-safe batched deletion with ledger; no rebootstrap path if a Device is
  mistakenly excluded. Revocation is security-significant and irreversible without enrollment.
- Cost/security: lowest migration and payload complexity; unbounded storage under one abandoned
  active Device, denial-of-retention by stale enrollment, and privacy exposure from long history.
- Tests: slow Device, ack regression, concurrent ack/cleanup, revoke during cleanup, worker retry.
- Rollback: stop cleanup worker; retained events remain valid. Confidence: medium technically, low
  as the long-term policy because it cannot guarantee bounded growth.

## 5. Alternative B — fixed TTL plus periodic Account snapshots

**Model.** Events expire strictly by age. Periodic complete snapshots cover a cursor; expired
Devices receive `cursor-expired` and rebootstrap from the newest compatible snapshot.

- Server tables: Account stream state; immutable snapshot manifest/chunks; cleanup jobs; no Device
  lease needed for deletion. Snapshot payload may be PostgreSQL bytes or object storage.
- API/Drift: manifest/chunk/rebootstrap endpoints and a local staging database; snapshot then catch
  up from covered cursor. Derived Lists rebuild after activation.
- Consistency: generate under one stable PostgreSQL snapshot and capture high-water from the same
  view; publication is a separate atomic metadata transition from `building` to `available`.
- Races: fixed TTL can delete events before a failed snapshot becomes durable unless cleanup checks
  coverage. Large Account generation and transfer may exceed transaction, compute or mobile limits.
- Failure/recovery: resumable chunks and verified manifest; local activation must be atomic. Unsent
  local facts can collide with authoritative snapshot identities and require quarantine/replay.
- Cost/security: predictable relay storage but continuous snapshot work, payload-leakage surface,
  object lifecycle/key complexity and forced rebootstrap even for recently dormant Devices.
- Tests: boundary-time deletion, concurrent uploads, corrupt/reordered chunks, obsolete manifest,
  interrupted activation, unknown completion, cross-Account object access.
- Rollback: suspend TTL cleanup and retain latest valid snapshot. Migration/operations high.
  Confidence: medium; strict TTL is too brittle without Device-awareness and minimum grace.

## 6. Alternative C — hybrid minimum TTL, Device lease and snapshot coverage

**Model.** Events receive a minimum retention age. Devices are `active`, `dormant` or `revoked`
according to an explicit lease policy. Cleanup floor is bounded by active Device acknowledgements,
minimum age and an available compatible snapshot. Dormant eligible Devices rebootstrap; revoked
Devices cannot bootstrap.

- Server: high-water/earliest cursor, Device lease and status, immutable manifests/chunks, cleanup
  ledger and recovery sessions. API owns authorization, lease renewal and typed lifecycle results.
- Drift: recovery session metadata, downloaded chunk ledger, staging database, preserved outbox and
  quarantine. Existing authoritative tables are replaced only after full verification/catch-up.
- Transactions: snapshot consistency and publication are separate; cleanup locks Account stream
  state, selects a valid snapshot and computes a monotonic deletion watermark. Deletion is batched,
  restartable and never advances earliest availability before committed deletion.
- Races: lease expiry during sync uses lease state captured by cleanup transaction; new uploads land
  after snapshot cursor and remain retained; Account deletion dominates publication/transfer.
- Cost/security: bounded growth with offline tolerance and explicit recovery, at the price of the
  largest state machine and a policy-sensitive dormant boundary.
- Tests: combined A/B tests plus lease edge times, snapshot compatibility, cleanup watermark
  monotonicity, reinstall/replacement and account-deletion races.
- Rollback: disable cleanup and snapshot scheduling; keep manifests/events; local-only composition
  remains unchanged. Migration cost high but forward-only and compartmentalized.
- Recommendation: C, high architectural confidence; retention durations and lease periods remain
  low-confidence policy decisions requiring Main and observed product usage.

## 7. Proposed server and storage model

| Structure | Owner | Key invariants |
| --- | --- | --- |
| `account_stream_state` | PostgreSQL | Account PK; next/high-water; earliest cursor; current snapshot |
| `device_sync_state` | PostgreSQL | Account+Device; status; ack; lease/last-seen; generation |
| `snapshots` | PostgreSQL metadata | SnapshotId; Account; state; format/schema/protocol; covered cursor; total hash/size |
| `snapshot_chunks` | PostgreSQL metadata | ordered index, size/hash, storage key; no public URL |
| payload chunks | object storage preferred after comparison | encrypted service-side; immutable; Account-prefixed opaque keys |
| `cleanup_runs` | PostgreSQL | planned/committed watermark, policy version, snapshot, attempts |
| `rebootstrap_sessions` | PostgreSQL | Device-bound, snapshot-bound, expiry, completion and catch-up cursor |
| recovery session/chunks | local Drift | inactive state, manifest, chunk hashes, progress, prior outbox inventory |

Small synthetic fixtures may keep chunks in PostgreSQL for the second local implementation. Do not
infer that production payloads belong there. Object storage avoids large database rows but adds
durability, authorization, encryption, lifecycle and egress dependencies. Flutter receives bytes
through the API or narrowly scoped short-lived download authorization; never PostgreSQL/object
storage credentials. Whether even signed URLs are permitted remains a Main security decision.

Snapshot content is a canonical, deterministic serialization of complete Account-owned Store,
Product, Person, Payment Method, Purchase and Item facts supported by the snapshot schema. It is not
event compaction and contains no pending queue, acknowledgement, inbox, Device secret, UI state or
Lists projection. Future edits/deletes require tombstones and snapshot semantics before cleanup can
cover them; current append-only scope must not invent those rules.

## 8. Snapshot creation and cleanup

Recommended trigger: threshold-driven (`events/bytes since last snapshot`) with an on-demand
administrative/test trigger and a maximum-age backstop; do not depend solely on wall-clock cron.

1. Start `SERIALIZABLE READ ONLY DEFERRABLE` or suitable stable-view transaction; read Account
   high-water and all authoritative facts from that same view.
2. Produce deterministic chunks outside the request path, each independently hashed; hash the
   ordered manifest including Account, SnapshotId, covered cursor, schema/protocol, chunks and size.
3. Durably write all chunks; verify read-after-write and total hash; atomically publish manifest as
   `available`. A failed build remains unavailable and cannot authorize cleanup.
4. Cleanup transaction locks Account stream state, rechecks snapshot availability/compatibility,
   active leases/acks and minimum age, records a proposed watermark, deletes a bounded batch, then
   advances earliest cursor and ledger together. Retry is idempotent by CleanupRunId.

PostgreSQL 18 documentation inspected 2026-07-15 guarantees that Repeatable Read sees a stable view
and that Serializable may require whole-transaction retry; `SERIALIZABLE READ ONLY DEFERRABLE` can
wait for a snapshot safe from serialization anomalies. This supports, but does not select, the
snapshot transaction design: https://www.postgresql.org/docs/current/transaction-iso.html

## 9. API contract hypothesis

- `GET /v1/sync/capabilities`: protocol/snapshot formats, high-water, earliest incremental cursor,
  current compatible SnapshotId, retention-policy version and Device lifecycle status.
- `GET /v1/sync/events?after&limit`: success includes earliest/high-water; if `after` precedes the
  floor, typed `cursor-expired` includes no facts and points to a recovery capability, not a raw key.
- `POST /v1/sync/rebootstrap`: idempotency key + Device; returns session and immutable manifest.
- `GET /v1/sync/rebootstrap/{session}/chunks/{index}`: bounded range/chunk response with index,
  length/hash and retry-safe ETag; reordered/truncated content fails locally.
- `POST /v1/sync/rebootstrap/{session}/complete`: reports verified SnapshotId/hash and committed
  catch-up cursor; replay returns stored result. It does not advance ack by assertion alone.
- existing acknowledgement remains monotonic and is sent only after snapshot activation and all
  events through the declared catch-up cursor commit locally.
- Device status endpoint returns active/dormant/revoked/replacement-required; it never enrolls or
  replaces a Device without a separately authorized production identity flow.

Unknown transfer outcome retries the same session/chunk/idempotency identity. Unknown completion
queries session status before retry. Obsolete snapshot, schema downgrade, revoked Device, hash
mismatch and Account deletion are terminal or require a new authorized session, never silent merge.

## 10. Local rebootstrap algorithm

1. Freeze sync orchestration, inventory original local database and durable unsent outbox; never
   mark unsent events accepted.
2. Download/verify manifest and chunks into resumable local recovery state.
3. Build a new inactive Drift database using normal fact invariants; verify Account, identity,
   totals, snapshot hash/schema and covered cursor; rebuild Lists.
4. Download/apply events `(coveredThrough, serverHighWater]` into the inactive database.
5. Reconcile preserved unsent events: equivalent server fact/event is satisfied; absent event is
   replayed with original identities after activation; same stable identity with different content
   is quarantined and blocks automatic activation/replay.
6. Atomically switch an installation pointer to the verified database where the platform supports
   it; otherwise close, rename with recoverable journal, reopen and retain the prior database until
   success. In-place table deletion/merge is not recommended.
7. Acknowledge only the committed catch-up cursor. Crashes before switch resume staging; during
   switch recover from journal; after switch resume ack without rebuilding.

Initial bootstrap is the same pipeline with no prior facts/outbox. Reinstall creates/replaces a
Device only through future enrollment. A revoked Device is denied; it cannot self-replace. Dormant
recovery requires still-valid authentication plus server lifecycle authorization.

## 11. Threat model and controls

| Threat | Required boundary |
| --- | --- |
| cross-Account snapshot/session | verified Account+Device on every metadata/chunk query; RLS and opaque keys |
| forged/obsolete manifest | server-issued immutable metadata; total hash; newest compatible/non-revoked session |
| truncation/reordering | per-chunk length/hash/index plus ordered manifest hash |
| schema downgrade | explicit minimum supported versions; reject lower/incompatible formats |
| premature cleanup | only published durable snapshot authorizes deletion; locked, audited watermark |
| malicious ack advancement | reject beyond Account high-water and beyond server-observed recovery completion |
| revoked/replacement abuse | enrollment authority separate from sync token; revoked sessions invalidated |
| payload/URL leakage | TLS; encryption at rest; short-lived authorization; no payloads, tokens or signed URLs in logs |
| cleanup privilege escalation | separate worker role limited to snapshot/cleanup procedures; no enrollment/account authority |
| account deletion race | deleting state blocks new sessions/publication, revokes access, then applies future tombstone policy |

Application snapshots may contain the complete purchase history and therefore expand privacy impact.
Client-side/end-to-end encryption is not silently proposed because key recovery, multi-Device key
distribution and server-side snapshot generation are unresolved. Service-managed encryption plus
strict authorization is the bounded hypothesis for local/provider exploration only.

## 12. Provider facts and MCG-01 dependencies

Official sources inspected 2026-07-15:

- Neon branches are copy-on-write isolated states and may have expiration; restore availability is
  bounded by plan/configured restore window. Therefore branch/PITR is operational recovery, not a
  client snapshot contract: https://neon.com/docs/introduction/branching
- Neon documents pooled and direct connections; web apps generally use pooled connections while
  migrations and operations relying on session behavior may require direct connections. MCG-01
  must test transaction-local RLS/context with the selected endpoint:
  https://neon.com/docs/connect/connection-pooling
- Neon supports `pg_cron`, but jobs run only while compute is active and setup changes endpoint
  settings/restarts compute. An external worker remains necessary unless sanitized MCG-01 proves an
  always-active compatible arrangement: https://neon.com/docs/extensions/pg_cron

MCG-01 must report only sanitized facts: development-branch availability/expiry, PostgreSQL
version, storage/compute/restore-window constraints, pg_cron or external-worker requirement, role
capabilities, pooled/direct behavior and connection limits. These affect scheduling and deployment,
not the logical cleanup/snapshot invariants. No secret or provider mutation is authorized here.

## 13. Second implementation and migration boundary

Split into two units.

**R1 policy-contract unit:** Main freezes lease states/times, minimum retention rule, snapshot
format/content, cursor-expired semantics, storage abstraction, local replacement strategy and
unsupported identity behavior; add deterministic contracts/fixtures only after authorization.

**R2 local materialization unit:** forward-only `003_retention_snapshot_recovery.sql` leaving
001/002 untouched; synthetic in-PostgreSQL chunks behind a storage port; deterministic snapshot at
a consistent cursor; coverage-gated deletion; expired third Device; resumable third isolated Drift
rebootstrap; preserved/quarantined unsent event; catch-up, ack, reopen and fact comparison; inject
interruption, corruption, cross-Account, revoked Device and premature-cleanup failures. Stop before
production auth, object storage or Neon mutation unless separately authorized.

Rollback is disable workers/endpoints, retain events/snapshots and remove explicit sync composition;
server schema corrections remain forward-only. Never reset local Drift or edit 001/002.

## 14. Main decisions and exit readiness

Main must reconcile: lease duration/status transition authority; minimum TTL and snapshot trigger;
PostgreSQL versus object-storage production payload; manifest signing/encryption; Account snapshot
content and future tombstones; signed-URL policy; local database activation mechanism per platform;
unsent identity-collision UX; Device replacement/enrollment; Account deletion dominance; protocol
support window; worker deployment; MCG-01 sanitized constraints; whether R1/R2 are separately gated.

Performance improvement: the problem is reduced to one recommended hybrid topology, two bounded
implementation units and explicit provider-dependent decisions. Evidence still missing: MCG-01,
snapshot-size measurements, platform-safe database swap evidence, product offline-duration policy
and production identity/enrollment. Exit toward implementation is **not ready** until Main freezes
R1. This document is speculative staging, not accepted architecture, implementation authority,
retention policy, backup policy or permission to configure Neon.
