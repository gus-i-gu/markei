# 14_MODEL_OVERVIEW.md

> Version: 0.5-cycle07-sprint03-unit01
> Status: Active Derived Overview
> Persistence Class: Derived
> Knowledge Class: Design
> Authority: Design Chat [D]
> Canonical Source: `design/01_ARCHITECTURE.md`
> Scope: Compact responsibility and evidence map after the local Flutter foundation

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above preserves earlier planning; this segment is the rebuildable current Design map after Sprint 05.

# 1. Current System Map

```text
Protected Python/PySide6 beta
    separate Cycle 06 SQLite; behavior reference and rollback

Windows / Android Flutter hosts
    → shared Flutter entrypoint and composition
    → presentation
    → application commands/query ports
    → independent Dart domain
    → local repository adapters
    → Drift schema v2
    → application-private SQLite

Deferred distributed path
    Flutter sync coordinator
    → authenticated TypeScript API
    → Neon Postgres
```

Android/Kotlin hosts Flutter only; it owns no business or persistence semantics.

# 2. Identity Ownership

| Identity | Owner and current state |
| --- | --- |
| Android application ID | `com.gusigu.markei`; installation/update/sandbox identity |
| Android label | `Markei`; presentation metadata |
| Account | `local-account`; provisional prototype placeholder |
| Device | database-owned UUID v4; created before composition completes |
| Device sequence | `devices.next_sequence`; allocated inside Purchase transaction |
| Product | immutable internal ID + user Product code + normalized identity facts |
| Purchase / Item | immutable local aggregate identities and facts |
| Event | UUID plus Account/Device/sequence envelope |
| central/cloud identity | deferred |

# 3. Device Bootstrap

```text
main() awaits MarkeiComposition.appPrivate()
→ open LocalDatabase.appPrivate()
→ LocalDeviceIdentityRepository.loadOrCreateDeviceId(local-account)
→ insert Account if absent
→ find reusable UUID v4 Device or create one
→ inject DeviceId into shared composition
→ event-producing commands become available
```

Tests establish creation, close/reopen reuse, distinct fresh-database IDs, sequence 1→2 continuity, and historical non-UUID preservation.

# 4. Prototype Debt

Current selection scans the first 20 Account Devices by creation time and chooses the earliest UUID v4.

```text
acceptable now
    bounded single-installation prototype

not acceptable for synchronization
    no explicit current-installation relation
    first-20 truncation
    ambiguous multiple-UUID selection
    no dedicated concurrent-bootstrap uniqueness
```

Future requirement: one installation metadata record references exactly one Device, bootstrap is idempotent under concurrency, and historical Devices remain separate.

# 5. Persistence and Schema

Schema v2 already owns Account, Device, sequence, Product, Store, Purchase/Items, Event, pending queue, sync metadata, and migration ledger. Sprint 05 changed bootstrap behavior, not persisted shape, so no schema migration was required.

Historical non-UUID Device rows remain untouched. Android runtime observed the SQLite database inside `com.gusigu.markei` application-private storage. Local queue/event preparation remains distinct from synchronization.

# 6. Purchase Transaction

```text
resolve/create Store and Product references
→ validate Purchase and Items
→ persist aggregate
→ allocate sequence for injected Device
→ persist purchase.registered event
→ enqueue pending event
→ commit once
```

# 7. Functional Scaffold

```text
Purchase / History navigation
+ SafeArea
+ scrollable phone-width form
+ staged BRL total
+ atomic registration
+ visible History
```

These are implemented functional-scaffold decisions, not final UI/UX. SafeArea owns inset avoidance; staged total exposes aggregate feedback. Broad visual hierarchy, accessibility, navigation refinement, and design-system work remain later.

# 8. Evidence Boundary

**Validated:** 27 Flutter tests, analysis, debug APK, identity badging, API 36 emulator boot/install/launch, Android sandbox database observation, Device bootstrap/sequence tests, human Purchase registration, Windows build, and five Python tests.

**Partial:** Android lifecycle/ergonomics, keyboard, Back, rotation, background/resume, larger text, and accessibility.

**Deferred:** physical device, release signing/store, backup policy, authentication, API/Neon, synchronization, central catalogue, import, broad UI/UX, iOS, and PySide6 retirement.

# 9. Configuration Boundary

```text
architectural
    stable application/sandbox identity
    shared dependency direction
    database-owned Device and sequence ownership
    app-private persistence

operational configuration
    compile/target SDK 36
    NDK, Java, Gradle
    Android Studio, emulator, SDK tools
```

# 10. Next Design Route

```text
optional bounded Android lifecycle/ergonomics supplement
→ Main closes Sprint 05 evidence
→ choose later UI/UX formalization or another accepted milestone
→ resolve explicit installation-Device invariant before real synchronization
```

# 11. Recovery Pointers

- Canonical: `design/01_ARCHITECTURE.md`, sections 16–19.
- Observational: `design/03_DECISION_LOG.md`, Event 17.
- Checkpoint: `design/09_DESIGN_STATE.md`.
- Evidence: `DEV_STAGE/I_DSN_CODEX.md`.
- Main reconciliation: `[M]_STAGE/J_[M]_STAGE.md`, §24.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here. Content above is historical; this regenerated segment is the current Cycle 09 map.

# Cycle 09 Sprint 02 Model Overview

## Current topology

```text
adaptive Flutter presentation
→ application ports/read models/results/calculations
→ Dart domain identity and quantity semantics
← local Drift/platform adapters
→ handwritten schema v4 / app-private SQLite
```

Generated Drift is derived evidence. Python/PySide6 and its database remain protected.

## Stable implemented model

| Concern | Current model |
| --- | --- |
| Person | opaque UUID + immutable Account-scoped `@nnn` code + nickname + archive state |
| Payment Method | opaque UUID + immutable Account-scoped `#nnn` code + nickname + archive state |
| Product | opaque UUID + mandatory immutable Account-scoped visible code + versioned exact identity |
| Purchase occurrence | editable local civil input converted to one persisted UTC instant |
| BULK | amount × price per same selected unit → half-up minor-unit line total |
| Lists | Product-first, rebuildable projection; no List aggregate/cache |
| Details | ProductId-bound application read model; shared adaptive surface incomplete |
| Exports | stable DTOs and deterministic CSV/PDF bytes; no Purchase mutation |

AccountPreferences owns next visible-reference counters. Optional Purchase references remain restrictive and archive-resolvable. Product code, Product UUID, exact identity, similarity and idempotency stay separate.

## Presentation state

Implemented narrowly:

- Home/Lists/Purchase/History/More compact navigation;
- Purchase exact-code resolution/autofill, manual occurrence and BULK calculator;
- Catalogue tap selection and explicit/double-click detail focus;
- History checkbox/tap selection, select-all and detail focus.

Partial/open:

- theme is only a small Material foundation;
- MarkeiCard/StatePanel/StatusChip exist but pages do not consume them;
- Home and Lists were not materially rebuilt;
- Lists lacks relational table/card/filter hierarchy;
- Catalogue and History remain standard list compositions;
- Purchase remains a ~1,020-line long form; Catalogue ~377 and History ~330;
- History double-click focuses detail, contradicting selection-toggle intent;
- target images 01–05 are not visually materialized;
- native sharing and complete responsive/accessibility validation are absent.

## Ownership

```text
presentation
    navigation, drafts, transient selection/detail/filter state

application
    exact lookup, occurrence parsing, BULK calculation,
    projections, export/read DTOs, typed results

domain
    Product identity, reference values, quantity/unit invariants

repository / handwritten Drift
    schema v4, migration/backfill/counters, FKs,
    Account scoping, joins, transactions
```

## Evidence and next route

Source range: `5ddff3c5eae582f0e25c1ecd0cfb3fe962026cf3..1d817972aea0229c9f109f236f4d224671927aab`. J accepts the functional/schema increment and rejects visual closure. Android, native share, Windows workflow acceptance, accessibility, screenshot parity and release readiness remain unvalidated.

Next proposed Design unit, inactive until Main authorization: expand shared tokens/primitives; consume them across pages; recompose Home, relational Lists and Catalogue; split/recompose Purchase; recompose History and resolve double-click; then validate expanded/compact screenshots, Windows workflow and accessibility.

Recovery: Architecture §21; Decision Log Event 21; checkpoint `09_DESIGN_STATE.md`; C/F/I and post-Codex J.

---

<!-- TEMPORAL_MARKER:C10-RECOVERED-PROMOTION-2026-07-15 -->
# Cycle 10 Synchronization and Hosted-Identity Model

```text
external issuer + subject
→ ExternalIdentity
→ AccountMembership(status, role)
→ Account

InstallationId + enrollment request identity
→ DeviceEnrollment(state, generation)
→ server DeviceId
→ Account-scoped synchronization authority
```

An external subject authenticates; it is not an Account or Device. Membership authorizes Account participation. InstallationId is client-held installation identity; DeviceId is server synchronization identity. Idempotent enrollment binds them without deriving Device identity from hardware, token subject or application ID. Revocation withdraws future hosted authority without erasing local facts.

| Owner | Responsibility |
| --- | --- |
| Flutter application | neutral authentication/enrollment ports and synchronization orchestration |
| Drift v7 | InstallationId, enrollment request/result and hosted-state continuity |
| HTTP/Auth adapters | token acquisition and typed transport; no embedded secret |
| Fastify | principal verification, membership/Device authorization and protocol routing |
| PostgreSQL | external identity, membership, enrollment, Account scope, audit and constraints |
| Direct migrator | forward-only schema and fixture provisioning |
| Pooled-intended runtime | least-privilege application transactions |
| Auth0/Render/Neon | provisional infrastructure; acceptance pending |

Current gap: membership, enrollment and Device state were not proved to be rechecked and locked inside the same transaction as every protected operation. The model is materialized locally but is not hosted-ready.

```text
MCG-01: sanitized development capability
MCG-02: provider-dashboard preparation partial
C10-S03A_CONTRADICTED_STOP
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```

Provider token shapes, tenant/application identifiers, callbacks, URLs, credentials and secrets remain outside the domain model and permanent memory.
