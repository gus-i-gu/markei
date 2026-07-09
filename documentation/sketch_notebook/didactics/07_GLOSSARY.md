# 07_GLOSSARY.md

> Domain: Didactic
> Status: Derived from `02_KANBAN.md`
> Last absorbed evidence: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
> Current cycle: Cycle 03 — Read-Model Consolidation

---

## Domain Model Field Semantics

KANBAN ID

&&&01

Type

Foundational Computer Science

Definition

The meaning and responsibility assigned to a named model field within a domain, independent of its raw data type.

Project Usage

Used to distinguish purchase rhythm, shelf-life rhythm, History analytics values, Lists status fields, and read-model display names.

Related Concepts

Raw Data Versus Derived Data; Naming as Data Contract; Product Cycle.

---

## Raw Data

KANBAN ID

&&&02

Type

Foundational Computer Science

Definition

Data directly entered, observed, imported, or retrieved before calculation or prediction.

Project Usage

Purchase rows, product rows, store rows, entered price, and purchase dates are raw inputs for Cycle 03 Lists and History analytics.

Related Concepts

Derived Data; Filtering Frame; Aggregation and Totals.

---

## Derived Data

KANBAN ID

&&&02

Type

Foundational Computer Science

Definition

Data produced by applying calculation, aggregation, inference, grouping, filtering, or prediction to other data.

Project Usage

Lists rows, Status labels, latest/delta display values, totals, percentages, average timelapse, and cycle comparisons are derived service/read-model values.

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

Cycle 03 relies on names such as `latest_price`, `delta_price`, `Status`, `frame_average_timelapse_days`, `expenditure_percentage`, and `comparison_label` to preserve meaning between services and UI.

Related Concepts

Domain Model Field Semantics; Repository Result Shape; Read Model.

---

## Cached Summary Field

KANBAN ID

&&&04

Type

Foundational Computer Science

Definition

A retained value calculated from other records and used as a summary for later access, display, or prediction.

Project Usage

`current_unit_price` is used as a product summary value for Lists latest price; History analytics values remain read-time derivations unless later persisted.

Related Concepts

Derived Data; SQLite Read Queries Versus Cached Columns.

---

## Time Bucketing

KANBAN ID

&&&05

Type

Foundational Computer Science

Definition

The classification of temporal records into discrete periods according to explicit start/end boundary rules.

Project Usage

Markei History assigns purchases to operational weeks and months using configured boundary rules.

Related Concepts

Date/Datetime Boundary Handling; Filtering Frame.

---

## Aggregation and Totals

KANBAN ID

&&&06

Type

Foundational Computer Science

Definition

The derivation of summary values from a collection of records using operations such as sum, mean, grouping, or counting.

Project Usage

Cycle 03 analytics calculates selected-frame total spent, product totals, purchase counts, and average purchase timelapse before percentages or comparisons.

Related Concepts

Expenditure Percentage; Comparative Metric; Service-Owned Calculation Responsibility.

---

## Grouping Versus Sorting

KANBAN ID

&&&07

Type

Foundational Computer Science

Definition

Sorting orders records according to comparison criteria, while grouping partitions records into collections based on shared keys or computed membership rules.

Project Usage

History sorts purchases by date before analytics intervals; Lists internal views filter/group products without owning separate persisted lists.

Related Concepts

Lists Internal View; UI View State.

---

## Configuration State

KANBAN ID

&&&08

Type

Foundational Computer Science

Definition

Persisted application preference data used to parameterize future behavior across sessions.

Project Usage

Settings stores configuration values; Cycle 03 keeps `pages.order` deferred and does not turn it into active tab ordering.

Related Concepts

Settings-Owned Preferences; Mobile Readiness Without Rewrite.

---

## Expenditure Percentage

KANBAN ID

&&&09

Type

Foundational Computer Science

Definition

A derived aggregate showing a part’s spending divided by the selected frame’s total spending.

Project Usage

History analytics computes product expenditure percentage as product total spent inside the selected date/store frame divided by frame total spent.

Related Concepts

Aggregation and Totals; Filtering Frame; Derived Data.

---

## Filtering Frame

KANBAN ID

&&&10

Type

Foundational Computer Science

Definition

The selected inclusion boundary that decides which records participate in a calculation or read-model view.

Project Usage

Cycle 03 History analytics uses a date range plus optional store filter as its frame; unparsed rows and excluded rows are reported separately.

Related Concepts

Date/Datetime Boundary Handling; Aggregation and Totals; Frame Average Purchase Timelapse.

---

## Comparative Metric

KANBAN ID

&&&11

Type

Foundational Computer Science

Definition

A derived value whose meaning comes from comparing one measurement with a defined baseline.

Project Usage

Cycle 03 compares product cycle against frame average purchase timelapse and displays faster, slower, or equal.

Related Concepts

Baseline; Product Cycle; Derived Data.

---

## Baseline

KANBAN ID

&&&12

Type

Foundational Computer Science

Definition

The reference value used to interpret a comparison.

Project Usage

For Cycle 03 analytics, the baseline is frame average purchase timelapse, not a product-specific average or shelf-life field.

Related Concepts

Comparative Metric; Frame Average Purchase Timelapse.

---

## Frame Average Purchase Timelapse

KANBAN ID

&&&12

Type

Derived terminology

Definition

The average interval between all parsed purchases inside the selected date/store frame, ordered by date.

Project Usage

History analytics uses this value as the baseline for product cycle comparison. If fewer than two parsed purchases exist, the value is unknown.

Related Concepts

Filtering Frame; Baseline; Date/Datetime Boundary Handling.

---

## Status Classification Versus UI Filtering

KANBAN ID

&&&13

Type

Foundational Computer Science

Definition

Status classification assigns semantic state to a record, while UI filtering decides which already-classified records are shown in a selected view.

Project Usage

Lists rows carry status such as `in-house`, `shortage`, or `to-buy`; Lists internal views filter rows by those statuses.

Related Concepts

Lists Internal View; UI View State; Service-Owned Calculation Responsibility.

---

## Mobile Readiness Without Rewrite

KANBAN ID

&&&14

Type

Foundational Computer Science

Definition

Preparing code for future platform movement by separating business meaning, service contracts, and read models from platform-specific UI implementation.

Project Usage

Cycle 03 keeps Lists and History analytics semantics in ProductService dictionaries/lists while PySide6 renders them; no mobile UI, API rewrite, sync, or backend rewrite was introduced.

Related Concepts

Platform-Neutral Read Model; Service Contract Stability.

---

## Optional Value

KANBAN ID

&&%01

Type

Python / Language Concept

Definition

A value that may be present or absent in the language model.

Project Usage

Cycle 03 uses absent values for missing delta price, missing frame average, or missing product cycle.

Related Concepts

Nullable Derived Display Values.

---

## Nullable Derived Display Value

KANBAN ID

&&%05

Type

Python / Language Concept

Definition

A calculated display value that may legitimately be unavailable and must be represented safely rather than invented.

Project Usage

Lists delta price may display `—` when no previous price exists; History analytics may omit comparison when cycle or frame average data is insufficient.

Related Concepts

Optional Value; Derived Data.

---

## Date/Datetime Boundary Handling

KANBAN ID

&&%03

Type

Python / Language Concept

Definition

The use of language-level temporal values and arithmetic to determine period starts, period ends, ordering, and membership.

Project Usage

Cycle 03 analytics parses date boundaries and excludes rows outside the selected frame; invalid date text currently behaves like an omitted boundary.

Related Concepts

Filtering Frame; Time Bucketing.

---

## Platform-Neutral Read Model

KANBAN ID

&&%04

Type

Python / Boundary Concept

Definition

A read-model shape expressed in plain language/runtime structures rather than tied to a specific UI toolkit.

Project Usage

Cycle 03 ProductService returns dictionaries/lists with primitive values and labels that PySide6 can render but future adapters could also consume.

Related Concepts

Read Model; Mobile Readiness Without Rewrite; Service Contract Stability.

---

## UI View State

KANBAN ID

&&%06

Type

Python / UI Concept

Definition

The current application/UI selection that changes what is displayed without becoming the owner of the underlying data.

Project Usage

The selected Lists internal view controls which shared rows are displayed.

Related Concepts

Lists Internal View; Status Classification Versus UI Filtering.

---

## Read Model

KANBAN ID

&%%02 / &%%05 / &%%09 / &%%10

Type

Markei Implementation Concept

Definition

A data shape prepared for reading and presentation rather than direct persistence or mutation.

Project Usage

Markei uses service-prepared Product View, History, Lists, and History analytics read models so UI renders prepared meaning instead of calculating it.

Related Concepts

Repository Result Shape; Service-Owned Calculation Responsibility; Platform-Neutral Read Model.

---

## Product Cycle

KANBAN ID

&%%01

Type

Markei Implementation Concept

Definition

The purchase recurrence rhythm represented by `average_duration_days`.

Project Usage

Cycle 03 analytics compares product cycle to frame average purchase timelapse. Product cycle is not shelf-life or expiration rhythm.

Related Concepts

Shelf-Life Rhythm; Comparative Metric; Baseline.

---

## Shelf-Life Rhythm

KANBAN ID

&%%01

Type

Markei Implementation Concept

Definition

The purchase-to-expiration interval for a purchased batch or product summary.

Project Usage

Cycle 03 analytics does not use shelf-life fields for cycle comparison.

Related Concepts

Product Cycle; Domain Model Field Semantics.

---

## History Analytics Read Model

KANBAN ID

&%%09

Type

Markei Implementation Concept

Definition

A service-prepared display shape for History analytics that separates frame diagnostics, aggregate totals, product percentages, and comparison metrics from UI rendering.

Project Usage

`get_history_analytics_view(...)` returns frame data, counts, total spent, frame average timelapse, product rows, and diagnostics for embedded History display.

Related Concepts

Filtering Frame; Expenditure Percentage; Comparative Metric.

---

## Lists Internal View

KANBAN ID

&%%10

Type

Markei Implementation Concept

Definition

A named UI view state inside the unified Lists page that filters shared Lists read-model rows without owning separate persisted data.

Project Usage

Cycle 03 Lists supports `all`, `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy` over one standardized row shape.

Related Concepts

Status Classification Versus UI Filtering; UI View State.

---

## Latest Value / Delta Calculation

KANBAN ID

&%%11

Type

Markei Implementation Concept

Definition

A read-model display calculation that shows the latest product value and its difference from a comparable previous value.

Project Usage

Lists shows latest price from product summary `current_unit_price` and delta through `get_price_variation(product)`, globally per product in Cycle 03.

Related Concepts

Nullable Derived Display Values; Cached Summary Field.

---

## Repository Result Shape

KANBAN ID

&%%03

Type

Markei Implementation Concept

Definition

The structure, field names, and relationship representation returned from persistence queries into application code.

Project Usage

Repository remains responsible for SQL retrieval and row mapping, not analytics semantics.

Related Concepts

Naming as Data Contract; Service-Owned Calculation Responsibility.

---

## Service-Owned Calculation Responsibility

KANBAN ID

&%%04

Type

Markei Implementation Concept

Definition

The principle that services coordinate calculation, aggregation, prediction, grouping, and repository access before UI rendering.

Project Usage

ProductService owns Lists status, latest/delta, frame totals, percentages, average timelapse, and cycle comparison.

Related Concepts

Read Model; Service Contract Stability.

---

## Service Contract Stability

KANBAN ID

&%%12

Type

Markei Implementation Concept

Definition

The stability of service method names, parameters, return shapes, and meanings relied on by UI or future adapters.

Project Usage

Cycle 03 adds service methods that expose Lists and History analytics as stable read-model shapes instead of PySide6-specific calculation logic.

Related Concepts

Platform-Neutral Read Model; Mobile Readiness Without Rewrite.

---

## PySide6 Read-Only Widget Composition

KANBAN ID

%%%03

Type

Dependency / Tool Concept

Definition

The construction of display-only Qt UI components by composing widgets, layouts, signals, and rendering behavior.

Project Usage

Markei Product View, History, Lists, and embedded analytics render service-prepared data without owning calculations.

Related Concepts

PySide6 Composition for Embedded Analytics; Service-Owned Calculation Responsibility.

---

## PySide6 Composition for Embedded Analytics

KANBAN ID

%%%06

Type

Dependency / Tool Concept

Definition

The composition of Qt controls and read-only display widgets inside an existing page to present analytics without creating a separate widget lifecycle.

Project Usage

Cycle 03 embeds date/store controls, summary label, and analytics table inside `HistoryPage`.

Related Concepts

History Analytics Read Model; PySide6 Read-Only Widget Composition.

---

## PySide6 Unified Page View Controls

KANBAN ID

%%%07

Type

Dependency / Tool Concept

Definition

Qt controls that let one page switch between internal display states while reusing a shared rendering surface.

Project Usage

ListsPage uses internal view selection over one standardized table.

Related Concepts

Lists Internal View; UI View State.

---

## SQLite Schema Evolution

KANBAN ID

%%%01

Type

Dependency / Tool Concept

Definition

Controlled modification of SQLite tables and columns over time while preserving existing database contents where possible.

Project Usage

Cycle 03 introduced no schema changes, reinforcing that not every read-model value needs persistence.

Related Concepts

SQLite Read Queries Versus Cached Columns.

---

## SQLite Read Queries Versus Cached Columns

KANBAN ID

%%%08

Type

Dependency / Tool Concept

Definition

The distinction between calculating display values from reads at runtime and storing those values as persistent columns.

Project Usage

Cycle 03 History analytics values are read-time service derivations; no persisted analytics cache was added.

Related Concepts

Cached Summary Field; Derived Data.

---

## Kept Unstable Terms

KANBAN ID

None

Type

Derived terminology / deferred design vocabulary

Definition

Terms intentionally not promoted because Cycle 03 deferred their implementation or meaning.

Project Usage

Detachable analytics, store/frame-scoped price delta, configurable comparison tolerance, active `pages.order`, mobile implementation architecture, API/backend rewrite, persisted analytics cache, and old page deletion remain deferred.

Related Concepts

Mobile Readiness Without Rewrite; SQLite Read Queries Versus Cached Columns.
