# 01_ARCHITECTURE.md

> Version: 0.3
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Design / Architecture
> Authority: Design Chat
> Scope: Markei architectural boundaries and responsibility ownership

---

# 1. Layer Boundaries

Markei currently follows a desktop layered architecture:

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
SQLite schema / storage
```

Canonical boundary rules:

- Desktop UI owns rendering, user events, page composition, and navigation hooks.
- Services own business meaning, calculations, workflow coordination, configuration interpretation, and UI-facing read-model assembly.
- Repository owns SQL retrieval, persistence operations, settings persistence access, and row-to-model mapping.
- Schema/storage owns persisted facts, relationships, migration-visible data shape, and application settings storage.
- Models describe domain entities and may hold cached summaries, but must not execute SQL or perform business orchestration.

---

# 2. Product View Architecture

The Product View is a reusable read-only `ProductDetailPanel`.

Canonical decision:

- `ProductDetailPanel` owns display of product detail data.
- `RegisterPage` owns placement of the panel below the writable receipt form.
- `RegisterPage` does not own Product View calculations.
- `RegisterPage` remains a receipt-entry page and must not absorb store-management responsibilities.
- `ProductService` owns Product View read-model assembly.
- Repository owns the SQL/retrieval/mapping needed to support that assembly.

Current composition:

```text
Inventory selection
    ↓ product_id
MainWindow navigation
    ↓
RegisterPage placement/loading
    ↓
ProductDetailPanel rendering
    ↓
ProductService read model
    ↓
Repository retrieval
    ↓
SQLite persistence
```

The Product View may later be reused by Lists or History without moving business logic into those pages.

---

# 3. Lists Architecture

Lists is now the public inventory surface.

Canonical decision:

- Public inventory navigation is represented by one `ListsPage`.
- Former Storage / Shortage / Market meanings are internal Lists views.
- Internal view names are `in-house`, `shortage`, and `to-buy`.
- Lists also supports combined views `in-house + shortage` and `shortage + to-buy`.
- The default Lists view is the hybrid all-products list with a Status column.
- ProductService owns Lists read-model assembly, status classification, latest price meaning, delta price meaning, remaining-days meaning, and row labels.
- ListsPage owns view selection, table rendering, refresh behavior, and product-opening events.
- Repository retrieves supporting product/purchase rows without deciding status or price-delta semantics.
- Old Storage/Shortage/Market page files may remain temporarily as transition artifacts, but they are no longer public inventory navigation surfaces.

Current composition:

```text
ListsPage
    ↓ selected view key
ProductService.get_lists_view(...)
    ↓ assembles list rows and status groups
Repository
    ↓ retrieves products / purchases / summaries
SQLite
```

Lists classification remains purchase-rhythm based through existing `expected_next_purchase` and threshold semantics unless a future design explicitly changes inventory status meaning.

---

# 4. History Architecture

History uses service-prepared read models.

Canonical decision:

- History page owns rendering only.
- History page renders grouped sections, purchase rows, summaries, total rows, and embedded analytics from service-prepared data.
- ProductService owns History read-model assembly.
- ProductService owns time bucketing semantics, including first-Wednesday operational month grouping and Wednesday week grouping.
- ProductService owns aggregate/total-row meaning.
- ProductService owns History analytics frame interpretation, totals, expenditure percentages, average purchase timelapse, and product-cycle comparison.
- Repository retrieves purchase, store, and settings data without deciding period or analytics semantics.
- SQLite persists settings values used by History grouping, but no analytics cache is persisted.

Current grouped History composition:

```text
HistoryPage
    ↓ requests grouped History view
ProductService
    ↓ reads settings and raw rows
Repository
    ↓ retrieves purchases / stores / settings
SQLite
```

Current embedded analytics composition:

```text
HistoryPage embedded analytics controls
    ↓ date range + optional store filter
ProductService.get_history_analytics_view(...)
    ↓ derives frame totals / percentages / timelapse / comparison
Repository
    ↓ retrieves supporting purchase/store rows
SQLite
```

History grouping and analytics are not repository responsibilities and must not be rebuilt inside the UI.

---

# 5. Settings Architecture

Settings is the configuration owner for user-facing application preferences.

Canonical decision:

- Settings page owns the configuration surface.
- Settings page owns the store editing placement surface.
- Store create/update belongs in Settings rather than RegisterPage.
- Settings writes configuration through service/repository flow.
- SQLite settings persistence is key/value based.
- History time-reference settings affect History grouping through ProductService interpretation.
- Page-order persistence may exist, but MainWindow page-order consumption remains deferred until a later cycle.

Settings may host focused editor components for store editing, time-reference configuration, and page sorting to avoid becoming an unbounded page.

---

# 6. Product / Purchase / Store Ownership

Canonical ownership:

- Product owns product identity, editable product metadata, inventory state, and cached product-level summaries.
- Purchase owns immutable receipt/batch facts.
- Store owns store identity and location facts.
- Product View owns no domain facts; it renders service-prepared data.
- Lists View owns no domain facts; it renders service-prepared list read-model data.
- History View owns no domain facts; it renders service-prepared grouped and analytics read-model data.

Specific accepted ownership:

- Product owns `average_duration_days` and `expected_next_purchase` as purchase-rhythm summaries.
- Product owns `average_shelf_life_days` and `expected_expiration_date` as shelf-life summaries.
- Purchase owns optional `expiration_date` as a receipt/batch-level fact.
- Store owns nullable `address`.
- Average price remains derived from purchases and is not a cached Product field.
- Latest price and delta price in Lists are derived read-model fields, not schema fields.
- History total rows and analytics rows are derived read-model summaries, not Product fields.

---

# 7. Rhythm and Time Separation

Markei separates temporal meanings:

- Purchase rhythm: how often the user buys the product.
- Shelf-life rhythm: how long a purchased batch lasts before expiration.
- History period grouping: how purchases are bucketed for display and reporting.
- Analytics frame timelapse: average interval between parsed purchases in a selected date/store frame.

Canonical mapping:

```text
average_duration_days       -> purchase-to-purchase rhythm / product cycle
expected_next_purchase      -> prediction from purchase rhythm
average_shelf_life_days     -> purchase-to-expiration rhythm
expected_expiration_date    -> prediction/state from shelf-life rhythm
history.week_boundary       -> History weekly bucket boundary
history.month_boundary_rule -> History operational month boundary rule
analytics frame average     -> selected-frame purchase interval average
```

Purchase classification for Lists remains based on `expected_next_purchase` unless a later design decision explicitly changes list semantics.

History grouping settings do not change Product purchase rhythm, shelf-life rhythm, or analytics frame meaning.

---

# 8. Mobile Readiness Boundary

Cycle 03 improved mobile readiness by making Lists and History analytics available through service-owned, platform-neutral read-model contracts.

Current classification:

- Prepared: service/read-model semantics are less tied to PySide6 widgets.
- Not ready: mobile implementation, API/backend rewrite, sync, authentication, and mobile persistence are not designed.

Next likely mobile-preparation topics:

- typed read-model contracts;
- service factory or dependency injection boundaries;
- explicit date validation strategy;
- automated service tests;
- separation between UI labels and semantic values.

---

# 9. Boundary Drift Guards

- UI must not calculate averages, shelf-life summaries, latest prices, price deltas, product status, History period buckets, analytics percentages, frame averages, comparisons, or predictions.
- Repository must not decide business meaning for returned rows, period buckets, settings interpretation, status classification, analytics frames, or aggregates.
- ProductService remains the owner of Product View, Lists, grouped History, and History analytics read-model assembly.
- Product must not absorb purchase-specific history or frame-dependent analytics beyond accepted cached summaries.
- Purchase expiration remains purchase-level history.
- Store address editing belongs to Settings/store-management surfaces, not RegisterPage.
- Page-order persistence must not imply MainWindow ordering until that consumption is explicitly designed and implemented.
