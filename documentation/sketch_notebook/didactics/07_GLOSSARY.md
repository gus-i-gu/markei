# 07_GLOSSARY.md

> Domain: Didactic
> Status: Derived from `02_KANBAN.md`
> Last absorbed evidence: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
> Current cycle: Cycle 02 — History + Settings

---

## Domain Model Field Semantics

KANBAN ID

&&&01

Type

Foundational Computer Science

Definition

The meaning and responsibility assigned to a named model field within a domain, independent of its raw data type.

Project Usage

Used to distinguish product rhythm fields and History/Settings field names such as `purchase_date`, `total_price`, and `settings.key`.

Related Concepts

Raw Data Versus Derived Data; Naming as Data Contract; Grouping Versus Sorting.

---

## Raw Data

KANBAN ID

&&&02

Type

Foundational Computer Science

Definition

Data directly entered, observed, or imported before calculation or prediction.

Project Usage

Purchase rows and purchase-level expiration dates are raw facts in Markei.

Related Concepts

Derived Data; Aggregation and Totals; Cached Summary Field.

---

## Derived Data

KANBAN ID

&&&02

Type

Foundational Computer Science

Definition

Data produced by applying calculation, aggregation, inference, grouping, or prediction to other data.

Project Usage

Product summaries, History sections, store totals, and average unit prices are derived from purchase records.

Related Concepts

Raw Data; Aggregation and Totals; Service-Owned Calculation Responsibility.

---

## Naming as Data Contract

KANBAN ID

&&&03

Type

Foundational Computer Science

Definition

The use of stable, precise names to preserve data meaning across program boundaries.

Project Usage

Markei uses explicit names for purchase rows, settings keys, time buckets, totals, and read-model fields.

Related Concepts

Domain Model Field Semantics; Repository Result Shape; Configuration State.

---

## Cached Summary Field

KANBAN ID

&&&04

Type

Foundational Computer Science

Definition

A retained value calculated from other records and used as a summary for access, display, or prediction.

Project Usage

`expected_expiration_date` is cached product summary data; History totals are derived display aggregates unless later persisted by design.

Related Concepts

Raw Data Versus Derived Data; Aggregation and Totals.

---

## Time Bucketing

KANBAN ID

&&&05

Type

Foundational Computer Science

Definition

The classification of temporal records into discrete periods according to explicit start/end boundary rules.

Project Usage

Markei History assigns purchases to operational weeks and months using Wednesday boundary rules.

Related Concepts

Date/Datetime Boundary Handling; Grouping Versus Sorting; History Read Model.

---

## Aggregation and Totals

KANBAN ID

&&&06

Type

Foundational Computer Science

Definition

The derivation of summary values from a collection of records using operations such as sum, mean, grouping, or counting.

Project Usage

Markei History sums `total_price`, averages `unit_price`, keeps quantity totals grouped by unit, and groups totals by store label.

Related Concepts

Raw Data Versus Derived Data; History Read Model; Service-Owned Calculation Responsibility.

---

## Grouping Versus Sorting

KANBAN ID

&&&07

Type

Foundational Computer Science

Definition

Sorting orders records according to comparison criteria, while grouping partitions records into collections based on shared keys or computed membership rules.

Project Usage

Markei sorts purchases chronologically, then groups them into operational month and week sections.

Related Concepts

Time Bucketing; Aggregation and Totals; Repository Result Shape.

---

## Configuration State

KANBAN ID

&&&08

Type

Foundational Computer Science

Definition

Persisted application preference data used to parameterize future behavior across sessions.

Project Usage

Markei Settings stores sorting and History time-reference values used by services later.

Related Concepts

Settings-Owned Preferences; SQLite Settings Persistence; Simple Key/Value Table.

---

## Optional Value

KANBAN ID

&&%01

Type

Python / Language Concept

Definition

A value that may be present or absent in the language model.

Project Usage

Markei Python models and settings defaults handle missing expiration, address, or preference values safely.

Related Concepts

Nullable Field; Dataclass Field Evolution; Date/Datetime Boundary Handling.

---

## Nullable Field

KANBAN ID

&&%01

Type

Python / Persistence Boundary Concept

Definition

A persistent field that may contain no value and must be handled explicitly by application code.

Project Usage

Markei allows missing expiration dates and store addresses to render or edit safely.

Related Concepts

Optional Value; SQLite Schema Evolution.

---

## Dataclass Field Evolution

KANBAN ID

&&%02

Type

Python / Language Concept

Definition

Controlled change of Python dataclass fields, defaults, and optionality as the domain model matures.

Project Usage

Markei models evolve as Product, History, Store, and Settings concepts become more explicit.

Related Concepts

Optional Value; Naming as Data Contract.

---

## Date/Datetime Boundary Handling

KANBAN ID

&&%03

Type

Python / Language Concept

Definition

The use of language-level temporal values and arithmetic to determine period starts, period ends, ordering, and membership.

Project Usage

Markei services use date parsing and Wednesday boundary rules to assign purchases to operational periods.

Related Concepts

Time Bucketing; Grouping Versus Sorting.

---

## Read Model

KANBAN ID

&%%02 / &%%05

Type

Markei Implementation Concept

Definition

A data shape prepared for reading and presentation rather than direct persistence or mutation.

Project Usage

Markei uses service-prepared Product View and History read models so UI renders prepared meaning instead of calculating it.

Related Concepts

Repository Result Shape; Service-Owned Calculation Responsibility; History Read Model.

---

## Purchase Rhythm

KANBAN ID

&%%01

Type

Markei Implementation Concept

Definition

The purchase-to-purchase interval for a product.

Project Usage

`average_duration_days` and `expected_next_purchase` remain tied to purchase cadence.

Related Concepts

Shelf-Life Rhythm; Domain Model Field Semantics.

---

## Shelf-Life Rhythm

KANBAN ID

&%%01

Type

Markei Implementation Concept

Definition

The purchase-to-expiration interval for a purchased batch or product summary.

Project Usage

`average_shelf_life_days` and `expected_expiration_date` are tied to expiration cadence.

Related Concepts

Purchase Rhythm; Cached Summary Field.

---

## History Read Model

KANBAN ID

&%%05

Type

Markei Implementation Concept

Definition

A Markei-specific read structure produced by services for rendering chronological and grouped purchase history without assigning calculation responsibility to the UI.

Project Usage

History renders operational month/week sections, ordered purchase rows, and Total rows prepared by services.

Related Concepts

Time Bucketing; Aggregation and Totals; Service-Owned Calculation Responsibility.

---

## Settings-Owned Preferences

KANBAN ID

&%%06

Type

Markei Implementation Concept

Definition

Configuration values exposed and persisted through the Settings page, then interpreted by the relevant service workflows.

Project Usage

Settings stores page sorting and History time-reference values; History services interpret them later.

Related Concepts

Configuration State; SQLite Settings Persistence.

---

## Store Editing Workflow

KANBAN ID

&%%07

Type

Markei Implementation Concept

Definition

The Markei-specific path through which store records are shown, edited, validated, persisted, and reflected in later views.

Project Usage

Settings turns Cycle 01 store-address display/persistence into editable store data.

Related Concepts

Optional Value; Settings-Owned Preferences; PySide6 Editable Form Composition.

---

## History Grouping Service Responsibility

KANBAN ID

&%%08

Type

Markei Implementation Concept

Definition

The assignment of History period construction, operational date boundaries, aggregate rows, and settings interpretation to the service layer.

Project Usage

History services build grouped sections and totals while History UI renders the prepared result.

Related Concepts

Service-Owned Calculation Responsibility; History Read Model; Time Bucketing.

---

## Repository Result Shape

KANBAN ID

&%%03

Type

Markei Implementation Concept

Definition

The structure, field names, and relationship representation returned from persistence queries into application code.

Project Usage

Markei repository queries return explicit purchase/time/store/settings facts for service interpretation.

Related Concepts

Naming as Data Contract; History Read Model.

---

## Service-Owned Calculation Responsibility

KANBAN ID

&%%04

Type

Markei Implementation Concept

Definition

The principle that services coordinate calculation, aggregation, prediction, grouping, and repository access before UI rendering.

Project Usage

Markei services own Product View calculations, History grouping, Total rows, and Settings interpretation.

Related Concepts

Read Model; Raw Data Versus Derived Data; History Grouping Service Responsibility.

---

## SQLite Schema Evolution

KANBAN ID

%%%01

Type

Dependency / Tool Concept

Definition

Controlled modification of SQLite tables and columns over time while preserving existing database contents where possible.

Project Usage

Markei migrations add needed structures without resetting the database.

Related Concepts

SQLite PRAGMA; SQLite Settings Persistence.

---

## SQLite PRAGMA

KANBAN ID

%%%02

Type

Dependency / Tool Concept

Definition

A SQLite command family for querying or modifying database metadata, configuration, and introspection information.

Project Usage

Markei uses PRAGMA-backed checks for idempotent migrations across Product View and Settings cycles.

Related Concepts

SQLite Schema Evolution; Repository Result Shape; SQLite Settings Persistence.

---

## SQLite Settings Persistence

KANBAN ID

%%%04

Type

Dependency / Tool Concept

Definition

The use of SQLite tables and repository/service access patterns to store and retrieve application configuration state.

Project Usage

Markei stores settings as `settings.key` and `settings.value`, inserts defaults without overwriting user choices, and reads them to guide History grouping.

Related Concepts

Configuration State; Simple Key/Value Table; Settings-Owned Preferences.

---

## Simple Key/Value Table

KANBAN ID

%%%04

Type

Derived terminology / persistence pattern

Definition

A table design where each setting or fact is stored as a named key paired with a value, usually as text.

Project Usage

Markei Settings can store entries such as `history.week_boundary = wednesday`. This is a glossary concept and lecture example under SQLite Settings Persistence, not a standalone KANBAN concept in Cycle 02.

Related Concepts

Configuration State; SQLite Settings Persistence.

---

## PySide6 Read-Only Widget Composition

KANBAN ID

%%%03

Type

Dependency / Tool Concept

Definition

The construction of display-only Qt UI components by composing widgets, layouts, signals, and rendering behavior.

Project Usage

Markei Product View and History render service-prepared data without owning calculations.

Related Concepts

Read Model; Service-Owned Calculation Responsibility.

---

## PySide6 Editable Form Composition

KANBAN ID

%%%05

Type

Dependency / Tool Concept

Definition

The construction of Qt input forms that collect user edits and delegate validation/persistence to application services.

Project Usage

Markei Settings exposes editable controls for store editing, sorting configuration, and time-reference configuration.

Related Concepts

Settings-Owned Preferences; Store Editing Workflow.
