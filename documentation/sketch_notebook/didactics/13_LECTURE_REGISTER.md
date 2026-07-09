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
