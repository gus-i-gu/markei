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

> Temporal boundary retained; this rebuildable current model supersedes the
> earlier C11-PH05 Analytics-defect segment while preserving PH05 architecture.

# Current Model Overview — C11 Analytics Correction

> Branch: `grm-guarded-provisioning-20260727`
> Implementation: `17fd65296e960112787b870363b40339f535f5b6`
> Implementation parent / rollback: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`
> Correction authority: `0e647e76aa8275bda48cea1e9d08427e3d949134`
> Evidence: complete `DEV_STAGE/I_DSN_CODEX.md`
> Main reconciliation: `[M]_STAGE/J_MAIN_STAGE.md` section 16
> Canonical owner: `design/01_ARCHITECTURE.md` §28

## 1. Current Analytics topology

~~~text
AnalyticsPage / Analytics components
→ one AnalyticsWorkspaceController
├─ one Account-local dataset load; Retry +1 read
├─ one AnalyticsComposerDraft.variables selection
├─ derived breakdown and measure compatibility views
├─ grouping + fixed-point calculation
└─ immutable session-only AnalyticsRecord
   ├─ Chart capability
   ├─ Table evidence
   ├─ interpretation
   └─ pure CSV/PDF builders
~~~

Composition, repository ownership and export destination effects remain as
accepted in PH05. No second controller, repository, persistence owner or
calculation engine was introduced.

## 2. Draft-to-record ownership

The typed Variables set is the only mutable variable selection. Categorical
breakdowns and numeric measures are derived from it. Validation blocks
categorical-only and unsupported operation-variable combinations without
inserting a substitute Quantity measure.

`Run & save` freezes determinant, variables, operation, timeframe, evidence
scope, selected labels and grouped entries into a new immutable record. Later
draft changes and record selection do not mutate or reuse existing records.
Grouping and calculation remain on the workspace path.

## 3. Value, calendar and identity boundaries

Fixed-point integer aggregation is unchanged. Pure
`analyticsDisplayValue` conversion formats ordinary presentation and export;
compatibility keys stay internal.

Custom Initial and Final dates are inclusive local calendar dates. Local start
and local day-after-final convert to the existing UTC half-open interval.

Stable Purchase, Product and Purchase Item IDs remain internal for selection,
History handoff, paging, fingerprints and reconstruction. Ordinary Variables
labels and exports hide UUIDs. Pure CSV/PDF builders and the shared destination
boundary are unchanged.

## 4. Result capability and defect classification

Incompatible numeric axes retain Table/CSV/PDF evidence and return typed Chart
unavailability.

The former raw fixed-point/internal-key presentation defect is corrected and
automated-validated. Calculation-selection integrity now has end-to-end
automated regression evidence. Silent default-Quantity insertion and a second
workspace calculation path are not evidenced. Human screenshot acceptance
remains unperformed.

## 5. Preserved architecture and evidence ceiling

Analytics effects remain initial read 1, Retry +1, other local transitions +0,
writes 0 and network 0. Schema, migrations, generated source, dependencies,
native platform files, export destination ownership, Auth/API/Sync/provider
contracts, PH05 Guide/Audit/Settings architecture and C12-PHASE02 boundaries are
unchanged.

Rollback to `2cdb8a66...` restores the prior correction state without data or
contract conversion. Wide/compact screenshot fidelity, keyboard-only use,
assistive technology, locale, Windows launch, Android real-device behavior,
learner comprehension and live provider/Sync operation remain host- or
human-unvalidated.

## 6. Recovery and next route

Use Architecture §28 for stable rules, Decision Log Event 28 for chronology and
alternatives, and `09_DESIGN_STATE.md` for the compact checkpoint. Main must
verify all three correction-domain reconciliations, retain unrelated PH05
qualifications, and complete final C11 permanent absorption and 00/05/06 refresh.
