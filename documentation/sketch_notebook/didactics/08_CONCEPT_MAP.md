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

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.

# Cycle 07 Sprint 03 Unit 01 Didactic Checkpoint

## Current Learning State

The Flutter/Dart foundation is now implemented and unit-tested locally. A fresh Drift database, immutable Dart domain models, account-private catalogue, Purchase aggregate, Purchase Items, local `purchase.registered` event, pending queue row, and minimal versioned analytics registry exist. Nine Flutter tests and five Python regression tests passed.

This evidence is bounded:

```text
local implementation: evidenced
local unit tests: passed
fresh local persistence and close/reopen: evidenced
generated Flutter targets: present
Windows/Android/iOS runtime: host-unvalidated
responsive Flutter workflow: absent
authentication/authorization: absent
server sync/cursor/eventual consistency: absent
legacy migration and schema upgrade: absent
learner mastery: not evidenced
```

## Maturity

No maturity changed. All Cycle 07 concepts remain Red because implementation and passing tests are not explicit learner evidence.

## Evidence-Bearing Concepts

Strong local executable evidence:

```text
&&&06 Stable Identity
&&&10 Historical Integrity
&&%05 Immutable Dart Model
&%%07 Reusable Catalogue
&%%09 Purchase Aggregate
&%%10 Purchase Item
&%%11 Append-Only Synchronization Event — local event only
&%%15 Dimensional Quantity
&%%16 Monetary Minor Unit
&%%17 Versioned Analytic
```

Bounded or provisional evidence:

```text
&%%08 Deterministic Normalization
    basic unit equivalence passes
    Unicode/Portuguese and cross-language parity unresolved

&%%12 Offline Queue and Idempotent Delivery
    queue preparation passes
    server idempotency absent

%%%07 Flutter Framework and Responsive Widget Composition
    framework/test setup evidenced
    responsive composition and platform runtime absent
```

Unimplemented or defective:

```text
&&&07 Authentication
&&&08 Authorization
&&&09 Eventual Consistency
&%%13 Device Ordering and Synchronization Cursor
&%%14 Sync Protocol
```

Device ordering has a likely sequence-reset defect. Current JSON files are versioned semantic fixtures or contract examples, not a complete protocol specification.

## Updated Dependency/Evidence Spine

```text
immutable Dart models
→ local catalogue identity
→ Purchase aggregate validation
→ atomic Drift transaction
→ local immutable event
→ pending queue preparation
→ close/reopen persistence
→ local projection/analytics registry
→ platform workflow evidence — pending
→ API/idempotency/cursor evidence — pending
→ cross-device convergence — pending
```

## Distinctions to Preserve

- Local implementation is not platform validation.
- Generated target files are not responsive application evidence.
- Offline queue preparation is not synchronization.
- Fixture examples are not a complete protocol.
- Local event identity is not proven server idempotency.
- Occurrence time is not device order or server cursor.
- Passing tests are not learner mastery.
- Fresh schema creation is not migration validation.
- Handwritten domain design differs from generated Drift/platform code.

## Next Learner Questions

1. Which Sprint 03 claims are implemented, validated locally, host-unvalidated, or absent?
2. Why does a persisted pending event not prove synchronization?
3. What would make the JSON examples a complete language-neutral protocol contract?
4. Why can a generated Flutter target exist without platform validation?
5. How should handwritten schema definitions and generated Drift code be reviewed differently?
6. Why might `\w`-style normalization damage Portuguese names?
7. What must a normalization-version migration preserve?
8. How should repeated registrations prove device sequences 1, 2, 3?
9. Why are authentication, authorization, and eventual consistency still conceptually Red/unimplemented?
10. Which evidence would support an actual maturity transition?

## Next Learning Boundary

Main currently favors the local shared-client route first: correct sequence and normalization defects, strengthen fixtures, add a minimal Flutter Purchase workflow and visible projection, then obtain Windows/Android runtime evidence. The local protocol harness remains a later route. This is Main orientation, not Didactic architecture selection or Sprint 04 authorization.

