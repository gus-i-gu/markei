# Operational Model

## Product View Operational Model

- Product View is a read-only inspection surface displayed in the lower portion of Register after product navigation from inventory pages.
- Inventory pages initiate Product View loading through double-click row selection and `MainWindow.edit_product(product)`.
- Register remains the writable receipt/product page; Product View is observational display only.
- Product View consumes prepared service read-model data rather than querying persistence directly from UI code.
- Cycle 02 manual validation confirms Product View remains operational.

## Rhythm and Expiration Model

- `average_duration_days` is the purchase-to-purchase rhythm and remains operationally distinct from shelf life.
- `expected_next_purchase` is predicted from purchase rhythm.
- `average_shelf_life_days` is the purchase-to-expiration rhythm.
- `expected_expiration_date` is predicted or summarized from shelf-life rhythm.
- `purchases.expiration_date` is optional, allowing older or unknown expiration data to remain valid.
- Inventory status classification remains tied to `expected_next_purchase` unless a future design decision changes it.

## History Operational Model

- History is a read-only page assembled from service-prepared History read-model data.
- Repository retrieves purchase, product, time, and store data.
- Service groups purchases into operational Month -> Week sections.
- Default operational month boundary is the first Wednesday of the month.
- Default week boundary is Wednesday.
- History supports date-drift handling by reporting unsupported rows through `unparsed_rows` rather than repairing them.
- History totals use stored purchase values as service-prepared aggregates.
- Multi-store History totals require further investigation before being considered fully validated.

## Settings Operational Model

- Settings is the user-facing page for implemented configuration and store create/update.
- Settings persistence uses SQLite-backed `settings(key, value)` rows.
- Implemented settings include:
  - `history.week_boundary`
  - `history.month_boundary_rule`
  - `pages.order`
- Default settings are inserted idempotently and existing user choices are preserved.
- History configuration UI currently exposes implemented defaults.
- Page sorting persistence exists, but MainWindow tab sorting behavior remains deferred.
- Store editing through Settings supports create/update for store name, city, state, and address.
- Store deletion remains deferred.
- Store update through Register remains an investigation item.

## Persistence and Migration Model

- Schema evolution must account for existing local SQLite databases.
- Database migration should be idempotent and inspect current table shape before adding missing columns/tables.
- Destructive reset is not the default operational path.
- Cycle 01 migration-relevant fields:
  - `purchases.expiration_date`
  - `products.average_shelf_life_days`
  - `products.expected_expiration_date`
  - `stores.address`
- Cycle 02 migration-relevant structure:
  - `settings(key, value)`
  - default settings insertion with existing-value preservation

## Validation Model

- Operational validation proceeds in layers:
  - compile/syntax validation
  - database initialization/migration validation
  - schema inspection
  - service-level read/write validation
  - application startup validation
  - manual interactive UI validation
- Product View has compile/database/service/startup evidence and Cycle 02 manual operational confirmation.
- History and Settings have compile/database/service/startup evidence and Cycle 02 manual operational confirmation.
- Manual validation is still required for specific edge cases:
  - store update through Register
  - multi-store History totals
  - future page sorting behavior from `pages.order`

## Known Operational Boundaries

- Average price is derived for Product View and is not currently a cached product field.
- Date calculations assume stored data can be parsed by supported date handling.
- Unsupported date formats are reported, not automatically repaired.
- Settings persistence must not be confused with completed UI behavior when a persisted key is not yet consumed.
