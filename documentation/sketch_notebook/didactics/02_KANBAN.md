# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register
> Last absorbed evidence: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

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
In Markei, `average_duration_days` means purchase-to-purchase rhythm, while `average_shelf_life_days` means purchase-to-expiration rhythm. They must not be merged.

#### Required Concepts
None.

#### Related Concepts
&&&02, &&&03, &&&04, &%%01, &%%02.

#### Status
Yellow.

#### Source
Product View materialization evidence in `H_DDC_CODEX.md`.

---

## &&&02

### Raw Data Versus Derived Data

#### Description
Programs often handle both facts that were directly entered or observed and values calculated from those facts. Learning the difference prevents accidental overwriting of evidence with predictions.

#### Formal Definition
Raw data is directly entered, observed, or imported information. Derived data is produced by applying rules, calculations, aggregation, or prediction to other data.

#### Practical Example
A receipt expiration date is a raw fact for one purchased batch. An expected future expiration date is derived from previous batch data.

#### Language Implementation
In Python, raw and derived values may both appear as attributes, so naming and service boundaries must explain which values are source facts and which are calculations.

#### Project Implementation
In Markei, `Purchase.expiration_date` is raw batch data, while `Product.average_shelf_life_days`, `Product.expected_expiration_date`, and Product View average price are derived values.

#### Required Concepts
&&&01.

#### Related Concepts
&&&04, &%%02, &%%03, &%%04.

#### Status
Yellow.

#### Source
Codex evidence separating `purchases.expiration_date` from product summary fields.

---

## &&&03

### Naming as Data Contract

#### Description
A name is a contract between layers. Precise names preserve meaning as data moves through schema, models, repositories, services, and UI.

#### Formal Definition
Naming as a data contract is the use of stable, precise names to define the expected meaning, shape, and responsibility of data exchanged between program components.

#### Practical Example
A value named `expiration_date` should not silently mean purchase cadence in one layer and shelf-life prediction in another.

#### Language Implementation
In Python, this contract appears in dataclass fields, row-mapping keys, service return dictionaries, and UI display labels.

#### Project Implementation
Markei preserves `expiration_date`, `average_shelf_life_days`, `expected_expiration_date`, `average_duration_days`, and `expected_next_purchase` across implementation boundaries.

#### Required Concepts
&&&01.

#### Related Concepts
&&&02, &&%01, &%%03.

#### Status
Yellow.

#### Source
Codex evidence reports uniform `expiration_date` naming across schema, model, repository, service, and UI boundaries.

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
In Markei, `expected_expiration_date` is a product summary field, while `expiration_date` is purchase-level raw history.

#### Required Concepts
&&&02.

#### Related Concepts
&%%02, &%%04, %%%01.

#### Status
Red.

#### Source
Codex evidence warning that `expected_expiration_date` may be confused with actual purchase expiration history.

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
In Markei, `Product`, `Purchase`, and `Store` gained optional fields compatible with existing records; missing expiration and address values render as placeholders.

#### Required Concepts
&&&02.

#### Related Concepts
&&%02, %%%01, &%%03.

#### Status
Yellow.

#### Source
Codex evidence on nullable model-field evolution.

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
In Markei, `Product`, `Purchase`, and `Store` evolved to support shelf-life data, expiration dates, store address data, and compatibility with existing records.

#### Required Concepts
&&&01, &&%01.

#### Related Concepts
&&&03, %%%01.

#### Status
Yellow.

#### Source
Codex evidence on dataclass field evolution.

---

## &%%01

### Markei Purchase Rhythm Versus Shelf-Life Rhythm

#### Description
Markei now teaches two different product rhythms: the rhythm of buying and the rhythm of expiration after purchase.

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
Codex evidence under naming and semantic distinctions preserved.

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
In Markei, `ProductService` assembles explicit identity, price, shelf-life, store, and purchase-history rows for the Product View.

#### Required Concepts
&&&02, &&&03, &%%01.

#### Related Concepts
&%%03, &%%04, %%%03.

#### Status
Red.

#### Source
Codex evidence: Product View read-model assembly is a service responsibility.

---

## &%%03

### Repository Result Shape

#### Description
Repository methods do not merely fetch data. They decide the named shape of data that services receive.

#### Formal Definition
Repository result shape is the structure, field names, and relationship representation returned from persistence queries into application code.

#### Practical Example
Returning `purchase_date`, `expiration_date`, and `latest_unit_price` is clearer than returning unnamed tuple positions or vague labels.

#### Language Implementation
In Python, repository result shape can appear as dictionaries, row objects, dataclasses, or tuples mapped into explicit keys.

#### Project Implementation
Markei repository outputs explicit keys such as `purchase_date`, `expiration_date`, and `latest_unit_price`, allowing Product View services to preserve data meaning.

#### Required Concepts
&&&03.

#### Related Concepts
&%%02, &%%04, %%%01.

#### Status
Yellow.

#### Source
Codex evidence on repository row mapping and explicit keys.

---

## &%%04

### Service-Owned Calculation Responsibility

#### Description
Domain calculations should be owned by services rather than UI widgets. This keeps display code from becoming hidden business logic.

#### Formal Definition
Service-owned calculation responsibility is the principle that application services coordinate calculations, aggregation, prediction, and repository access before UI rendering.

#### Practical Example
A panel should display average price and expected expiration; it should not calculate them itself.

#### Language Implementation
In Python, this appears as service methods that call repositories, calculate or coordinate derived values, and return prepared data.

#### Project Implementation
In Markei, average price, shelf-life, expected expiration, and Product View assembly are owned by `ProductService`, not the UI.

#### Required Concepts
&&&02, &&&04, &%%02.

#### Related Concepts
&%%03, %%%03.

#### Status
Yellow.

#### Source
Codex responsibility evidence: service owns calculations and UI owns read-only rendering.

---

## %%%01

### SQLite Schema Evolution

#### Description
A database schema can change without deleting existing data. This concept teaches controlled persistence evolution.

#### Formal Definition
SQLite schema evolution is the controlled modification of SQLite tables and columns over time while preserving existing database contents whenever possible.

#### Practical Example
A migration can add an expiration column only if the column is missing.

#### Language Implementation
Python can execute SQLite DDL statements and metadata checks through database connection/cursor operations.

#### Project Implementation
Markei migration logic adds columns only when absent, supporting Product View shelf-life fields without destructive reset.

#### Required Concepts
&&&02, &&%01.

#### Related Concepts
%%%02, &%%03.

#### Status
Yellow.

#### Source
Codex evidence: schema evolution without destructive reset.

---

## %%%02

### SQLite PRAGMA

#### Description
PRAGMA is a SQLite-specific command family used for database metadata and settings. It is useful for inspecting schema state before migration actions.

#### Formal Definition
SQLite PRAGMA commands are special SQLite statements that query or modify database-level metadata, configuration, and introspection information.

#### Practical Example
`PRAGMA table_info(products)` returns column metadata for the `products` table so code can check whether a column already exists.

#### Language Implementation
In Python, PRAGMA statements are executed through SQLite cursor calls like other SQL statements, then read from returned rows.

#### Project Implementation
Markei uses `PRAGMA table_info(table_name)` to inspect whether migration columns already exist before running `ALTER TABLE`.

#### Required Concepts
%%%01.

#### Related Concepts
&%%03, &&%01.

#### Status
Red.

#### Source
Codex PRAGMA note in `H_DDC_CODEX.md`.

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
In Markei, Product View was extracted into `ProductDetailPanel`, which owns read-only rendering while services own calculation and assembly.

#### Required Concepts
&%%02, &%%04.

#### Related Concepts
&&&03.

#### Status
Red.

#### Source
Codex evidence: Product View was extracted into `ProductDetailPanel`.
