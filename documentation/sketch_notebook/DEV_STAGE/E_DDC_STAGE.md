# Materialization Stage — Didactic

## 1. Scope

This stage gives Codex didactic reporting instructions for Cycle 03: Lists remodel, embedded History analytics, latest/delta price expansion, and mobile-readiness preparation.

Codex must preserve learning evidence for Didactic Chat in `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md` after materialization.

Codex must not promote or edit permanent didactic memory in this pass.

## 2. Source Inputs

Codex must read:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

The didactic source of truth for this pass is staged learning evidence, not permanent didactic promotion.

## 3. Didactic Invariants

Codex should preserve and report these distinctions:

- raw purchase/product/store rows are not the same as derived display values
- a filtering frame determines which rows participate in analytics
- date range plus optional store filter is the Cycle 03 analytics frame
- aggregates such as totals and averages precede percentages and comparisons
- percentage is a derived aggregate: product total divided by selected-frame total
- comparative metric requires an explicit baseline
- Cycle 03 baseline is the average interval between all parsed purchases in the selected date/store frame, ordered by date
- Product cycle means `average_duration_days`, not shelf-life or expiration
- Lists internal views are UI view/filter states over shared read-model data
- Product status classification belongs to service logic, not UI widgets
- latest price and delta price are global per-product read-model/display values in Cycle 03
- mobile readiness means stable service/read-model boundaries, not a mobile rewrite

## 4. Concepts Codex Should Report for Didactic Chat

Report these as implementation evidence or concept candidates in `H_DDC_CODEX.md`.

### Foundational CS concepts (`&&&`)

- Raw Data Versus Derived Data
- Percentage as Derived Aggregate
- Temporal / Spatial Filtering Frame
- Aggregation and Totals
- Comparative Metric
- Baseline Definition
- Grouping / Filtering Versus Data Ownership
- Status Classification Versus UI Filtering
- Mobile Readiness Without Rewrite

### Python / language concepts (`&&%`)

- Platform-neutral read-model shape
- Nullable derived display values
- UI view state
- Date/datetime boundary handling

### Markei implementation concepts (`&%%`)

- History Analytics Read Model
- Unified Lists Page With Internal Views
- Product Status Classification Versus UI Filtering
- Latest Value / Delta Calculation
- Service Contract Stability
- Product Cycle Versus Shelf-Life
- Mobile readiness through service/read-model contracts

### Dependency / tool concepts (`%%%`)

- PySide6 widget composition for embedded analytics
- PySide6 unified page view controls
- SQLite read queries versus cached columns
- SQLite aggregation/read support for analytics where used

## 5. Learning Evidence Codex Should Capture

Codex should report compact evidence for these learning claims:

### Read-model consolidation

Show how Cycle 03 moved Markei from separate page-specific display logic toward service-prepared read models for Lists and History analytics.

### Raw-to-derived analytics pipeline

Report how implementation follows or deviates from this pipeline:

```text
raw data
→ filtered frame
→ aggregate
→ derived metric
→ read model
→ UI presentation
```

### Lists learning evidence

Report:

- how former Storage/Shortage/Market meanings became Lists internal views
- how the hybrid all-products view works
- whether all list views share one row shape
- how Status is represented
- how Price and Δ Price are supplied
- whether UI code recalculates any service-owned meanings

### History analytics learning evidence

Report:

- where date/store frame selection is collected
- where frame semantics are interpreted
- how total spent is calculated
- how expenditure percentage is calculated
- how average purchase timelapse is calculated
- how product cycle comparison is calculated
- how unparsed/excluded rows are handled

### Mobile-readiness learning evidence

Report how implementation supports future portability through:

- stable service method(s)
- plain read-model values
- separation from PySide6 widget details
- repository/service/UI boundary preservation

Do not report this as mobile implementation.

## 6. Concepts Not Ready for Canon

Codex should explicitly report that these remain deferred or unstable if they appear during implementation:

- detachable analytics widget lifecycle
- store/frame-scoped price delta
- configurable comparison tolerance
- active `pages.order` consumption
- mobile implementation architecture
- API/backend rewrite
- persisted analytics cache
- physical deletion of old Storage/Shortage/Market page files

## 7. Didactic Risks to Report

Codex should identify whether implementation introduced or avoided these confusions:

- raw unit price versus total spent versus expenditure percentage
- product cycle versus shelf-life
- baseline average timelapse ambiguity
- UI view grouping/filtering versus persistence
- derived display field versus cached database field
- mobile preparation versus mobile rewrite
- treating History analytics as only a widget rather than a read-model pipeline

## 8. H_DDC_CODEX.md Report Shape

After materialization, write:

`documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

Keep it compact and evidence-oriented.

Required sections:

1. Source stage files read
2. Coding concepts exposed
3. Concept candidates by marker
4. Existing concepts reinforced
5. Lists read-model consolidation evidence
6. History analytics pipeline evidence
7. Latest/delta price evidence
8. Product cycle versus shelf-life evidence
9. Service vs Repository vs UI responsibility evidence
10. Mobile-readiness boundary evidence
11. Concepts deferred / not ready for canon
12. Didactic risks or remaining confusions
13. Suggested Didactic Chat follow-up

Do not reproduce long code.
Do not edit permanent didactic files.
