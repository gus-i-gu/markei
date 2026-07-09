# 07_GLOSSARY.md

> Domain: Didactic
> Status: Derived from `02_KANBAN.md`
> Last absorbed evidence: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

---

## Domain Model Field Semantics

KANBAN ID

&&&01

Type

Foundational Computer Science

Definition

The meaning and responsibility assigned to a named model field within a domain, independent of its raw data type.

Project Usage

Used to distinguish `average_duration_days` from `average_shelf_life_days` in Markei.

Related Concepts

Raw Data Versus Derived Data; Naming as Data Contract; Markei Purchase Rhythm Versus Shelf-Life Rhythm.

---

## Raw Data

KANBAN ID

&&&02

Type

Foundational Computer Science

Definition

Data directly entered, observed, or imported before calculation or prediction.

Project Usage

`Purchase.expiration_date` is raw batch-level data entered with a receipt and may be null.

Related Concepts

Derived Data; Cached Summary Field; Optional Values and Nullable Fields.

---

## Derived Data

KANBAN ID

&&&02

Type

Foundational Computer Science

Definition

Data produced by applying calculation, aggregation, inference, or prediction to other data.

Project Usage

`average_shelf_life_days`, `expected_expiration_date`, and Product View average price are derived from purchase records.

Related Concepts

Raw Data; Cached Summary Field; Service-Owned Calculation Responsibility.

---

## Naming as Data Contract

KANBAN ID

&&&03

Type

Foundational Computer Science

Definition

The use of stable, precise names to preserve data meaning across program boundaries.

Project Usage

Markei keeps `expiration_date`, `average_shelf_life_days`, and `expected_expiration_date` distinct across schema, models, repositories, services, and UI.

Related Concepts

Domain Model Field Semantics; Repository Result Shape; Read Model.

---

## Cached Summary Field

KANBAN ID

&&&04

Type

Foundational Computer Science

Definition

A retained value calculated from other records and used as a summary for access, display, or prediction.

Project Usage

`expected_expiration_date` is a product-level summary, not the purchase-level expiration fact.

Related Concepts

Raw Data Versus Derived Data; Service-Owned Calculation Responsibility.

---

## Optional Value

KANBAN ID

&&%01

Type

Python / Language Concept

Definition

A value that may be present or absent in the language model.

Project Usage

Markei Python models use optional fields so missing expiration or address data can be represented safely.

Related Concepts

Nullable Field; Dataclass Field Evolution.

---

## Nullable Field

KANBAN ID

&&%01

Type

Python / Persistence Boundary Concept

Definition

A persistent field that may contain no value and must be handled explicitly by application code.

Project Usage

Markei allows missing expiration dates and store addresses to render as placeholders instead of errors.

Related Concepts

Optional Value; SQLite Schema Evolution.

---

## Read Model

KANBAN ID

&%%02

Type

Markei Implementation Concept

Definition

A data shape prepared for reading and presentation rather than direct persistence or mutation.

Project Usage

`ProductService` assembles Product View identity, price, shelf-life, store, and purchase-history rows.

Related Concepts

Repository Result Shape; Service-Owned Calculation Responsibility; PySide6 Read-Only Widget Composition.

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

## Repository Result Shape

KANBAN ID

&%%03

Type

Markei Implementation Concept

Definition

The structure, field names, and relationship representation returned from persistence queries into application code.

Project Usage

Markei repository queries return explicit keys such as `purchase_date`, `expiration_date`, and `latest_unit_price`.

Related Concepts

Naming as Data Contract; Product View Read Model.

---

## Service-Owned Calculation Responsibility

KANBAN ID

&%%04

Type

Markei Implementation Concept

Definition

The principle that services coordinate calculation, aggregation, prediction, and repository access before UI rendering.

Project Usage

Markei Product View receives average price, shelf-life, and expected expiration from service-prepared data rather than UI calculations.

Related Concepts

Read Model; Raw Data Versus Derived Data.

---

## SQLite Schema Evolution

KANBAN ID

%%%01

Type

Dependency / Tool Concept

Definition

Controlled modification of SQLite tables and columns over time while preserving existing database contents where possible.

Project Usage

Markei migrations add columns only when absent instead of resetting the database.

Related Concepts

SQLite PRAGMA; Nullable Field.

---

## SQLite PRAGMA

KANBAN ID

%%%02

Type

Dependency / Tool Concept

Definition

A SQLite command family for querying or modifying database metadata, configuration, and introspection information.

Project Usage

Markei uses `PRAGMA table_info(table_name)` to inspect existing columns before `ALTER TABLE` migration steps.

Related Concepts

SQLite Schema Evolution; Repository Result Shape.

---

## PySide6 Read-Only Widget Composition

KANBAN ID

%%%03

Type

Dependency / Tool Concept

Definition

The construction of display-only Qt UI components by composing widgets, layouts, signals, and rendering behavior.

Project Usage

Markei extracts Product View rendering into `ProductDetailPanel` while services prepare the data.

Related Concepts

Read Model; Service-Owned Calculation Responsibility.
