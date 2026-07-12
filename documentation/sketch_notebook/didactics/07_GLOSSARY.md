# 07_GLOSSARY.md

> Domain: Didactic
> Status: Persistent derivative — Cycle 06
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

Primary concepts: `&&&01`, `&%%03`, `&%%01`, `&%%02`, `%%%02`, `%%%01`.

## Release-evidence spine

```text
source execution
→ packaging configuration
→ frozen distribution
→ frozen launch
→ installer configuration
→ compiled installer — blocked
→ installed execution — blocked
→ lifecycle validation — pending
→ acceptance — pending
```

Primary concepts: `&&&05`, `&&%04`, `&%%06`, `%%%06`, `%%%05`.

## Runtime-resource spine

```text
resource creation
→ ownership
→ use
→ transaction scope
→ cleanup
```

Primary concepts: `&&&04`, `&&%03`, `%%%02`, `&%%05`.

---

# 2. Canonical Terms

## Responsibility Boundary
**KANBAN ID:** `&&&01`  
**Definition:** Allocation of knowledge and behavior to a component or layer, including what remains outside it.  
**Project Usage:** Markei separates application behavior, packaging collection, installer placement, validation evidence, and release acceptance.

## Raw Data Versus Derived Data
**KANBAN ID:** `&&&02`  
**Definition:** Raw data is a source fact; derived data is produced through calculation, grouping, formatting, prediction, or interpretation.  
**Project Usage:** Purchases are historical events; summaries and status labels are derived interpretations.

## Naming as Data Contract
**KANBAN ID:** `&&&03`  
**Definition:** Stable names define the expected meaning and shape of exchanged information.  
**Project Usage:** Cycle 06 keeps `configured`, `built`, `launched`, `installed`, `validated`, and `accepted` distinct.

## Resource Ownership and Lifetime
**KANBAN ID:** `&&&04`  
**Definition:** Ownership assigns creation, use, sharing, and release responsibility; lifetime is the interval a resource remains retained and valid.  
**Project Usage:** Four page-owned service chains are closed by the validated `MainWindow` shutdown coordinator in the focused source/frozen gate.

## Evidence State
**KANBAN ID:** `&&&05`  
**Definition:** The strongest truthful project claim supported by the evidence obtained so far.  
**Project Usage:** Markei is configured, built, and frozen-launched; installed is blocked, validation is partial, and acceptance is absent.

## Validation Boundary
**KANBAN ID:** `&&&05`  
**Definition:** The exact environment, lifecycle stage, conditions, and behavior covered by a validation result.  
**Project Usage:** Passing frozen shutdown/reopen does not validate installed shutdown/reopen.

## Package and Module Boundary
**KANBAN ID:** `&&%01`  
**Definition:** A module is an importable Python unit; a package groups related modules under an import namespace.  
**Project Usage:** `app/core`, `app/database`, and `app/desktop` group different responsibilities.

## Dataclass as Structured Data Carrier
**KANBAN ID:** `&&%02`  
**Definition:** A Python class declaration optimized for carrying named fields.  
**Project Usage:** Markei models carry application data without owning SQL or complete workflows.

## Context Manager and Deterministic Cleanup
**KANBAN ID:** `&&%03`  
**Definition:** A cleanup protocol that ties resource release to a visible scope or explicit lifecycle event.  
**Project Usage:** Long-lived desktop services close during `MainWindow.closeEvent()` rather than a short `with` block.

## Source Execution
**KANBAN ID:** `&&%04`  
**Definition:** Repository modules and resources run through a development Python interpreter.  
**Project Usage:** `python main.py` is a source context, not a packaged or installed launch.

## Frozen Application
**KANBAN ID:** `&&%04`  
**Definition:** A generated executable distribution containing collected code, resources, and runtime dependencies.  
**Project Usage:** `dist/Markei/Markei.exe` was built and launched against isolated external user data.

## Installed Application
**KANBAN ID:** `&&%04`  
**Definition:** A frozen runtime placed and registered through an installer-controlled deployment process.  
**Project Usage:** Markei installed execution remains blocked because no installer artifact has been compiled.

## Application Service
**KANBAN ID:** `&%%01`  
**Definition:** A use-case boundary that validates and coordinates application work while shielding callers from persistence details.  
**Project Usage:** `ProductService` coordinates receipt, settings, store, calculation, and projection workflows.

## Repository Pattern and Persistence Adapter
**KANBAN ID:** `&%%02`  
**Definition:** A persistence boundary that translates application operations into storage operations and maps results back.  
**Project Usage:** Markei's repository owns SQL, row mapping, one connection, one cursor, and individual commits.

## Presentation Adapter
**KANBAN ID:** `&%%03`  
**Definition:** A component translating platform interaction into application calls and application results into rendering.  
**Project Usage:** PySide6 pages call `ProductService` and render its projections.

## Database Row, Domain Model, and View Model
**KANBAN ID:** `&%%04`  
**Definition:** Persistence, application-entity, and presentation-specific representations of overlapping information.  
**Project Usage:** Markei maps `sqlite3.Row` into models or projections and then into Qt rendering.

## Statement Atomicity Versus Workflow Atomicity
**KANBAN ID:** `&%%05`  
**Definition:** One SQL statement may be atomic while a multi-step use case remains non-atomic if steps commit separately.  
**Project Usage:** Receipt and deletion/recalculation workflows remain inherited multi-commit debt.

## Packaging Artifact
**KANBAN ID:** `&%%06`  
**Definition:** A generated frozen distribution produced from packaging configuration.  
**Project Usage:** `dist/Markei` is evidenced; `Markei.spec` itself is configuration, not the artifact.

## Installer Artifact
**KANBAN ID:** `&%%06`  
**Definition:** A compiled setup program produced from installer configuration and a frozen distribution.  
**Project Usage:** `installer/Markei.iss` exists, but no Markei installer artifact exists because `ISCC.exe` was unavailable.

## Packaging and Installation Artifact Lifecycle
**KANBAN ID:** `&%%06`  
**Definition:** The sequence from source configuration to frozen artifact, installer configuration, compiled installer, installed application, and lifecycle evidence.  
**Project Usage:** Markei has reached frozen build/launch but not compiled installer or installed lifecycle.

## SQLite Initialization Versus Migration
**KANBAN ID:** `%%%01`  
**Definition:** Initialization creates fresh persistence; migration adapts existing persistence; seeding inserts predefined rows.  
**Project Usage:** Production includes `schema.sql`, excludes `seed.sql`, and retains additive compatibility migration.

## SQLite Connection and Cursor Ownership
**KANBAN ID:** `%%%02`  
**Definition:** A connection owns SQLite session and transaction state; a cursor executes statements through it.  
**Project Usage:** Each page-owned repository has one connection and cursor; focused cleanup now closes all four.

## SQLite PRAGMA and Connection Configuration
**KANBAN ID:** `%%%03`  
**Definition:** Connection-level commands and settings controlling SQLite behavior.  
**Project Usage:** Markei enables foreign keys, requests WAL, uses synchronous `NORMAL`, and configures named rows.

## Relational Schema and Referential Integrity
**KANBAN ID:** `%%%04`  
**Definition:** Tables, columns, keys, constraints, and rules that keep references valid.  
**Project Usage:** Markei relates categories, products, stores, purchases, settings, and promotions.

## Bundled Resource Versus Writable User Data
**KANBAN ID:** `%%%05`  
**Definition:** Replaceable application resources and persistent mutable user state have different locations and lifecycles.  
**Project Usage:** `schema.sql` is bundled; `market.sqlite`, WAL/SHM, and startup logs are writable external state; `seed.sql` is excluded from the beta package.

## Build-Time Dependency
**KANBAN ID:** `%%%06`  
**Definition:** A dependency required to produce a generated application artifact.  
**Project Usage:** PyInstaller is a Markei build-time example.

## Runtime Dependency
**KANBAN ID:** `%%%06`  
**Definition:** A dependency required by the executing application, whether collected into or placed beside it.  
**Project Usage:** Collected PySide6 and Qt components are Markei runtime examples.

## Installer-Time Dependency
**KANBAN ID:** `%%%06`  
**Definition:** A dependency required to compile or execute installation tooling.  
**Project Usage:** Inno Setup's `ISCC.exe` is the missing installer-time prerequisite that blocked compilation.

---

# 3. Derived Supporting Terms

These terms aid retrieval and do not create independent concepts.

- **Cursor** — connection-bound SQL execution object. Related: `%%%02`, `&%%02`.
- **Row factory** — connection setting controlling row representation. Related: `%%%03`, `&%%04`.
- **Write-Ahead Logging (WAL)** — SQLite journaling mode using adjacent transient files. Related: `%%%03`, `%%%02`, `%%%05`.
- **Idempotent migration** — repeatable migration that does not duplicate the same change. Related: `%%%01`, `%%%03`.
- **Schema introspection** — reading database metadata to discover current structure. Related: `%%%01`, `%%%03`, `%%%04`.
- **Projection** — selected and reshaped data for a query or use case. Related: `&%%01`, `&%%04`, `&%%03`.
- **Signal and slot** — Qt event-connection mechanism. Related: `&%%03`.
- **User-data directory** — user-writable location for persistent runtime state. Related: `%%%05`, `%%%01`.
- **Bundled resource** — version-controlled non-user file distributed with the runtime. Related: `%%%05`, `&&%04`.
- **Cascading foreign-key action** — database action propagating an update or deletion to dependent rows. Related: `%%%04`.

---

# 4. Supervision Notes

- `02_KANBAN.md` is authoritative when glossary wording differs.
- All four Cycle 06 concepts remain Red.
- PyInstaller and Inno Setup appear only as Markei project examples.
- A frozen launch is not an installed launch.
- Installer configuration is not a compiled installer artifact.
- External user-data placement and absence of an uninstall deletion directive do not validate uninstall preservation.
- Passing implementation tests does not promote learner mastery to Green.