# 13_LECTURE_REGISTER.md

> Domain: Didactic
> Status: Observational learning history

---

## 2026-07-09 — Product View Didactic Absorption

### Source Evidence

- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

### Learning Event

Codex materialization evidence exposed a coherent learning cycle around the Register-page Product View. The feature introduced shelf-life data, Product View read-model assembly, nullable model-field evolution, schema-safe migration, and explicit separation between service calculation and UI rendering.

### Concepts Absorbed

- &&&01 — Domain Model Field Semantics
- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &&&04 — Cached Summary Field
- &&%01 — Optional Values and Nullable Fields
- &&%02 — Dataclass Field Evolution
- &%%01 — Markei Purchase Rhythm Versus Shelf-Life Rhythm
- &%%02 — Product View Read Model
- &%%03 — Repository Result Shape
- &%%04 — Service-Owned Calculation Responsibility
- %%%01 — SQLite Schema Evolution
- %%%02 — SQLite PRAGMA
- %%%03 — PySide6 Read-Only Widget Composition

### Key Didactic Observation

The main learner risk is semantic collapse: treating `average_duration_days`, `average_shelf_life_days`, `expected_next_purchase`, `expected_expiration_date`, and `expiration_date` as interchangeable date or duration fields. The lesson should emphasize semantic ownership before implementation mechanics.

### Recommended Next Lecture Sequence

1. Same type, different meaning: field semantics.
2. Raw receipt facts versus derived product summaries.
3. Optional and nullable values as valid absence.
4. Read model as service-prepared display shape.
5. SQLite schema evolution and `PRAGMA table_info`.
6. PySide6 read-only composition after the domain meaning is stable.

### Remaining Didactic Risks

- `expected_expiration_date` may be mistaken for actual purchase-level expiration history.
- Product View UI may be mistaken as the owner of calculations.
- SQLite PRAGMA may be treated as ordinary SQL instead of SQLite metadata introspection.
- Nullable fields may be treated as errors instead of intentionally supported absence.

---

## 2026-07-09 — Cycle 02 History + Settings Didactic Reconciliation

### Source Evidence

- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

### Learning Event

Cycle 02 introduced History and Settings as a continuation of Cycle 01. The feature exposed time bucketing by business boundaries, grouping distinct from sorting, aggregate Total rows, SQLite-backed configuration state, Settings-owned preferences, store editing, and separate read-only versus editable PySide6 composition.

### Concepts Promoted / Added

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

### Concepts Reinforced From Cycle 01

- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &&%01 — Optional Values and Nullable Fields
- &%%03 — Repository Result Shape
- &%%04 — Service-Owned Calculation Responsibility
- %%%01 — SQLite Schema Evolution
- %%%02 — SQLite PRAGMA
- %%%03 — PySide6 Read-Only Widget Composition

### Explicit Decisions

- Simple Key/Value Table is a glossary concept and lecture example under `%%%04 SQLite Settings Persistence`, not a standalone KANBAN concept in this cycle.
- SQLite PRAGMA moves from Red exploratory to Yellow reinforced knowledge after reuse in two successful migration cycles. It is still not Green until taught explicitly.
- Page sorting persistence exists, but page sorting behavior is not fully implemented; teaching must preserve that distinction.
- Operational month grouping is not plain calendar-month grouping; it depends on the first-Wednesday boundary.

### Recommended Next Lecture Sequence

1. Grouping versus sorting.
2. Time bucketing by business boundaries.
3. Aggregation and totals as derived data.
4. Configuration state and Settings-owned preferences.
5. Simple key/value settings table tradeoffs.
6. SQLite PRAGMA as migration introspection.
7. Read-only History UI versus editable Settings forms.

### Remaining Didactic Risks

- The learner may treat grouping as only visual sorting.
- Total rows may be mistaken for raw purchase rows.
- Settings may be mistaken as the owner of History calculations.
- Simple key/value tables may look easier than they are because values require parsing and validation.
- PRAGMA may still be mistaken for normal table data access rather than metadata introspection.
