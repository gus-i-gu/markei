# [M] Session 003 | 11:??_07_07_2026 | Markei

# D_OPS_STAGE — Main Operational Materialization Stage

> Source stages:
> - `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
> - `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
> - `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
>
> Purpose: Codex-ready operational implementation brief for the current StoragePage runtime failure.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Operational Synthesis

The previous Repository ImportError is no longer the active blocker.

Operational evidence confirms `app/core/repository.py` now defines a module-level `Repository` class and initializes a SQLite connection/cursor.

The active failure is now:

```text
KeyError: "color"
```

The execution path is:

```text
python main.py
↓
app/main.py
↓
MainWindow.__init__
↓
StoragePage(self)
↓
StoragePage.__init__
↓
StoragePage.build_ui()
↓
StoragePage.load_products()
↓
ProductService.get_price_variation(product)
↓
StoragePage expects variation["color"]
↓
KeyError: "color"
```

The immediate operational cause is a return-shape mismatch:

- `StoragePage.load_products()` expects `variation["color"]`.
- `ProductService.get_price_variation()` returns dictionaries containing `delta`, `percentage`, and `text`, but no `color` key.

Therefore the failing source target is:

```text
app/desktop/ui/pages/storage_page.py
```

`app/core/services.py` is relevant for inspection but should not be patched to return Qt objects.

---

# 2. Shiboken Warning Synthesis

The terminal also reports:

```text
Shiboken::Conversions::_pythonToCppCopy:
Cannot copy-convert (...) list to C++.
```

Operational analysis identifies the likely cause in `StoragePage.build_ui()`:

```python
self.table.setHorizontalHeaderLabels([
    [
        "Product",
        "Brand",
        "Quantity",
        "Price",
        "Δ Price",
        "Cycle",
        "Next Purchase",
        "Remaining",
        "Status",
        "ID",
    ]
])
```

`setHorizontalHeaderLabels()` expects a flat list of strings, but StoragePage passes a nested list.

This warning is independent from the `KeyError`:

- Shiboken warning occurs during table header setup.
- `KeyError: "color"` occurs later during row rendering.

Both should be repaired in the same focused StoragePage patch because both are in the same file and affect the same startup path.

---

# 3. Main Operational Decision

Approved operational patch scope:

```text
app/desktop/ui/pages/storage_page.py
```

Do not modify for this task unless strictly necessary:

```text
app/core/services.py
app/core/repository.py
app/core/database.py
app/core/models.py
```

Reason:

- The service/repository read path is coherent enough to reach UI row rendering.
- The runtime blocker is in UI consumption and UI table setup.
- The design boundary requires Qt presentation values to remain in the UI layer.

---

# 4. Required Code Changes

## 4.1 Fix header label list shape

In `StoragePage.build_ui()`, replace the nested list passed to `setHorizontalHeaderLabels()` with a flat list:

```python
self.table.setHorizontalHeaderLabels([
    "Product",
    "Brand",
    "Quantity",
    "Price",
    "Δ Price",
    "Cycle",
    "Next Purchase",
    "Remaining",
    "Status",
    "ID",
])
```

Expected effect:

- removes the Shiboken list-to-C++ conversion warning from this table-header call;
- preserves the existing 10-column table structure.

## 4.2 Fix price variation color handling in UI

In `StoragePage`, add a UI-local helper that derives presentation color from semantic price variation data:

```python
def price_variation_color(self, variation: dict) -> QColor:
    delta = variation.get("delta")

    if delta is None or delta == 0:
        return QColor(150, 150, 150)

    if delta > 0:
        return QColor(230, 126, 34)

    return QColor(46, 204, 113)
```

Then replace direct access to:

```python
variation["color"]
```

with:

```python
self.price_variation_color(variation)
```

Expected effect:

- removes `KeyError: "color"`;
- keeps `ProductService.get_price_variation()` semantic and UI-free;
- keeps `QColor` in the desktop UI layer.

## 4.3 Fix nearby StoragePage double-click ID bug

Operational analysis found a nearby bug in the same file:

```python
product_id = self.table.item(row, 7).text()
```

Column `7` is `Remaining`, not `ID`. The ID column is set at index `9`.

Update to:

```python
product_id = self.table.item(row, 9).text()
```

This is approved in the same focused patch because it is in the same file, uses the same table schema, and will likely surface immediately after StoragePage starts rendering correctly.

## 4.4 Make optional brand rendering safe

Operational analysis also found:

```python
QTableWidgetItem(product.brand)
```

`Product.brand` is optional. If the current code passes `None` to `QTableWidgetItem`, PySide conversion may fail or warn.

Patch this in `StoragePage.load_products()` to use a string fallback:

```python
QTableWidgetItem(product.brand or "—")
```

or equivalent.

This is approved because it is a minimal StoragePage UI-safety fix and may reduce remaining Qt conversion issues.

---

# 5. Do Not Do

Codex must not:

1. Add `QColor` imports to `app/core/services.py`.
2. Add a `"color"` key to `ProductService.get_price_variation()`.
3. Move price variation calculations into `StoragePage` beyond presentation-color mapping.
4. Change repository/database/model code for this runtime patch.
5. Introduce a broad UI architecture refactor.
6. Modify methodology files.

---

# 6. Required Inspection Before Patch

Before editing, Codex should search for these patterns:

```text
variation["color"]
setHorizontalHeaderLabels([
QTableWidgetItem(product.brand)
self.table.item(row, 7)
```

If equivalent `variation["color"]` usage appears outside StoragePage, report it before expanding scope.

If equivalent nested header lists appear in other pages, report them. Patch only if they are clearly the same table-label bug and within desktop UI pages.

---

# 7. Required Validation Commands

After patching, run:

```bash
python -m compileall app
```

Then run a service smoke test:

```bash
python - <<'PY'
from app.core.services import ProductService

service = ProductService()
products = service.get_products()
print("products", len(products))
if products:
    print(service.get_price_variation(products[0]))
service.close()
PY
```

Then run the app:

```bash
python main.py
```

If the local execution convention uses module mode, also try:

```bash
python -m app.main
```

---

# 8. Expected Results

Expected after patch:

1. `python -m compileall app` succeeds.
2. Service smoke test prints a dictionary with `delta`, `percentage`, and `text`.
3. StoragePage no longer raises `KeyError: "color"`.
4. The Shiboken nested-list warning disappears if it came from `setHorizontalHeaderLabels()`.
5. MainWindow opens far enough to show Register, Storage, Shortage, Market, History, and Settings tabs.

If a new traceback appears, Codex must report it exactly and avoid speculative fixes beyond this patch scope.

---

# 9. Expected Codex Report

Codex must report:

1. files changed;
2. exact StoragePage changes made;
3. whether `ProductService` remained UI-free;
4. whether nested header labels were fixed;
5. whether `variation["color"]` remains anywhere;
6. whether the double-click ID column was corrected;
7. validation commands run;
8. command outputs;
9. remaining risks.
