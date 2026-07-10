# 07_GLOSSARY.md

> Domain: Didactic
> Status: Persistent derivative — initial recovery reorganization
> Authority source: `didactics/02_KANBAN.md`
> Purpose: Compact human supervision and low-cost agent retrieval
> Constraint: This file reorganizes canonical knowledge and introduces no independent truth.

---

# 1. Recovery-Economy Index

## Current system spine

```text
Desktop presentation
→ ProductService
→ Repository
→ Database manager
→ SQLite
```

Use these concepts first when recovering the current structure:

```text
&&&01  Responsibility Boundary
&%%03  Presentation Adapter
&%%01  Application Service
&%%02  Repository Pattern and Persistence Adapter
%%%02  SQLite Connection and Cursor Ownership
%%%01  SQLite Initialization Versus Migration
```

## Representation spine

```text
source fact
→ persistence representation
→ domain representation
→ service projection
→ rendered view
```

Primary concepts:

```text
&&&02  Raw Data Versus Derived Data
&&&03  Naming as Data Contract
&&%02  Dataclass as Structured Data Carrier
&%%04  Database Row, Domain Model, and View Model
```

## Runtime-resource spine

```text
resource creation
→ ownership
→ use
→ transaction scope
→ cleanup
```

Primary concepts:

```text
&&&04  Resource Ownership and Lifetime
&&%03  Context Manager and Deterministic Cleanup
%%%02  SQLite Connection and Cursor Ownership
&%%05  Statement Atomicity Versus Workflow Atomicity
```

## Persistence-lifecycle spine

```text
bundled schema resource
→ fresh initialization
→ configured connection
→ additive migration
→ writable user database
```

Primary concepts:

```text
%%%05  Bundled Resource Versus Writable User Data
%%%01  SQLite Initialization Versus Migration
%%%03  SQLite PRAGMA and Connection Configuration
%%%04  Relational Schema and Referential Integrity
```

---

# 2. Architecture and Responsibility

## Responsibility Boundary

**KANBAN ID**  
`&&&01`

**Type**  
Foundational Computer Science

**Definition**  
Allocation of knowledge and behavior to a component or layer, including what must remain outside that component.

**Project Usage**  
Markei separates desktop rendering, service orchestration, repository SQL, database lifecycle, and SQLite storage.

**Related Concepts**  
`&%%01`, `&%%02`, `&%%03`, `&&%01`.

---

## Package and Module Boundary

**KANBAN ID**  
`&&%01`

**Type**  
Python Language Concept

**Definition**  
A module is an importable Python file; a package is an import namespace grouping related modules. Placement communicates responsibility but does not enforce it automatically.

**Project Usage**  
`app/core` holds application and persistence modules, `app/database` holds SQL resources, and `app/desktop` holds PySide6 presentation code.

**Related Concepts**  
`&&&01`, `&%%01`, `&%%03`, `%%%05`.

---

## Application Service

**KANBAN ID**  
`&%%01`

**Type**  
Target-File and Architecture Concept

**Definition**  
A use-case boundary that validates and coordinates application work while shielding callers from persistence and infrastructure details.

**Project Usage**  
`ProductService` coordinates commands, recalculation, settings interpretation, stores, and UI-facing projections. It currently acts as a broad application facade.

**Related Concepts**  
`&&&01`, `&%%02`, `&%%03`, `&%%04`, `&%%05`.

---

## Repository Pattern and Persistence Adapter

**KANBAN ID**  
`&%%02`

**Type**  
Target-File and Architecture Concept

**Definition**  
A persistence boundary that translates application-oriented operations into storage operations and maps stored representations back into application representations.

**Project Usage**  
Markei's `Repository` owns SQL, row mapping, one connection, one cursor, and individual commits; database setup and migration remain in `app.core.database`.

**Related Concepts**  
`&&&01`, `&%%01`, `%%%02`, `%%%03`, `&%%05`.

---

## Presentation Adapter

**KANBAN ID**  
`&%%03`

**Type**  
Target-File and Architecture Concept

**Definition**  
A component that translates platform-specific input into application calls and application results into platform-specific rendering.

**Project Usage**  
PySide6 pages collect input, call `ProductService`, and render projections. They do not execute SQL directly.

**Related Concepts**  
`&&&01`, `&&%01`, `&%%01`, `&%%04`.

---

# 3. Data Meaning and Representation

## Raw Data Versus Derived Data

**KANBAN ID**  
`&&&02`

**Type**  
Foundational Computer Science

**Definition**  
Raw data is a source fact; derived data is produced from facts through calculation, grouping, formatting, prediction, or interpretation.

**Project Usage**  
Purchases are historical source events. Product summaries and service-produced status or display labels are derived or cached interpretations.

**Related Concepts**  
`&&&03`, `&&%02`, `&%%01`, `&%%04`.

---

## Naming as Data Contract

**KANBAN ID**  
`&&&03`

**Type**  
Foundational Computer Science

**Definition**  
Stable and precise names define the expected meaning and shape of data exchanged between components.

**Project Usage**  
Names such as `product_name`, `expected_next_purchase`, `remaining_label`, and `history.week_boundary` preserve meaning across schema, mappings, services, and UI.

**Related Concepts**  
`&&&02`, `&&%02`, `&%%04`.

---

## Dataclass as Structured Data Carrier

**KANBAN ID**  
`&&%02`

**Type**  
Python Language Concept

**Definition**  
A Python class declaration optimized for carrying named fields; its architectural role depends on how the application uses it.

**Project Usage**  
`Category`, `Store`, `Product`, and `Purchase` are slotted dataclasses carrying application data without owning SQL or complete workflows.

**Related Concepts**  
`&&&02`, `&&&03`, `&%%04`.

---

## Database Row, Domain Model, and View Model

**KANBAN ID**  
`&%%04`

**Type**  
Target-File and Architecture Concept

**Definition**  
A database row represents persistence, a domain model represents an application entity, and a view model represents presentation-specific data for a use case.

**Project Usage**  
Markei maps `sqlite3.Row` results into models or projections, then `ProductService` builds dictionary projections consumed by Qt widgets.

**Related Concepts**  
`&&&02`, `&&&03`, `&&%02`, `&%%01`, `&%%03`, `%%%03`.

---

# 4. Resource and Transaction Lifecycle

## Resource Ownership and Lifetime

**KANBAN ID**  
`&&&04`

**Type**  
Foundational Computer Science

**Definition**  
Resource ownership assigns creation, use, sharing, and release responsibility; lifetime is the period for which the resource remains retained and valid.

**Project Usage**  
Each principal page creates a service whose repository owns a connection and cursor. Local close capability exists, while one composition-level shutdown owner remains unresolved.

**Related Concepts**  
`&&%03`, `%%%02`, `&%%03`.

---

## Context Manager and Deterministic Cleanup

**KANBAN ID**  
`&&%03`

**Type**  
Python Language Concept

**Definition**  
A context manager ties setup and cleanup to a visible scope so release occurs on normal or exceptional exit.

**Project Usage**  
Repository and service cleanup can be explicit or scope-bound. Markei's long-lived desktop resources still require validated application-shutdown ownership.

**Related Concepts**  
`&&&04`, `%%%02`, `&%%03`.

---

## SQLite Connection and Cursor Ownership

**KANBAN ID**  
`%%%02`

**Type**  
SQLite Concept

**Definition**  
A connection owns SQLite session and transaction state; a cursor is a connection-bound interface for executing statements and traversing results.

**Project Usage**  
Every repository opens one configured connection and cursor. The four principal pages normally produce four long-lived repository connection chains.

**Related Concepts**  
`&&&04`, `&&%03`, `&%%02`, `&%%05`, `%%%03`.

---

## Statement Atomicity Versus Workflow Atomicity

**KANBAN ID**  
`&%%05`

**Type**  
Target-File and Architecture Concept

**Definition**  
One SQL statement may be atomic while a multi-step use case remains non-atomic when its steps commit separately.

**Project Usage**  
Repository mutations commit individually, so receipt registration and purchase deletion plus recalculation are multi-commit workflows rather than single transactional units.

**Related Concepts**  
`&%%01`, `&%%02`, `%%%02`.

---

# 5. SQLite Structure and Lifecycle

## SQLite Initialization Versus Migration

**KANBAN ID**  
`%%%01`

**Type**  
SQLite Concept

**Definition**  
Initialization creates fresh persistence from a baseline schema; migration changes existing persistence while preserving compatible user data.

**Project Usage**  
Markei initializes from `schema.sql` and optional `seed.sql`. Existing databases receive additive, idempotent compatibility changes without a numbered migration ledger.

**Related Concepts**  
`&%%02`, `%%%02`, `%%%03`, `%%%05`.

---

## SQLite PRAGMA and Connection Configuration

**KANBAN ID**  
`%%%03`

**Type**  
SQLite Concept

**Definition**  
PRAGMA commands inspect or configure SQLite behavior; centralized connection configuration applies required behavior to every opened connection.

**Project Usage**  
Markei enables foreign keys, selects WAL, uses synchronous `NORMAL`, and configures `sqlite3.Row` for name-based access.

**Related Concepts**  
`%%%01`, `%%%02`, `%%%04`, `&%%04`.

---

## Relational Schema and Referential Integrity

**KANBAN ID**  
`%%%04`

**Type**  
SQLite Concept

**Definition**  
A relational schema defines tables, columns, keys, and constraints; referential integrity keeps record references valid under declared rules.

**Project Usage**  
Markei relates categories, products, purchases, stores, settings, and promotions. `purchases.product_id` uses update and delete cascades.

**Related Concepts**  
`&&&01`, `&%%02`, `%%%01`, `%%%03`.

---

## Bundled Resource Versus Writable User Data

**KANBAN ID**  
`%%%05`

**Type**  
Packages, Dependencies, and Persistence Concept

**Definition**  
Bundled resources are replaceable files supplied with the application; writable user data is mutable state expected to persist separately from installed program files.

**Project Usage**  
`schema.sql` and `seed.sql` are bundled resources, while `market.sqlite` is stored under the user's Markei data directory.

**Related Concepts**  
`&&&04`, `&&%01`, `%%%01`.

---

# 6. Derived Supporting Terms

These terms provide quick retrieval vocabulary. They do not create additional canonical concepts.

## Cursor

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A connection-bound object used to execute SQL and access query results.

**Project Usage**  
Each Markei repository retains one cursor created from its SQLite connection.

**Related Concepts**  
`%%%02`, `&%%02`.

---

## Row Factory

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A connection setting that determines how SQLite result rows are represented.

**Project Usage**  
Markei uses `sqlite3.Row` so repository code can access columns by name.

**Related Concepts**  
`%%%03`, `&%%04`.

---

## Write-Ahead Logging (WAL)

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A SQLite journaling mode that records changes in a separate log before they are merged into the main database file.

**Project Usage**  
Every configured Markei connection requests WAL mode. Its presence does not settle application-level connection ownership.

**Related Concepts**  
`%%%03`, `%%%02`, `&&&04`.

---

## Idempotent Migration

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A migration operation designed so repeating it does not repeatedly apply the same structural change.

**Project Usage**  
Markei checks for columns, tables, and default settings before adding them.

**Related Concepts**  
`%%%01`, `%%%03`.

---

## Schema Introspection

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
Reading database metadata to discover its current structure.

**Project Usage**  
Markei uses `PRAGMA table_info(...)` to inspect columns before additive migration.

**Related Concepts**  
`%%%01`, `%%%03`, `%%%04`.

---

## Projection

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A selected and reshaped representation of data prepared for a particular query or use case.

**Project Usage**  
`ProductService` returns dictionary projections for Lists, History, analytics, and product details.

**Related Concepts**  
`&%%01`, `&%%04`, `&%%03`.

---

## Signal and Slot

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
Qt's event-connection mechanism in which a signal emitted by one object invokes a connected handler or slot.

**Project Usage**  
Markei pages connect buttons, selectors, and widget events to service-calling or rendering handlers.

**Related Concepts**  
`&%%03`.

---

## User-Data Directory

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A user-writable location intended for persistent runtime state.

**Project Usage**  
Markei stores `market.sqlite` under `%LOCALAPPDATA%/Markei`, with a home-directory fallback.

**Related Concepts**  
`%%%05`, `%%%01`.

---

## Bundled Resource

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A version-controlled non-user file distributed with the application and resolved at runtime.

**Project Usage**  
Markei resolves `schema.sql` and `seed.sql` from source or frozen-runtime resource paths.

**Related Concepts**  
`%%%05`, `&&%01`.

---

## Cascading Foreign-Key Action

**KANBAN ID**  
`None`

**Type**  
Derived terminology

**Definition**  
A declared database action that propagates an update or deletion from a referenced row to dependent rows.

**Project Usage**  
Updates or deletion of a product ID propagate to related purchases through the declared cascade on `purchases.product_id`.

**Related Concepts**  
`%%%04`, `%%%03`.

---

# 7. Supervision Notes

- `02_KANBAN.md` remains authoritative when this glossary and canon differ.
- Glossary wording may be shortened or reorganized without semantic promotion.
- Red canonical concepts remain unresolved learning areas; their glossary entries describe the current structure, not an accepted future solution.
- The glossary does not decide shutdown ownership, transaction redesign, service decomposition, typed view models, migration versioning, promotions status, `pages.order`, or packaging validation.
- The next recovery layer is `08_CONCEPT_MAP.md`, which should summarize current learning state rather than repeat this glossary.