# 09_DESIGN_STATE.md

> Version: 0.1-recovery
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat [D]
> Scope: Low-cost recovery surface for the current Markei architectural state
> Sources: `01_ARCHITECTURE.md`, `14_MODEL_OVERVIEW.md`, `DEV_STAGE/C_DESIGN.md`

---

# Current Milestone

The Design domain has completed its first recovery repopulation cycle.

```text
implementation inspection
→ Main reconciliation
→ canonical architecture rebuilt
→ derivative model overview rebuilt
→ historical cycle retrospective staged
→ Design checkpoint rebuilt
```

The current milestone is **architectural recovery and stabilization**, not feature expansion.

No new packaging, mobile, backend, synchronization, or installer architecture is currently accepted.

---

# Current Architecture

Markei is a layered local desktop monolith:

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
Database Manager
    ↓
SQLite
```

Stable ownership:

| Area | Current owner |
| --- | --- |
| Qt rendering, controls, navigation and dialogs | Desktop pages and widgets |
| Application workflows, validation, calculations and projections | `ProductService` |
| SQL, row mapping and persistence operations | `Repository` |
| Database paths, initialization, configuration and additive migration | `app.core.database` |
| Persistent facts and relationships | SQLite |

Public desktop surfaces:

```text
Register
Lists
History
Settings
```

Storage, Shortage, and Market are Lists modes rather than separate public pages.

---

# Domain Model Snapshot

```text
Category 1 ─── * Product
Product  1 ─── * Purchase
Store    1 ─── * Purchase, optional
```

`Purchase` is the historical receipt record.

`Product` contains editable identity and metadata plus cached current and analytical summaries derived from Purchase history.

`ProductService.recalculate_product()` is the centralized producer of calculated Product state.

Promotion persistence exists in the schema, but Promotion is not classified as an active application capability.

---

# Current Structural Constraints

## Lifecycle

Each principal page currently constructs its own service, repository, and SQLite connection.

```text
RegisterPage → ProductService → Repository → connection
ListsPage    → ProductService → Repository → connection
HistoryPage  → ProductService → Repository → connection
SettingsPage → ProductService → Repository → connection
```

Local close capability exists, but application-wide shutdown ownership remains implicit.

## Transactions

Repository mutation methods commit independently.

Receipt registration and purchase deletion are multi-commit workflows and are not atomic across the full user action.

## Facade breadth

`ProductService` currently acts as the broad application facade.

`Repository` currently acts as the broad persistence facade.

Their breadth is accepted current state, not a permanent decomposition decision.

## Contracts and projections

Source contracts record important invariants but do not cover the complete concrete runtime surface.

Service-produced dictionaries currently function as UI-facing view models.

---

# Failed Precedent Cycle

The previous main-branch recovery sequence closed Cycle 04 with coherent Product View, History, Lists, analytics, and Settings boundaries, but retained operational verification debt.

Cycle 05 then widened rapidly from post-cycle verification into mobile planning and Windows packaging preparation.

The `cycle 5.0 outburst mode` commit rewrote all three functional stages, the Main reconciliation reference, and the session scheme together. This created a cycle-control failure:

```text
unresolved Cycle 04 verification
+
broad mobile planning
+
packaging architecture proposal
+
simultaneous A/B/C and Main-stage replacement
=
insufficiently controlled promotion surface
```

The failed cycle does **not** prove that Markei's layered architecture failed.

Its durable lesson is:

> A new cycle must establish one active milestone, preserve inherited verification debt, separate current facts from future targets, and reconcile domain outputs before replacing shared coordination surfaces.

Packaging and mobile architecture from that cycle remain historical proposals, not current canon.

---

# Recovery Status

```text
01_ARCHITECTURE.md    populated and canonical
14_MODEL_OVERVIEW.md  populated and derivative
09_DESIGN_STATE.md    rebuilt and active
03_DECISION_LOG.md    intentionally empty
```

The current checkpoint is derived from the recovered canon plus the staged commit retrospective.

The observational file remains empty until a later explicit action records this completed repopulation cycle as accepted design history.

---

# Active Design Questions

1. Should application services and repositories remain page-local or move under an explicit composition root?
2. Which object should own deterministic application shutdown?
3. Which workflows require service-level transaction boundaries?
4. Should `ProductService` remain one application facade or be decomposed by capability?
5. Should Repository remain one persistence facade?
6. Should contracts become complete substitutable interfaces or remain responsibility declarations?
7. Should dictionary projections become typed view models?
8. Where should presentation formatting live?
9. Should migration become an explicit versioned startup process?
10. Is Promotion persistence active, deferred, or stale?
11. Should `pages.order` be consumed, migrated, or retired?
12. Is Product's combined editable/cache role the long-term domain model?

These questions are unresolved. They must not be read as approved refactor instructions.

---

# Operational Validation Dependencies

Design state still depends on operational evidence for:

- deterministic closure of all page-owned connections;
- failure behavior inside multi-commit workflows;
- packaged schema and seed inclusion;
- user-data preservation through installation and upgrade;
- first-weekday operational-month period-end correctness;
- Settings save feedback, store editing, dependent refresh, and broad desktop regression behavior.

Until validated, these remain implementation risks or watch points rather than accepted architectural failures.

---

# Next Design Actions

1. Keep the current canon stable while operational validation proceeds.
2. Reconcile any new runtime evidence against this checkpoint.
3. Do not reopen packaging or mobile architecture without a separately scoped cycle.
4. Require one explicit milestone and bounded acceptance criteria before future Design staging.
5. Populate `03_DECISION_LOG.md` only after an explicit decision or accepted recovery event is authorized.

---

# Recovery Route

For rapid recovery, read this file first.

Then use:

```text
Architecture overview
    design/14_MODEL_OVERVIEW.md

Exact accepted architecture
    design/01_ARCHITECTURE.md

Temporary retrospective evidence
    DEV_STAGE/C_DESIGN.md

Accepted design history
    design/03_DECISION_LOG.md
    currently empty
```
