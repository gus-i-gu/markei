# Main Synthesis Summary

Cycle 07 Shared Beta Planning changes Markei’s learning problem from “Can a mobile client work locally?” to “How can desktop and mobile preserve one account’s facts while each remains useful offline?” The favored planning target is one cross-platform client with local persistence, verified-email identity, a small custom synchronization API, Neon as shared event storage, and an append-only first synchronization workflow.

The central lesson is separation of responsibilities. Email verification helps prove account access; an immutable account UUID identifies the account; an access token carries temporary proof to the API; the API validates, authorizes, orders, and accepts events; Neon stores shared facts; each client owns its local database, offline queue, and rebuilt projections. A managed database reduces database administration, but it does not invent synchronization rules.

The first shared slice should synchronize immutable purchase events and necessary identity/reference facts. Storage, Shortage, Market, expected dates, and averages should normally be rebuilt locally from those authoritative facts. This report stages concepts only. It does not select providers, authorize implementation, create KANBAN entries, or change maturity.

# Conceptual Model of the Shared App

Each installation is a client with its own durable local database. “Offline-first” means registering and viewing purchases should continue when the network is unavailable. It does not mean permanently offline: when connectivity returns, the client uploads queued local events and downloads events it has not seen.

The shared model is:

```text
user action
→ local transaction
→ append authoritative event locally
→ update/rebuild local projections
→ queue event for synchronization
→ authenticated API upload
→ idempotent shared append
→ server cursor
→ other client downloads unseen events
→ transactional local application
→ deterministic projection rebuild
```

The API is an application boundary, not merely a tunnel to Neon. It protects database credentials and owns validation, account isolation, retry behavior, cursor semantics, and protocol compatibility. Neon is the managed Postgres store behind that boundary. “Managed” means infrastructure duties such as hosting and availability are reduced; synchronization logic still belongs to Markei.

A shared client does not mean a copied database file. Database-file copying mixes local engine state, partially written changes, platform paths, and device-specific lifecycle. Synchronization exchanges defined facts through a protocol.

# Identity, Authentication and Authorization

**Identity** answers “Which account, device, entity, or event is this?” **Authentication** answers “What evidence proves this caller controls the account?” **Authorization** answers “What may this authenticated caller read or write?”

A verified email address is a login and communication attribute. It may change, differ in capitalization, or be replaced. It should not be the permanent key connecting every purchase. After verification, the system resolves an immutable account UUID. That UUID remains the stable owner even if the email changes.

An access token is short-lived proof presented to the API. It may contain or resolve the account identity and expiry. It is not a database credential. A database credential can directly access Neon and may carry broad privileges; embedding it in clients would bypass Markei’s validation and account-ownership rules.

Authorization applies after authentication. The API must still ensure that an event’s `account_id` belongs to the authenticated account. **Row ownership** means every shared event or relevant reference fact is scoped to its owning account, preventing one account from reading or appending another account’s data.

# Local Persistence and Synchronization

Local persistence means one installation retains data across close, restart, and offline use. Shared state means facts accepted into the account-scoped server history can become available to other authorized installations. Synchronization is the protocol that moves and applies those facts; it is not “make two SQLite files identical.”

An **offline queue** records events created locally but not yet acknowledged by the server. Losing the network must not lose the purchase. Reconnecting should retry safely. Downloading must also be incremental: the client asks for events after its last acknowledged server cursor, applies them transactionally, then advances its local cursor.

**Eventual consistency** means devices may temporarily show different state while offline or between synchronization rounds, but should converge after they have received and deterministically applied the same accepted facts. It is not permission for arbitrary permanent disagreement.

**Conflict avoidance** designs the first slice so conflicting edits are uncommon: immutable purchases, no purchase editing/deletion, stable IDs, and append-only exchange. **Conflict resolution** defines what happens when legitimate competing changes exist. By excluding mutable concurrent workflows, Sprint 02 can avoid designing a general resolution system without pretending conflicts are universally solved.

# Append-Only Event Model

An append-only event records that something happened; accepted events are not overwritten in place. For Markei, “purchase registered” is a strong first event because purchases are already treated as immutable historical facts. A mutable record instead represents a current value that can be replaced, which demands rules for concurrent edits and lost updates.

Event identity and entity identity differ. An `event_id` UUID identifies one occurrence in the synchronization history. An `entity_id` identifies the product, purchase, store, or other domain object affected. Two events may concern the same entity, while one retry of the same event retains the same event UUID.

A planning event needs:

```text
event UUID
account UUID
device UUID
per-device sequence
entity type and entity UUID
operation type
payload
client occurrence time
server acceptance cursor
schema/protocol versions
```

The authoritative fact is the accepted purchase event and required identity/reference facts. Cached averages and status labels are interpretations of those facts, not competing events to be synchronized independently.

# Ordering, Idempotency and Cursors

Timestamps alone are insufficient. Device clocks differ; an offline event may arrive late; two events may share a timestamp; and network retries may deliver events in a different order. Client occurrence time remains useful for domain meaning—when the purchase happened—but cannot alone establish unique identity, duplicate protection, or global delivery order.

The combined roles are:

- **Event UUID:** globally identifies the logical event and lets retries refer to the same fact.
- **Device sequence:** records creation order from one installation and exposes gaps or repeated submissions.
- **Client occurrence time:** preserves the user/domain time associated with the purchase, while remaining untrusted for global ordering.
- **Server cursor:** gives accepted events a server-owned incremental download position.

**Idempotency** means repeating the same request has the same intended result as accepting it once. If upload acknowledgement is lost, the client retries the same event UUID. The API recognizes it and returns the existing acceptance rather than creating a second purchase.

A retry is another attempt to deliver the same event; duplication is accidentally storing or applying that event more than once. Idempotency connects them safely. A per-device sequence does not replace the event UUID: it orders one device’s events but is not globally unique. The server cursor does not replace purchase time: it orders server acceptance/download, not real-world occurrence.

# Facts and Derived Projections

An **authoritative fact** is the accepted source statement from which other state can be reproduced. A **derived projection** is a read-oriented view calculated from facts.

For Markei:

```text
purchase events
→ local purchase history
→ duration and consumption calculations
→ expected dates
→ Storage / Shortage / Market projections
```

Synchronizing projections as mutable truth risks disagreement: desktop and mobile could upload different calculated values. Synchronizing purchase facts and rebuilding projections from one specified rule set makes semantic parity testable. A golden fixture can provide events and expected projections to both clients.

A protocol version describes the message rules: required fields, endpoints, cursor behavior, error meanings, and compatibility. A schema version describes a particular stored data shape or event payload shape. They may evolve together, but they are not interchangeable. The API can support more than one protocol version while migrating storage independently.

# Concept Dependency Spine

```text
Stable Identity
→ Authentication
→ Authorization / Row Ownership
→ API boundary and access token
→ Local Persistence
→ Append-Only Event / Offline Queue
→ Event Identity
→ Idempotency
→ Per-Device Ordering
→ Synchronization Cursor
→ Sync Protocol and Versioning
→ Eventual Consistency
→ Authoritative Fact / Derived Projection
→ Conflict Avoidance
→ later Conflict Resolution, only when mutable workflows require it
```

Existing concepts provide prerequisites: Responsibility Boundary, Naming as Data Contract, Raw versus Derived Data, Application Service, Repository Pattern, Resource Ownership, Workflow Atomicity, SQLite ownership, and Evidence State.

# KANBAN Candidates

No concept is promoted in this staging task. Candidates for later evaluation are:

- Authentication
- Authorization
- Stable Identity
- Append-Only Event
- Idempotency
- Event Ordering
- Synchronization Cursor
- Eventual Consistency
- Authoritative Fact
- Derived Projection
- Sync Protocol
- Row Ownership
- Offline Queue
- Schema/Protocol Versioning

Some may merge with existing identities. “Authoritative Fact / Derived Projection” overlaps `&&&02 Raw Data Versus Derived Data`; “Row Ownership” may be a specialized authorization example; transaction behavior overlaps `&%%05`. Later promotion should create only concepts with independent reusable meaning and concrete evidence.

Glossary candidates use the same names but remain derivative candidates until canonical identity exists. No glossary truth is created here.

# Learner Checkpoints

1. Explain why verified email and account UUID serve different purposes.
2. Distinguish authentication from authorization using an attempted cross-account event.
3. Explain why a client receives an access token rather than Neon credentials.
4. Describe what remains possible while completely offline.
5. Distinguish an event UUID from the purchase/product entity UUID.
6. Explain four reasons timestamps cannot provide total synchronization order.
7. Assign one job each to event UUID, device sequence, occurrence time, and server cursor.
8. Show why retrying after a lost acknowledgement must not create a second purchase.
9. Explain eventual consistency without claiming immediate equality.
10. Identify authoritative purchase facts and rebuilt Storage/Shortage/Market projections.
11. Distinguish protocol version from storage schema version.
12. Explain which exclusions avoid conflicts and which future feature would require resolution.

# Misconceptions to Prevent

```text
email address = permanent account identity
authentication = authorization
access token = database password
managed Postgres = synchronization system
API = direct database connection
local persistence = shared state
synchronization = database-file copying
timestamp = unique identity or total order
retry = new event
event identity = entity identity
append-only = no validation
offline-first = never connects
eventual consistency = uncontrolled inconsistency
derived projection = authoritative fact
conflict avoidance = general conflict resolution
protocol version = schema version
planning preference = validated architecture
technical evidence = learner mastery
```

# Handoff to Main

Main can reconcile this dependency model with Operational feasibility and Design ownership. The next planning decision should define the minimum event envelope, account/device identity rules, API-visible idempotency and cursor behavior, deterministic purchase fixtures, local transaction boundary, and explicit exclusions.

The favored shared-beta target is conceptually coherent, but provider selection, Neon schema, API runtime, authentication service, protocol acceptance, framework selection, and implementation remain open. D/E/F should remain postponed until Main converts the reconciled A/B/C plans into one bounded authorization. No KANBAN concept or maturity state changed.
