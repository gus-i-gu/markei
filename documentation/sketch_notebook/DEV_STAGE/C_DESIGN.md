# 1. Main Synthesis Summary

Cycle 07 Shared Beta Planning should pursue one maintained cross-platform client for desktop and mobile, with offline-first local authority during ordinary use and a small synchronization API coordinating account-scoped events through Neon Postgres. This is a planning architecture, not framework acceptance or implementation authority.

The first shared slice should synchronize immutable purchase-registration events plus the minimum product, category, and store facts needed to apply those purchases independently. Each client writes locally first, queues an event, projects local state immediately, and later exchanges events through an authenticated API. Clients never receive privileged Neon credentials and never write Neon tables directly.

Three orderings serve different purposes: a device-local monotonically increasing sequence detects gaps and stabilizes retries; a server cursor orders accepted events for download; timestamps preserve business and diagnostic time but do not decide synchronization order. Globally unique UUIDs identify accounts, devices, entities, events, and commands. Event IDs and an account-scoped idempotency constraint make retry after an unknown network result safe.

The strategic migration is progressive: build the cross-platform client as the future shared desktop/mobile application while keeping the accepted PySide6 beta unchanged and recoverable. The new client does not replace PySide6 until fixture parity, desktop workflow parity, mobile lifecycle evidence, migration safety, and human/Main acceptance exist.

# 2. Accepted Human/Product Direction

The current Human/Main preference is:

```text
one maintained shared desktop/mobile application
+ offline-first local data
+ verified-email accounts
+ small custom synchronization API
+ Neon Postgres
+ append-only first synchronized slice
```

This activates synchronized-state planning and supersedes the earlier near-term “no backend” assumption. It does not accept a UI framework, authentication provider, API language, Neon schema, repository topology, or implementation plan. D/E/F remain unauthorized.

The product goal is not two applications that happen to read a shared remote database. It is one maintained client behavior expressed on desktop and mobile, with each installation owning its local database and the service boundary owning cross-device acceptance. Email provides a familiar login identifier; an immutable account UUID—not the email string—owns data.

# 3. Shared Client Boundary

The shared client owns responsive presentation, local application composition, local persistence, projection calculation, pending-event management, synchronization coordination, and the authenticated session.

The presentation requests use cases and renders facts. It does not own synchronization rules or SQL. The application composition root creates the local database, repositories, projection services, pending-event queue, synchronization coordinator, and authentication session for one installation. It also coordinates startup, logout, suspend/resume, and orderly close.

The local database is the client’s operational source while offline. A successful local registration should immediately appear in lists without waiting for Neon. The synchronization coordinator uploads pending events, downloads accepted remote events after the stored cursor, applies them idempotently, advances local sync metadata, and reports status without becoming a second business-rule engine.

Projection calculation belongs to shared client behavior. Average duration, expected next purchase, current quantity, and Storage/Shortage/Market status should be deterministically rebuilt from accepted facts where practical, rather than synchronized as competing mutable values.

# 4. Local Persistence and Event Queue

Each installation owns a fresh application-private database. It stores local entity references, immutable events, derived projections, authentication/session metadata appropriate for secure client storage, device identity, the last applied server cursor, and queue state.

A local purchase transaction should atomically:

1. validate the registration command;
2. ensure the required local reference facts exist;
3. append one immutable local event with a global event UUID and next device sequence;
4. update or rebuild affected projections;
5. mark the event pending upload;
6. commit once.

Queue states may be `pending`, `in_flight`, `accepted`, or `rejected`, but network timeout must not imply rejection. After an unknown upload result, the client retries the identical event IDs and device sequences. The server returns the previously accepted result rather than duplicating facts.

Downloaded events are applied in server-cursor order within a local transaction. The client inserts an event only if unseen, applies its reference facts, rebuilds affected projections, and advances the cursor only after successful commit. A crash before commit leaves the old cursor and permits safe replay.

# 5. Identity and Ownership Model

Candidate global identifiers are UUIDs generated without central coordination:

- `account_id`: immutable ownership principal;
- `device_id`: one registered installation;
- `event_id`: immutable synchronization event identity;
- `product_id`, `category_id`, and `store_id`: account-scoped entity identities;
- optional `batch_id` or request id: observability and request correlation.

Verified email is a replaceable login attribute linked to `account_id`. Changing email must not move, duplicate, or orphan data. Authentication proves a session belongs to an account; authorization checks that every device, event, entity, cursor request, and status query belongs to that account.

Access tokens authorize short API calls. Refresh tokens or equivalent renewable sessions belong in platform-secure client storage and may be revoked. Exact token format and provider remain open. Clients must never contain privileged database credentials, service-role tokens, or a Neon connection string capable of bypassing account authorization.

A device receives its `device_id` through authenticated registration. Each event carries `device_id` and a strictly increasing `device_sequence`. The server enforces uniqueness for both `event_id` and the account/device/sequence tuple.

# 6. Append-Only Event Contract

The first event family is `purchase.registered`. It records a completed purchase fact and is never edited in the first beta. The envelope should include:

- protocol version;
- event type and payload version;
- event UUID;
- account and device identity as authenticated/validated context;
- device sequence;
- client-recorded timestamp with timezone or UTC normalization;
- product, category, store, and purchase UUIDs;
- payload;
- optional correlation metadata.

The minimum independently applicable payload should contain purchase date, quantity, unit, unit price, total price, promotion flag, optional expiration date and notes, plus product name, brand, unit, category identity/name, and store identity/name required to create missing references. Reference snapshots avoid a second device receiving a purchase whose product/store rows do not exist.

This does not define editing. If the same product identity appears again, stable identity links the purchase. Category/store facts included in the event are bootstrap facts for that identity, not permission for arbitrary last-writer-wins updates. Address, analytics settings, page order, cached projections, and desktop display labels are outside the first payload.

Invariants include positive quantity, coherent price fields, recognized units, supported versions, valid UUIDs, authenticated account ownership, monotonic device sequence, immutable accepted payload, and deterministic validation results. Client timestamps record when the user says the purchase occurred; server acceptance time records ingestion. Neither replaces server cursor ordering.

# 7. Synchronization API Boundary

Candidate operations are technology-neutral:

**Register device.** Input: authenticated account context, installation-generated device UUID, protocol/client version, platform metadata kept minimal. Output: accepted device identity, active protocol range, current account cursor, and registration status. Errors: invalid session, revoked device, unsupported protocol, identity collision.

**Upload event batch.** Input: authenticated device, protocol version, ordered events, and request correlation ID. Output per event: accepted/already accepted/rejected, assigned server cursor when accepted, stable error code, and latest cursor. The API validates the whole envelope and each event, authorizes ownership, and appends idempotently.

**Download after cursor.** Input: authenticated device, last applied cursor, supported protocol versions, bounded page size. Output: ordered accepted events, next cursor, high-water mark, and continuation indicator. Cursors are opaque to clients even if represented numerically.

**Synchronization status.** Output: device registration/revocation state, server high-water cursor, client-reported cursor if submitted, pending rejection summaries, and protocol compatibility. It must not expose another account’s metadata.

**Revoke device/session**, optional for the first UI: invalidates future token/device use without deleting accepted events.

The API owns token verification, authorization, payload validation, protocol negotiation, idempotency, database transactions, cursor allocation, stable error taxonomy, and observability. Logs correlate account safely, device, batch, event, result, latency, and error class while avoiding purchase-note or token leakage.

# 8. Neon Data Responsibilities

Neon Postgres is the shared synchronization store, not the client’s direct operational database. Candidate responsibilities include:

- account identity references keyed by immutable account UUID;
- verified-email/provider reference metadata only as required;
- device registrations and revocation state;
- account-scoped entity identities;
- immutable accepted event envelopes and payloads;
- global or account-partitioned monotonically allocated server cursor;
- unique constraints for event UUID and account/device/device-sequence;
- protocol and schema metadata;
- acceptance timestamps and minimal observability references.

Every row carrying user data must be bound to `account_id`. The API transaction obtains the authenticated account context and never trusts a client-supplied ownership key alone. Whether database row-level security adds defense in depth remains open, but API authorization is mandatory.

Neon migrations belong to the server deployment boundary, not clients. Managed Postgres reduces infrastructure operations; it does not supply identity semantics, event idempotency, conflict rules, API authorization, or projection policy.

# 9. Projection and Transaction Ownership

Immutable events are shared facts. Local projections are rebuildable client views. The server may maintain operational indexes or account/device status projections, but it should not become the initial authority for Markei’s calculated Storage/Shortage/Market values.

Server upload transaction ownership should cover validation against server state, idempotency lookup, entity/reference acceptance, immutable event append, cursor allocation, and response status. Either all accepted effects for an event commit together or none do. Batch atomicity remains open: per-event atomic acceptance permits partial success; whole-batch atomicity is simpler conceptually but makes one bad event block unrelated valid events. The initial candidate is per-event results inside bounded transactional processing, while preserving request idempotency.

Local application transactions separately own local event creation/projection and downloaded-event application/cursor advancement. Network calls never remain inside a local database transaction.

A second device bootstraps by authenticating, registering, initializing an empty local store, and downloading from cursor zero in bounded pages. It applies all accepted events and rebuilds projections before declaring synchronization current.

# 10. Desktop-Beta Migration Strategy

Choose strategy B: progressively make the cross-platform client the shared desktop/mobile application, while preserving PySide6 unchanged until parity is evidenced. Strategy A—permanently adding a mobile client beside PySide6—would preserve desktop stability but retain two presentation/runtime implementations indefinitely, conflicting with the one-maintained-application direction.

Progression should be additive:

1. freeze and preserve the accepted Cycle 06 desktop recovery boundary;
2. specify contracts and deterministic fixtures from current behavior;
3. build the new client against a fresh isolated local database;
4. evidence mobile and desktop parity for the reduced slice;
5. design a one-time import that reads a protected copy of current desktop data and emits mapped append-only events;
6. validate counts, identities, dates, totals, and projections before any cutover;
7. keep rollback to PySide6 and the untouched original database;
8. retire or demote PySide6 only after human/Main acceptance.

Current text IDs and integer purchase/store IDs require explicit mapping to new UUIDs. Migration must be deterministic and recorded so retry does not create new identities. Direct file transfer, shared opening of the old SQLite file, and in-place destructive conversion are prohibited.

# 11. API Runtime Comparison

A TypeScript API aligns naturally with many cross-platform/web-oriented clients, offers strong JSON/schema validation ecosystems, mature Postgres tooling, and convenient shared generated types. It may reduce boundary friction if the client is TypeScript-based. It does not reuse Python business code, so deterministic fixtures become essential; careless type sharing can also confuse compile-time shapes with runtime validation.

A Python API can reuse vocabulary, validation concepts, date logic, and potentially fixture tooling from Markei. Mature web frameworks, validation libraries, database drivers, and migration tools exist. It may reduce the cost of translating current behavior, but sharing Python server code does not make the cross-platform client share that runtime, and async/deployment/database choices still require disciplined maintenance.

Selection should depend on executable contract tests, database migration quality, authentication integration, deployment support, observability, team maintenance burden, and how cleanly the API remains a synchronization boundary. Familiarity alone is insufficient. The first architecture should keep events language-neutral so either runtime can be replaced.

# 12. Explicit Deferrals

Deferred from the first shared beta: purchase editing/deletion or compensating-event design; household sharing; collaborative permissions; complex conflicts; real-time push; background sync; broad schema redesign; direct database-file transfer; complete settings sync; historical mutable product/store editing; app-store production release; permanent repository split; public API; server-authoritative analytics; full PySide6 retirement; and final authentication, client, API, or database framework selection.

# 13. Candidate Minimal Shared Slice

The smallest meaningful synchronized slice is:

1. user verifies email and signs in on device A;
2. client registers the device and initializes a fresh local database;
3. user registers one purchase offline;
4. local event, pending queue entry, and projection commit atomically;
5. client uploads the event; the API authenticates, authorizes, validates, appends idempotently, and assigns a cursor;
6. device B signs into the same account, registers, and downloads from cursor zero;
7. device B applies the event and rebuilds the same projection;
8. device A retries the original upload after a simulated unknown response and receives “already accepted,” with no duplicate;
9. a different account cannot read or append against either account’s data;
10. the Cycle 06 database remains unchanged and recoverable.

# 14. Unresolved Decisions

Main must still decide: client framework; authentication provider; TypeScript versus Python API; cursor allocation scope; per-event versus whole-batch atomicity; exact event/reference payload; unit and currency representation; secure token storage; database row-level-security role; migration mapping rules; repository topology during the shared-client transition; whether device revocation is required in the first UI; and the evidence threshold for desktop parity and PySide6 retirement.

The first decisions should be contract and identity semantics, because framework experiments without stable events may test packaging while leaving synchronization meaning undefined.

# 15. Handoff to Main

Main should reconcile this report with Operational infrastructure/toolchain constraints and Didactic contract/synchronization distinctions. The next authorized work should remain planning: accept or revise the identity/event envelope, decide the minimum purchase/reference payload, choose the batch transaction rule, and define fixture scenarios. Only after those boundaries are accepted should Main select one bounded D/E/F unit for framework/API/Neon prototyping.