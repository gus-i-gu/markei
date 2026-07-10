# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register — recovery baseline
> Authority: Didactic Chat [A], reconciled through Main reference
> Recovery sources: `DEV_STAGE/B_DIDACTIC.md` and `[M]_STAGE/J_[M]_STAGE.md`
> Scope: Stable concepts evidenced by the contemporary Markei repository
> Observational history: intentionally excluded until checkpoint completion

---

# Foundational Computer Science

## &&&01

### Responsibility Boundary

#### Description
A responsibility boundary identifies which part of a system is expected to know, decide, or perform a particular kind of work. Clear boundaries prevent presentation, business rules, persistence, and infrastructure from silently becoming mixed together.

#### Formal Definition
A responsibility boundary is an explicit allocation of knowledge and behavior to a component or layer, together with constraints on which responsibilities belong elsewhere.

#### Practical Example
A screen may collect user input and display results, while a service validates the input and a repository stores it. The screen should not also contain database queries simply because it initiated the action.

#### Language Implementation
In Python, responsibility boundaries appear through modules, packages, classes, imports, method calls, abstract interfaces, and naming conventions. They are enforced partly by structure and partly by discipline.

#### Project Implementation
Markei currently expresses this chain:

```text
Desktop presentation
→ ProductService
→ Repository
→ Database manager
→ SQLite
```

Desktop code renders widgets and collects input. `ProductService` owns workflows, calculations, settings interpretation, and service projections. `Repository` owns SQL and row mapping. `app.core.database` owns connection configuration, initialization, migration, and database paths.

#### Required Concepts
None.

#### Related Concepts
`&&&02`, `&&&03`, `&%%01`, `&%%02`, `&%%03`.

#### Status
Yellow.

#### Source
Reconciled dependency and responsibility spine in `B_DIDACTIC.md` and `J_[M]_STAGE.md`.

---

## &&&02

### Raw Data Versus Derived Data

#### Description
Applications handle both source facts and values calculated from those facts. A prediction, status, label, aggregate, or cached summary does not have the same evidential role as the records from which it was produced.

#### Formal Definition
Raw data is information directly entered, observed, imported, or retrieved as a source fact. Derived data is information produced through calculation, aggregation, filtering, grouping, formatting, prediction, or business interpretation.

#### Practical Example
A purchase recorded from a receipt is a source event. An expected next-purchase date or inventory status is derived from purchase history.

#### Language Implementation
In Python, raw and derived values may both appear as dataclass fields or dictionary keys. Their distinction must therefore be preserved through naming, ownership, construction rules, persistence decisions, and recalculation behavior.

#### Project Implementation
In Markei, `Purchase` records are historical receipt events. Product summary fields such as expected dates, price deltas, and calculated inventory state are derived or cached interpretations. Lists and History labels are service-produced presentation data.

#### Required Concepts
`&&&01`.

#### Related Concepts
`&&&03`, `&&&04`, `&%%02`, `&%%04`.

#### Status
Yellow.

#### Source
Reconciled Product/Purchase model and service read-model boundary.

---

## &&&03

### Naming as Data Contract

#### Description
Names communicate meaning between layers. A field name, settings key, method name, or read-model key tells another component what value it receives and how that value should be interpreted.

#### Formal Definition
Naming as a data contract is the use of stable, precise, responsibility-aware names to define the expected meaning and shape of information exchanged between components.

#### Practical Example
`product_name`, `expected_next_purchase`, `quantity_label`, and `history.week_boundary` describe different meanings even when some are represented as strings.

#### Language Implementation
In Python, naming contracts appear in dataclass attributes, function signatures, keyword arguments, dictionary keys, constants, imported symbols, and settings keys. Untyped dictionaries make naming especially important because keys become runtime contracts.

#### Project Implementation
Markei carries names across:

```text
SQLite column
→ repository mapping
→ domain model or service projection
→ desktop rendering
```

Examples include `product_name`, persisted settings keys, and Lists projection keys such as `remaining_label`, `status`, and `status_label`.

#### Required Concepts
`&&&01`.

#### Related Concepts
`&&&02`, `&&%02`, `&%%04`.

#### Status
Yellow.

#### Source
Reconciled schema/model/repository/service/UI naming chain.

---

## &&&04

### Resource Ownership and Lifetime

#### Description
Resources such as database connections must have an identifiable owner and a defined lifetime. Creating a resource and being able to close it are different from proving that the whole application closes it at the correct moment.

#### Formal Definition
Resource ownership is the assignment of responsibility for creating, using, sharing, and releasing a finite runtime resource. Resource lifetime is the interval during which that resource remains valid and retained.

#### Practical Example
A repository may open a database connection and expose `close()`, while a composition object must still determine when all repositories should be closed during application shutdown.

#### Language Implementation
In Python, ownership and lifetime may be expressed through constructors, context managers, `close()` methods, `try/finally`, dependency injection, application shutdown hooks, and object composition.

#### Project Implementation
Each principal Markei desktop page constructs a `ProductService`; each service constructs a `Repository`; each repository owns one SQLite connection and cursor. Local close capability exists, but one application-level shutdown owner is not yet established. This is taught as a current ownership structure and unresolved lifecycle question, not as a proven runtime leak.

#### Required Concepts
`&&&01`.

#### Related Concepts
`&&%03`, `&%%03`, `%%%02`.

#### Status
Red.

#### Source
Main reconciliation of page-owned services, repository connections, and shutdown responsibility.

---

# Python Language Concepts

## &&%01

### Package and Module Boundary

#### Description
A module groups Python definitions in one file. A package groups related modules under a shared import namespace. File placement helps communicate responsibility but does not automatically enforce architectural correctness.

#### Formal Definition
A Python module is an importable unit normally represented by one `.py` file. A Python package is an importable namespace containing related modules and optionally subpackages.

#### Practical Example
A package may place business services, persistence adapters, and models together while still requiring each module to retain a distinct responsibility.

#### Language Implementation
Python boundaries appear through directories, `__init__.py` package markers where applicable, absolute or relative imports, module-level names, and the import graph.

#### Project Implementation
Markei uses:

```text
app/core/
app/database/
app/desktop/
```

`app/core` contains several internal responsibilities rather than one homogeneous layer. `app/database` contains SQL resources. `app/desktop` contains PySide6 presentation code.

#### Required Concepts
`&&&01`.

#### Related Concepts
`&&%02`, `&%%01`, `&%%03`.

#### Status
Yellow.

#### Source
Confirmed repository topography in the Main reconciliation reference.

---

## &&%02

### Dataclass as Structured Data Carrier

#### Description
A dataclass provides a concise way to define objects whose main role is to carry named data. It does not, by itself, determine whether the object is a domain entity, database row, command, or view model.

#### Formal Definition
A Python dataclass is a class declaration enhanced by generated methods for initialized fields, representation, comparison, and related data-oriented behavior.

#### Practical Example
A purchase object can carry a product ID, date, quantity, price, and notes without owning SQL statements or the full purchase-registration workflow.

#### Language Implementation
Python uses `@dataclass` and typed fields. `slots=True` restricts instances to declared attributes and can reduce accidental attribute creation.

#### Project Implementation
Markei defines `Category`, `Store`, `Product`, and `Purchase` as slotted dataclasses. They carry application data across layers while SQL remains in `Repository` and workflows remain in `ProductService`.

#### Required Concepts
`&&&01`, `&&&03`.

#### Related Concepts
`&&&02`, `&%%04`.

#### Status
Yellow.

#### Source
Current `app/core/models.py` and reconciled domain-entity interpretation.

---

## &&%03

### Context Manager and Deterministic Cleanup

#### Description
A context manager ties resource acquisition and release to a visible lexical scope. It is one way to make cleanup deterministic, although long-lived application resources may require composition-level lifecycle handling instead.

#### Formal Definition
A context manager is a Python object implementing the context-management protocol so setup occurs on entry and cleanup occurs on exit, including exceptional exit.

#### Practical Example
A short database operation can open a repository inside a `with` block and guarantee closure when the block ends. A desktop application may instead hold repositories for the application session and close them during shutdown.

#### Language Implementation
Python uses `with`, `__enter__`, and `__exit__`, along with `try/finally` and explicit `close()` methods for other cleanup patterns.

#### Project Implementation
Markei repositories and services expose explicit closure behavior, and the repository supports lifecycle ownership. The current desktop composition still requires validation and a design decision about which object owns final shutdown.

#### Required Concepts
`&&&04`.

#### Related Concepts
`%%%02`, `&%%03`.

#### Status
Red.

#### Source
Reconciled cleanup capability and unresolved application-shutdown ownership.

---

# Target-File and Architecture Concepts

## &%%01

### Application Service

#### Description
An application service coordinates a user-facing use case. It applies business rules, validates inputs, calls persistence operations, and prepares results without becoming presentation code or raw database infrastructure.

#### Formal Definition
An application service is a boundary object that orchestrates domain and persistence operations to fulfill application use cases while shielding callers from lower-level implementation details.

#### Practical Example
A receipt-registration service can validate input, create or locate a product, insert a purchase, recalculate summaries, and return a result without the UI knowing SQL.

#### Language Implementation
In Python, an application service is commonly a class with methods representing use cases. It may depend on repository contracts or concrete repositories and return domain objects or projections.

#### Project Implementation
`ProductService` owns purchase and product commands, recalculation, Lists and History projections, settings interpretation, store management, and product-detail projections. It currently functions as a broad application facade despite its narrower name.

#### Required Concepts
`&&&01`, `&&%01`.

#### Related Concepts
`&%%02`, `&%%04`.

#### Status
Yellow.

#### Source
Reconciled ProductService responsibility inventory.

---

## &%%02

### Repository Pattern and Persistence Adapter

#### Description
A repository gives application code a controlled way to retrieve and persist data without exposing SQL details to every caller. It is not the database itself and should not own business interpretation merely because it accesses stored facts.

#### Formal Definition
A repository is a persistence abstraction that translates application-oriented operations into storage operations and maps storage representations to application representations.

#### Practical Example
A service asks for purchases of a product. The repository executes the query and returns mapped results; the service decides how those purchases affect inventory status.

#### Language Implementation
In Python, a repository may be a class containing parameterized SQL statements, cursor execution, transaction calls, and row-to-object mapping methods.

#### Project Implementation
Markei's `Repository` is a broad SQLite persistence facade for products, purchases, categories, stores, settings, and related query projections. It owns SQL, mappings, one connection, one cursor, and individual commits. Connection configuration and migration remain delegated to `app.core.database`.

#### Required Concepts
`&&&01`, `&&&02`, `&%%01`.

#### Related Concepts
`%%%02`, `%%%03`, `&%%05`.

#### Status
Yellow.

#### Source
Current repository implementation and Main reconciliation.

---

## &%%03

### Presentation Adapter

#### Description
A presentation adapter translates user interaction into application-service calls and translates service results into platform-specific rendering. It should not become the owner of SQL or business calculations.

#### Formal Definition
A presentation adapter is a component that converts platform-specific input and output into calls and representations understood by the application boundary.

#### Practical Example
A desktop page reads widget values, calls a service, receives a prepared result, and renders rows or messages.

#### Language Implementation
In PySide6, this appears through widgets, layouts, signals, slots, event handlers, dialogs, and calls to service methods.

#### Project Implementation
`app/desktop` contains `MainWindow`, page widgets, and `ProductDetailPanel`. Pages call `ProductService` rather than `Repository` or SQLite. `MainWindow` coordinates tabs, navigation, edit routing, and page refreshes.

#### Required Concepts
`&&&01`, `&&%01`, `&%%01`.

#### Related Concepts
`&%%04`, `%%%04`.

#### Status
Yellow.

#### Source
Reconciled desktop composition and page responsibilities.

---

## &%%04

### Database Row, Domain Model, and View Model

#### Description
The same underlying information may appear in several representations, each shaped for a different responsibility. A database row, domain model, and view model should not be treated as interchangeable merely because they contain overlapping fields.

#### Formal Definition
A database row is a persistence representation, a domain model is an application entity representation, and a view model is a use-case-specific presentation representation prepared for rendering.

#### Practical Example
A database row may contain stored numeric values, a Product object may expose application state, and a Lists row may contain formatted labels and status text for a table.

#### Language Implementation
Python may represent rows as `sqlite3.Row`, domain models as dataclasses, and view models as dictionaries, dataclasses, TypedDicts, or other boundary objects.

#### Project Implementation
Markei currently uses:

```text
sqlite3.Row
→ repository mapping
→ Product/Purchase or raw projection
→ ProductService dictionary projection
→ Qt widgets
```

Lists, History, analytics, and product-detail surfaces consume dictionary-based projections. These are platform-neutral but untyped. Whether they should become explicit typed objects remains unresolved and is not canonically prescribed here.

#### Required Concepts
`&&&02`, `&&&03`, `&&%02`, `&%%01`.

#### Related Concepts
`&%%03`, `%%%03`.

#### Status
Yellow.

#### Source
Main reconciliation of the current view-model boundary.

---

## &%%05

### Statement Atomicity Versus Workflow Atomicity

#### Description
A single database statement may complete atomically while a larger business workflow remains non-atomic if several statements commit separately. This distinction matters when an operation includes multiple dependent changes.

#### Formal Definition
Statement atomicity is the all-or-nothing execution of one database statement. Workflow atomicity is the all-or-nothing execution of an entire multi-step application use case within one transaction boundary.

#### Practical Example
Creating a product, inserting a purchase, and recalculating a summary may each succeed independently. If each step commits separately, failure in a later step can leave an earlier change persisted.

#### Language Implementation
Python's SQLite integration controls workflow atomicity through transaction boundaries, connection commits, rollbacks, context managers, and repository/service coordination.

#### Project Implementation
Markei repository mutation methods commit individually. Receipt registration and purchase deletion with recalculation are multi-commit workflows and therefore not transactionally atomic as complete use cases. Whether to introduce a workflow transaction boundary remains a design decision.

#### Required Concepts
`&&&01`, `&%%01`, `&%%02`.

#### Related Concepts
`%%%02`.

#### Status
Red.

#### Source
Main source verification resolving the receipt-workflow atomicity conflict.

---

# Packages, Dependencies, and SQLite Concepts

## %%%01

### SQLite Initialization Versus Migration

#### Description
Initialization and migration solve different persistence-lifecycle problems. Initialization creates a new database state. Migration changes an existing database while preserving compatible user data.

#### Formal Definition
Database initialization creates a fresh persistence structure from a baseline schema. Database migration transforms an existing persistence structure toward a newer expected form.

#### Practical Example
A first launch creates tables from `schema.sql`. A later launch adds a missing column or default settings row without deleting existing purchases.

#### Language Implementation
Python may initialize through `sqlite3.connect()` and `executescript()`. Migration may use schema inspection, conditional DDL, idempotent inserts, and explicit commits.

#### Project Implementation
Markei initialization creates the user-data directory, preserves an existing database unless recreation is requested, executes `schema.sql`, optionally executes `seed.sql`, commits, and closes. Existing connections run additive compatibility migration using checks such as `PRAGMA table_info`, conditional columns, table creation, and `INSERT OR IGNORE` defaults. No numbered migration ledger currently exists.

#### Required Concepts
`&&&01`, `&%%02`.

#### Related Concepts
`%%%02`, `%%%03`.

#### Status
Yellow.

#### Source
Reconciled database lifecycle.

---

## %%%02

### SQLite Connection and Cursor Ownership

#### Description
A connection represents an active session with SQLite. A cursor executes statements and reads results through that connection. Their ownership determines transaction scope, lifetime, configuration, and cleanup.

#### Formal Definition
A SQLite connection is the Python runtime object that owns database-session state and transaction context. A cursor is a connection-bound execution interface for SQL statements and result traversal.

#### Practical Example
One repository can hold one connection and cursor for repeated operations. Several repositories can therefore create several independent database sessions.

#### Language Implementation
Python uses `sqlite3.Connection` and `sqlite3.Cursor`. Connections configure row factories and PRAGMAs, create cursors, commit or roll back transactions, and must eventually close.

#### Project Implementation
Each Markei `Repository` opens one configured connection and cursor. Because four principal pages construct their own services and repositories, normal MainWindow composition creates four long-lived connections. WAL is enabled, but application-wide shutdown ownership remains unresolved and requires validation.

#### Required Concepts
`&&&04`, `&%%02`.

#### Related Concepts
`&&%03`, `%%%03`, `&%%05`.

#### Status
Red.

#### Source
Main conflict resolution on service and connection count.

---

## %%%03

### SQLite PRAGMA and Connection Configuration

#### Description
SQLite behavior is partly configured per connection. Database integrity, journaling, durability/performance, and row representation are separate concerns even when configured in one function.

#### Formal Definition
SQLite PRAGMA statements are special commands used to inspect or modify SQLite metadata and connection/database behavior. Connection configuration is the centralized application of required settings to each new connection.

#### Practical Example
Foreign-key enforcement can be enabled, WAL journaling selected, synchronous behavior adjusted, and named row access configured whenever a connection opens.

#### Language Implementation
Python executes PRAGMA statements through `sqlite3.Connection.execute()` or cursors. `connection.row_factory = sqlite3.Row` changes returned row representation.

#### Project Implementation
Every Markei connection obtained through the database manager applies:

```text
PRAGMA foreign_keys = ON
PRAGMA journal_mode = WAL
PRAGMA synchronous = NORMAL
row_factory = sqlite3.Row
```

These settings support referential enforcement, journaling behavior, a durability/performance trade-off, and name-based row access.

#### Required Concepts
`%%%02`.

#### Related Concepts
`%%%01`, `&%%02`, `&%%04`.

#### Status
Yellow.

#### Source
Confirmed connection configuration in the Main reconciliation reference.

---

## %%%04

### Relational Schema and Referential Integrity

#### Description
A relational schema defines tables, columns, keys, and relationships. Referential integrity ensures that references between records remain valid according to declared rules.

#### Formal Definition
A relational schema is the structural specification of relations and constraints in a database. Referential integrity is the requirement that foreign-key values correspond to valid referenced records or permitted null states.

#### Practical Example
A purchase references a product. Deleting the product may be prohibited, detached, or cascaded according to the declared foreign-key action.

#### Language Implementation
SQLite expresses schemas through `CREATE TABLE`, primary keys, foreign keys, indexes, nullability, and `ON UPDATE` or `ON DELETE` actions.

#### Project Implementation
Markei defines `categories`, `products`, `stores`, `purchases`, `settings`, and `promotions`. The main relationship spine is Category-to-Product, Product-to-Purchase, Store-to-Purchase, and Product/Store-to-Promotion. `purchases.product_id` uses update and delete cascades. Other relationships do not all declare equivalent actions.

#### Required Concepts
`&&&01`, `&%%02`.

#### Related Concepts
`%%%01`, `%%%03`.

#### Status
Yellow.

#### Source
Confirmed current SQL schema and Main reconciliation.

---

## %%%05

### Bundled Resource Versus Writable User Data

#### Description
Application resources distributed with the program and user-created mutable data have different lifecycles. Replaceable program files should not be confused with persistent user state.

#### Formal Definition
A bundled resource is a version-controlled file supplied with the application runtime. Writable user data is mutable state created or modified during use and expected to persist independently of application installation files.

#### Practical Example
A schema script can be bundled with the application, while the user's database belongs in a writable per-user directory.

#### Language Implementation
Python commonly resolves resource paths using `pathlib`, frozen-runtime indicators, and packaging paths, while user data paths use environment variables or platform-specific directories.

#### Project Implementation
Markei treats `app/database/schema.sql` and `seed.sql` as bundled resources and stores `market.sqlite` under `%LOCALAPPDATA%/Markei`, with a home-directory fallback. Frozen execution is supported through `sys.frozen` and `_MEIPASS` lookup. Packaged-resource inclusion and installer lifecycle preservation remain operational validation questions.

#### Required Concepts
`&&&04`, `%%%01`.

#### Related Concepts
`&&%01`.

#### Status
Yellow.

#### Source
Reconciled resource and writable-state separation.

---

# Canonical Recovery Notes

This register contains only concepts supported by the current implementation and the exact Main recovery reconciliation reference.

The following remain intentionally non-canonical decisions:

- whether page-local services are the desired final lifecycle model;
- which composition object should own shutdown;
- whether complete workflow transactions are required;
- whether `ProductService` or `Repository` should be decomposed;
- whether contracts should become complete substitutable interfaces;
- whether dictionary view models should become typed objects;
- whether migration should adopt a numbered version ledger;
- whether the promotions table and `pages.order` are active, dormant, or stale;
- whether packaged resources and installer lifecycle are fully validated.

These unresolved matters may appear later in the checkpoint as active or unstable concepts, but they do not define accepted solutions in canonical didactic knowledge.
