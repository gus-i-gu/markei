# Materialization Stage — Operational

## 1. Scope

This stage gives Codex the operational implementation instructions for Cycle 03: Lists remodel, embedded History analytics, latest/delta price expansion, and mobile-readiness preparation.

This is a materialization stage, not permanent domain memory. Codex may modify application/source files required by this stage and must report evidence into `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md` after materialization.

Codex must not edit methodology files or permanent domain memory during this pass.

## 2. Source Inputs

Codex must read these files before implementation:

- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
- `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`

Codex should also inspect implementation files as needed, especially:

- `app/desktop/main_window.py`
- `app/desktop/ui/pages/storage_page.py`
- `app/desktop/ui/pages/shortage_page.py`
- `app/desktop/ui/pages/market_page.py`
- `app/desktop/ui/pages/history_page.py`
- `app/desktop/ui/pages/register_page.py`
- `app/desktop/ui/pages/settings_page.py`
- `app/core/services.py`
- `app/core/repository.py`
- `app/core/models.py`
- `app/core/contracts.py`
- database/schema/migration files only if implementation proves they are needed

## 3. Accepted Operational Decisions

- Replace the public `Storage`, `Shortage`, and `Market` top-level tabs with one public `Lists` tab.
- Retain the old Storage/Shortage/Market source files temporarily unless safe deletion is explicitly justified and reported.
- `Lists` default view is the hybrid all-products view with a Status column.
- `Lists` must expose internal views:
  - `in-house`
  - `shortage`
  - `to-buy`
  - `in-house + shortage`
  - `shortage + to-buy`
- `in-house` maps to former Storage behavior.
- `shortage` maps to former Shortage behavior.
- `to-buy` maps to former Market behavior.
- All Lists views must show the standardized columns:
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
- Latest price and delta price are global per product in Cycle 03.
- Do not scope latest price or delta price to History date/store filters in this cycle.
- History analytics starts embedded in `HistoryPage`.
- Detachable analytics behavior is deferred.
- Analytics frame means date range plus optional store filter.
- Average purchase timelapse means the average interval between all parsed purchases in the selected date/store frame, ordered by date.
- Product cycle means existing `average_duration_days`.
- Cycle comparison means `product average_duration_days - frame average purchase timelapse`.
- Cycle comparison display is simple: faster / slower / equal / unknown.
- Do not add configurable comparison tolerance in Cycle 03.
- `pages.order` remains deferred. Do not activate persisted tab ordering.
- Register remains purchase-entry-only. Store management remains in Settings.
- Avoid schema changes for Lists and analytics unless an unavoidable implementation blocker is found and reported.

## 4. Operational Implementation Instructions

### 4.1 Service-level Lists read model

Implement or extend service behavior before UI remodel.

Preferred service surface:

```text
ProductService.get_lists_view(view_key="all") -> dict
```

The exact name may vary if project conventions require it, but Codex must preserve these meanings.

Required view keys:

```text
all
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

The service must own product status classification and row assembly. UI must not recalculate status, remaining days, latest price, delta price, or cycle meaning.

Keep existing compatibility methods unless safe refactor preserves all callers:

- `get_storage_products()`
- `get_shortage_products()`
- `get_market_products()`

### 4.2 ListsPage

Create a unified Lists page, likely at:

```text
app/desktop/ui/pages/lists_page.py
```

Minimum behavior:

- title: `Lists`
- view selector for all required internal views
- refresh button
- default view: all-products hybrid view
- standardized 10-column read-only table
- double-click row opens the selected product through `MainWindow.edit_product(product)`
- no direct SQL
- no business calculation in UI

If table duplication becomes high, Codex may create a focused helper widget under the existing desktop UI widget path, but should keep the implementation minimal.

### 4.3 MainWindow remodel

Update `app/desktop/main_window.py`.

Required behavior:

- public tabs become:
  - Register
  - Lists
  - History
  - Settings
- remove Storage/Shortage/Market as public top-level tabs
- instantiate `ListsPage`
- update `refresh_pages()` to refresh Lists and History
- preserve `edit_product()`
- preserve compatibility helpers:
  - `open_storage()` selects Lists and switches to `in-house`
  - `open_shortage()` selects Lists and switches to `shortage`
  - `open_market()` selects Lists and switches to `to-buy`
- do not consume `pages.order`

Search for old page attribute references and update them safely.

### 4.4 History analytics service read model

Implement analytics in `ProductService`, not in the UI.

Preferred service surface:

```text
ProductService.get_history_analytics_view(start_date=None, end_date=None, store_id=None) -> dict
```

Required summary output:

- selected frame
- parsed purchase count
- unparsed/excluded row count
- total spent in frame
- average purchase timelapse in days, or unknown/None when insufficient data exists
- product analytics rows

Each product analytics row should include:

- product ID
- product name
- brand when available
- total spent in selected frame
- percentage of selected frame total
- purchase count in selected frame
- product cycle from `average_duration_days`
- frame average timelapse
- cycle difference in days
- comparison label: faster / slower / equal / unknown

Calculation constraints:

- reuse existing project date parsing where possible
- include only parsed purchases in analytics calculations
- filter by date range and optional store after parsing or through repository support that preserves equivalent semantics
- order parsed purchases by date before interval calculation
- average timelapse is the arithmetic average of day gaps between consecutive parsed purchases in the selected frame
- if fewer than two parsed purchases exist, frame average timelapse is unknown rather than an error
- use stored `total_price` for monetary totals when available
- do not repair historical rows with unsupported dates
- do not cache analytics values in schema

### 4.5 Embedded History analytics UI

Modify `HistoryPage` to embed analytics while preserving existing grouped History behavior.

Minimum UI behavior:

- date range controls
- optional store selector
- refresh/apply button for analytics frame
- display total spent
- display average purchase timelapse
- display unparsed/excluded row count when relevant
- display product analytics rows
- keep analytics read-only
- keep existing History tree/grouped rendering intact
- no detachable widget/window in Cycle 03

A focused helper widget may be created if needed, but it must remain embedded in HistoryPage.

## 5. Explicit Deferrals

Codex must not implement these unless an explicit later Main stage says otherwise:

- detachable History analytics
- active `pages.order` consumption
- store editing through Register
- store deletion
- mobile implementation
- API/backend rewrite
- cloud sync
- persisted analytics cache
- schema fields for analytics percentages or cycle comparison
- store/frame-scoped latest price or delta price
- configurable tolerance for cycle comparison
- broad History configuration rule editor
- destructive database reset or historical date repair

## 6. Validation Requirements

Run and report available commands. Adapt only where local environment requires it.

### Required compile check

```bash
python -m compileall app
```

### Database smoke check

```bash
python -m app.core.database
```

Expected:

- existing DB opens without destructive reset
- migrations remain idempotent
- no schema change was introduced unless explicitly justified

### ProductService Lists smoke check

Run a service-level smoke check for all required Lists view keys. If the exact service method name differs, adapt the command and report the actual method.

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
finally:
    service.close()
PY
```

### Product status / price variation smoke check

```bash
python - <<'PY'
from app.core.services import ProductService

service = ProductService()
try:
    for product in service.get_products()[:5]:
        print(product.id, service.product_status(product), service.get_price_variation(product))
finally:
    service.close()
PY
```

### History read-model regression check

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

### History analytics smoke check

Run after analytics service method exists. If date format differs, adapt and report.

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
        print("products", len(result.get("products", result.get("rows", []))))
finally:
    service.close()
PY
```

### Desktop startup check

```bash
python -m app.main
```

Expected:

- app opens without traceback
- visible top-level tabs are Register, Lists, History, Settings
- Storage/Shortage/Market are not public top-level tabs
- `pages.order` does not reorder tabs

### Manual UI checks to report

- Register opens and remains purchase-entry-only.
- Register can still save a receipt and refresh Lists/History.
- Lists opens by default in all-products hybrid view.
- Every required Lists internal view renders.
- Every Lists view shows Price and Δ Price.
- Double-click from Lists opens Register/product edit flow.
- History grouped Month -> Week rendering still works.
- Embedded analytics renders and reacts to date/store frame changes.
- Analytics excludes/reports unparsed rows.
- Settings store create/update still works.
- Product View behavior is not regressed.

## 7. Codex Operational Report Requirement

After materialization, write:

`documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`

Report compactly:

- source stage files read
- files changed
- files created
- files deleted
- commands run
- validation results
- Lists implementation evidence
- MainWindow tab remodel evidence
- compatibility navigation helper evidence
- price/delta display evidence
- History analytics implementation evidence
- date/store frame behavior evidence
- unparsed-row handling evidence
- Settings/Register/Product View regression evidence
- instructions completed
- instructions skipped
- failures/blockers
- unresolved operational risks
- suggested follow-up
