# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register — Cycle 06 Sprint 02
> Authority: Didactic Chat [A], reconciled through Main reference
> Reconciliation sources: `DEV_STAGE/E_DDC_STAGE.md`, `DEV_STAGE/H_DDC_CODEX.md`, `DEV_STAGE/G_OPS_CODEX.md`, and `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Stable concepts evidenced by the contemporary Markei repository
> Maturity rule: implementation success does not establish learner mastery

---

# Foundational Computer Science

## &&&01
### Responsibility Boundary
#### Description
A responsibility boundary identifies which component should know, decide, or perform a kind of work.
#### Formal Definition
An explicit allocation of knowledge and behavior to a component or layer, together with constraints on what belongs elsewhere.
#### Practical Example
A screen gathers input, a service coordinates a use case, and a repository stores data.
#### Language Implementation
Python expresses boundaries through packages, modules, classes, imports, interfaces, and method calls.
#### Project Implementation
Markei separates desktop presentation, `ProductService`, `Repository`, database lifecycle, packaging, installer placement, validation evidence, and Main/human acceptance.
#### Required Concepts
None.
#### Related Concepts
`&&&02`, `&&&03`, `&&&05`, `&%%01`, `&%%02`, `&%%03`.
#### Status
Yellow.
#### Source
Current application and Cycle 06 reconciliation.

---

## &&&02
### Raw Data Versus Derived Data
#### Description
Source facts and values calculated from those facts have different evidential roles.
#### Formal Definition
Raw data is directly entered, observed, imported, or retrieved; derived data is produced through calculation, aggregation, filtering, formatting, prediction, or interpretation.
#### Practical Example
A receipt purchase is a source event; an expected next-purchase date is derived from history.
#### Language Implementation
Both may be represented by fields or keys, so naming, ownership, recalculation, and persistence rules preserve the distinction.
#### Project Implementation
Markei treats purchases as historical events and product summaries, status labels, and projections as derived or cached interpretations.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&&03`, `&&&05`, `&&%02`, `&%%04`.
#### Status
Yellow.
#### Source
Current Product/Purchase and service-projection boundary.

---

## &&&03
### Naming as Data Contract
#### Description
Names communicate the expected meaning of data and project states across boundaries.
#### Formal Definition
The use of stable, precise, responsibility-aware names to define the meaning and shape of exchanged information.
#### Practical Example
`configured`, `built`, `launched`, `installed`, `validated`, and `accepted` are not interchangeable labels.
#### Language Implementation
Naming contracts appear in attributes, signatures, dictionary keys, constants, settings keys, artifacts, and status reports.
#### Project Implementation
Cycle 06 keeps automated technical validation distinct from human-visible UI acceptance and final Main/human acceptance.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&&02`, `&&&05`, `&&%02`, `&%%04`.
#### Status
Yellow.
#### Source
Current naming chain and Cycle 06 evidence classification.

---

## &&&04
### Resource Ownership and Lifetime
#### Description
Resources require an identifiable owner and a defined lifetime.
#### Formal Definition
Resource ownership assigns creation, use, sharing, and release responsibility; lifetime is the interval during which a resource remains retained and valid.
#### Practical Example
A repository owns a database connection, while the application composition determines when all repositories close.
#### Language Implementation
Python expresses lifetime through constructors, `close()`, context managers, `try/finally`, event hooks, and composition.
#### Project Implementation
A bounded, idempotent `MainWindow.closeEvent()` closes all four page-owned services. Source/frozen and installed close/reopen evidence passed, while human-visible walkthrough remains pending.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&%03`, `&&&05`, `%%%02`, `&%%06`.
#### Status
Red.
#### Source
Cycle 06 shutdown failure, correction, and installed lifecycle rerun evidence.

---

## &&&05
### Evidence State and Validation Boundary
#### Description
A claim is limited by the strongest evidence actually obtained. Configuration, artifact creation, execution, deployment, validation, and acceptance are distinct states.
#### Formal Definition
An evidence state records what has been demonstrated; a validation boundary identifies the exact environment, lifecycle stage, conditions, and behavior covered by that evidence. Evidence from one boundary cannot automatically prove another.
#### Practical Example
A compiled installer proves artifact creation; it does not by itself prove installation, workflow behavior, retention, or acceptance.
#### Language Implementation
Projects encode evidence through command results, artifact inspection, hashes, logs, test results, environment records, and explicit acceptance decisions.
#### Project Implementation
Cycle 06 progressed from installer configuration to compiled installer, per-user installation, Start Menu launch, technical workflow persistence, close/reopen, same-version reinstall, uninstall retention, and reinstall recovery. Automated installed-lifecycle evidence is strong, but human-visible UI acceptance and SmartScreen behavior remain pending or unknown; `accepted: no`.
#### Required Concepts
`&&&01`, `&&&02`, `&&&03`.
#### Related Concepts
`&&%04`, `&%%06`, `%%%06`, `&&&04`.
#### Status
Red.
#### Source
Sprint 02 Main reconciliation plus G/H evidence.

---

# Python Language Concepts

## &&%01
### Package and Module Boundary
#### Description
A module groups definitions in one file; a package groups related modules under an import namespace.
#### Formal Definition
A module is an importable unit normally represented by a `.py` file; a package is an importable namespace containing modules or subpackages.
#### Practical Example
Business services and database infrastructure may share a package while retaining separate responsibilities.
#### Language Implementation
Python boundaries use directories, package markers, imports, and module-level names.
#### Project Implementation
Markei uses `app/core`, `app/database`, and `app/desktop`; physical grouping does not erase semantic responsibility.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&%02`, `&&%04`, `&%%01`, `&%%03`.
#### Status
Yellow.
#### Source
Current repository topology.

---

## &&%02
### Dataclass as Structured Data Carrier
#### Description
A dataclass concisely defines objects whose main role is carrying named data.
#### Formal Definition
A class declaration enhanced by generated initialization, representation, comparison, and related data-oriented behavior.
#### Practical Example
A purchase object carries product, date, quantity, and price without owning SQL.
#### Language Implementation
Python uses `@dataclass`, typed fields, and optionally `slots=True`.
#### Project Implementation
Markei defines `Category`, `Store`, `Product`, and `Purchase` as slotted dataclasses while persistence and workflows remain elsewhere.
#### Required Concepts
`&&&01`, `&&&03`.
#### Related Concepts
`&&&02`, `&%%04`.
#### Status
Yellow.
#### Source
Current models and reconciled entity boundary.

---

## &&%03
### Context Manager and Deterministic Cleanup
#### Description
A context manager ties setup and cleanup to a visible scope; long-lived applications may require an explicit lifecycle event instead.
#### Formal Definition
An object implementing context management so setup occurs on entry and cleanup on exit, including exceptional exit.
#### Practical Example
A short database operation can use `with`; a desktop session may close repositories during window shutdown.
#### Language Implementation
Python uses `with`, `__enter__`, `__exit__`, `try/finally`, and explicit `close()` methods.
#### Project Implementation
Markei uses explicit service closure in `MainWindow.closeEvent()`. Automated installed close and immediate reopen passed after the Sprint 01 correction.
#### Required Concepts
`&&&04`.
#### Related Concepts
`&&&05`, `%%%02`, `&%%06`.
#### Status
Red.
#### Source
Cycle 06 shutdown and installed-reopen evidence.

---

## &&%04
### Source, Frozen, and Installed Execution Context
#### Description
The same application can run from repository source, a collected executable distribution, or an installer-placed distribution. These contexts share business architecture but differ operationally.
#### Formal Definition
Source execution runs modules and resources through a development interpreter; frozen execution runs collected code and resources through a generated executable; installed execution runs that frozen runtime after installer-controlled placement, registration, and launch-path creation.
#### Practical Example
`python main.py`, `dist/Markei/Markei.exe`, and a Start Menu shortcut start the same application through different execution contexts.
#### Language Implementation
Python applications distinguish contexts through entrypoints, `sys.frozen`, `_MEIPASS`, resource resolution, collected dependencies, and platform-specific writable paths.
#### Project Implementation
Source and frozen execution were previously evidenced. Sprint 02 added actual installed execution from a Start Menu shortcut under `%LOCALAPPDATA%\Programs\Markei`, without requiring a Python command or source checkout.
#### Required Concepts
`&&&01`, `&&%01`, `%%%05`.
#### Related Concepts
`&&&05`, `&%%06`, `%%%06`.
#### Status
Red.
#### Source
Cycle 06 source, frozen, and installed-launch evidence.

---

# Target-File and Architecture Concepts

## &%%01
### Application Service
#### Description
An application service coordinates a user-facing use case without becoming presentation or persistence infrastructure.
#### Formal Definition
A boundary object that orchestrates domain and persistence operations to fulfill application use cases.
#### Practical Example
Receipt registration validates input, records a purchase, recalculates summaries, and returns results without exposing SQL to the UI.
#### Language Implementation
Commonly a class whose methods represent use cases and depend on repositories.
#### Project Implementation
`ProductService` coordinates commands, calculations, settings, stores, and UI-facing projections.
#### Required Concepts
`&&&01`, `&&%01`.
#### Related Concepts
`&%%02`, `&%%04`, `&%%05`.
#### Status
Yellow.
#### Source
Current service responsibility inventory.

---

## &%%02
### Repository Pattern and Persistence Adapter
#### Description
A repository translates application-oriented persistence operations into storage operations.
#### Formal Definition
A persistence abstraction that maps application requests and representations to database commands and results.
#### Practical Example
A service asks for purchases; the repository runs SQL and returns mapped results.
#### Language Implementation
Python repositories commonly contain parameterized SQL, cursor execution, commits, and row mapping.
#### Project Implementation
Markei's `Repository` owns SQL, mappings, one connection, one cursor, and individual commits; database setup remains in `app.core.database`.
#### Required Concepts
`&&&01`, `&&&02`, `&%%01`.
#### Related Concepts
`%%%02`, `%%%03`, `&%%05`.
#### Status
Yellow.
#### Source
Current repository implementation.

---

## &%%03
### Presentation Adapter
#### Description
A presentation adapter translates platform input into application calls and application results into rendering.
#### Formal Definition
A component that converts platform-specific interaction into application-boundary calls and representations.
#### Practical Example
A page reads widgets, calls a service, and renders prepared data.
#### Language Implementation
PySide6 uses widgets, layouts, signals, slots, event handlers, and dialogs.
#### Project Implementation
Markei pages call `ProductService`; automated Sprint 02 evidence exercised the same service/database path, but a full human-visible UI walkthrough remains pending.
#### Required Concepts
`&&&01`, `&&%01`, `&%%01`.
#### Related Concepts
`&&&04`, `&&%03`, `&%%04`, `&&&05`.
#### Status
Yellow.
#### Source
Current desktop composition and Sprint 02 validation boundary.

---

## &%%04
### Database Row, Domain Model, and View Model
#### Description
Overlapping information may appear in representations shaped for persistence, application meaning, or presentation.
#### Formal Definition
A database row is a persistence representation, a domain model is an application entity representation, and a view model is a use-case-specific rendering representation.
#### Practical Example
Stored numbers become a Product object and then formatted Lists labels.
#### Language Implementation
Python may use `sqlite3.Row`, dataclasses, dictionaries, `TypedDict`, or dedicated view models.
#### Project Implementation
Sprint 02 technical evidence included persisted product/purchase rows plus Lists, History, and Settings projections.
#### Required Concepts
`&&&02`, `&&&03`, `&&%02`, `&%%01`.
#### Related Concepts
`&%%03`, `%%%03`.
#### Status
Yellow.
#### Source
Current mapping and installed technical workflow evidence.

---

## &%%05
### Statement Atomicity Versus Workflow Atomicity
#### Description
One database statement can be atomic while a multi-step use case remains non-atomic when its steps commit separately.
#### Formal Definition
Statement atomicity is all-or-nothing execution of one statement; workflow atomicity is all-or-nothing execution of a complete use case within one transaction boundary.
#### Practical Example
Creating a product, adding a purchase, and updating a summary may leave partial state if each commits independently.
#### Language Implementation
SQLite workflow atomicity uses transaction boundaries, commits, rollbacks, and service/repository coordination.
#### Project Implementation
Markei receipt registration and deletion/recalculation remain multi-commit workflows. Sprint 02 success does not remove this inherited debt.
#### Required Concepts
`&&&01`, `&%%01`, `&%%02`.
#### Related Concepts
`&&&05`, `%%%02`.
#### Status
Red.
#### Source
Current repository/service behavior and Cycle 06 scope boundary.

---

## &%%06
### Packaging and Installation Artifact Lifecycle
#### Description
Packaging and installation move through distinct configurations, generated artifacts, deployed states, and lifecycle evidence.
#### Formal Definition
A release artifact lifecycle transforms source configuration into a frozen distribution, installer configuration into a compiled installer, and that installer into an installed application whose reinstall, uninstall, recovery, and retained-data behavior require separate validation.
#### Practical Example
A `.spec` file is not an executable; an executable directory is not an installer; installer source is not compiled setup media; installation is not lifecycle acceptance.
#### Language Implementation
Projects use packaging specifications, build wrappers, generated distributions, installer definitions, compiler outputs, installation metadata, and lifecycle tests.
#### Project Implementation
Sprint 02 produced `dist/installer/Markei-Setup-0.1.0-x64.exe`, installed files under `%LOCALAPPDATA%\Programs\Markei`, validated same-version reinstall, removed installed files during uninstall while retaining `%LOCALAPPDATA%\Markei`, and recovered retained data after reinstall.
#### Required Concepts
`&&&01`, `&&&04`, `&&%04`, `%%%05`.
#### Related Concepts
`&&&05`, `%%%06`.
#### Status
Red.
#### Source
Cycle 06 installer artifact and installed lifecycle evidence.

---

# Packages, Dependencies, and SQLite Concepts

## %%%01
### SQLite Initialization Versus Migration
#### Description
Initialization creates a new database; migration changes an existing database while preserving compatible user state. Seeding inserts predefined rows.
#### Formal Definition
Initialization establishes baseline persistence, migration transforms existing persistence, and seeding inserts optional predefined records into an initialized structure.
#### Practical Example
A first launch creates tables; migration ensures required defaults; a development fixture may insert sample rows.
#### Language Implementation
Python may use `connect`, `executescript`, schema inspection, conditional DDL, idempotent inserts, and commits.
#### Project Implementation
Production includes `schema.sql` and excludes `seed.sql`. Sprint 02 showed that category `F` / `General` and store `1` / `Default Store` are required structural defaults, created idempotently without sample products or purchases.
#### Required Concepts
`&&&01`, `&%%02`.
#### Related Concepts
`%%%02`, `%%%03`, `%%%05`, `&&&05`.
#### Status
Yellow.
#### Source
Current database lifecycle and Sprint 02 fresh-production correction.

---

## %%%02
### SQLite Connection and Cursor Ownership
#### Description
A connection owns SQLite session and transaction state; a cursor is a connection-bound execution interface.
#### Formal Definition
A connection is the runtime object owning database-session state and transaction context; a cursor executes statements and traverses results through that connection.
#### Practical Example
Four repositories can hold four independent database sessions.
#### Language Implementation
Python uses `sqlite3.Connection` and `sqlite3.Cursor`, explicit commit/rollback, row factories, PRAGMAs, and close operations.
#### Project Implementation
Each Markei repository opens one connection and cursor. The four page-owned chains closed successfully during automated installed close/reopen validation.
#### Required Concepts
`&&&04`, `&%%02`.
#### Related Concepts
`&&%03`, `&&&05`, `%%%03`, `&%%05`.
#### Status
Red.
#### Source
Current ownership structure and installed lifecycle evidence.

---

## %%%03
### SQLite PRAGMA and Connection Configuration
#### Description
SQLite behavior is partly configured per connection.
#### Formal Definition
PRAGMA statements inspect or modify SQLite metadata and connection/database behavior; centralized configuration applies expected settings to each connection.
#### Practical Example
Foreign keys, WAL, synchronous mode, and named row access are configured separately.
#### Language Implementation
Python uses connection execution and `row_factory` assignment.
#### Project Implementation
Markei enables foreign keys, requests WAL, uses synchronous `NORMAL`, and configures `sqlite3.Row`.
#### Required Concepts
`%%%02`.
#### Related Concepts
`%%%01`, `%%%04`, `&%%04`.
#### Status
Yellow.
#### Source
Current connection configuration.

---

## %%%04
### Relational Schema and Referential Integrity
#### Description
A relational schema defines tables, columns, keys, relationships, and constraints.
#### Formal Definition
Referential integrity requires foreign-key references to correspond to valid records or permitted null states.
#### Practical Example
A purchase references a product and follows declared update/delete behavior.
#### Language Implementation
SQLite uses `CREATE TABLE`, keys, indexes, nullability, and foreign-key actions.
#### Project Implementation
The fresh-production Register failure exposed that required category/store references must exist before inserting a purchase-backed product workflow.
#### Required Concepts
`&&&01`, `&%%02`.
#### Related Concepts
`%%%01`, `%%%03`.
#### Status
Yellow.
#### Source
Current schema and Sprint 02 referential-integrity evidence.

---

## %%%05
### Bundled Resource Versus Writable User Data
#### Description
Replaceable application resources and persistent mutable user state have different locations and lifecycles.
#### Formal Definition
A bundled resource is supplied with the application runtime; writable user data is created or modified during use and persists independently from installed program files.
#### Practical Example
A schema script travels with the application while the user's database belongs in a per-user directory.
#### Language Implementation
Python resolves source/frozen resources through paths and runtime indicators, while user data uses platform directories or environment variables.
#### Project Implementation
Installed program files under `%LOCALAPPDATA%\Programs\Markei` were removed by uninstall, while `%LOCALAPPDATA%\Markei\market.sqlite` remained and was recovered after reinstall. `schema.sql` is bundled, `seed.sql` is excluded, and logs/WAL/SHM remain writable external state.
#### Required Concepts
`&&&04`, `%%%01`.
#### Related Concepts
`&&%01`, `&&%04`, `&%%06`.
#### Status
Yellow.
#### Source
Sprint 02 uninstall retention and reinstall recovery evidence.

---

## %%%06
### Build-Time, Runtime, and Installer-Time Dependency
#### Description
Dependencies belong to different lifecycle stages and must not be treated as one undifferentiated requirement set.
#### Formal Definition
A build-time dependency produces a frozen artifact; a runtime dependency supports the executing application; an installer-time dependency compiles or executes installation tooling.
#### Practical Example
A packaging tool may exist only on the builder, collected GUI libraries support the executable, and an installer compiler produces setup media.
#### Language Implementation
Projects separate dependency manifests, build commands, collected modules/native libraries, and external compiler discovery.
#### Project Implementation
PyInstaller produced the frozen runtime; collected PySide6/Qt components support execution. Inno Setup 6.7.3 was installed per-user and discovered at `%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe`; it compiled the installer but is not required by the installed Markei application.
#### Required Concepts
`&&%01`, `&&%04`, `&%%06`.
#### Related Concepts
`&&&05`, `%%%05`.
#### Status
Red.
#### Source
Sprint 02 toolchain discovery and installed runtime evidence.

---

# Canonical Boundary

The four Cycle 06 release concepts remain **Red**. Sprint 02 strengthens their project examples but does not demonstrate learner mastery. No concept is Green. Automated technical workflow validation does not equal a human-visible UI walkthrough, SmartScreen behavior remains unknown for normal visible execution, and final beta acceptance remains owned by Main/human review.
