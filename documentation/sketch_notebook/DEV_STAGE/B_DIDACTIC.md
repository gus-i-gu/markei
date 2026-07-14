<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# Intermid Cycle Recovery — Didactic Ordinary Assessment

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Didactic Chat [A]
> Branch: `intermid-cycle-recovery`
> Main orientation: `[M]_STAGE/J_MAIN_STAGE.md` (IRC-R00, provisional)
> Authority: append Didactic findings to this file only
> Evidence boundary: repository inspection and previously recorded validation; no tests rerun, no learner interview, no maturity promotion

## 1. Bounded objective

Recover the learner-facing knowledge expressed by the current Flutter product implementation, distinguish implemented project knowledge from demonstrated learner maturity, identify permanent Didactic drift, and prepare the next Didactic reconciliation boundary.

## 2. Evidence inspected

- `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`
- `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`
- `documentation/sketch_notebook/didactics/02_KANBAN.md`
- Cycle 08 implementation commit `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`
- `clients/markei_flutter/lib/app/pages/products_page.dart`
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/app/pages/history_page.dart`
- `clients/markei_flutter/lib/application/register_purchase.dart`
- `clients/markei_flutter/lib/application/purchase_history.dart`
- `clients/markei_flutter/lib/domain/catalogue/product.dart`
- `clients/markei_flutter/lib/domain/purchase/purchase.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_purchase_repository.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`

The Cycle 08 commit records six focused widget tests, 31 Flutter tests, clean Flutter analysis, a Windows release build, and five Python regressions. Those commands were not rerun during this assessment.

## 3. Implemented project vocabulary

Current presentation and tests express:

- `Purchase`, `Products`, and `History` as distinct destinations.
- `Product`, mandatory `Product code`, `similar Product`, use-existing, and create-anyway.
- `Choose Store` and `Create Store` as different user actions.
- session `Purchase draft`, staged `Item`, edit/remove, running total, `Review purchase`, and `Register purchase`.
- `Purchase registered locally.`, `Purchase History`, and `Purchase Item`.
- `Price change in your purchases` and explicit unavailable-comparison language.
- local-device storage boundaries without claims of upload, synchronization, backup, authentication, or production readiness.
- separate loading, empty, no-match, failure, retry, in-progress, and success states.

This vocabulary is implemented project knowledge. It does not by itself establish that the learner can define, compare, or transfer the underlying concepts.

## 4. Conceptual distinctions evidenced by implementation

### Product identity, code, and similarity

`ProductId` supplies record identity; Product code participates in account-local identification; normalized fields and exact identity keys support deterministic matching; similarity warnings remain advisory. “Similar” therefore does not mean “identical,” and create-anyway does not authorize automatic merging.

### Store record and Store identity

`ExistingStoreReference(StoreId)` preserves a selected Store record. `NewStoreReference(displayName)` creates a new record. The implementation does not establish normalized branch identity, uniqueness, or merge semantics.

### Draft Item and registered Purchase Item

A staged line is mutable, keyed, session-only presentation state. Registration converts the reviewed draft into persisted Purchase and Purchase Item facts. Editing a draft is not mutation of an already registered Purchase.

### Atomicity and idempotency

`LocalPurchaseRepository.registerPurchase()` uses one local transaction for Store/Product resolution, Purchase, Items, Device sequence, SyncEvent, and PendingEvent. This supports statement/workflow atomicity within the local boundary. The UI in-flight guard does not provide durable registration idempotency, and no durable SubmissionId exists.

### Raw fact and derived price change

Purchase Items and compatible price observations are historical facts. “Price change in your purchases” is a rebuildable comparison derived from the latest two compatible observations. It is not official inflation, forecasting, or a universal market-price claim.

### Local queue and synchronization

SyncEvent/PendingEvent persistence prepares local event delivery. It does not demonstrate upload, download, convergence, authentication, cursor replay, or synchronization.

### State lifetime and evidence boundary

Mounted draft state, persisted local facts, responsive widget state, Windows build evidence, and Android host evidence have different lifetimes and validation boundaries. A passing widget case does not prove process-death recovery, physical-device behavior, accessibility, or full lifecycle acceptance.

## 5. Learner-maturity classification

No explicit learner explanation, comparison, debugging narration, prediction, or transfer exercise was found in the inspected evidence.

Therefore:

- no KANBAN maturity change is supported;
- existing Green/Yellow/Red states must be preserved;
- repository implementation and passing tests count as project evidence only;
- human use of the application, where previously recorded, does not alone demonstrate conceptual mastery;
- Cycle 08 vocabulary may become permanent Didactic material only through later FLX-PRM-04 classification and reconciliation.

## 6. Didactic drift and knowledge gaps

The current `08_CONCEPT_MAP.md` checkpoint retains Cycle 07 foundations and an empty Intermid Recovery segment. It does not yet expose the final Cycle 08 Products/Purchase/History vocabulary or the implemented distinctions above.

Permanent reconciliation should later determine whether existing concepts already own these meanings or require carefully bounded additions. Immediate candidates for reinforcement are:

- `&&&02 Raw Data Versus Derived Data`;
- `&&&03 Naming as Data Contract`;
- `&&&04 Resource Ownership and Lifetime`;
- `&&&05 Evidence State and Validation Boundary`;
- `&%%05 Statement Atomicity Versus Workflow Atomicity`;
- `&&&06 Stable Identity`;
- `&%%07 Reusable Catalogue`;
- `&%%09 Purchase Aggregate`;
- `&%%10 Purchase Item`;
- `&%%11 Append-Only Synchronization Event`;
- `&%%12 Offline Queue and Idempotent Delivery`;
- `&%%17 Versioned Analytic`.

No new canonical concept is selected here. The permanent Didactic owner must check concept identity and duplication before any addition.

## 7. Concepts needed for the next cycle

The next database/UI cycle should require learner-facing treatment of:

1. record identity versus business identity versus similarity;
2. reference objects versus creation drafts;
3. aggregate boundary and transaction atomicity;
4. retry guard versus durable idempotency;
5. mutable draft lifetime versus immutable registered history;
6. schema version, migration, compatibility, and recovery evidence;
7. raw persisted facts versus rebuildable projections;
8. local event queue versus actual synchronization;
9. UI state labels as evidence-bearing contracts;
10. test/build/manual/lifecycle evidence ladders.

A maturity transition should require the learner to explain at least one distinction in their own words and apply it correctly to a concrete Markei path or failure case.

## 8. Classification for Main

- Retained: implementation evidence is not learner maturity.
- Newly confirmed: Cycle 08 product vocabulary and state language exist in current source and focused widget tests.
- Corrected: the Didactic checkpoint statement that no Flutter implementation exists is historical within its earlier segment, not current branch truth.
- Contradicted: no current evidence contradicts the preserved rule against automatic maturity promotion.
- Unresolved: whether existing KANBAN concepts fully own Store identity, durable submission idempotency, and schema-migration teaching needs.
- Prospective: a bounded next-cycle lesson/evidence exercise covering identity, transaction/idempotency, migration, and derived projections.
- Deferred: authentication, real synchronization, backup/restore, production release, and broader analytics teaching until corresponding project boundaries activate.

## 9. Recommendation and stop condition

Main should use this assessment as Didactic input for later reconciliation. A subsequent FLX-PRM-04/PDR-A pass may update permanent Didactic memory, but this Ordinary assessment authorizes no such promotion.

Stop reached: the bounded Didactic investigation and single authorized stage append are complete. No architecture selection, Operational acceptance, source change, methodology change, permanent-memory change, J change, or other domain-stage change is included.
