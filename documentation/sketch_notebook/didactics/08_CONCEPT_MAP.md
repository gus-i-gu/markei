# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Checkpoint
> Current Milestone: Cycle 02 — History + Settings

---

## Current Milestone

Markei is extending from Product View learning into History and Settings. The learning focus is now service-prepared History read models, time bucketing, aggregation, grouping versus sorting, durable configuration state, store editing, and SQLite-backed settings persistence.

## Stable Concepts

- None fully Green yet.

## Active Concepts

- &&&01 — Domain Model Field Semantics
- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &&&04 — Cached Summary Field
- &&%01 — Optional Values and Nullable Fields
- &&%02 — Dataclass Field Evolution
- &%%02 — Product View Read Model
- &%%03 — Repository Result Shape
- &%%04 — Service-Owned Calculation Responsibility
- %%%01 — SQLite Schema Evolution
- %%%02 — SQLite PRAGMA
- %%%03 — PySide6 Read-Only Widget Composition

## New / Unstable Concepts

- &&&05 — Time Bucketing
- &&&06 — Aggregation and Totals
- &&&07 — Grouping Versus Sorting
- &&&08 — Configuration State
- &&%03 — Date/Datetime Boundary Handling
- &%%05 — History Read Model
- &%%06 — Settings-Owned Preferences
- &%%07 — Store Editing Workflow
- &%%08 — History Grouping Service Responsibility
- %%%04 — SQLite Settings Persistence
- %%%05 — PySide6 Editable Form Composition

## Explicit Decisions

- Simple Key/Value Table is not promoted to standalone KANBAN in Cycle 02. It is a glossary concept and lecture example under `%%%04 SQLite Settings Persistence`.
- SQLite PRAGMA moves from exploratory Red toward reinforced Yellow after reuse across Product View and Settings migration cycles. It is not Green yet; it still needs explicit teaching as SQLite metadata introspection rather than ordinary SQL.
- History totals are derived display aggregates, not cached summary fields unless future Design/Main synthesis chooses persistence.
- Settings owns preference editing and persistence; History service owns interpretation of those preferences.

## Next Concepts

1. Grouping versus sorting.
2. Time bucketing with Wednesday boundary rules.
3. Aggregation and Total rows as derived data.
4. Configuration state and Settings-owned preferences.
5. SQLite settings persistence and simple key/value table tradeoffs.
6. Date/datetime boundary handling in Python.
7. PySide6 editable forms after service responsibilities are clear.

## Dependency Spine

```text
&&&01 Domain Model Field Semantics
↓
&&&03 Naming as Data Contract
↓
&&&02 Raw Data Versus Derived Data
↓
&&&07 Grouping Versus Sorting
↓
&&&05 Time Bucketing
↓
&&%03 Date/Datetime Boundary Handling
↓
&&&06 Aggregation and Totals
↓
&%%05 History Read Model
↓
&%%04 Service-Owned Calculation Responsibility
↓
&%%08 History Grouping Service Responsibility
↓
&&&08 Configuration State
↓
&%%06 Settings-Owned Preferences
↓
%%%04 SQLite Settings Persistence
↓
%%%02 SQLite PRAGMA
```

## Project Learning Spine

```text
Raw purchase/time/store rows
↓
Repository explicit result shape
↓
Chronological sorting by date and ID
↓
Service time bucketing by Wednesday rules
↓
Operational month/week sections
↓
Derived store/timeframe Total rows
↓
History read model
↓
History UI read-only tree rendering
↓
Settings persisted preferences
↓
History service interprets settings on later reads
```

## Lecture Progression

1. Explain grouping versus sorting using History rows.
2. Explain time bucketing using the first-Wednesday month rule and Wednesday week rule.
3. Explain aggregation with monetary sum, average unit price, unit-separated quantity totals, and store totals.
4. Explain configuration state using Settings values that change later History interpretation.
5. Explain simple key/value settings table as a flexible but validation-heavy persistence pattern.
6. Revisit SQLite PRAGMA as repeated migration introspection.
7. Contrast read-only History rendering with editable Settings forms.

## Session Delta

Cycle 02 Codex evidence was reconciled with Cycle 01 didactic memory. New concepts were added for History + Settings while preserving Cycle 01 continuity around raw vs derived data, naming contracts, read models, repository result shape, service-owned responsibility, nullable values, SQLite schema evolution, PRAGMA, and PySide6 composition.
