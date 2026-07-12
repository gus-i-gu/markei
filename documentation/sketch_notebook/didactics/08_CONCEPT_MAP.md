# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Cycle 07 Sprint 02 Flutter canonical checkpoint
> Authority: Didactic Chat [A]
> Canon source: `02_KANBAN.md`
> Derivative source: `07_GLOSSARY.md`
> Evidence sources: `[M]_STAGE/J_[M]_STAGE.md` sections 17–18, `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`, and `13_LECTURE_REGISTER.md`
> Current milestone: Flutter/Dart shared-client model and synchronized-beta concept preparation

---

## Current Learning State

Flutter/Dart is the accepted planning basis for one maintained Windows, Android, and iOS client. TypeScript remains favored for the custom synchronization API, Neon for managed shared persistence, and Python/PySide6 as the protected beta reference and rollback.

The reusable catalogue, Purchase aggregate, dimensional quantity/money, append-only synchronization, and versioned analytics models are defined for planning. No Flutter code, API, schema, provider, infrastructure, or D/E/F materialization has been authorized or validated.

Concept introduction during model design is authorized because the concepts have reusable meaning and concrete Markei manifestations. Introduction is not learner mastery.

## Maturity

### Green

None.

### Yellow

`&&&01`, `&&&02`, `&&&03`, `&&%01`, `&&%02`, `&%%01`, `&%%02`, `&%%03`, `&%%04`, `%%%01`, `%%%03`, `%%%04`, `%%%05`.

### Red — existing

`&&&04`, `&&&05`, `&&%03`, `&&%04`, `&%%05`, `&%%06`, `%%%02`, `%%%06`.

### Red — introduced in Cycle 07 Sprint 02

```text
&&&06 Stable Identity
&&&07 Authentication
&&&08 Authorization
&&&09 Eventual Consistency
&&&10 Historical Integrity
&&%05 Immutable Dart Model
&%%07 Reusable Catalogue
&%%08 Product Identification Set and Deterministic Normalization
&%%09 Purchase Aggregate
&%%10 Purchase Item
&%%11 Append-Only Synchronization Event
&%%12 Offline Queue and Idempotent Delivery
&%%13 Device Ordering and Synchronization Cursor
&%%14 Sync Protocol
&%%15 Dimensional Quantity
&%%16 Monetary Minor Unit
&%%17 Versioned Analytic
%%%07 Flutter Framework and Responsive Widget Composition
```

No pre-existing maturity changed. All introduced concepts begin Red because no explicit learner validation exists.

## Dependency Spine

Identity and access:

```text
&&&01 Responsibility Boundary
→ &&&06 Stable Identity
→ &&&07 Authentication
→ &&&08 Authorization
```

Catalogue and purchase:

```text
&&%05 Immutable Dart Model
→ &%%07 Reusable Catalogue
→ &%%08 Product Identification Set and Deterministic Normalization
→ &%%09 Purchase Aggregate
→ &%%10 Purchase Item
→ &%%05 Statement Atomicity Versus Workflow Atomicity
→ &&&10 Historical Integrity
```

Synchronization:

```text
&%%09 Purchase Aggregate
→ &%%11 Append-Only Synchronization Event
→ &%%12 Offline Queue and Idempotent Delivery
→ &%%13 Device Ordering and Synchronization Cursor
→ &%%14 Sync Protocol
→ &&&09 Eventual Consistency
```

Types and analytics:

```text
&&&03 Naming as Data Contract
→ &%%15 Dimensional Quantity
→ &%%16 Monetary Minor Unit
→ &&&02 Raw Data Versus Derived Data
→ &%%17 Versioned Analytic
```

Presentation support:

```text
&&%05 Immutable Dart Model
→ %%%07 Flutter Framework and Responsive Widget Composition
→ &%%03 Presentation Adapter
→ &&&04 Resource Ownership and Lifetime
```

## Reconciled Ownership

- Authoritative facts and derived projections extend `&&&02`.
- Purchase atomicity extends `&%%05`.
- Row ownership is an `&&&08 Authorization` example.
- Composition root and lifecycle remain related to `&&&01`, `&&&04`, and `&&%03`.
- Protocol versioning belongs to `&%%14`.
- Storage-schema versioning remains related to `%%%01`.
- `&%%11` append-only event semantics are distinct from `&&%05` Dart immutability.
- Dart is the language; Flutter is the framework.

## Current Project Learning Spine

```text
protected PySide6 beta
→ language-neutral contracts and fixtures
→ immutable Dart models
→ Flutter shared-client composition
→ account-private reusable catalogue
→ atomic Purchase with Purchase Items
→ application-private local persistence
→ append-only pending event
→ authenticated/authorized custom API
→ idempotent event acceptance
→ account cursor download
→ local deterministic projection rebuild
→ versioned analytics
→ parity and migration evidence
```

## Next Learner Questions

1. How do Dart language responsibilities differ from Flutter framework responsibilities?
2. Which state belongs in immutable models, local persistence, use cases, and widgets?
3. Why is email not a stable ownership identity?
4. How does authorization differ from successful authentication?
5. Which exact facts identify PACKAGED and BULK Products?
6. Why can normalization merge 350 g with 0.350 kg while fuzzy similarity cannot?
7. Which invariants belong to the Purchase aggregate?
8. Why must Purchase, Items, and pending event commit atomically?
9. How do event UUID, device sequence, occurrence time, and cursor differ?
10. How does idempotent delivery protect a retry?
11. Why can clients differ temporarily under eventual consistency?
12. How do dimensional quantity and minor-unit money prevent ambiguous facts?
13. Which facts are authoritative and which projections are rebuildable?
14. Why does analytic version 2 not rewrite version 1 or raw purchases?
15. How can Dart and TypeScript share behavior without sharing source?
16. What evidence would justify maturity movement for any new concept?

## Immediate Learning Boundary

The next Didactic evaluation requires explicit learner explanations or implementation-linked evidence. Architecture discussion and canonical introduction do not change maturity. D/E/F remain postponed.
