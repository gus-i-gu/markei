# Operational Stage — Cycle 03 Coordinated Staging

## 1. Methodology Recovery

`documentation/sketch_notebook/INDEX.md` was read first.

Methodology boot was then loaded according to the current INDEX route:

1. `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
2. `documentation/sketch_notebook/methodology/FLUX.md`
3. `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
4. `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`

`CHAT_BEHAVIOUR.md` and `METHOD_GLOSSARY.md` were not required for this cycle staging because the Operational Chat role, routing authority, stage-file authority, and vocabulary were clear from the primary boot files.

Operational recovery followed the hierarchical recovery route. The operational checkpoint was read first:

`documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md`

The checkpoint was sufficient for current operational state recovery. Repository inspection was limited to implementation truth, source-file relevance, validation planning, and drift prevention for Cycle 03.

## 2. Recovered Operational State

Only the following recovered state is operationally relevant to Cycle 03:

- Cycle 01 Product View remains implemented and operational.
- Register remains operational and is still the purchase-entry surface.
- History page is implemented and functional.
- Settings page is implemented and functional.
- Store management currently belongs to Settings.
- Store editing through Settings is implemented and reflected across pages.
- Store update through Register remains a previous-cycle investigation item, but Main has now resolved that Register should remain purchase-entry-only for this cycle.
- Product View remains service-driven and read-only.
- Inventory classification remains based on `expected_next_purchase`.
- Purchase recurrence rhythm is represented by `average_duration_days` / `expected_next_purchase`.
- Shelf-life rhythm remains separate through `average_shelf_life_days` / `expected_expiration_date`.
- History grouping is service-driven with Month -> Week sections.
- History totals are service-prepared from stored purchase values.
- SQLite-backed settings persistence exists through `settings(key, value)`.
- `pages.order` persistence exists, but visible tab/page ordering remains deferred.
- Existing unsupported historical date formats are reported through `unparsed_rows`, not repaired.
- Multi-store aggregate behavior still requires explicit validation before analytics depends on it.
- Full automated PySide6 interaction coverage is not present, so manual desktop QA remains required.

Direct implementation checks confirmed the current UI split that Cycle 03 must remodel:

- `app/desktop/main_window.py` mounts `Storage`, `Shortage`, and `Market` as separate top-level tabs.
- `StoragePage` already uses a 10-column table with `Price` and `Δ Price`.
- `ShortagePage` and `MarketPage` still use smaller 8-column tables without `Price` and `Δ Price`.
- `HistoryPage` currently embeds a grouped tree view and warning label, but no analytics widget.
- `ProductService` remains the correct layer for read models and business calculations.

## 3. Main Decisions Accepted

Operational staging accepts Main's Cycle 03 synthesis as binding for this stage:

1. History analytics starts embedded in `HistoryPage`.
2. Detachable analytics behavior is deferred.
3. Analytics frame means date range plus optional store filter.
4. Average purchase timelapse means the average interval between all parsed purchases in the selected date/store frame, ordered by date.
5. Product cycle means `average_duration_days`, the existing purchase recurrence rhythm.
6. Cycle comparison means `product cycle - frame/store average timelapse`.
7. Cycle comparison display should be simple: faster / slower / equal.
8. No configurable comparison tolerance is introduced in Cycle 03.
9. Latest price and delta price are global per product for Lists in Cycle 03.
10. Latest price and delta price are not scoped to the selected store/frame this cycle.
11. Lists default view is the hybrid all-products list with a Status column.
12. Lists must expose internal views:
    - `in-house`
    - `shortage`
    - `to-buy`
    - `in-house + shortage`
    - `shortage + to-buy`
13. `pages.order` remains deferred and must not be activated this cycle.
14. Register remains purchase-entry-only.
15. Store management stays in Settings.
16. Old `StoragePage`, `ShortagePage`, and `MarketPage` source files should be retained temporarily unless safe deletion is explicitly justified later.
17. Schema changes should be avoided for analytics and Lists unless an unavoidable implementation blocker is discovered.

Operational translation of these decisions:

- Cycle 03 should be implemented as a UI/read-model remodel, not a database remodel.
- Lists and History analytics should consume service-prepared plain data structures.
- PySide pages/widgets should render prepared values and should not own business grouping, classification, or analytics calculations.
- Repository changes should be limited to row retrieval support if existing purchase/history queries cannot provide the selected date/store frame.

## 4. Exact Source Files To Inspect / Modify

### Navigation / app bootstrap

Likely modify:

- `app/desktop/main_window.py`

Purpose:

- Replace separate top-level `Storage`, `Shortage`, and `Market` tabs with one top-level `Lists` tab.
- Preserve `Register`, `History`, and `Settings` top-level tabs.
- Keep compatibility navigation helpers:
  - `open_storage()` should route to Lists with the `in-house` view.
  - `open_shortage()` should route to Lists with the `shortage` view.
  - `open_market()` should route to Lists with the `to-buy` view.
- Update `refresh_pages()` so it refreshes Lists and History without referencing removed top-level page instances.
- Preserve `edit_product()` and Register loading behavior.

Inspect for startup integration:

- `app/main.py`
- `app/__main__.py` if present or used by validation commands.

### Lists UI

Likely add/modify application source during Codex materialization:

- `app/desktop/ui/pages/lists_page.py`

Retain temporarily:

- `app/desktop/ui/pages/storage_page.py`
- `app/desktop/ui/pages/shortage_page.py`
- `app/desktop/ui/pages/market_page.py`

Purpose:

- Add a single Lists page with internal view switching.
- Default to the hybrid all-products view.
- Expose internal views:
  - `in-house`
  - `shortage`
  - `to-buy`
  - `in-house + shortage`
  - `shortage + to-buy`
- Standardize the table columns across all internal views:
  - Product
  - Brand
  - Quantity
  - Price
  - Δ Price
  - Cycle
  - Next Purchase
  - Remaining
  - Status
  - ID
- Preserve double-click row behavior into `MainWindow.edit_product(product)`.
- Avoid duplicating the current Storage/Shortage/Market table code directly where possible.

Optional helper if duplication becomes high:

- `app/desktop/ui/widgets/product_list_table.py`

This helper should only be introduced if Codex can justify the added file as reducing duplicated table logic without changing behavior.

### History analytics UI

Likely modify:

- `app/desktop/ui/pages/history_page.py`

Possible helper if embedding grows too large:

- `app/desktop/ui/widgets/history_analytics_widget.py`

Purpose:

- Embed analytics inside HistoryPage.
- Add date range controls and optional store filter.
- Display frame-level totals and product-level analytics.
- Reuse the existing History warning behavior for unparsed purchase rows.
- Keep analytics read-only.
- Do not implement detachable analytics.

### ProductService read models

Likely modify:

- `app/core/services.py`

Purpose:

- Add a service-level Lists read model, for example:
  - `get_lists_view(view_name: str = "all") -> dict`
  - or `get_list_products(view_name: str = "all") -> list[Product]`
- Keep existing `get_storage_products`, `get_shortage_products`, and `get_market_products` as compatibility methods unless a safe internal refactor preserves callers.
- Add History analytics read model, for example:
  - `get_history_analytics_view(start_date: str | None = None, end_date: str | None = None, store_id: int | None = None) -> dict`
- Reuse existing parsing and History row preparation rules where possible.
- Reuse `product_status(product)`, `days_until_restock(product)`, and `get_price_variation(product)`.
- Keep latest price and delta price global per product.
- Keep product cycle sourced from `average_duration_days`.
- Calculate frame average timelapse from parsed purchases in the selected date/store frame, ordered by date.
- Exclude unparsed rows from analytics calculations, while reporting their count.

### Repository support queries

Inspect first:

- `app/core/repository.py`

Modify only if existing queries cannot support the service-level frame requirements.

Potential repository support needs:

- Retrieve History purchase rows with enough fields for filtering by date and optional store.
- Retrieve store list for the History analytics store filter if the UI does not already obtain it through service `get_stores()`.
- Preserve Repository ownership of SQL and avoid placing SQL in `ProductService` or UI files.

### models / contracts / schema only if needed

Avoid changes unless implementation blockers are discovered.

Inspect only if required:

- `app/core/models.py`
- `app/core/contracts.py`
- `app/database/schema.sql`
- `app/core/database.py`

Operational default:

- No schema changes for Lists.
- No schema changes for History analytics.
- No new persisted analytics cache.
- No new settings persistence for `pages.order` activation.
- Dataclass changes only if a current model cannot represent already-persisted data needed by the service read model.
- Contract changes only if the existing service contract blocks adding UI-facing service methods cleanly.

### Tests or validation surfaces

Inspect/use:

- `app/core/database.py`
- `app/database/schema.sql`
- `app/desktop/main_window.py`
- `app/desktop/ui/pages/register_page.py`
- `app/desktop/ui/pages/settings_page.py`
- `app/desktop/ui/pages/history_page.py`
- new `app/desktop/ui/pages/lists_page.py` after materialization
- `app/core/services.py`
- `app/core/repository.py`

Validation should prefer service-level smoke scripts plus manual PySide startup and interaction checks because full automated PySide interaction coverage is not currently available.

## 5. Implementation Sequence

### 1. Service-level Lists read model

Add the Lists read model in `ProductService` before changing navigation.

Minimum behavior:

- `all`: return all products with status metadata.
- `in-house`: products where `product_status(product) == "storage"`.
- `shortage`: products where `product_status(product) == "shortage"`.
- `to-buy`: products where `product_status(product) == "market"`.
- `in-house + shortage`: storage + shortage products.
- `shortage + to-buy`: shortage + market products.

The read model should expose or preserve everything the Lists UI needs:

- product identity
- product name
- brand
- current quantity and unit
- global current unit price
- global price delta text/values
- average duration cycle
- expected next purchase
- remaining days
- status

Keep existing inventory methods as wrappers or unchanged compatibility methods:

- `get_storage_products()`
- `get_shortage_products()`
- `get_market_products()`

### 2. ListsPage

Create `ListsPage` as the new unified inventory page.

Minimum UI behavior:

- Title: `Lists`
- View selector for required internal views.
- Refresh button.
- Standard 10-column table.
- Default internal view: `all` hybrid view.
- Double-click a row -> fetch product by ID -> call `main_window.edit_product(product)`.
- Use ProductService read model rather than duplicating classification logic inside the UI.

### 3. MainWindow tab remodel and compatibility navigation helpers

Update `app/desktop/main_window.py` after `ListsPage` exists.

Patch behavior:

- Import `ListsPage`.
- Remove top-level instantiation/mounting of `StoragePage`, `ShortagePage`, and `MarketPage`.
- Instantiate `self.lists_page = ListsPage(self)`.
- Add tabs in this order for Cycle 03:
  - Register
  - Lists
  - History
  - Settings
- Do not consume `pages.order`.
- Update `refresh_pages()` to call:
  - `self.lists_page.load_products()` or equivalent refresh method
  - `self.history_page.load_history()`
- Preserve `edit_product()`.
- Keep navigation helpers:
  - `open_storage()` switches to Lists and selects `in-house`.
  - `open_shortage()` switches to Lists and selects `shortage`.
  - `open_market()` switches to Lists and selects `to-buy`.

### 4. Standardized price / delta display across Lists views

Use Storage's existing presentation as the baseline.

Operational requirements:

- All Lists views show `Price` and `Δ Price`.
- Price/delta values are global per product in Cycle 03.
- Do not scope price/delta to History date range or store selection.
- Preserve neutral/missing display for absent prices.
- Preserve semantic color direction if implemented in the UI.
- Ensure the ID column index used by double-click logic matches the new 10-column table.

### 5. Service-level History analytics read model

Add analytics logic in `ProductService` before adding UI widgets.

Minimum read-model output should include:

- selected `start_date`
- selected `end_date`
- selected `store_id`
- parsed purchase count
- unparsed row count
- total spent in frame
- frame average timelapse in days
- product analytics rows

Each product analytics row should include:

- product ID
- product name
- store-filtered/frame-filtered spent value
- percentage of frame total
- product cycle from `average_duration_days`
- cycle delta = `average_duration_days - frame_average_timelapse_days`
- comparison label:
  - `faster` when product cycle is less than frame average
  - `slower` when product cycle is greater than frame average
  - `equal` when product cycle equals frame average
  - `unknown` when either value is missing

Calculation constraints:

- Use only parsed purchases for analytics.
- Filter by date range and optional store after parsing.
- Order parsed purchases by date before calculating intervals.
- Average timelapse should be the arithmetic average of day gaps between consecutive parsed purchases in the selected frame.
- If fewer than two parsed purchases exist in frame, frame average timelapse is unknown.
- Avoid schema changes and analytics caching.

### 6. Embedded History analytics component

Modify `HistoryPage` to embed analytics.

Minimum UI behavior:

- Date range controls.
- Optional store selector.
- Refresh/apply button for analytics frame.
- Display frame total spent.
- Display frame average timelapse.
- Display unparsed row count if relevant.
- Display product analytics rows.
- Keep existing History tree behavior intact.
- Do not detach analytics into a separate window this cycle.

If the component becomes too large, introduce a focused helper widget under `app/desktop/ui/widgets/`, but keep it embedded in `HistoryPage`.

### 7. Validation and regression checks

Run service-level validation first, then UI startup/manual checks.

Validation must confirm:

- app compiles
- database initialization/migration still opens existing DB without destructive reset
- Lists internal views classify expected products
- Lists price/delta display uses global product values
- double-click edit flow still opens Register with selected product
- History read model still groups Month -> Week
- History analytics filters date/store frame correctly
- unparsed dates are reported and excluded from analytics calculations
- Settings store editing still persists and refreshes relevant pages
- Register remains purchase-entry-only and still refreshes Lists/History after receipt entry

## 6. Validation Plan

### Static/application compilation

```bash
python -m compileall app
```

Expected result:

- no syntax/import errors
- new `ListsPage` imports successfully
- modified `MainWindow` imports successfully
- modified `HistoryPage` imports successfully

### Database initialization / migration smoke check

```bash
python -m app.core.database
```

Expected result:

- existing user DB opens without destructive reset
- migrations remain idempotent
- no analytics/List schema migration is introduced unless explicitly justified

Optional schema sanity check:

```bash
python - <<'PY'
from app.core.database import connect

connection = connect()
try:
    for table in ["products", "purchases", "stores", "settings"]:
        rows = connection.execute(f"PRAGMA table_info({table})").fetchall()
        print(table, [row[1] for row in rows])
finally:
    connection.close()
PY
```

Expected result:

- core tables remain readable
- no missing current product price/cycle fields
- settings table still exists

### ProductService smoke checks for lists/status/price variation

After Lists service method exists:

```bash
python - <<'PY'
from app.core.services import ProductService

service = ProductService()
try:
    for view in [
        "all",
        "in-house",
        "shortage",
        "to-buy",
        "in-house + shortage",
        "shortage + to-buy",
    ]:
        result = service.get_lists_view(view)
        rows = result.get("rows", result if isinstance(result, list) else [])
        print(view, len(rows))

    for product in service.get_products()[:5]:
        print(
            product.id,
            service.product_status(product),
            service.get_price_variation(product),
        )
finally:
    service.close()
PY
```

Expected result:

- all required view names are accepted
- no view raises an exception
- status values remain `storage`, `shortage`, or `market`
- price variation remains available globally per product

If Codex implements a different service method name, adjust only the smoke command, not the behavioral requirement.

### History read-model smoke check

```bash
python - <<'PY'
from app.core.services import ProductService

service = ProductService()
try:
    history = service.get_history_view()
    print("months", len(history.get("months", [])))
    print("unparsed", len(history.get("unparsed_rows", [])))
finally:
    service.close()
PY
```

Expected result:

- existing History read model still returns Month -> Week data
- unparsed rows remain reported, not silently repaired

### History analytics date/store frame smoke check

After analytics service method exists:

```bash
python - <<'PY'
from app.core.services import ProductService

service = ProductService()
try:
    stores = service.get_stores()
    store_id = stores[0].id if stores else None

    frames = [
        {"start_date": None, "end_date": None, "store_id": None},
        {"start_date": "01/07/2026", "end_date": "31/07/2026", "store_id": None},
        {"start_date": "01/07/2026", "end_date": "31/07/2026", "store_id": store_id},
    ]

    for frame in frames:
        result = service.get_history_analytics_view(**frame)
        print(frame)
        print("parsed", result.get("parsed_purchase_count"))
        print("unparsed", result.get("unparsed_row_count"))
        print("total", result.get("total_spent"))
        print("avg gap", result.get("frame_average_timelapse_days"))
        print("products", len(result.get("products", [])))
finally:
    service.close()
PY
```

Expected result:

- no frame raises an exception
- date range filters parsed rows
- optional store filter narrows the frame when a store exists
- unparsed rows are counted/excluded
- fewer than two parsed purchases returns unknown frame average rather than crashing

If the service method accepts ISO dates instead of display dates, the UI must convert consistently and this smoke command should be adjusted accordingly.

### Desktop startup check

```bash
python -m app.main
```

Expected result:

- desktop app opens without traceback
- visible tabs are Register, Lists, History, Settings
- Storage/Shortage/Market are not mounted as separate top-level tabs
- `pages.order` does not reorder tabs

### Manual UI checks

Manual QA is required because full automated PySide6 interaction coverage is not currently present.

Check Register:

- Register still opens.
- Existing product can be loaded for edit through Product View/double-click flow.
- New receipt can be registered.
- Register remains purchase-entry-only and does not expose store editing.
- After receipt entry, Lists and History refresh correctly.

Check Lists:

- Default view is all-products hybrid view.
- Internal view selector exposes all required views.
- `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy` show expected classifications.
- Every view uses the standardized 10-column table.
- Price and delta price appear consistently across all internal views.
- Double-click opens Register/Product edit flow for the selected product.

Check History:

- Existing Month -> Week grouped History still renders.
- Existing warning label still reports unparsed rows.
- Analytics is embedded in HistoryPage.
- Date range changes update analytics.
- Optional store filter updates analytics.
- Product percentage totals are sensible against the selected frame total.
- Product cycle comparison displays faster/slower/equal/unknown without configurable tolerance.

Check Settings:

- Store create/update still works.
- Store management remains in Settings.
- Settings changes refresh dependent pages as before.
- `pages.order` may still be displayed/persisted if already present, but must not reorder MainWindow tabs in Cycle 03.

Check Product View double-click/edit flow:

- Double-click from Lists opens Register with selected product loaded.
- Product metadata update does not destroy calculated fields.
- Product View read model remains service-driven and read-only.

## 7. Operational Risks

### Duplicated table logic

Risk: creating `ListsPage` by copying Storage/Shortage/Market code may preserve behavior quickly but increase maintenance cost and divergence.

Mitigation:

- Prefer one Lists table renderer.
- Introduce a helper widget only if duplication becomes meaningfully high.
- Keep old pages temporarily but do not keep evolving their independent table logic.

### Breaking double-click edit flow

Risk: replacing three pages with one Lists page can break Product View/Register edit navigation, especially if the ID column index changes.

Mitigation:

- Keep ID as the last column in the standardized 10-column table.
- Explicitly test double-click from every internal Lists view.
- Preserve `MainWindow.edit_product(product)`.

### Stale `pages.order`

Risk: persisted `pages.order` still contains old tab names and may confuse implementation if activated accidentally.

Mitigation:

- Do not consume `pages.order` in Cycle 03.
- Do not implement tab sorting behavior.
- Treat any stale persisted value as inert data until a later cycle explicitly remaps it.

### Date parsing / unparsed rows

Risk: analytics can silently miscount purchases if unsupported historical date formats are included in calculations.

Mitigation:

- Reuse existing History parsing behavior.
- Exclude unparsed rows from analytics calculations.
- Report unparsed row count in analytics output/UI.
- Do not repair historical rows in this cycle.

### Multi-store analytics totals

Risk: store-filtered analytics may expose inconsistencies in History totals or purchase rows when multiple stores exist.

Mitigation:

- Validate with at least two stores and known purchase totals.
- Keep store filter optional.
- Use stored `total_price` as the monetary aggregation source unless Main later changes the total rule.

### Keeping old page files during transition

Risk: retaining `storage_page.py`, `shortage_page.py`, and `market_page.py` can create confusion about the active UI route.

Mitigation:

- Stop mounting old pages as top-level tabs.
- Keep files temporarily for rollback/reference only.
- Do not delete them in Cycle 03 unless Main explicitly approves safe deletion.

### UI regression from replacing tabs

Risk: removing three top-level tabs can break refresh paths, Settings refresh dependents, or code that expects `storage_page`, `shortage_page`, and `market_page` attributes.

Mitigation:

- Update `refresh_pages()` and navigation helpers in the same patch as MainWindow tab remodel.
- Search for references to old page attributes before materialization completes.
- Preserve compatibility helper methods even if internal page attributes disappear.

## 8. Explicit Deferrals

Cycle 03 explicitly defers:

- detachable History analytics
- active `pages.order` consumption or visible tab reordering
- store editing through Register
- store deletion
- mobile implementation
- schema caching for analytics
- store/frame-scoped price delta
- configurable tolerance for cycle comparison
- broad History configuration rule editor
- destructive database reset or data repair for unsupported historical dates
- deletion of old Storage/Shortage/Market page files unless explicitly approved later

## 9. GitHub Materialization Result

`documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md` was updated through the GitHub connector as the assigned Operational active-stage file.

Application source files were not modified.

Methodology files were not modified.

Main stage files were not modified.

Codex report files were not modified.

Other functional stage files were not modified.

Permanent domain memory was not modified.

No files were created or renamed.

Commit SHA: reported by the GitHub connector response for this materialization.
