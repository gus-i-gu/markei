# Codex Report — Operational

## Source Stage Files

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

## Files Changed

- `app/database/schema.sql`: added nullable `purchases.expiration_date`, `products.average_shelf_life_days`, `products.expected_expiration_date`, and `stores.address`.
- `app/core/database.py`: added idempotent PRAGMA-driven migration and changed module execution to initialize/migrate without destructive recreation.
- `app/core/models.py`: added new optional fields to `Purchase`, `Product`, and `Store`.
- `app/core/contracts.py`: added new calculated/product and purchase contract fields.
- `app/core/repository.py`: added SQL insert/update/mapping support and Product View read helpers.
- `app/core/services.py`: added shelf-life calculation, product expiration summary calculation, and Product View read-model assembly.
- `app/desktop/ui/pages/register_page.py`: added optional expiration-date input and embedded Product View panel loading.
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`: populated this operational report.
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`: populated didactic evidence report.
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`: populated design evidence report.

## Files Created

- `app/desktop/ui/widgets/product_detail_panel.py`: reusable read-only Product View panel.

## Files Deleted

- None.

## Commands Run

- `python -m compileall app`
- `python -m app.core.database`
- `python -c "... PRAGMA table_info(...) ..."`
- `python -c "... ProductService ... get_product_view ..."`
- `python -m app.main`
- `Stop-Process -Id 26064,14340`
- isolated temp-`LOCALAPPDATA` registration workflow using `ProductService`
- `git diff --check`

## Validation Results

- `python -m compileall app`: passed.
- `python -m app.core.database`: passed; reported existing database path and existence without destructive reset.
- `python -m app.main`: launched GUI processes and timed out because the Qt event loop stayed open; no import/startup traceback appeared. The spawned processes were stopped.
- Product View service read on migrated user database: passed; returned product identity, derived average price, store/latest price row, last purchase row, and `expiration_date: None` for existing purchase data.
- Isolated write workflow: passed. Registered one receipt without `expiration_date` and one with `expiration_date`; purchase rhythm stayed 10 days, `expected_next_purchase` was `21/07/2026`, shelf-life average was 10 days, `expected_expiration_date` was `21/07/2026`, and average price was derived as 11.0.
- `git diff --check`: no whitespace errors; Git emitted line-ending normalization warnings only.

## Migration Evidence

Existing user database PRAGMA output after normal connection:

- `purchases`: includes `expiration_date`.
- `products`: includes `average_shelf_life_days` and `expected_expiration_date`.
- `stores`: includes `address`.

Migration is idempotent through `PRAGMA table_info(table)` inspection and `ALTER TABLE ... ADD COLUMN ...` only when missing.

## Instructions Completed

- Preserved `average_duration_days` as purchase-to-purchase rhythm.
- Preserved `expected_next_purchase` as purchase-rhythm prediction.
- Added separate `average_shelf_life_days` purchase-to-expiration calculation.
- Added optional purchase `expiration_date`.
- Added nullable product `expected_expiration_date`.
- Added nullable store `address`.
- Kept average price derived from purchases for Product View.
- Kept Product View read-only.
- Kept repository responsible for persistence and SQL row shape.
- Kept service responsible for calculations and Product View read-model assembly.
- Kept UI responsible for rendering prepared data.
- Added reusable lower Product View panel to RegisterPage.
- Preserved inventory page classification by `expected_next_purchase`.

## Instructions Skipped

- No permanent domain folder updates were performed, per staging boundary.
- No methodology files were modified.

## Failures Or Blockers

- Full interactive manual UI validation was not completed inside the terminal session; `python -m app.main` entered the expected GUI event loop and was stopped after startup.

## Unresolved Operational Risks

- Existing historical records may use mixed date formats if older seed data was recalculated manually; shelf-life calculation expects the same configured date format as purchase rhythm.
- Store address has persistence and display support, but no store-editing UI was added in this milestone.

## Suggested Functional Follow-Up

- Manually verify the desktop UI by double-clicking Storage/Shortage/Market rows and inspecting the Register lower Product View panel.
- Decide whether store address editing belongs in a later store-management milestone.
