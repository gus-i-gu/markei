# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Recovery checkpoint
> Authority: Didactic Chat [A]
> Canon source: `02_KANBAN.md`
> Derivative source: `07_GLOSSARY.md`
> Retrospective source: `DEV_STAGE/B_DIDACTIC.md`
> Current milestone: Didactic domain repopulation after failed Cycle 05 transition

---

## Current Milestone

The Didactic domain has recovered its first complete memory sequence:

```text
02_KANBAN canonical register
↓
07_GLOSSARY derivative retrieval surface
↓
08_CONCEPT_MAP recovery checkpoint
```

The contemporary project remains a layered local desktop application:

```text
PySide6 desktop presentation
→ ProductService application facade
→ Repository persistence facade
→ database lifecycle manager
→ SQLite
```

This checkpoint also preserves the most important historical discontinuity:

```text
closed Cycle 04 desktop baseline
↓
Cycle 05 mobile-preparation plan
↓
mobile exit conditions not reached
↓
cycle 5.0 outburst pivot
↓
partially completed Windows packaging sprint
↓
current recovery cycle
```

The mobile-preparation direction was historically useful but incomplete. It did not establish an accepted mobile product, persistence/synchronization model, backend, identity boundary, framework, migration plan, or implementation authorization.

The packaging pivot produced a validated PyInstaller one-folder runtime and external per-user SQLite state, but not a fully validated installed lifecycle.

---

## Stable Concepts

No canonical concept is currently confirmed Green through explicit human learning validation.

Repository and commit evidence establish implementation confidence, not automatic learner mastery.

---

## Active Concepts

```text
&&&01  Responsibility Boundary
&&&02  Raw Data Versus Derived Data
&&&03  Naming as Data Contract

&&%01  Package and Module Boundary
&&%02  Dataclass as Structured Data Carrier

&%%01  Application Service
&%%02  Repository Pattern and Persistence Adapter
&%%03  Presentation Adapter
&%%04  Database Row, Domain Model, and View Model

%%%01  SQLite Initialization Versus Migration
%%%03  SQLite PRAGMA and Connection Configuration
%%%04  Relational Schema and Referential Integrity
%%%05  Bundled Resource Versus Writable User Data
```

These concepts are strongly evidenced by the current repository and should be reinforced through tracing real application flows.

---

## Unstable Concepts

```text
&&&04  Resource Ownership and Lifetime
&&%03  Context Manager and Deterministic Cleanup
&%%05  Statement Atomicity Versus Workflow Atomicity
%%%02  SQLite Connection and Cursor Ownership
```

Current reasons:

- four principal pages construct separate service/repository/connection chains;
- local close capability exists, but one application-level shutdown owner is not established;
- page cleanup behavior has not been proven through final Qt shutdown validation;
- repository mutations commit individually;
- receipt registration and purchase deletion/recalculation are multi-commit workflows;
- complete workflow atomicity remains an unresolved design decision.

These facts do not prove a runtime leak or frequent corruption. They expose ownership and transaction models requiring further study and validation.

---

## Next Concepts

The next concepts should be investigated before canonical promotion:

1. source execution versus frozen execution;
2. packaging versus installation;
3. build-time dependency versus runtime dependency;
4. successful build versus validated release;
5. application composition root and shutdown ownership;
6. workflow transaction boundary;
7. migration ledger and version compatibility;
8. second-platform readiness versus second-platform implementation.

These are checkpoint recommendations, not current KANBAN concepts.

---

## Dependency Spine

```text
&&&01 Responsibility Boundary
├──→ &&%01 Package and Module Boundary
│    ├──→ &%%01 Application Service
│    │    ├──→ &%%02 Repository Pattern and Persistence Adapter
│    │    │    ├──→ %%%02 SQLite Connection and Cursor Ownership
│    │    │    │    ├──→ %%%03 SQLite PRAGMA and Connection Configuration
│    │    │    │    └──→ &%%05 Statement Atomicity Versus Workflow Atomicity
│    │    │    └──→ %%%01 SQLite Initialization Versus Migration
│    │    │         ├──→ %%%04 Relational Schema and Referential Integrity
│    │    │         └──→ %%%05 Bundled Resource Versus Writable User Data
│    │    └──→ &%%04 Database Row, Domain Model, and View Model
│    └──→ &%%03 Presentation Adapter
│
├──→ &&&02 Raw Data Versus Derived Data
│    └──→ &%%04 Database Row, Domain Model, and View Model
│
├──→ &&&03 Naming as Data Contract
│    ├──→ &&%02 Dataclass as Structured Data Carrier
│    └──→ &%%04 Database Row, Domain Model, and View Model
│
└──→ &&&04 Resource Ownership and Lifetime
     ├──→ &&%03 Context Manager and Deterministic Cleanup
     └──→ %%%02 SQLite Connection and Cursor Ownership
```

---

## Project Learning Spine

```text
root/app entrypoint
↓
PySide6 MainWindow and page composition
↓
page-owned ProductService instances
↓
ProductService workflows and view projections
↓
Repository SQL, mappings, commits, and connection ownership
↓
database initialization, migration, and PRAGMA configuration
↓
SQLite schema and per-user database
```

Historical extension:

```text
source-run application
↓
PyInstaller frozen runtime
↓
bundled schema.sql
↓
%LOCALAPPDATA%/Markei/market.sqlite
↓
Inno Setup configuration
↓
compiled and installed lifecycle not validated
```

---

## Failed-Cycle Recovery Note

The preceding Cycle 05 mobile-preparation attempt should be remembered as a failed cycle rather than erased or misclassified as completion.

It successfully exposed necessary decision areas:

- product scope;
- platform-neutral contracts;
- persistence and synchronization;
- backend/API;
- identity and security;
- framework selection;
- migration and desktop coexistence;
- automated validation.

It failed to reconcile those areas before the project changed direction. Its value is therefore diagnostic and didactic, not implementation-completion evidence.

The later packaging sprint also remained partial:

```text
validated frozen runtime
≠
validated installed release
```

This distinction should guide future status claims.

---

## Current Unresolved Project Questions

- Who should own final application shutdown and resource closure?
- Should services and repositories remain page-local or become composition-owned?
- Should complete business workflows receive one transaction boundary?
- Should ProductService and Repository remain broad facades?
- Should abstract contracts cover the complete runtime surface?
- Should dictionary view models become typed boundary objects?
- When should additive schema inspection become versioned migration history?
- Is the promotions table active, deferred, or stale?
- Should `pages.order` be consumed, migrated, or retired?
- Which seed rows belong in production?
- Can installer upgrade, uninstall, and reinstall preserve user data?
- What exact product and architecture would justify reopening mobile work?

These remain active questions, not accepted solutions.

---

## Recovery Route

For low-cost Didactic recovery:

```text
1. Read this checkpoint.
2. Read 07_GLOSSARY for concise terminology.
3. Read targeted 02_KANBAN concepts only when full explanation is required.
4. Read DEV_STAGE/B_DIDACTIC only for the Cycle 04/05 retrospective or current staging evidence.
5. Inspect repository or commit history only when these surfaces are insufficient or drift is suspected.
```

---

## Session Delta

The recovery cycle reconstructed the current repository learning model, populated a fresh canonical register, derived a compact glossary, and rebuilt this checkpoint through a bounded main-branch retrospective.

The checkpoint records two incomplete transitions:

```text
Cycle 05 mobile preparation
→ failed to meet its declared exit conditions

Cycle 05 desktop packaging sprint
→ validated frozen runtime
→ installed lifecycle incomplete
```

No observational entry has yet been written. `13_LECTURE_REGISTER.md` remains intentionally empty until explicit observational registration is authorized after checkpoint acceptance.