# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register — Cycle 06
> Authority: Didactic Chat [A], reconciled through Main reference
> Reconciliation sources: `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/E_DDC_STAGE.md`, `DEV_STAGE/H_DDC_CODEX.md`, `DEV_STAGE/G_OPS_CODEX.md`, and `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Stable concepts evidenced by the contemporary Markei repository

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
Markei separates desktop presentation, `ProductService`, `Repository`, database lifecycle, packaging collection, installer placement, validation evidence, and Main/human acceptance.
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
Markei carries stable data names across SQLite, mappings, models, projections, and UI; Cycle 06 also uses exact evidence-state vocabulary.
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
Resource ownership assigns creation, use, sharing, and release responsibility; lifetime is the interval during which the resource remains retained and valid.
#### Practical Example
A repository owns a database connection, while the application composition must determine when all repositories close.
#### Language Implementation
Python expresses lifetime through constructors, `close()`, context managers, `try/finally`, event hooks, and composition.
#### Project Implementation
Markei creates four page-owned service/repository chains. Cycle 06 validation initially found retained SQLite access; a bounded, idempotent `MainWindow.closeEvent()` coordinator then closed all four services and the focused source/frozen gate passed.
#### Required Concepts
`&&&01`.
#### Related Concepts
`&&%03`, `&&&05`, `%%%02`, `&%%06`.
#### Status
Red.
#### Source
Cycle 06 shutdown failure, correction, and rerun evidence.

---

## &&&05
### Evidence State and Validation Boundary
#### Description
A claim is limited by the strongest evidence actually obtained. Configuration, artifact creation, execution, deployment, validation, and acceptance are distinct states.
#### Formal Definition
An evidence state records what has been demonstrated; a validation boundary identifies the exact environment, lifecycle stage, conditions, and behavior covered by that evidence. Evidence from an earlier state cannot prove a later state.
#### Practical Example
An installer source file proves installer configuration, not that an installer executable was compiled, installed, or accepted.
#### Language Implementation
Projects encode evidence through test results, command exits, artifact inspection, hashes, logs, status enums, reports, and explicit acceptance decisions.
#### Project Implementation
Cycle 06 currently supports `configured: yes`, `built: yes`, `launched: yes — frozen`, `installed: blocked`, `validated: partial`, and `accepted: no`. Shutdown validation first failed, justified a bounded correction, and passed on rerun; installed shutdown remains outside that boundary.
#### Required Concepts
`&&&01`, `&&&02`, `&&&03`.
#### Related Concepts
`&&%04`, `&%%06`, `%%%06`, `&&&04`.
#### Status
Red.
#### Source
Main Cycle 06 reconciliation plus G/H evidence.

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
Repositories and services expose close behavior. Cycle 06 added an idempotent `MainWindow.closeEvent()` cleanup path after focused evidence demonstrated the previous close path retained the isolated database.
#### Required Concepts
`&&&04`.
#### Related Concepts
`&&&05`, `%%%02`, `&%%06`.
#### Status
Red.
#### Source
Cycle 06 shutdown validation and bounded correction.

---

## &&%04
### Source, Frozen, and Installed Execution Context
#### Description
The same application can run from repository source, from a collected executable distribution, or from an installer-placed distribution. These contexts share business architecture but differ operationally.
#### Formal Definition
Source execution runs modules and resources through a development interpreter; frozen execution runs collected code and resources through a generated executable; installed execution runs the frozen runtime after installer-controlled placement, registration, and launch-path creation.
#### Practical Example
`python main.py`, `dist/Markei/Markei.exe`, and a Start Menu shortcut may start the same application through different resource and dependency contexts.
#### Language Implementation
Python applications distinguish contexts using entrypoints, `sys.frozen`, `_MEIPASS`, resource resolution, collected dependencies, and platform-specific writable paths.
#### Project Implementation
Markei source and frozen execution are evidenced. The frozen executable launched twice using isolated external user data. `installer/Markei.iss` defines installed placement and shortcuts, but no compiled installer or installed launch exists yet.
#### Required Concepts
`&&&01`, `&&%01`, `%%%05`.
#### Related Concepts
`&&&05`, `&%%06`, `%%%06`.
#### Status
Red.
#### Source
Cycle 06 release configuration and frozen-launch evidence.

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
Markei pages call `ProductService`; `MainWindow` coordinates tabs, navigation, refresh, and now final page-service cleanup.
#### Required Concepts
`&&&01`, `&&%01`, `&%%01`.
#### Related Concepts
`&&&04`, `&&%03`, `&%%04`.
#### Status
Yellow.
#### Source
Current desktop composition.

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
Markei maps rows into models or projections, then services prepare dictionaries consumed by Qt widgets.
#### Required Concepts
`&&&02`, `&&&03`, `&&%02`, `&%%01`.
#### Related Concepts
`&%%03`, `%%%03`.
#### Status
Yellow.
#### Source
Current mapping and projection boundary.

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
Markei receipt registration and deletion/recalculation remain multi-commit workflows. This is inherited validation debt, not a packaging concept or a proven beta failure.
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
A release artifact lifecycle transforms source configuration into a frozen distribution, installer configuration into a compiled installer, and that installer into an installed application whose upgrade, uninstall, reinstall, and retained-data behavior require separate validation.
#### Practical Example
A `.spec` file is not an executable; an executable directory is not an installer; an installer source is not a compiled setup program; an installed program is not automatically lifecycle-validated.
#### Language Implementation
Projects use packaging specifications, build wrappers, generated distribution directories, installer definitions, compiler outputs, installation metadata, and lifecycle tests.
#### Project Implementation
`Markei.spec` and `scripts/build_windows.ps1` produced `dist/Markei/Markei.exe`. `installer/Markei.iss` and `scripts/build_installer.ps1` configure the next transformation, but missing `ISCC.exe` blocked the compiled installer and all installed lifecycle gates.
#### Required Concepts
`&&&01`, `&&&04`, `&&%04`, `%%%05`.
#### Related Concepts
`&&&05`, `%%%06`.
#### Status
Red.
#### Source
Cycle 06 build, artifact, installer-blocker, and Main reconciliation evidence.

---

# Packages, Dependencies, and SQLite Concepts

## %%%01
### SQLite Initialization Versus Migration
#### Description
Initialization creates a new database; migration changes an existing database while preserving compatible user state. Seeding is a third operation that inserts initial rows.
#### Formal Definition
Initialization establishes baseline persistence, migration transforms existing persistence, and seeding inserts predefined records into an initialized structure.
#### Practical Example
A first launch creates tables; a later launch adds a missing column; optional fixtures insert sample rows.
#### Language Implementation
Python may use `connect`, `executescript`, schema inspection, conditional DDL, idempotent inserts, and commits.
#### Project Implementation
Markei production packaging includes `schema.sql` but excludes `seed.sql`; fresh production launch therefore creates structure and defaults without sample business rows. Additive compatibility migration still runs for existing data.
#### Required Concepts
`&&&01`, `&%%02`.
#### Related Concepts
`%%%02`, `%%%03`, `%%%05`, `&&&05`.
#### Status
Yellow.
#### Source
Current database lifecycle and Cycle 06 schema-only evidence.

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
Each Markei repository opens one connection and cursor. The four page-owned chains are now closed through the validated `MainWindow` close coordinator in the focused source/frozen gate; installed behavior remains untested.
#### Required Concepts
`&&&04`, `&%%02`.
#### Related Concepts
`&&%03`, `&&&05`, `%%%03`, `&%%05`.
#### Status
Red.
#### Source
Current ownership structure and Cycle 06 shutdown evidence.

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
Markei defines categories, products, stores, purchases, settings, and promotions with explicit relationships.
#### Required Concepts
`&&&01`, `&%%02`.
#### Related Concepts
`%%%01`, `%%%03`.
#### Status
Yellow.
#### Source
Current SQL schema.

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
Python resolves source/frozen resources with paths and runtime indicators, while user data uses platform directories or environment variables.
#### Project Implementation
For the primary beta, `schema.sql` is bundled, `seed.sql` is a development/test fixture excluded from production, `market.sqlite` is retained writable state, WAL/SHM are transient companions, and `startup.log` is writable diagnostics under `%LOCALAPPDATA%/Markei`. External placement supports preservation but does not validate uninstall retention.
#### Required Concepts
`&&&04`, `%%%01`.
#### Related Concepts
`&&%01`, `&&%04`, `&%%06`.
#### Status
Yellow.
#### Source
Cycle 06 package inspection, startup diagnostics, and installer configuration.

---

## %%%06
### Build-Time, Runtime, and Installer-Time Dependency
#### Description
Dependencies belong to different lifecycle stages and must not be treated as one undifferentiated requirement set.
#### Formal Definition
A build-time dependency is required to produce a frozen artifact; a runtime dependency is required by the executing application and may be collected into or placed beside it; an installer-time dependency is required to compile or run installation tooling.
#### Practical Example
A packaging tool may be needed only on the builder, collected GUI libraries are needed by the executable, and an installer compiler is needed only to produce setup media.
#### Language Implementation
Projects separate dependency manifests, build commands, collected modules/native libraries, and external compiler discovery.
#### Project Implementation
Cycle 06 recorded PyInstaller 6.21.0 and PySide6 6.11.1 in `requirements-build.txt`. PyInstaller produced the one-folder runtime; collected PySide6/Qt components support execution; Inno Setup's `ISCC.exe` is an installer-time prerequisite whose absence blocked installer compilation without invalidating the frozen build.
#### Required Concepts
`&&%01`, `&&%04`, `&%%06`.
#### Related Concepts
`&&&05`, `%%%05`.
#### Status
Red.
#### Source
Cycle 06 dependency record, successful frozen build, and installer-time blocker.

---

# Canonical Boundary

The four Cycle 06 additions — `&&&05`, `&&%04`, `&%%06`, and `%%%06` — are canonical **Red** concepts. They are supported as teachable distinctions but have not been demonstrated as learner mastery.

The register does not claim that a compiled installer exists, that installed execution has occurred, that uninstall retention is validated, or that the beta is accepted. Tool names remain project examples rather than standalone concepts. Existing architecture, migration, transaction, and packaging decisions remain owned by their proper project domains.