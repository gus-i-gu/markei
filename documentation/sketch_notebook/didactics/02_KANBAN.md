# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register
> Last absorbed evidence: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
> Current cycle: Cycle 02 — History + Settings

---

## &&&01

### Domain Model Field Semantics

#### Description
A domain field is not only a storage slot. It carries a specific project meaning. Two fields may share a technical type while representing different concepts.

#### Formal Definition
Domain model field semantics are the meaning and responsibility assigned to a named model field within a domain, independent of its raw data type.

#### Practical Example
Two day-count fields may both store integers, but one may describe how often something is bought while another describes how long it lasts before expiration.

#### Language Implementation
In Python, field semantics appear through class attributes, dataclass fields, function parameters, dictionary keys, and returned read-model keys.

#### Project Implementation
In Markei, `average_duration_days` means purchase-to-purchase rhythm, while `average_shelf_life_days` means purchase-to-expiration rhythm. In Cycle 02, field semantics also protect History names such as `purchase_date`, `total_price`, `unit_price`, and settings keys.

#### Required Concepts
None.

#### Related Concepts
&&&02, &&&03, &&&04, &&&07, &%%01, &%%05.

#### Status
Yellow.

#### Source
Product View and History/Settings materialization evidence in `H_DDC_CODEX.md`.

---

## &&&02

### Raw Data Versus Derived Data

#### Description
Programs often handle both facts that were directly entered or observed and values calculated from those facts. Learning the difference prevents accidental overwriting of evidence with predictions.

#### Formal Definition
Raw data is directly entered, observed, or imported information. Derived data is produced by applying rules, calculations, aggregation, or prediction to other data.

#### Practical Example
A receipt row is raw history. A monthly total, average unit price, or expected expiration date is derived from raw records.

#### Language Implementation
In Python, raw and derived values may both appear as attributes or dictionary keys, so naming and service boundaries must explain which values are source facts and which are calculations.

#### Project Implementation
In Markei, `Purchase.expiration_date` and purchase rows are raw data. `Product.average_shelf_life_days`, `Product.expected_expiration_date`, History sections, store totals, and average unit prices are derived data.

#### Required Concepts
&&&01.

#### Related Concepts
&&&04, &&&06, &%%02, &%%05, &%%08.

#### Status
Yellow.

#### Source
Cycle 01 Product View evidence and Cycle 02 History evidence separating purchase rows from derived sections and totals.

---

## &&&03

### Naming as Data Contract

#### Description
A name is a contract between layers. Precise names preserve meaning as data moves through schema, models, repositories, services, and UI.

#### Formal Definition
Naming as a data contract is the use of stable, precise names to define the expected meaning, shape, and responsibility of data exchanged between program components.

#### Practical Example
`purchase_date`, `week_boundary`, `month_boundary`, `total_price`, and `average_unit_price` should each identify a distinct meaning.

#### Language Implementation
In Python, this contract appears in dataclass fields, row-mapping keys, service return dictionaries, settings keys, and UI display labels.

#### Project Implementation
Markei preserves explicit naming across repository rows, service read models, settings keys, and UI rendering. Cycle 02 extends the contract to History grouping and settings values.

#### Required Concepts
&&&01.

#### Related Concepts
&&&02, &&&07, &&%01, &%%03, &%%05, &%%06.

#### Status
Yellow.

#### Source
Cycle 01 naming evidence and Cycle 02 explicit row/settings keys.

---

## &&&04

### Cached Summary Field

#### Description
A cached summary field stores a value that summarizes other records. It can make display and workflow easier, but it must not be confused with the source records it summarizes.

#### Formal Definition
A cached summary field is a persisted or retained value calculated from other data and kept as a summary for later access, display, or prediction.

#### Practical Example
A product-level expected expiration date may summarize historical purchase rows, but it is not itself the actual expiration date of every purchase.

#### Language Implementation
In Python, cached summaries may appear as dataclass attributes or service-return fields and should be recalculated by the responsible workflow layer.

#### Project Implementation
In Markei, `expected_expiration_date` is a product summary field. History Total rows are derived display aggregates and should not be treated as cached summaries unless a future design explicitly persists them.

#### Required Concepts
&&&02.

#### Related Concepts
&&&06, &%%02, &%%04, &%%05, %%%01.

#### Status
Yellow.

#### Source
Cycle 01 expected-expiration evidence and Cycle 02 contrast with History aggregate rows.

---

## &&&05

### Time Bucketing

#### Description
Time bucketing assigns dated events into named periods using boundary rules. The boundary rule may differ from ordinary calendar expectations.

#### Formal Definition
Time bucketing is the classification of temporal records into discrete periods according to explicit start/end boundary rules.

#### Practical Example
If Wednesday starts the week, a Tuesday purchase belongs to the previous operational week and a Wednesday purchase begins the next operational week.

#### Language Implementation
In Python, time bucketing usually uses `date` or `datetime` parsing, weekday checks, date arithmetic, and inclusive/exclusive range decisions.

#### Project Implementation
In Markei History, the first Wednesday defines operational month start, every Wednesday starts the operational week, and purchases before the first Wednesday are assigned to the previous operational month.

#### Required Concepts
&&&01, &&&03, &&%03.

#### Related Concepts
&&&07, &%%05, &%%08.

#### Status
Red.

#### Source
Cycle 02 History grouping evidence in `H_DDC_CODEX.md`.

---

## &&&06

### Aggregation and Totals

#### Description
Aggregation combines multiple records into a summary value. Totals are derived data and must not be confused with the individual records used to calculate them.

#### Formal Definition
Aggregation is the derivation of summary values from a collection of records using operations such as sum, mean, grouping, or counting.

#### Practical Example
A store total can sum all purchase `total_price` values in a week while average unit price computes the mean of unit prices.

#### Language Implementation
In Python, aggregation may use loops, dictionaries keyed by group, accumulators, decimal arithmetic, and explicit handling for incompatible units.

#### Project Implementation
In Markei History, monetary totals sum stored `total_price`, average unit price is a mean over `unit_price`, quantity totals are grouped by unit, and store totals are grouped by store label.

#### Required Concepts
&&&02.

#### Related Concepts
&&&04, &&&07, &%%05, &%%08.

#### Status
Red.

#### Source
Cycle 02 aggregation and Total-row evidence in `H_DDC_CODEX.md`.

---

## &&&07

### Grouping Versus Sorting

#### Description
Grouping and sorting are different operations. Sorting decides sequence. Grouping decides membership in categories or buckets.

#### Formal Definition
Sorting orders records according to comparison criteria, while grouping partitions records into collections based on shared keys or computed membership rules.

#### Practical Example
Purchases can be sorted by date and ID, then grouped into operational weeks. The order does not itself decide which week a purchase belongs to.

#### Language Implementation
In Python, sorting commonly uses `sorted(..., key=...)`; grouping may use dictionaries, `itertools.groupby`, or service-built nested structures.

#### Project Implementation
In Markei History, purchases are sorted chronologically by parsed purchase date and ID, then grouped into operational month and week sections by service rules.

#### Required Concepts
&&&01, &&&03.

#### Related Concepts
&&&05, &&&06, &%%05, &%%08.

#### Status
Red.

#### Source
Cycle 02 grouping-versus-sorting evidence in `H_DDC_CODEX.md`.

---

## &&&08

### Configuration State

#### Description
Configuration state stores user or application choices that affect later behavior. It is not the behavior itself; it is input interpreted by the responsible service or workflow.

#### Formal Definition
Configuration state is persisted application preference data used to parameterize future application behavior across sessions.

#### Practical Example
A saved setting saying the week starts on Wednesday changes how future purchases are bucketed, but the setting does not itself perform the grouping.

#### Language Implementation
In Python, configuration state may be represented as dictionaries, dataclasses, service return values, or parsed key/value records.

#### Project Implementation
In Markei, Settings persists page sorting choices and History time-reference values; History services later read those values to interpret grouping and bucketing rules.

#### Required Concepts
&&&03.

#### Related Concepts
&%%06, %%%04.

#### Status
Red.

#### Source
Cycle 02 Settings/configuration evidence in `H_DDC_CODEX.md`.

---

## &&%01

### Optional Values and Nullable Fields

#### Description
Some valid records do not have every value yet. Optional and nullable fields teach the learner that absence can be meaningful data rather than an error.

#### Formal Definition
An optional value is a language-level value that may be present or absent. A nullable database field is a persistent field that may contain no value.

#### Practical Example
A product may have no store address or expiration date yet, so the application should render a placeholder instead of failing.

#### Language Implementation
In Python, optional model fields are commonly represented with `Optional[...]` type hints and `None` values.

#### Project Implementation
In Markei, `Product`, `Purchase`, and `Store` support optional fields compatible with existing records. Settings defaults also require safe behavior when a user has not customized a value.

#### Required Concepts
&&&02.

#### Related Concepts
&&%02, &&%03, %%%01, &%%03, &%%06.

#### Status
Yellow.

#### Source
Cycle 01 nullable model-field evolution and Cycle 02 configuration defaults.

---

## &&%02

### Dataclass Field Evolution

#### Description
Python dataclasses evolve when the domain model becomes clearer. Adding fields is not only syntax; it changes what the model can express.

#### Formal Definition
Dataclass field evolution is the controlled change of Python dataclass fields, defaults, and optionality as the domain model matures.

#### Practical Example
A product dataclass can gain a field for average shelf life once the program needs to distinguish expiration rhythm from purchase rhythm.

#### Language Implementation
In Python, dataclasses use annotated fields and default values to define object shape and construction behavior.

#### Project Implementation
In Markei, product/store/purchase models evolved in Cycle 01; Cycle 02 may continue this learning through History read models or configuration models.

#### Required Concepts
&&&01, &&%01.

#### Related Concepts
&&&03, &%%05, &%%06, %%%01.

#### Status
Yellow.

#### Source
Cycle 01 dataclass field evolution and Cycle 02 structured History/Settings data needs.

---

## &&%03

### Date/Datetime Boundary Handling

#### Description
Date and datetime values need explicit boundary rules. Without clear rules, period membership becomes ambiguous.

#### Formal Definition
Date/datetime boundary handling is the use of language-level temporal values and arithmetic to determine period starts, period ends, ordering, and membership.

#### Practical Example
A purchase on Wednesday may be the first record of a new operational week, while a purchase on Tuesday belongs to the previous week.

#### Language Implementation
In Python, this uses date parsing, `datetime.date`, weekday calculations, comparisons, and careful inclusive/exclusive boundary checks.

#### Project Implementation
In Markei History, service tests confirmed Tuesday/Wednesday/Thursday boundary behavior around `07/07/2026`, `08/07/2026`, and `09/07/2026`.

#### Required Concepts
&&&05.

#### Related Concepts
&&&07, &%%05, &%%08.

#### Status
Red.

#### Source
Cycle 02 time-boundary evidence in `H_DDC_CODEX.md`.

---

## &%%01

### Markei Purchase Rhythm Versus Shelf-Life Rhythm

#### Description
Markei teaches two different product rhythms: the rhythm of buying and the rhythm of expiration after purchase.

#### Formal Definition
Purchase rhythm is the purchase-to-purchase interval for a product. Shelf-life rhythm is the purchase-to-expiration interval for a purchased batch or product summary.

#### Practical Example
A user may buy milk every seven days even if the milk usually expires ten days after purchase.

#### Language Implementation
In Python, these rhythms appear as separately named fields and service calculations rather than one generic duration value.

#### Project Implementation
`average_duration_days` remains tied to purchase cadence. `average_shelf_life_days` is tied to expiration cadence. `expected_next_purchase` follows purchase rhythm. `expected_expiration_date` follows shelf-life rhythm.

#### Required Concepts
&&&01, &&&02, &&&03.

#### Related Concepts
&&&04, &%%02, &%%04.

#### Status
Yellow.

#### Source
Cycle 01 Product View evidence.

---

## &%%02

### Product View Read Model

#### Description
A read model is a data shape prepared for display. It gathers the exact information a view needs without making the UI calculate domain meaning.

#### Formal Definition
A read model is an application-facing data structure optimized for reading and presentation rather than direct persistence or domain mutation.

#### Practical Example
A product-detail panel may need product identity, average price, store information, shelf-life fields, and recent purchase rows together.

#### Language Implementation
In Python, read models may be dictionaries, dataclasses, typed objects, or structured return values from service methods.

#### Project Implementation
In Markei, `ProductService` assembles explicit identity, price, shelf-life, store, and purchase-history rows for the Product View. Cycle 02 generalizes this lesson into History read models.

#### Required Concepts
&&&02, &&&03, &%%01.

#### Related Concepts
&%%03, &%%04, &%%05, %%%03.

#### Status
Yellow.

#### Source
Cycle 01 Product View read-model evidence and Cycle 02 History read-model continuation.

---

## &%%03

### Repository Result Shape

#### Description
Repository methods do not merely fetch data. They decide the named shape of data that services receive.

#### Formal Definition
Repository result shape is the structure, field names, and relationship representation returned from persistence queries into application code.

#### Practical Example
Returning `purchase_date`, `total_price`, `unit_price`, `store_name`, and `store_label` is clearer than returning unnamed tuple positions or vague labels.

#### Language Implementation
In Python, repository result shape can appear as dictionaries, row objects, dataclasses, or tuples mapped into explicit keys.

#### Project Implementation
Markei repository outputs explicit keys for Product View and History. Cycle 02 repository rows provide raw purchase/time/store facts for service grouping and aggregation.

#### Required Concepts
&&&03.

#### Related Concepts
&%%02, &%%04, &%%05, %%%01, %%%04.

#### Status
Yellow.

#### Source
Cycle 01 row-mapping evidence and Cycle 02 joined purchase/store row evidence.

---

## &%%04

### Service-Owned Calculation Responsibility

#### Description
Domain calculations should be owned by services rather than UI widgets. This keeps display code from becoming hidden business logic.

#### Formal Definition
Service-owned calculation responsibility is the principle that application services coordinate calculations, aggregation, prediction, grouping, and repository access before UI rendering.

#### Practical Example
A History page should display grouped sections and totals; it should not calculate bucket membership itself.

#### Language Implementation
In Python, this appears as service methods that call repositories, calculate or coordinate derived values, and return prepared data.

#### Project Implementation
In Markei, Product View calculations and Cycle 02 History grouping/totals are owned by services. UI renders the service read model.

#### Required Concepts
&&&02, &&&04, &%%02.

#### Related Concepts
&&&05, &&&06, &%%03, &%%05, &%%08, %%%03.

#### Status
Yellow.

#### Source
Cycle 01 responsibility evidence and Cycle 02 service grouping evidence.

---

## &%%05

### History Read Model

#### Description
The History read model is the structured display data prepared for the History UI. It contains grouped period sections, ordered purchase rows, and derived totals.

#### Formal Definition
The History read model is a Markei-specific read structure produced by services for rendering chronological and grouped purchase history without assigning calculation responsibility to the UI.

#### Practical Example
A History read model may contain an operational month, several operational weeks, purchase rows in each week, and store-level Total rows.

#### Language Implementation
In Python, the read model may be represented as nested dictionaries, dataclasses, lists of section objects, or structured service return values.

#### Project Implementation
In Markei, the History UI renders service-prepared grouped sections and Total rows based on repository purchase/time/store data and Settings time-reference rules.

#### Required Concepts
&&&02, &&&05, &&&06, &&&07, &%%03, &%%04.

#### Related Concepts
&%%02, &%%08, %%%03.

#### Status
Red.

#### Source
Cycle 02 History UI evidence in `H_DDC_CODEX.md`.

---

## &%%06

### Settings-Owned Preferences

#### Description
Settings owns editing and persistence of preferences, but not the business calculations that those preferences affect.

#### Formal Definition
Settings-owned preferences are Markei configuration values exposed and persisted through the Settings page, then interpreted by the relevant service workflows.

#### Practical Example
Settings may persist `history.week_boundary = wednesday`; History services later use that value when assigning purchases to weeks.

#### Language Implementation
In Python, settings preferences may be read as key/value rows, parsed into typed values, validated, and passed into service rules.

#### Project Implementation
In Markei, Settings persists sorting and time-reference preferences. History service reads those preferences to group purchases; Settings UI does not group History rows.

#### Required Concepts
&&&08, &&&03.

#### Related Concepts
&%%05, &%%08, %%%04.

#### Status
Red.

#### Source
Cycle 02 Settings/configuration evidence in `H_DDC_CODEX.md`.

---

## &%%07

### Store Editing Workflow

#### Description
Store editing continues the Cycle 01 store-address work by turning persisted/displayed store data into editable application data.

#### Formal Definition
The Store Editing Workflow is the Markei-specific path through which store records are shown, edited, validated, persisted, and reflected in later views.

#### Practical Example
A store address that was previously displayed as optional data can now be edited through Settings and later shown consistently in product or history views.

#### Language Implementation
In Python, the workflow coordinates UI form values, service validation/orchestration, repository updates, and optional field handling.

#### Project Implementation
In Markei, Settings exposes store editing while service/repository orchestration handles persistence. This continues Cycle 01 deferred store-address persistence/display work.

#### Required Concepts
&&%01, &%%03, &%%04.

#### Related Concepts
&%%06, %%%05.

#### Status
Red.

#### Source
Cycle 02 store editing evidence in `H_DDC_CODEX.md`.

---

## &%%08

### History Grouping Service Responsibility

#### Description
History grouping service responsibility is the Markei-specific rule that grouping, bucketing, totals, and setting interpretation belong to service logic rather than UI widgets.

#### Formal Definition
History grouping service responsibility is the assignment of History period construction, operational date boundaries, aggregate rows, and settings interpretation to the service layer.

#### Practical Example
The UI should receive sections already labeled as operational months or weeks rather than computing the first-Wednesday rule while painting rows.

#### Language Implementation
In Python, this appears as service methods that read settings, parse dates, call repository methods, bucket rows, aggregate totals, and return a History read model.

#### Project Implementation
In Markei, repository persists and retrieves raw rows/settings, service interprets settings/date boundaries/grouping/aggregates, and History UI renders the read model.

#### Required Concepts
&&&05, &&&06, &&&07, &%%04, &%%05, &%%06.

#### Related Concepts
&%%03, %%%04, %%%05.

#### Status
Red.

#### Source
Cycle 02 responsibility evidence in `H_DDC_CODEX.md`.

---

## %%%01

### SQLite Schema Evolution

#### Description
A database schema can change without deleting existing data. This concept teaches controlled persistence evolution.

#### Formal Definition
SQLite schema evolution is the controlled modification of SQLite tables and columns over time while preserving existing database contents whenever possible.

#### Practical Example
A migration can add an expiration or settings table only if the structure is missing.

#### Language Implementation
Python can execute SQLite DDL statements and metadata checks through database connection/cursor operations.

#### Project Implementation
Markei migration logic adds or prepares structures only when absent, supporting Product View shelf-life fields and Cycle 02 Settings persistence without destructive reset.

#### Required Concepts
&&&02, &&%01.

#### Related Concepts
%%%02, %%%04, &%%03.

#### Status
Yellow.

#### Source
Cycle 01 schema evolution and Cycle 02 settings migration evidence.

---

## %%%02

### SQLite PRAGMA

#### Description
PRAGMA is a SQLite-specific command family used for database metadata and settings. It is useful for inspecting schema state before migration actions.

#### Formal Definition
SQLite PRAGMA commands are special SQLite statements that query or modify database-level metadata, configuration, and introspection information.

#### Practical Example
`PRAGMA table_info(products)` returns column metadata so code can check whether a column already exists before migration.

#### Language Implementation
In Python, PRAGMA statements are executed through SQLite cursor calls like other SQL statements, then read from returned rows.

#### Project Implementation
Markei uses PRAGMA-backed idempotent migration checks across Product View and Settings work. After two successful migration cycles, PRAGMA moves from exploratory Red to reinforced Yellow knowledge, but remains not fully Green until explicitly lectured.

#### Required Concepts
%%%01.

#### Related Concepts
&%%03, &&%01, %%%04.

#### Status
Yellow.

#### Source
Cycle 01 PRAGMA note and Cycle 02 settings migration reuse in `H_DDC_CODEX.md`.

---

## %%%03

### PySide6 Read-Only Widget Composition

#### Description
A read-only UI panel is built by composing widgets that display prepared data without owning calculation rules.

#### Formal Definition
PySide6 widget composition is the construction of Qt interfaces by combining widgets, layouts, and signals into a user-facing component.

#### Practical Example
A product detail panel can update labels and purchase-history rows when a table item is double-clicked.

#### Language Implementation
In Python, PySide6 uses widget classes, layout objects, signals, and slots to compose UI behavior.

#### Project Implementation
In Markei, Product View and History rendering use widgets to display service-prepared data while calculations remain outside the UI.

#### Required Concepts
&%%02, &%%04.

#### Related Concepts
&&&03, %%%05.

#### Status
Yellow.

#### Source
Cycle 01 Product View panel and Cycle 02 History rendering evidence.

---

## %%%04

### SQLite Settings Persistence

#### Description
SQLite settings persistence stores small durable configuration values in the local database so user preferences can affect future sessions.

#### Formal Definition
SQLite settings persistence is the use of SQLite tables and repository/service access patterns to store and retrieve application configuration state.

#### Practical Example
A settings table can store a row whose key is `history.week_boundary` and whose value is `wednesday`.

#### Language Implementation
In Python, settings persistence uses SQL reads/writes, migration checks, value parsing, default insertion, and service-level validation.

#### Project Implementation
In Markei, `settings.key` identifies a setting and `settings.value` stores text. Defaults are inserted without overwriting user choices, and History services read settings to interpret time buckets.

#### Required Concepts
&&&08, %%%01, %%%02.

#### Related Concepts
&%%06, &%%08.

#### Status
Red.

#### Source
Cycle 02 Settings persistence evidence in `H_DDC_CODEX.md`.

---

## %%%05

### PySide6 Editable Form Composition

#### Description
Editable forms compose input widgets that let the user change persisted application state while still delegating validation and persistence to services.

#### Formal Definition
PySide6 editable form composition is the construction of Qt input forms using widgets, layouts, signals, and event handlers that collect user edits and send them to application services.

#### Practical Example
A Settings page can show controls for store editing, page sorting, and History time-reference configuration.

#### Language Implementation
In Python, this appears through PySide6 input widgets, signal handlers, form population methods, and service calls on save/apply actions.

#### Project Implementation
In Markei, Settings page widgets expose editable controls for store editing and configuration while delegating persistence to service/repository workflows.

#### Required Concepts
&%%06, &%%07, &%%04.

#### Related Concepts
%%%03, &&%01.

#### Status
Red.

#### Source
Cycle 02 PySide6 editable forms evidence in `H_DDC_CODEX.md`.

---

## Lecture-only / Glossary-only Decision

### Simple Key/Value Table

Decision: glossary concept and lecture example, not a standalone canonical KANBAN concept in this cycle.

Reason: the pattern is important for understanding Cycle 02 Settings persistence, but it is currently a sub-pattern of `%%%04 SQLite Settings Persistence` rather than a broad project-level learning object requiring its own KANBAN entry. It should be introduced in lecture when teaching configuration state and SQLite settings persistence.
