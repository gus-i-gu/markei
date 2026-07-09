# Functional Stage — Operational

## 1. Scope
Cycle 02 operational staging covers the History UI page and Settings Page as execution work: current implementation state, exact inspection/update targets, persistence and migration implications, validation commands, and continuity with Cycle 01 Product View evidence. This stage does not edit source code or permanent domain memory.

## 2. Accepted Facts
- `HistoryPage` currently exists as a placeholder with only a `QLabel("History")` and no purchase table, grouping, totals, or service calls.
- `SettingsPage` currently exists as a placeholder with only a `QLabel("Settings")` and no store editing or configuration UI.
- `MainWindow` already creates History and Settings tabs, but `refresh_pages()` refreshes only Storage, Shortage, and Market.
- `purchases` already stores `purchase_date`, `store_id`, `quantity`, `unit_price`, `total_price`, and optional `expiration_date`.
- `stores` already has `name`, `city`, `state`, and `address` persistence/display fields.
- Repository currently has generic purchase reads and store reads, plus Product View helpers; no History-specific grouped read helpers are visible.
- Service currently exposes `get_history()` as raw purchases, not grouped month/week periods.
- Existing database migration infrastructure is idempotent through `PRAGMA table_info(...)` plus nullable `ALTER TABLE ... ADD COLUMN ...`.
- No settings/preferences table or config persistence model is visible.
- `DATE_FORMAT` is `%d/%m/%Y`, but seed data still contains ISO-like dates, so date-format drift is already operationally relevant.

## 3. Current Implementation Questions
- Should settings/preferences be persisted in SQLite, a local config file, or constants until a later milestone?
- If persisted in SQLite, should one table store key/value settings or structured columns for history boundary and page sorting preferences?
- Should History grouping use purchase date only, or support alternate time references later such as expiration date or expected purchase date?
- What exactly means “ordered sequentially”: ascending chronological order for human history, or descending newest-first?
- What exactly means “trench purchases by month and week”: nested sections Month → Week, or independent period filters?
- For the first Wednesday month boundary, should purchases before that Wednesday belong to the previous operational month?
- Are Total rows per store/timeframe based on `SUM(total_price)`, `SUM(quantity * unit_price)`, or product-level value aggregation?
- Should store editing allow create/update/delete stores, or update only existing stores?
- Should Settings trigger immediate refresh of History after changing grouping rules?

## 4. Requirements for Main Synthesis
- Keep repository responsible for retrieving purchase/time/store data; avoid grouping logic in SQL unless limited to simple row retrieval/filtering.
- Add service-layer grouping for History periods using configurable month/week boundary rules.
- Add UI rendering of grouped History sections and per-store/timeframe Total rows.
- Add Settings persistence for time-reference/grouping rules and page sorting preferences if configuration must survive restart.
- Add store editing path using existing `stores.address` field; likely requires repository/service write methods for stores.
- Ensure Settings changes affect History grouping/bucketing without requiring source-code constant edits.
- Preserve Product View service/read-model behavior and receipt registration paths.
- Do not alter `average_duration_days`, `expected_next_purchase`, shelf-life calculations, or inventory classification.
- Include migration for any new settings/preferences table or new store fields if added.
- Include refresh wiring so History can update after new receipts and after Settings changes.

## 5. Continuity from Cycle 01
- Product View is implemented but still requires manual double-click UI validation; Cycle 02 should not obscure or regress this open validation item.
- Store address persistence/display already exists; Cycle 02 is the natural place to add store address editing in Settings.
- Manual double-click validation from Storage/Shortage/Market into Register remains open and should be rechecked after Settings/History changes to `MainWindow` refresh wiring.
- Date-format drift remains active and becomes more important because History grouping depends directly on parsing purchase dates.
- Inventory classification must remain based on `expected_next_purchase`; History grouping and Settings time reference must not silently change Storage/Shortage/Market classification.
- Existing migration infrastructure should be reused rather than reintroducing destructive reset behavior.
- Nullable expiration data from Cycle 01 should remain placeholder-safe in History if shown.

## 6. Risks / Open Questions
- Date parsing can fail or misbucket records if older seed/user rows use `YYYY-MM-DD` while services expect `%d/%m/%Y`.
- Month/week boundary rules around the first Wednesday need precise tests, especially dates before the first Wednesday.
- Settings persistence likely requires schema change and migration; lack of persistence would make Settings incomplete.
- Store editing can affect Product View store display, so regressions must be checked there.
- Total rows may be misleading unless the aggregation source is explicitly defined.
- UI grouping can become complex quickly; minimal implementation should prioritize correct service read model before presentation polish.
- Multiple pages may need refresh coordination; avoid stale History after receipt registration or settings updates.
- Deleting stores, if supported, risks orphaned or null store references unless behavior is explicitly defined.

## 7. Recommended Materialization Targets
- `app/database/schema.sql`
- `app/core/database.py`
- `app/core/models.py`
- `app/core/contracts.py`
- `app/core/repository.py`
- `app/core/services.py`
- `app/core/config.py`
- `app/desktop/main_window.py`
- `app/desktop/ui/pages/history_page.py`
- `app/desktop/ui/pages/settings_page.py`
- `app/desktop/ui/pages/register_page.py` only if refresh/Settings interaction requires it
- `app/database/seed.sql` if date-format drift or default settings seed must be corrected
- Optional new UI helper widget only if Main/Design approve reuse boundaries

## 8. Validation Plan
- Run `python -m compileall app`.
- Run `python -m app.core.database` and confirm migration completes without destructive reset.
- Inspect schema with PRAGMA for any new settings/preferences table and required store/config columns.
- Use an isolated temp `LOCALAPPDATA` workflow to register purchases across known Wednesday boundaries.
- Validate first-Wednesday month bucketing with dates before, on, and after the first Wednesday of a month.
- Validate weekly Wednesday bucketing with purchases on Tuesday, Wednesday, and Thursday around the same boundary.
- Validate History ordering matches the selected sequential rule.
- Validate Total rows per store/timeframe against known fixture purchases using `SUM(total_price)` or the selected aggregation rule.
- Validate Settings can edit store name/city/state/address and that Product View reflects updated store display.
- Validate Settings can change History time reference/grouping and History re-buckets without restarting, if required.
- Launch app with `python -m app.main`; confirm History and Settings tabs open without traceback.
- Manually register a purchase, refresh pages, and confirm History updates while Product View and inventory status still behave as before.
- Re-run Cycle 01 manual check: double-click Storage/Shortage/Market row opens Register Product View.
- Check `git diff --check` before report.

## 9. Handoff Summary
- History and Settings are currently placeholders; Cycle 02 is mostly new implementation.
- Existing purchase/store schema is sufficient for basic History rows and store display, but not for persisted settings/preferences.
- Add settings persistence only with idempotent migration.
- Service should own History period grouping and Total row read model.
- UI should render prepared grouped data, not compute date buckets ad hoc.
- Store editing should reuse existing `stores.address` field and add missing store write operations.
- Date normalization/parsing must be handled before reliable History grouping validation.
- Product View and purchase rhythm logic are protected continuity constraints.
- Main synthesis must define exact boundary semantics and total aggregation before Codex materialization.
- Validation must include both service-level boundary tests and manual PySide6 UI checks.
