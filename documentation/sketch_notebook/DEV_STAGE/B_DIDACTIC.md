# Main Synthesis Summary

Flutter/Dart is now accepted as the planning basis for one maintained Windows, Android, and iOS Markei client. TypeScript remains favored for the custom synchronization API, Neon for managed shared persistence, and Python/PySide6 as the protected beta reference and rollback. This is a model-design decision, not implementation evidence.

The Didactic consequence is substantial enough for canonical concept introduction: stable identity, account-private catalogue structure, purchase aggregation, explicit quantity/money representation, synchronization, and versioned analytics now have reusable definitions and concrete Markei manifestations. Human clarification permits introduction during design when a concept has genuinely been approached. It does not permit maturity inflation: every proposed entry begins Red.

Existing ceilings are `&&&05`, `&&%04`, `&%%06`, and `%%%06`. Proposed IDs therefore begin at 06, 05, 07, and 07 respectively. Final promotion remains for the permanent-documentation pass after Main reconciliation.

# Dart and Flutter Learning Boundary

Dart is the programming language: it supplies types, classes, records, functions, asynchronous operations, immutability conventions, and compilation. Flutter is the UI/application framework: it supplies widgets, rendering, navigation, responsive layout, platform lifecycle integration, plugins, and build targets.

An immutable Dart model represents state through final fields and replacement objects rather than uncontrolled in-place change. This suits event payloads and catalogue identities: accepted identity facts should not silently mutate. A Flutter widget describes presentation. Responsive composition chooses arrangements according to available space and interaction context; it does not change business facts.

Shared source means the same Dart implementation executes across targets. Shared behavior means two implementations—Dart client, TypeScript API, or preserved Python reference—obey the same language-neutral contract and fixtures. Markei uses shared Dart source inside the client, while Dart/TypeScript/Python continuity depends on shared behavior.

The composition root is the startup boundary that creates the database, repositories, use cases, sync client, analytics registry, and lifecycle owner, then connects them. Application lifecycle covers start, foreground/background transitions, suspension, termination, and relaunch. Flutter coordinates these events, but local transactions and durable queues—not widget memory—protect facts.

# Catalogue and Purchase Model

The reusable catalogue is private to one account. It remembers household product identities that can be referenced repeatedly without becoming a global product database.

A packaged Product identity combines normalized name, brand, `PACKAGED` mode, package amount, dimension, and unit. A bulk Product uses name, brand, and `BULK` mode; package amount is omitted. Deterministic normalization converts mechanically equivalent input to one canonical form: for example, `350 g` and `0.350 kg`. Fuzzy similarity may warn, but cannot merge automatically.

A Purchase is an aggregate: one consistency boundary containing receipt-level identity, store, occurrence time, currency, one or more Purchase Items, and its pending synchronization event. A Purchase Item is one commercial observation referencing a catalogue Product and recording quantity, line total, package count, promotion, and other item facts.

Atomicity extends existing `&%%05`: Purchase, Items, and pending event either commit together or not at all. The first UI may guide one item at a time, but the model must not make “one purchase equals one item” permanent.

Historical integrity means later catalogue or analytic changes do not rewrite accepted purchase meaning. In the first beta, identity-changing brand, name, or package changes produce a new Product ID.

# Dimensional Quantity and Money

A dimensional quantity combines numeric magnitude with measurement kind and unit. Markei stores MASS/KG, VOLUME/L, or COUNT/UNIT explicitly. It never assumes volume equals mass. Product package amount and Purchase Item purchased amount remain distinct: two 0.350 KG packages mean package count 2 and purchased amount 0.700 KG.

Money uses an explicit currency code and integer minor units: BRL 8.79 becomes `BRL` plus `879`. Integer minor units avoid binary floating-point ambiguity for ordinary currency arithmetic. Account currency may provide a UI default, but each Purchase retains historical currency evidence.

# Synchronization Concepts

Authentication proves control of an account; authorization decides what the authenticated account may access. Row ownership remains an authorization example, not an independent concept. Stable UUIDs identify account, device, Product, Purchase, Item, and event independently of mutable labels such as email.

An append-only event records an accepted fact without overwriting it. The offline queue durably holds unsent events. Idempotency makes retry safe: identical event UUID and content returns prior acceptance; reused UUID with changed content is rejected.

Device sequence orders creation on one installation. Client occurrence timestamp records business time. An opaque account-scoped server cursor orders accepted events for incremental download. Eventual consistency means temporarily different clients converge after receiving and deterministically applying the same accepted history.

The Sync Protocol is language-neutral: JSON shapes, stable errors, validation, idempotency, sequence gaps, cursor paging, authorization, and protocol versions must mean the same to Dart and TypeScript. It is not a shared language or direct database connection.

# Versioned Analytics

Authoritative purchase facts remain the source evidence. Storage, Shortage, Market, normalized price, price change, personalized inflation/deflation, store comparison, and forecasts are derived projections.

A versioned analytic has a stable identifier and immutable rule version. A better formula creates a new version rather than silently changing old meaning. Cached results record the version when reproducibility requires it. Raw purchases are never rewritten by analytical evolution.

# Dependency Spine

```text
&&&01 Responsibility Boundary
→ Stable Identity
→ Authentication
→ Authorization
→ Reusable Catalogue
→ Product Identification Set / Deterministic Normalization
→ Purchase Aggregate / Purchase Item
→ &%%05 Workflow Atomicity
→ Historical Integrity
→ Append-Only Event
→ Offline Queue / Idempotency
→ Device Ordering / Synchronization Cursor
→ Sync Protocol
→ Eventual Consistency
→ &&&02 Raw versus Derived Data
→ Versioned Analytic
```

Supporting type spine:

```text
Dart immutable model
→ Flutter responsive widget composition
→ composition root and lifecycle ownership
→ dimensional quantity
→ monetary minor unit
```

# Canonical Promotion Recommendations

Every entry below has initial maturity **Red** and source **Cycle 07 Sprint 02 J sections 15–17 plus Flutter A/B/C restaging**.

## Foundational proposals

**`&&&06 Stable Identity`.** Description: identity survives mutable labels. Formal: durable UUID-based reference to one logical object. Example: account number persists after contact change. Dart/Flutter: immutable UUID value object. Markei: account/device/Product/Purchase/Item/event IDs. Prerequisites: `&&&01`, `&&&03`. Related: normalization, synchronization.

**`&&&07 Authentication`.** Description: proving who controls an account. Formal: verification of credentials yielding an authenticated principal. Example: verified sign-in produces a session. Dart/Flutter: secure token acquisition/storage. Markei: verified email resolves account UUID. Prerequisites: `&&&06`. Related: Authorization, Sync Protocol.

**`&&&08 Authorization`.** Description: limiting an authenticated principal’s actions. Formal: policy decision over principal, resource, and operation. Example: one account cannot read another’s rows. Dart/Flutter: token sent to API; client does not self-authorize. Markei: account-scoped events; row ownership example. Prerequisites: `&&&07`. Related: API boundary.

**`&&&09 Eventual Consistency`.** Description: replicas may differ temporarily but converge. Formal: identical accepted history and deterministic application eventually produce equivalent state. Example: offline device catches up later. Dart/Flutter: reconnect synchronization. Markei: two clients rebuild the same projections. Prerequisites: Sync Protocol, cursor. Related: idempotency.

**`&&&10 Historical Integrity`.** Description: later change must not rewrite earlier meaning. Formal: accepted historical facts retain their original identity and interpretation inputs. Example: package change creates a new identity. Dart/Flutter: immutable event/model history. Markei: old Purchase Items retain Product IDs and commercial facts. Prerequisites: `&&&02`, `&&&06`. Related: Versioned Analytic.

## Language/framework proposals

**`&&%05 Immutable Dart Model`.** Description: structured Dart data changed by replacement. Formal: typed object whose identity-bearing fields cannot mutate after construction. Example: create a revised value instead of editing the original. Dart/Flutter: `final` fields and immutable constructors. Markei: event envelopes and catalogue identities. Prerequisites: `&&%02`. Related: Historical Integrity.

**`%%%07 Flutter Framework and Responsive Widget Composition`.** Description: Flutter renders one client across platform layouts. Formal: framework-managed widget tree composed responsively from application state. Example: navigation rail on desktop, compact navigation on phone. Dart/Flutter: widgets, constraints, lifecycle hooks. Markei: shared Register/history/projection UI. Prerequisites: `&&%05`, `&%%03`. Related: composition root.

## Target/model proposals

**`&%%07 Reusable Catalogue`.** Description: account-private reusable identities separate from purchases. Formal: owner-scoped reference set for recurring domain objects. Example: repeated receipts reference one product. Dart/Flutter: catalogue repository/use case. Markei: private Products and Stores. Prerequisites: `&&&06`, `&%%02`. Related: Purchase Item.

**`&%%08 Product Identification Set and Deterministic Normalization`.** Description: exact canonical facts determine Product identity. Formal: deterministic mapping from normalized identity tuple to stable account-scoped ID. Example: 350 g equals 0.350 kg. Dart/Flutter: pure normalization/value objects. Markei: packaged versus BULK identity; fuzzy matches only warn. Prerequisites: `&%%07`. Related: Dimensional Quantity.

**`&%%09 Purchase Aggregate`.** Description: Purchase owns one atomic registration boundary. Formal: aggregate root enforcing consistency across header, Items, and pending event. Example: invalid line rejects the aggregate. Dart/Flutter: Purchase command and transaction use case. Markei: multi-item-capable receipt. Prerequisites: `&%%01`, `&%%05`. Related: Purchase Item.

**`&%%10 Purchase Item`.** Description: one Product observation inside a Purchase. Formal: aggregate member carrying product reference and commercial facts. Example: one receipt line. Dart/Flutter: immutable item model. Markei: quantity, line total, package count, promotion. Prerequisites: `&%%09`, `&%%08`. Related: projections.

**`&%%11 Append-Only Synchronization Event`.** Description: accepted facts are appended, not overwritten. Formal: immutable identified protocol fact applied deterministically. Example: `purchase.registered`. Dart/Flutter: event model encoded to JSON. Markei: atomic Purchase with Item lines. Prerequisites: `&&&06`, `&%%09`. Related: idempotency.

**`&%%12 Offline Queue and Idempotent Delivery`.** Description: durable pending work can be retried without duplicate effect. Formal: queue plus uniqueness rule making repeated logical submission equivalent to one acceptance. Example: lost acknowledgement triggers safe retry. Dart/Flutter: local pending-event table. Markei: UUID/content equality policy. Prerequisites: `&%%11`, `&%%05`. Related: cursor.

**`&%%13 Device Ordering and Synchronization Cursor`.** Description: creation order and download order have different owners. Formal: device-monotonic sequence plus opaque server acceptance position. Example: missing device sequence is requested; cursor pages unseen events. Dart/Flutter: persisted sequence/cursor. Markei: account-scoped incremental sync. Prerequisites: `&%%12`. Related: occurrence timestamp.

**`&%%14 Sync Protocol`.** Description: stable cross-runtime rules for exchange. Formal: versioned contract governing payloads, validation, authorization, retry, ordering, errors, and compatibility. Example: Dart client and TypeScript API interpret one event identically. Dart/Flutter: typed DTOs plus runtime validation at boundaries. Markei: custom API/Neon boundary. Prerequisites: `&&&08`, `&%%13`. Related: schema version.

**`&%%15 Dimensional Quantity`.** Description: magnitude is inseparable from dimension/unit. Formal: fixed-precision amount qualified by measurement kind and canonical unit. Example: 1 L is not 1 KG. Dart/Flutter: sealed enum/value object. Markei: MASS/KG, VOLUME/L, COUNT/UNIT. Prerequisites: `&&&03`. Related: normalization.

**`&%%16 Monetary Minor Unit`.** Description: money is currency plus integer smallest-unit amount. Formal: ISO-like currency code paired with integer minor units. Example: BRL 8.79 → 879. Dart/Flutter: immutable Money value. Markei: Purchase currency and line totals. Prerequisites: `&&&03`. Related: analytics.

**`&%%17 Versioned Analytic`.** Description: derived algorithms evolve without rewriting facts. Formal: analytic identified by stable name/version whose released meaning is immutable. Example: improved inflation formula gets v2. Dart/Flutter: Dart analytics registry and fixtures. Markei: rebuildable price/consumption projections. Prerequisites: `&&&02`, `&&&10`. Related: semantic parity.

# Concepts Reconciled With Existing Canon

Authoritative Fact and Derived Projection extend `&&&02`; no duplicate entry is recommended. Purchase atomicity extends `&%%05`. Row Ownership remains an Authorization example. Composition root and application lifecycle extend `&&&01`, `&&&04`, and `&&%03` until repeated implementation evidence justifies separate entries. Product Identification Set owns deterministic normalization. Append-only event remains distinct from immutable Dart syntax. Protocol versioning belongs to Sync Protocol; storage schema versioning remains related to `%%%01`.

# Learner Checkpoints

1. Distinguish Dart from Flutter and shared source from shared behavior.
2. Explain why widgets do not own durable facts or transactions.
3. Derive packaged and BULK identities; explain why fuzzy similarity cannot merge.
4. Distinguish Purchase aggregate from Purchase Item.
5. Show why Purchase, Items, and pending event commit together.
6. Represent 350 g, 1 L, five units, and BRL 8.79 without ambiguity.
7. Distinguish authentication, authorization, and stable identity.
8. Assign roles to event UUID, device sequence, occurrence time, and server cursor.
9. Explain idempotency and eventual convergence after offline work.
10. Separate purchase facts from Storage/Shortage/Market and inflation projections.
11. Explain how Dart and TypeScript share a protocol without sharing source.
12. Explain why analytic v2 must not change v1 history.

# Maturity Guard

All proposed concepts are Red. Human design discussion demonstrates approach, not mastery. No existing Green/Yellow/Red status changes. Promotion creates stable learning objects; maturity changes only after explicit learner evidence.

# Permanent-Documentation Update Plan

After Main acceptance, Didactic may add the recommended entries to `02_KANBAN.md` in sequence, derive only matching terminology into `07_GLOSSARY.md`, refresh `08_CONCEPT_MAP.md` with the new dependency spine, and append the design-stage promotion event to `13_LECTURE_REGISTER.md`. The permanent pass should recheck IDs immediately before writing and may split entries if Main identifies duplicate ownership.

# Handoff to Main

Accept the proposed canonical set as the minimum model-design learning vocabulary, or return specific merge/split corrections before permanent promotion. Keep Flutter/Dart as planning basis, TypeScript API contracts language-neutral, PySide6 recoverable, and all implementation/D/E/F inactive. No maturity change is recommended.
