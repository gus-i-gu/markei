# Functional Stage — Operational

## 1. Scope
This stage records the operational implementation diagnosis for the Product View feature in Markei, focused on persistence impact, UI execution path, validation, migration risk, and safe materialization sequencing. It does not decide architecture beyond operational defaults and does not modify permanent notebook domains.

## 2. Accepted Facts
- Product View is opened from inventory pages by double-clicking a product row and returning to Register.
- Storage, Shortage, and Market already contain double-click navigation into `MainWindow.edit_product()`.
- Register currently loads selected product data into the editable form but has no lower Product View panel.
- Existing product rhythm fields are `average_duration_days` and `expected_next_purchase`.
- New shelf-life fields must remain separate: `average_shelf_life_days` and `expected_expiration_date`.
- Current purchases do not store an expiration/expiring date.
- Current stores schema has name/city/state, but no explicit full address field.
- Existing database initialization preserves an existing local SQLite database unless reset is explicitly requested.

## 3. Requirements for Main Synthesis
- Preserve purchase-to-purchase behavior for `average_duration_days` and `expected_next_purchase`.
- Add shelf-life behavior separately using `average_shelf_life_days` and `expected_expiration_date`.
- Add an optional purchase-level expiration date before Product View can show real expiring dates.
- Decide whether store address means a new address column or temporary city/state display.
- Decide whether average price should be dynamically computed or cached.
- Keep inventory status logic based on `expected_next_purchase` unless Design/Main explicitly changes it.
- Include a database migration path because existing local DBs will not update from `schema.sql` alone.
- Keep first materialization minimal: schema/model/repository/service/Register Product View.

## 4. Risks / Open Questions
- Existing SQLite databases may fail after schema/model changes without migration or reset.
- Resetting the local DB can destroy user test data.
- Merging shelf-life and purchase rhythm would violate accepted domain naming.
- Product View depends on expiration data that is not currently captured.
- Store address is underspecified by the current schema.
- Average price is requested but not currently stored as a product summary.
- Extracting Product View into a reusable widget may be better design, but is not required for the minimal patch.

## 5. Recommended Materialization Targets
- `app/database/schema.sql`
- `app/core/models.py`
- `app/core/contracts.py`
- `app/core/repository.py`
- `app/core/services.py`
- `app/core/database.py`
- `app/desktop/main_window.py`
- `app/desktop/ui/pages/register_page.py`
- `app/desktop/ui/pages/storage_page.py`
- `app/desktop/ui/pages/shortage_page.py`
- `app/desktop/ui/pages/market_page.py`
- Optional inspection: `app/desktop/ui/pages/history_page.py`
- Operational notebook areas: DEV_STAGE synthesis files only until promotion is approved.

## 6. Handoff Summary
- Existing double-click path already reaches Register through `edit_product()`.
- Register needs a lower Product View panel populated by `load_product(product)`.
- Add `expiration_date` to purchases as nullable text.
- Add `average_shelf_life_days` and `expected_expiration_date` to products as nullable calculated fields.
- Preserve `average_duration_days` calculation exactly as purchase-to-purchase rhythm.
- Extend repository insert/update/mappers for new fields.
- Extend service recalculation with separate shelf-life calculations.
- Add migration or approved reset process before running with an existing local DB.
- Validate with compile, schema inspection, app launch, manual receipt entry, and double-click UI checks.
- Defer unresolved architecture/domain choices to Main/Design synthesis.
