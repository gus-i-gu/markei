# 01_ARCHITECTURE.md

> Version: 0.2
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
Inventory table double-click
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

The Product View may later be reused by Storage, Shortage, Market, or History without moving business logic into those pages.

Cycle 02 did not change this architecture.

---

# 3. History Architecture

History uses a service-prepared read model.

Canonical decision:

- History page owns rendering only.
- History page renders grouped sections, purchase rows, and total rows from service-prepared data.
- ProductService owns History read-model assembly.
- ProductService owns time bucketing semantics, including first-Wednesday operational month grouping and Wednesday week grouping.
- ProductService owns aggregate/total-row meaning.
- Repository retrieves purchase, store, and settings data without deciding period semantics.
- SQLite persists settings values used by History grouping.

Current composition:

```text
HistoryPage
    ↓ requests History view
ProductService
    ↓ reads settings and raw rows
Repository
    ↓ retrieves purchases / stores / settings
SQLite
```

History grouping is not a repository responsibility and must not be rebuilt inside the UI.

---

# 4. Settings Architecture

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

# 5. Product / Purchase / Store Ownership

Canonical ownership:

- Product owns product identity, editable product metadata, inventory state, and cached product-level summaries.
- Purchase owns immutable receipt/batch facts.
- Store owns store identity and location facts.
- Product View owns no domain facts; it renders service-prepared data.
- History View owns no domain facts; it renders service-prepared grouped read-model data.

Specific accepted ownership:

- Product owns `average_duration_days` and `expected_next_purchase` as purchase-rhythm summaries.
- Product owns `average_shelf_life_days` and `expected_expiration_date` as shelf-life summaries.
- Purchase owns optional `expiration_date` as a receipt/batch-level fact.
- Store owns nullable `address`.
- Average price remains derived from purchases and is not a cached Product field.
- History total rows are derived read-model summaries, not Product fields.

---

# 6. Rhythm and Time Separation

Markei separates three temporal meanings:

- Purchase rhythm: how often the user buys the product.
- Shelf-life rhythm: how long a purchased batch lasts before expiration.
- History period grouping: how purchases are bucketed for display and reporting.

Canonical mapping:

```text
average_duration_days      -> purchase-to-purchase rhythm
expected_next_purchase     -> prediction from purchase rhythm
average_shelf_life_days    -> purchase-to-expiration rhythm
expected_expiration_date   -> prediction/state from shelf-life rhythm
history.week_boundary      -> History weekly bucket boundary
history.month_boundary_rule -> History operational month boundary rule
```

Purchase classification for Storage / Shortage / Market remains based on `expected_next_purchase` unless a later design decision explicitly changes list semantics.

History grouping settings do not change Product purchase rhythm or shelf-life rhythm.

---

# 7. Boundary Drift Guards

- UI must not calculate averages, shelf-life summaries, latest store prices, product status, History period buckets, or predictions.
- Repository must not decide business meaning for returned rows, period buckets, settings interpretation, or aggregates.
- ProductService must remain the owner of Product View and History read-model assembly.
- Product must not absorb purchase-specific history beyond cached summaries.
- Purchase expiration remains purchase-level history.
- Store address editing belongs to Settings/store-management surfaces, not RegisterPage.
- Page-order persistence must not imply MainWindow ordering until that consumption is explicitly designed and implemented.
