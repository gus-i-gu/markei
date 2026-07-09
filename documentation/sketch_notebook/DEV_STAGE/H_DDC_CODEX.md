# Codex Report — Didactic

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Coding Concepts Exposed

- Schema evolution without destructive reset.
- Nullable model-field evolution across schema, dataclasses, repository mappers, service calculations, and UI rendering.
- Separation of raw receipt facts from derived product summaries.
- Product View read-model assembly as a service responsibility.
- Read-only widget composition in PySide6.

## Concept Candidates By Marker

- `&&&` Semantic field distinction: purchase rhythm and shelf-life rhythm use date intervals but mean different things.
- `&&&` Raw data versus derived data: `Purchase.expiration_date` is raw batch data; `Product.average_shelf_life_days` is calculated.
- `&&&` Naming as data contract: uniform `expiration_date` naming was used at schema, model, repository, service, and UI boundaries.
- `&&&` Cached summary field: `expected_expiration_date` is a product summary field, not the source expiration fact.
- `&%%` Product summary state in Markei: Product now holds purchase rhythm and shelf-life summary separately.
- `&%%` Purchase rhythm versus shelf-life rhythm: `average_duration_days` remains purchase-to-purchase; `average_shelf_life_days` is purchase-to-expiration.
- `&%%` Product View read model: ProductService returns explicit identity, price, shelf-life, store, and purchase-history rows.
- `&%%` Service-owned calculation responsibility: average price, shelf-life, and expected expiration are not calculated in UI.
- `&%%` Repository result shape: repository returns explicit keys such as `purchase_date`, `expiration_date`, and `latest_unit_price`.
- `&&%` Dataclass field evolution: `Product`, `Purchase`, and `Store` gained optional fields compatible with existing records.
- `&&%` Optional values / nullable fields in Python models: missing expiration and address values render as placeholders.
- `%%%` SQLite schema evolution: migration adds columns only when absent.
- `%%%` SQLite PRAGMA: `PRAGMA table_info` was used for column metadata inspection.
- `%%%` PySide6 widget composition: Product View was extracted into `ProductDetailPanel`.

## Naming / Semantic Distinctions Preserved

- `average_duration_days` was not repurposed.
- `expected_next_purchase` remains tied to purchase cadence.
- `average_shelf_life_days` is distinct from purchase cadence.
- `expected_expiration_date` is a cached product summary, while `expiration_date` is purchase-level history.
- Average price is derived from purchases, not cached on Product.

## Raw Data Vs Derived Data Evidence

- Raw data: `purchases.expiration_date` is inserted with each receipt and may be null.
- Derived data: `products.average_shelf_life_days` is recalculated from purchase rows that have expiration data.
- Derived data: `products.expected_expiration_date` is estimated from the latest purchase date plus average shelf-life.
- Derived display: Product View average price is calculated from purchase unit prices.

## Responsibility Evidence

- Repository owns SQL migration-visible shape, insert/update/select, joins, and row mapping.
- Service owns purchase rhythm, shelf-life, expected expiration, average price retrieval orchestration, and Product View assembly.
- UI owns form input, panel placement, and read-only rendering.

## PRAGMA Note

PRAGMA is a SQLite command family for database metadata and settings. `PRAGMA table_info(table_name)` returns information about a table's columns. Here it checks whether migration columns already exist before `ALTER TABLE` runs.

## Didactic Risks Or Confusions Remaining

- The same date type appears in multiple places but has different meanings; later learning material should emphasize semantic ownership rather than column type.
- `expected_expiration_date` may be confused with actual purchase expiration history unless Product-level summary and Purchase-level raw data are taught separately.

## Suggested [A] Follow-Up

- Decide whether SQLite PRAGMA becomes a `%%%` KANBAN concept.
- Consider didactic material on read models and nullable schema evolution using this Product View milestone as the project example.
