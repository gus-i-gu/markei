<!-- TEMPORAL_MARKER:C10-ENTRY-2026-07-14 -->
> Cycle 10 Design investigation. Replaces the prior active C cache; permanent Design memory retains Cycle 09 history.

# C_DESIGN — Cycle 10 Synchronization Architecture Investigation

Sequence: FLX-INV-02
Role: Design/Architecture [D]
Branch/baseline: `intermid-cycle-recovery` / `0b3c8320069723ff94617bd6d83630684993c4f3`
Authority: investigation and Main handoff only
Writable surface: `DEV_STAGE/C_DESIGN.md`
Evidence: methodology; 00/06/J; Design memory; handwritten Drift/repositories/tests; v1 fixtures; official Neon/PostgreSQL and candidate-runtime docs
Prohibited: source/config/schema/dependencies/permanent memory/J/A/B; external resources; secrets; Cycle 11 UI

## 1. Methodology retained

Project memory outranks chat memory. Design owns responsibility, trust, identity, migration and convergence analysis, not Operational validation or implementation authority. PRC-01 separates implemented, prototype-only, contradicted, prospective, deferred and unvalidated claims. Source/executable evidence may correct prose; generated Drift remains derived. C is staged evidence for Main, not canon or D/E/F.

## 2. Current architecture inventory

```text
Flutter presentation
→ application commands/query ports/read models
→ independent Dart domain
← local Drift adapters
→ handwritten schema v4 / app-private SQLite
```

Usable now:

- `Devices(id, accountId, nextSequence, createdAt)`;
- immutable `SyncEvents`: EventId, AccountId, DeviceId, DeviceSequence, type, payload version/JSON, occurrence, content hash;
- unique `(accountId, deviceId, deviceSequence)`;
- `PendingEvents(eventId, state, enqueuedAt)` outbox membership;
- `SyncState(accountId, nullable accountCursor, updatedAt)`;
- atomic Purchase + Items + Event + PendingEvent transaction;
- file-reopen persistence, sequence continuity and rollback tests;
- shallow `purchase.registered`/aggregate protocol examples.

Handwritten `local_database.dart` and repository transactions are authority. `local_database.g.dart` is derived.

## 3. Prototype-only and contradictions

- `local-account` is not authenticated identity.
- Device bootstrap scans only 20 Account Devices and selects the earliest UUID v4; it does not identify this installation.
- One app-private database can contain historical Devices, but has no singleton installation metadata pointing to exactly one current Device.
- PendingEvent has no attempts, next-attempt, lease, terminal rejection or acknowledged cursor.
- SyncState has one cursor, but no inbox/applied-event ledger.
- Event envelope can upload immutable facts, but alone cannot safely deduplicate crash-replayed downloads.
- v1 protocol examples are descriptive and shall not control newer payload versions without reconciliation.
- EventId identifies the immutable event; reusing it as a request/retry identity cannot distinguish one batch attempt from its events.
- current Account/Product/reference codes were designed locally; server allocation/convergence is unresolved.
- local outbox preparation is not authentication, upload, download, acknowledgement or convergence.

Must migrate before networking: authenticated Account mapping; installation→current Device invariant; inbox/applied-event state; durable outbox attempt/result fields or companion table; cursor/apply transaction; protocol fixtures/version rules. Do not retrofit these through generated code.

## 4. Proposed topology and trust boundaries

```text
Flutter + authoritative local Drift
↕ authenticated HTTPS, versioned contracts
controlled application API
↕ least-privilege server role
Neon-hosted PostgreSQL coordination store
```

Flutter never receives database owner/migration/Neon API credentials and never connects to Postgres. Client bearer/session material belongs in platform-secure storage when selected. API verifies token, resolves immutable Account, authorizes Device, validates schema/hash/sequence, performs idempotent append/cursor transaction, filters downloads, records acknowledgement and returns typed outcomes. Neon/Postgres owns durable constraints, transactions and indexes, not product meaning.

Provider environments should be isolated. Neon branches are copy-on-write and may support development/test/temporary environments; databases belong to branches. Runtime and migration roles must be distinct and least-privilege. RLS is defense in depth only, never a substitute for API authorization. Official evidence: Neon branching/databases/roles/pooling docs; PostgreSQL 18 row security, INSERT/ON CONFLICT and transaction-isolation docs.

## 5. Account, installation and Device alternatives

| Alternative | Cost/security/offline | Rollback/evidence | Recommendation |
| --- | --- | --- | --- |
| Auth account + server-enrolled Device; local singleton InstallationMetadata references Device | local migration + enrollment API; clear revocation/history | additive tables; prove reinstall, restore, concurrent bootstrap, revocation | recommend, high |
| derive Device from hardware/app installation | low schema; unstable/privacy/platform risk | hard to repair; rejected | reject |
| choose any historical UUID Device on startup | no migration; forgery/sequence collision | current heuristic only | reject |

InstallationId is local app-instance metadata, not DeviceId. Device is server-enrolled event origin; historical/revoked Devices remain addressable. Reinstall/data clear creates or recovers identity only through an explicit pairing policy. Authentication provider and pairing UX remain Main decisions.

## 6. Event, SubmissionId, sequence and cursor

Recommended identities:

- EventId: immutable UUID, globally deduplicates one domain event.
- SubmissionId: UUID per upload request/batch attempt; repeated HTTP retry reuses it and receives the same stored response. New batching attempt uses a new SubmissionId while EventIds remain stable.
- DeviceSequence: monotonic per enrolled Device; server unique key enforces it.
- ServerCursor: opaque, monotonically allocated per Account when an event is accepted.
- Inbox key: `(accountId, eventId)` plus applied cursor/result.
- Device acknowledgement: greatest contiguous applied cursor, not “last downloaded”.

Sequence policy alternatives:

1. require exact next sequence; detects gaps but can block after lost local state;
2. accept any greater sequence; easier recovery, weaker gap evidence;
3. accept exact next with explicit server-authorized recovery/reset epoch.

Recommend 3 prospectively, medium confidence; Main must freeze recovery semantics. Event hash mismatch for the same EventId is terminal tampering/collision, never duplicate success.

## 7. First synchronized vertical slice

Recommend one append-only `purchase.registered` aggregate only:

```text
Device A registers offline
→ local facts + immutable outbox event commit
→ authenticated batch upload
→ API validates Account/Device/version/hash and appends idempotently
→ assigns Account cursor
→ Device B downloads after cursor
→ inbox insert + Purchase/Product/Store/reference apply + cursor advance in one Drift transaction
→ rebuild/invalidate Lists from synchronized facts
→ B acknowledges contiguous cursor
```

Exclude edits/deletes, Settings mutation, reference management, Product merge, Analytics, Household and background/realtime sync. Minimum UI is observable sync state/retry/error only; Cycle 11 owns polish.

The event payload must contain stable IDs and complete immutable fact data needed to apply without querying another client. Server must not manufacture Product identity. Collision between same stable ID and different content is a typed conflict requiring quarantine/manual policy.

## 8. Server schema and API responsibility outline

Logical server units, not accepted physical DDL:

- Accounts and AuthSubjects mapping;
- Devices with Account, status, enrollment/revocation and optional key/credential reference;
- Events with EventId, Account, Device, sequence, cursor, type/version, occurrence, payload, hash, received time;
- Submissions with SubmissionId, Account, Device, request hash and stored response;
- DeviceAcknowledgements with Account/Device/contiguous cursor;
- schema migration ledger; optional rejection/quarantine record.

Required constraints/indexes: EventId unique; Account+Device+sequence unique; Account+cursor unique; SubmissionId scoped unique; Account+cursor download index; Device status lookup; FK Account isolation. Every event append, sequence check, cursor allocation and submission result commits atomically.

API surface candidate: enroll/pair Device; upload event batch; download after opaque cursor with limit; acknowledge cursor; inspect/revoke current Device. Responses return stable code, title/explanation, operation/field, retryability and outcome: applied, duplicate-equivalent, rejected-not-applied, unknown/retry-safe, auth-required, device-revoked, cursor-expired or protocol-upgrade-required.

## 9. API runtime alternatives

| Alternative | Responsibility/cost | Security/recovery/evidence | Position |
| --- | --- | --- | --- |
| TypeScript Node + Fastify-style schema routes | explicit long-lived API, strong route/schema/testing seams; moderate ops | prove host, auth middleware, transactions, connection/pooling limits | favored investigation, medium |
| TypeScript Hono on selected serverless runtime | small portable HTTP layer; runtime coupling/cold starts | prove driver/runtime limits, transaction behavior and observability | retain |
| provider-specific data API/direct RLS client | less custom API, but moves trust/contracts toward client/database | conflicts with controlled-API boundary | reject for first slice |

No framework/host/ORM/migration tool is selected. Compare primary docs and a local contract harness before Main freezes D/E/F.

## 10. Upload/download, retention and convergence alternatives

Inbox:

- ledger of applied EventIds + cursor is recommended; high confidence;
- cursor-only is rejected because a crash/reorder/replay can reapply an event.

Acknowledgement:

- per-Device greatest contiguous cursor recommended;
- “last seen” cursor rejected because gaps become invisible.

Retention:

1. retain immutable event log until account deletion: simplest recovery, greatest privacy/storage cost;
2. snapshots + bounded event window after all eligible Devices acknowledge: lower retention, requires snapshot/bootstrap/expiry proof;
3. fixed TTL regardless of Devices: simple, can strand offline Devices.

Recommend investigate 2, low/medium confidence; duration and eligibility remain Main/human decisions. Expired cursor must return a typed rebootstrap requirement, never silently skip facts. Account deletion requires authentication/reconfirmation, revocation, bounded purge workflow and auditable status without logging payloads.

Convergence:

- append-only Purchase: same EventId must converge identically; different Purchase IDs coexist;
- Product stable-ID/content collision: quarantine/conflict, no automatic merge;
- visible-code/exact-identity collision across Devices: deterministic typed conflict policy remains unresolved;
- Store/reference creation and later edits are deferred from slice one;
- derived Lists are invalidated/rebuilt locally after apply and are never synchronized as authority.

## 11. Crash safety and unknown outcomes

Upload timeout after server commit is unknown locally: retry same SubmissionId/EventIds; server returns stored equivalent result. Download apply must transactionally insert inbox records, apply facts and advance cursor; crash before commit replays safely. Acknowledgement occurs only after commit. Invalid payload/version is quarantined or rejected without cursor advancement locally. Corrupt local queue/inbox requires explicit recovery/export evidence, not database reset.

Synchronization is not backup. Export remains a user-controlled artifact. Neon recovery protects service data but does not replace portable local backup/restore policy.

## 12. Threat model

| Threat | Required boundary |
| --- | --- |
| privileged credentials in client | prohibit; API-only DB access, secret scanning |
| token theft/replay | short-lived tokens, rotation/revocation, TLS, audience/issuer checks |
| cross-Account access | server-derived Account, scoped queries/constraints; optional RLS |
| forged Device/Event | enrollment authorization, Device status, UUID/hash/sequence validation |
| sequence/cursor manipulation | server-owned cursor; transactional next/epoch policy |
| duplicate/reordered delivery | Event uniqueness, inbox ledger, contiguous acknowledgements |
| payload tampering/version mismatch | canonical hash, schema/type/version validation, size limits |
| unsafe logs/telemetry | identifiers/status only; no tokens, credentials or purchase payloads |
| over-retention | explicit eligibility/window/deletion policy |
| migration privilege escalation | separate migration/runtime roles; audited one-way migrations |
| compromised/revoked Device | deny uploads/enrollment renewal; preserve historical attribution |

Rate limiting, request-size/batch limits and generic external auth errors are API responsibilities.

## 13. Manual Configuration Gates

- MCG-01: human creates/selects isolated Neon project/branch/database; records non-secret identifiers, region/version, runtime vs migration roles, least privileges, pooling decision and teardown. No schema yet.
- MCG-02: human configures candidate API runtime, TLS endpoint and secret variables outside repo; proves health + DB connectivity with runtime role and migration path separately.
- MCG-03: human provisions minimum test Account/auth subject and enrolls two controlled Devices; proves token storage/revocation without permanent secrets in fixtures/docs.
- MCG-04: human prepares Device A/B databases, deterministic fixtures, cleanup/retention observation and teardown; no production data.

Each gate pauses broad refactoring, records owner/evidence/rollback, and never commits values.

## 14. Migration and rollback boundaries

Local schema units must be independent: InstallationMetadata/current Device; outbox attempt/result; inbox/applied ledger; cursor/ack metadata. Each needs v4 fixture, backfill, failure/reopen/no-reset and generated-code reconciliation. Preserve historical Devices/events and the Python database.

Server migrations are forward, versioned and run by migration role; runtime role cannot DDL. Deploy schema/API compatibility before client activation. Rollback is disable sync and keep local-first writes/outbox; never downgrade by deleting local facts. Provider branch/reset is environment recovery, not application migration rollback.

## 15. Unresolved Main decisions

1. authentication provider, Account recovery and Device pairing/reinstall policy;
2. API framework/runtime/host, Postgres driver and migration tool;
3. Neon project/branch/database/role layout per environment;
4. exact InstallationMetadata and local inbox/outbox schema units;
5. SubmissionId response-retention rule and sequence recovery/epoch policy;
6. canonical payload/schema/hash rules and size/batch limits;
7. Product/code/exact-identity collision and quarantine UX policy;
8. acknowledgement eligibility, retention duration, snapshot/rebootstrap policy;
9. RLS adoption and migration/runtime privileges;
10. export-only versus local backup/restore;
11. MCG evidence and Windows/Android/two-device acceptance matrix.

Exit: investigation complete; first slice recommended; implementation/provider mutation inactive; Main must reconcile A/B/C before D/E/F.
