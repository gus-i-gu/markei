# C_DESIGN.md

> Status: Functional Design Stage
> Knowledge State: Staged / Reconciled Candidate / Unpromoted
> Authority: Design Chat [D]
> Scope: Design-domain recovery, reconciliation report, and initial canonical candidate for `design/01_ARCHITECTURE.md`
> Branch inspected: `sketch-notebook-recovery`

---

# 1. Stage Purpose

This file preserves Design Chat reasoning for Main synthesis. It records the recovered implementation structure, reports reconciliation status against Main staging, and stages the first candidate body for canonical design knowledge.

This file is not canonical architecture. Canonical design knowledge belongs in:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
```

Physical materialization of that file requires Main-approved routing.

---

# 2. Reconciliation Inputs

## 2.1 Design functional stage

The Design stage was recovered from direct repository inspection of:

```text
app/main.py
app/core/contracts.py
app/core/models.py
app/core/services.py
app/core/repository.py
app/core/database.py
app/database/schema.sql
app/desktop/main_window.py
app/desktop/ui/pages/*
app/desktop/ui/widgets/product_detail_panel.py
```

The recovered evidence supports a stable present-state structural picture.

## 2.2 Main stage

Expected reconciliation input:

```text
documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md
```

Repository result:

```text
file absent on sketch-notebook-recovery
```

The path was checked directly and through repository search.

Consequences:

- no Main-stage proposition was available to confirm, reject, or constrain the Design findings;
- Design Chat must not invent or write `J_MAIN_STAGE.md`;
- the missing Main-stage counterpart is a structural reconciliation gap;
- the canonical candidate below is reconciled against implementation evidence and methodology only, not against a Main-authored J synthesis.

This absence must be surfaced to Main Chat before materialization.

---

# 3. Methodological Routing Result

`FLUX.md` assigns Design Chat active-stage authority only over:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

It identifies the permanent Design symmetry files as:

```text
Canonical Knowledge      design/01_ARCHITECTURE.md
Derived Knowledge        design/14_MODEL_OVERVIEW.md
Domain Checkpoint        design/09_DESIGN_STATE.md
Observational History    design/03_DECISION_LOG.md
```

During active functional staging, Design Chat must not edit Main stage files or prematurely materialize permanent domain memory. Therefore this pass stages a proposed canonical body here. It does not write `01_ARCHITECTURE.md` directly.

---

# 4. Recovered Current Architecture

## 4.1 Runtime dependency direction

```text
Desktop UI
    → ProductService
        → Repository
            → Database Manager
                → SQLite
```

Supporting domain representations and declared invariants live in `app/core/models.py` and `app/core/contracts.py`.

Runtime inversion is incomplete because concrete UI pages construct `ProductService`, and `ProductService` constructs `Repository`.

## 4.2 Functional layers

```text
Desktop bootstrap
    app/main.py

Desktop composition and coordination
    app/desktop/main_window.py

Qt presentation
    app/desktop/ui/pages/*
    app/desktop/ui/widgets/*

Application facade and business layer
    app/core/services.py

Persistence facade
    app/core/repository.py

Persistence lifecycle and compatibility
    app/core/database.py

Domain representation and declared invariants
    app/core/models.py
    app/core/contracts.py
    app/core/config.py

Bundled persistence definition
    app/database/schema.sql

External writable state
    %LOCALAPPDATA%/Markei/market.sqlite
```

---

# 5. Canonical Candidate — Architecture Foundations

The following sections are staged as the first proposed content for `design/01_ARCHITECTURE.md`.

## 5.1 System form

Markei is a local desktop monolith implemented with Python, PySide6, and SQLite.

The application is organized as a layered system rather than as independently deployed services. Layer boundaries separate presentation, business coordination, persistence behavior, and database lifecycle while preserving a small deployment unit.

## 5.2 Dependency direction

The accepted dependency-direction candidate is:

```text
Desktop presentation
    ↓
Application and business services
    ↓
Persistence adapter
    ↓
Database lifecycle manager
    ↓
SQLite
```

Higher layers may request behavior from lower layers. Lower persistence layers must not depend on Qt presentation objects.

The desktop UI must not execute SQL or manipulate database cursors.

The service layer must not contain SQLite statements or depend on Qt widgets.

The repository owns SQLite statements and row-to-model mapping.

The database manager owns database location, initialization, connection configuration, migration, and closure primitives.

## 5.3 Domain records and source relationships

The active domain model contains `Category`, `Store`, `Product`, and `Purchase`.

Persistent relationships are:

```text
Category 1 ─── * Product
Product  1 ─── * Purchase
Store    1 ─── * Purchase, optional
```

`Purchase` is the historical purchase ledger. A receipt entry creates a Purchase record. Purchase records are not edited as ordinary mutable state; erroneous records may be deleted and dependent summaries recalculated.

`Product` owns editable product identity and metadata while also storing cached current and analytical state derived from Purchase history.

The Product cache remains valid only while one service-owned recalculation path is authoritative for calculated fields.

## 5.4 Product calculated-state invariant

Editable Product state and calculated Product state are distinct responsibilities.

Editable state includes product identity, category, name, brand, unit, minimum quantity, reorder threshold, and notes.

Calculated state includes current quantity, price history, purchase dates, consumption estimates, duration estimates, expected next purchase, shelf-life estimates, expected expiration, and price deltas.

Calculated fields must not be independently authored by desktop pages or arbitrary repository callers. They are produced through the Product recalculation workflow.

## 5.5 Application service responsibility

The current `ProductService` acts as the Markei application facade.

It owns receipt and product workflows, Product-summary recalculation, inventory classification, history grouping and analytics, settings validation and persistence coordination, store administration, and platform-neutral read-model preparation.

This breadth is accepted as the recovered current architecture of the small monolith. It does not establish that one service class must remain permanent.

Future decomposition must preserve workflow, transaction, and calculated-state ownership rather than splitting methods solely by file size.

## 5.6 Repository responsibility

The current Repository is the complete SQLite persistence facade for the monolith.

It owns SQL execution, CRUD and query operations, row-to-domain mapping, one SQLite connection and cursor per Repository instance, and persistence resource closure.

The repository must not own business classification, history grouping, inventory forecasting, or Qt presentation behavior.

Repository and service decomposition are coupled architectural decisions because transaction boundaries and aggregate workflows cross multiple persistence operations.

## 5.7 Database resource boundary

Installed application resources and writable user state are separate:

```text
Bundled read-only schema
    application resource directory

Writable user database
    %LOCALAPPDATA%/Markei/market.sqlite
```

Application replacement or uninstall must not implicitly redefine the writable database as an installed program resource.

Database initialization and compatibility migration belong to the persistence lifecycle boundary, not to presentation logic.

## 5.8 Desktop composition

`app/main.py` is the desktop bootstrap. It creates the Qt application and the main window.

`MainWindow` is the current desktop shell and informal UI coordinator. It owns page construction, tab composition, navigation, edit routing, and cross-page refresh calls.

Pages own Qt interaction and rendering. They consume application operations and read models rather than database commands.

`ProductDetailPanel` represents the preferred read-only presentation boundary:

```text
service prepares view data
    ↓
widget renders view data
```

## 5.9 Current composition limitation

Each page currently constructs its own service, repository, and SQLite connection:

```text
RegisterPage → ProductService → Repository → connection
ListsPage    → ProductService → Repository → connection
HistoryPage  → ProductService → Repository → connection
SettingsPage → ProductService → Repository → connection
```

This is a recovered implementation property, not a preferred permanent principle.

Application resource ownership and shutdown are consequently distributed among pages. A future composition decision must establish either one shared application facade and explicit composition-root shutdown, or multiple bounded services/repositories with explicit ownership for each connection.

## 5.10 Transaction integrity

Repository mutation methods currently commit autonomously.

Receipt registration therefore performs multiple commits:

```text
create or update Product
→ insert Purchase
→ recalculate and update Product summary
```

The current workflow is sequentially consistent but not atomic.

This is an implementation limitation, not a canonical target. Workflows that semantically represent one user action should eventually declare whether partial persistence is acceptable or whether all participating mutations must commit or roll back together.

Transaction ownership belongs at the workflow boundary. It cannot be corrected safely by splitting the repository without first defining service-level unit-of-work semantics.

## 5.11 Presentation read models

Services may expose platform-neutral read models so presentation layers do not recreate business calculations.

Qt-specific responsibilities remain in desktop widgets: widget construction, event and signal binding, colors and selection behavior, dialogs, and visual placement.

The current dictionary read models are valid for the MVP. Whether they later become explicit immutable view-model types remains an unresolved refinement rather than a foundational requirement.

---

# 6. Excluded From Initial Canon

## 6.1 Promotions

The `promotions` table exists in `schema.sql`, but no active Promotion model, service workflow, or desktop feature was recovered.

Classification remains open:

```text
dormant roadmap structure
or incomplete feature
or stale schema
```

## 6.2 Persisted page order

`pages.order` is persisted, but current MainWindow tab composition is hard-coded and consolidates Storage, Shortage, and Market into Lists. The setting is persisted but currently inert for desktop composition.

## 6.3 Contract mechanism

`contracts.py` records useful invariants and partial abstract interfaces, but concrete runtime construction does not currently depend on those abstractions.

It remains unclassified as the intended complete dependency-inversion boundary, a partial interface awaiting expansion, or source-adjacent architectural documentation.

---

# 7. Decisions Requiring Main Reconciliation

Before materializing `design/01_ARCHITECTURE.md`, Main Chat should explicitly accept, revise, or defer these points:

1. Accept the layered local-desktop-monolith description.
2. Accept Purchase as historical ledger and Product as editable identity plus persisted calculated cache.
3. Accept ProductService as the recovered current application facade without making its permanence mandatory.
4. Accept Repository as the recovered monolithic persistence facade.
5. Classify per-page service ownership as implementation state rather than architectural target.
6. Classify non-atomic receipt registration as a limitation requiring a later transaction decision.
7. Confirm MainWindow as the current desktop coordinator.
8. Decide whether the missing `J_MAIN_STAGE.md` should be created, restored, or intentionally replaced by another Main synthesis surface.

---

# 8. Proposed Materialization Target

Upon Main acceptance, the first Design domain materialization should populate:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
```

Suggested metadata:

```text
Status: Draft / Recovered Canon
Persistence Class: Canonical
Knowledge Class: Design
Authority: Design Chat, reconciled by Main Chat
Scope: Markei dependency direction, responsibility boundaries, domain relationships, persistence boundaries, and desktop composition
```

The later Design recovery sequence should be:

```text
01_ARCHITECTURE.md
    ↓ derive
14_MODEL_OVERVIEW.md
    ↓ checkpoint
09_DESIGN_STATE.md
    ↓ preserve accepted evolution
03_DECISION_LOG.md
```

The observational history file should record the recovery and acceptance event, not duplicate the full canon.

---

# 9. Stage Classification

```text
Implementation evidence: inspected
C_DESIGN structural report: reconciled and condensed
J_MAIN_STAGE comparison: blocked by absent file
Canonical candidate: staged in C_DESIGN
Canonical domain file: not materialized
Derived design file: not materialized
Design checkpoint: not materialized
Design observational history: not materialized
Application code changed: no
Methodology files changed: no
```
