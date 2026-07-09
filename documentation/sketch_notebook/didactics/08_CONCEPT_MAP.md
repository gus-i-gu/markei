# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Checkpoint
> Current Milestone: Register Product View — Product rhythms and read model

---

## Current Milestone

Markei added a lower Product View for Register-page product selection. The learning focus is the distinction between purchase rhythm, shelf-life rhythm, raw receipt data, derived product summaries, and service-prepared read models.

## Stable Concepts

None yet.

## Active Concepts

- &&&01 — Domain Model Field Semantics
- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &%%01 — Markei Purchase Rhythm Versus Shelf-Life Rhythm
- &%%02 — Product View Read Model
- &%%04 — Service-Owned Calculation Responsibility

## Unstable Concepts

- &&&04 — Cached Summary Field
- &&%01 — Optional Values and Nullable Fields
- &&%02 — Dataclass Field Evolution
- &%%03 — Repository Result Shape
- %%%01 — SQLite Schema Evolution
- %%%02 — SQLite PRAGMA
- %%%03 — PySide6 Read-Only Widget Composition

## Next Concepts

1. Teach same technical type versus different semantic ownership.
2. Teach raw receipt facts versus derived product summaries.
3. Teach nullable values as valid absence rather than failure.
4. Teach read models as service-prepared display data.
5. Teach SQLite `PRAGMA table_info` as schema introspection for safe migration.

## Dependency Spine

```text
&&&01 Domain Model Field Semantics
↓
&&&03 Naming as Data Contract
↓
&&&02 Raw Data Versus Derived Data
↓
&&&04 Cached Summary Field
↓
&%%01 Purchase Rhythm Versus Shelf-Life Rhythm
↓
&%%02 Product View Read Model
↓
&%%04 Service-Owned Calculation Responsibility
↓
&%%03 Repository Result Shape
↓
%%%01 SQLite Schema Evolution
↓
%%%02 SQLite PRAGMA
```

## Project Learning Spine

```text
Register inventory double-click
↓
ProductDetailPanel read-only display
↓
ProductService read-model assembly
↓
Repository explicit result keys
↓
Purchase.expiration_date as raw batch data
↓
Product.average_shelf_life_days as derived summary
↓
Product.expected_expiration_date as cached summary
↓
SQLite migration guarded by PRAGMA table_info
```

## Session Delta

Codex didactic evidence from `H_DDC_CODEX.md` was absorbed into the didactic domain. The domain now has first canonical KANBAN entries, glossary derivatives, and a compact checkpoint centered on Product View learning: purchase rhythm vs shelf-life rhythm, raw vs derived data, Optional/nullable values, read models, service-owned calculations, SQLite schema evolution, and SQLite PRAGMA.
