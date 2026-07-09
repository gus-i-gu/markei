# Operational State

> Checkpoint refreshed from Cycle 02 Codex evidence and manual validation.

## Current Implementation State

- Cycle 01 Product View remains implemented and operational after Cycle 02.
- Register remains operational after Cycle 02.
- History page is implemented and functional.
- Settings page is implemented and functional.
- Store editing through Settings is implemented and updates are reflected across pages.
- Store address persistence/display exists and now has Settings UI editing support.
- Store update through Register still requires investigation.
- Product View read model remains service-driven and read-only.
- Inventory classification remains based on `expected_next_purchase`.
- Purchase rhythm remains separate from shelf-life rhythm:
  - `average_duration_days` / `expected_next_purchase`
  - `average_shelf_life_days` / `expected_expiration_date`
- History grouping is service-driven with Month -> Week sections.
- Default History time rules are implemented:
  - month boundary: first Wednesday
  - week boundary: Wednesday
- History totals are service-prepared from stored purchase values.
- SQLite-backed settings persistence exists through `settings(key, value)`.
- Page sorting persistence exists through `pages.order`, but tab-reordering UI behavior remains deferred.
- History configuration UI currently exposes only implemented defaults.

## Validation Evidence

- Cycle 02 Codex validation passed `python -m compileall app`.
- Database initialization/migration opened existing user DB without destructive reset.
- `settings` table migration validated with `PRAGMA table_info(settings)` returning `key`, `value`.
- Existing user DB contained default settings for `history.week_boundary`, `history.month_boundary_rule`, and `pages.order`.
- Existing user DB History service read returned one month section and zero unparsed purchase dates.
- Product View regression check returned expected Cycle 01 keys.
- Inventory regression check returned normal `product_status()` behavior.
- Qt app startup reached event loop without traceback; full terminal-driven interaction remained limited.
- Boundary test grouped `30/06/2026` into Operational June 2026.
- Boundary test grouped `01/07/2026` into Operational July 2026.
- Boundary test started a new Wednesday week on `08/07/2026`.
- Settings persistence read/write survived SQLite-backed service readback.
- Store create/update worked through service/repository and manual validation confirms store edits are reflected across pages.
- Manual validation confirms History page, Settings page, Register, and Product View are functional.

## Remaining Operational Work

- Investigate store update through Register.
- Investigate multi-store History totals.
- Decide whether/when `pages.order` should be consumed by MainWindow for actual tab/page sorting behavior.
- Expand manual UI QA for History grouped rendering and Settings store editing after further changes.
- Continue monitoring unsupported historical date formats surfaced through `unparsed_rows`.

## Known Implementation Limitations

- Store deletion remains intentionally deferred.
- Page sorting is persisted but not yet applied to MainWindow tab ordering.
- History configuration UI currently exposes implemented defaults rather than a broad custom rule editor.
- Existing unsupported date formats are reported, not repaired.
- Full automated PySide6 interaction coverage is not present.

## Active Operational Risks

- Multi-store aggregate behavior may need correction or clearer validation.
- Store update paths may diverge between Settings and Register if Register attempts store-related edits.
- Date-format drift can affect History bucketing if stored rows use unsupported formats.
- Settings persistence must not silently desynchronize from visible UI behavior.
