# Codex Report — Design

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Architectural Decisions Materialized

- Product View was implemented as a reusable read-only `ProductDetailPanel`.
- RegisterPage owns panel placement below the writable receipt form.
- MainWindow double-click navigation remains unchanged.
- ProductService owns Product View read-model assembly.
- Repository owns SQL retrieval, migration-visible persistence shape, and row mapping.
- Product owns cached summary fields for purchase rhythm and shelf-life summary.
- Purchase owns optional `expiration_date` as receipt/batch history.
- Store owns nullable `address`.
- Average price remains derived from purchases.

## Files Changed Or Created For Design Reasons

- `app/desktop/ui/widgets/product_detail_panel.py`: isolates read-only Product View rendering.
- `app/desktop/ui/pages/register_page.py`: composes the panel and passes service-prepared data into it.
- `app/core/services.py`: centralizes shelf-life calculation and Product View read-model assembly.
- `app/core/repository.py`: provides explicit SQL read helpers for average price, latest store rows, and last purchase rows.
- `app/core/models.py`: reflects ownership changes in Product, Purchase, and Store dataclasses.
- `app/core/database.py` and `app/database/schema.sql`: materialize persistence shape and migration.

## Responsibility Boundaries Preserved

- RegisterPage placement versus business calculation: preserved; RegisterPage collects optional expiration input and loads the panel but does not calculate shelf-life or averages.
- ProductDetailPanel display versus persistence access: preserved; the widget renders dictionaries and does not open repositories or services.
- Repository retrieval versus service calculation: preserved; repository returns rows and aggregate price, while ProductService decides read-model assembly and shelf-life meaning.
- Product summary fields versus Purchase history fields: preserved; `expiration_date` remains purchase-level and `average_shelf_life_days` / `expected_expiration_date` are Product summaries.
- Derived average price versus cached price fields: preserved; Product View average price comes from purchase rows.
- Purchase rhythm versus shelf-life rhythm: preserved; purchase classification still uses `expected_next_purchase`.
- Uniform `expiration_date` naming: preserved across schema, model, repository, service, and UI display.
- Reusable Product View panel composition: preserved through `ProductDetailPanel`.

## Boundary Drift

- No architecture boundary drift was intentionally introduced.
- `RegisterPage` now contains optional receipt expiration input in addition to Product View placement; this matches the staged purchase-level expiration support.

## Product / Purchase / Store Ownership Evidence

- Product: `average_duration_days`, `expected_next_purchase`, `average_shelf_life_days`, and `expected_expiration_date`.
- Purchase: `purchase_date`, quantity, unit, unit price, total price, promotion, and optional `expiration_date`.
- Store: `name`, `city`, `state`, and nullable `address`.

## Product View UI Composition Evidence

- Product identity line renders name, brand, and ID.
- Summary line renders derived average price, average shelf-life, and expected expiration.
- Store table renders store name, store ID, address, latest price, and latest purchase date.
- Last purchases table always includes the expiration-date column.
- Missing values render as a placeholder.

## Open Design Questions

- Store address persistence exists, but store address entry/editing remains outside this milestone.
- Product-level `expected_expiration_date` exists for future analysis; later design should decide where it becomes user-facing beyond the Product View summary.

## Suggested [D] Follow-Up

- Absorb this report into design memory as evidence for the Product View read-model boundary.
- Decide whether a future store-management screen should own address editing.
