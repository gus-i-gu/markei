# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Checkpoint
> Current Milestone: Cycle 03 — Read-Model Consolidation

---

## Current Milestone

Markei has moved from Cycle 02 History + Settings into Cycle 03 read-model consolidation. The learning focus is now the repeated pipeline:

```text
raw data
→ filtered frame
→ aggregate
→ derived metric
→ read model
→ UI presentation
```

Cycle 03 consolidates this pipeline through:

- Lists as one unified page with internal views;
- embedded History analytics inside `HistoryPage`;
- latest price and delta price as Lists read-model/display values;
- product cycle comparison using `average_duration_days` versus frame average purchase timelapse;
- mobile readiness through service/read-model boundaries rather than rewrite.

## Stable Concepts

- None fully Green yet.

## Active Concepts

- &&&01 — Domain Model Field Semantics
- &&&02 — Raw Data Versus Derived Data
- &&&03 — Naming as Data Contract
- &&&04 — Cached Summary Field
- &&&06 — Aggregation and Totals
- &&&07 — Grouping Versus Sorting
- &&%01 — Optional Values and Nullable Fields
- &&%03 — Date/Datetime Boundary Handling
- &%%01 — Markei Purchase Rhythm Versus Shelf-Life Rhythm
- &%%03 — Repository Result Shape
- &%%04 — Service-Owned Calculation Responsibility
- &%%05 — History Read Model
- %%%03 — PySide6 Read-Only Widget Composition

## New / Unstable Concepts

- &&&09 — Percentage as Derived Aggregate
- &&&10 — Filtering Frame
- &&&11 — Comparative Metric
- &&&12 — Baseline Definition
- &&&13 — Status Classification Versus UI Filtering
- &&&14 — Mobile Readiness Without Rewrite
- &&%04 — Platform-Neutral Read-Model Shape
- &&%05 — Nullable Derived Display Values
- &&%06 — UI View State
- &%%09 — History Analytics Read Model
- &%%10 — Unified Lists Page With Internal Views
- &%%11 — Latest Value / Delta Calculation
- &%%12 — Service Contract Stability
- %%%06 — PySide6 Composition for Embedded Analytics
- %%%07 — PySide6 Unified Page View Controls
- %%%08 — SQLite Read Queries Versus Cached Columns

## Explicit Decisions

- Cycle 03 did not introduce schema changes for Lists or History analytics.
- History analytics starts embedded in `HistoryPage`; detachable analytics remains deferred.
- Analytics frame means date range plus optional store filter.
- Frame average purchase timelapse means the average interval between all parsed purchases inside the selected frame, ordered by date.
- Product cycle means `average_duration_days`, the existing purchase recurrence rhythm.
- Product cycle is not shelf-life or expiration rhythm.
- Cycle comparison means product cycle minus frame average purchase timelapse, displayed as faster/slower/equal without configurable tolerance.
- Latest price and delta price are global per product for Lists in Cycle 03, not scoped to History date/store frames.
- Lists default view is the hybrid all-products view with a Status column.
- Lists internal views are `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy`.
- Register remains purchase-entry-only; Settings remains store-management surface.
- `pages.order` remains deferred/inert for active tab ordering.
- Mobile readiness is a boundary lesson, not a mobile implementation decision.

## Kept Explicitly Unstable

- detachable analytics widget lifecycle;
- store/frame-scoped price delta;
- configurable comparison tolerance;
- active `pages.order` consumption;
- mobile implementation architecture;
- API/backend rewrite;
- persisted analytics cache;
- physical deletion of old Storage/Shortage/Market page files.

## Next Concepts

1. Filtering frame before analytics calculation.
2. Product unit price versus product total spent versus frame total spent versus expenditure percentage.
3. Baseline definition and comparative metrics.
4. Product cycle versus shelf-life rhythm.
5. Lists internal views as UI state over one read model.
6. Status classification versus UI filtering.
7. Nullable derived display values for missing delta/cycle/frame data.
8. Platform-neutral service read models as mobile-readiness boundary.
9. PySide6 composition for embedded analytics and unified page controls.
10. SQLite read queries versus cached analytics columns.

## Dependency Spine

```text
&&&01 Domain Model Field Semantics
↓
&&&03 Naming as Data Contract
↓
&&&02 Raw Data Versus Derived Data
↓
&&&06 Aggregation and Totals
↓
&&&09 Percentage as Derived Aggregate
↓
&&&10 Filtering Frame
↓
&&&12 Baseline Definition
↓
&&&11 Comparative Metric
↓
&%%09 History Analytics Read Model
↓
&%%04 Service-Owned Calculation Responsibility
↓
&%%12 Service Contract Stability
↓
&&%04 Platform-Neutral Read-Model Shape
↓
&&&14 Mobile Readiness Without Rewrite
```

## Project Learning Spine

```text
Raw purchase/product/store rows
↓
Repository explicit result shape
↓
ProductService read-model assembly
↓
Lists unified 10-column row shape
↓
Lists internal views over shared rows
↓
Status classification displayed as a column
↓
Global latest/delta price display values
↓
History date/store frame controls
↓
Parsed frame rows and excluded/unparsed diagnostics
↓
Frame totals and average purchase timelapse
↓
Product expenditure percentage and cycle comparison
↓
Embedded History analytics rendering
↓
Platform-neutral service dictionaries/lists as future adapter boundary
```

## Lecture Progression

1. Raw rows versus derived display/read-model values.
2. Date/store filtering frame and excluded/unparsed rows.
3. Aggregation and totals before percentage.
4. Expenditure percentage as part/whole inside the selected frame.
5. Baseline definition and frame average purchase timelapse.
6. Product cycle as `average_duration_days`, not shelf-life.
7. Comparative metric as cycle minus baseline.
8. Lists as one page with internal views.
9. Status classification versus UI filtering.
10. Latest price and delta price as global per-product read-model values.
11. Service contracts and platform-neutral read models as mobile readiness without rewrite.

## Session Delta

Cycle 03 Codex evidence was absorbed from `H_DDC_CODEX.md`, with `G_OPS_CODEX.md` and `I_DSN_CODEX.md` used for validation and boundary context. The notebook now reflects that Lists and History analytics were implemented as service-owned read models, UI renders prepared values without direct SQL, no schema changes were introduced, and mobile preparation remains a separation/boundary concept rather than a rewrite path.
