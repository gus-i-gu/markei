# 01_ARCHITECTURE.md

> Version: 0.5
> Status: Draft
> Persistence Class: Canonical
> Knowledge Class: Design / Architecture
> Authority: Design Chat
> Scope: Markei architectural boundaries and responsibility ownership

---

# 1. Layer Boundaries

Markei follows a desktop layered architecture:

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

- Desktop UI owns rendering, user events, page composition, navigation hooks, and presentation state.
- ProductService owns business meaning, calculations, workflow coordination, configuration defaults, validation, interpretation, and UI-facing read-model assembly.
- Repository owns SQL retrieval, persistence operations, generic settings access, and row-to-model mapping.
- SQLite/schema owns persisted facts, relationships, migration-visible shape, and key/value settings storage.
- Models describe domain entities and may hold accepted cached summaries, but must not execute SQL or perform business orchestration.

---

# 2. Product View Architecture

Product View is a reusable read-only `ProductDetailPanel`.

- `ProductDetailPanel` renders product detail data.
- `RegisterPage` owns placement below the writable receipt form.
- `RegisterPage` does not own Product View calculations.
- `ProductService` owns Product View read-model assembly.
- Repository owns supporting retrieval and mapping.
- Register remains receipt-entry focused and must not absorb store-management responsibility.

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

---

# 3. Lists Architecture

Lists is the public inventory surface.

- Public inventory navigation is represented by one `ListsPage`.
- Former Storage / Shortage / Market meanings are internal Lists views.
- Internal view names are `in-house`, `shortage`, and `to-buy`.
- Combined views include `in-house + shortage` and `shortage + to-buy`.
- The default view is the all-products hybrid list with Status.
- ProductService owns Lists read-model assembly, status classification, latest/delta price meaning, remaining-days meaning, and row labels.
- ListsPage owns view selection, rendering, refresh, and product-opening events.
- Repository retrieves supporting rows without deciding status or price semantics.
- Old page files may remain as transition artifacts but are not public navigation surfaces.

Lists classification remains purchase-rhythm based through `expected_next_purchase` and threshold semantics unless a future design explicitly changes it.

---

# 4. History Architecture

History uses service-prepared read models.

- HistoryPage owns rendering, controls, and refresh events.
- ProductService owns grouped History read-model assembly and time-bucketing semantics.
- ProductService owns aggregate/total-row meaning.
- ProductService owns History analytics frame interpretation, totals, expenditure percentages, average purchase timelapse, and product-cycle comparison.
- Repository retrieves purchase/store/settings data without deciding period or analytics semantics.
- SQLite persists grouping settings; analytics remain read-time derivations.

Current grouping settings:

```text
history.week_boundary
history.month_boundary_mode
history.month_boundary_weekday
history.month_boundary_day
```

Current semantics:

- `history.week_boundary` selects any of seven semantic weekday values.
- `history.month_boundary_mode = first_weekday` starts an operational month at the first configured weekday.
- `history.month_boundary_mode = day_of_month` starts an operational month at a configured day from 1 to 28.
- Invalid persisted values fall back through ProductService defaults.
- HistoryPage must not group raw purchases itself.

```text
HistoryPage
    ↓ requests grouped History view
ProductService
    ↓ validates/interprets settings and groups raw rows
Repository
    ↓ retrieves purchases / stores / settings
SQLite
```

History analytics remains embedded and read-only:

```text
HistoryPage analytics controls
    ↓ date range + optional store filter
ProductService.get_history_analytics_view(...)
    ↓ derives totals / percentages / timelapse / comparison
Repository
    ↓ retrieves supporting purchase/store rows
SQLite
```

---

# 5. Settings Architecture

Settings is the user-facing configuration and store-management surface. It is not the owner of configuration meaning.

Canonical responsibility map:

```text
SettingsPage
    edits configuration and store data

ProductService
    defines defaults, validates user edits,
    normalizes persisted values, and interprets behavior

Repository
    persists generic key/value settings and store records

SQLite
    stores settings and application facts
```

SettingsPage owns:

- controls and labels;
- loading current service-prepared values;
- collecting edits;
- triggering save through ProductService;
- displaying validation feedback;
- store create/update placement.

ProductService owns:

- the settings contract and defaults;
- strict rejection of invalid submitted values;
- tolerant fallback for invalid persisted values;
- week/month boundary interpretation;
- operational-date derivation.

Repository must remain unaware of weekday, month-mode, month-day, and day-boundary semantics.

Canonical settings keys:

```text
history.week_boundary
history.month_boundary_mode
history.month_boundary_weekday
history.month_boundary_day
time_reference.day_boundary_time
```

Stored values must be stable semantic values rather than presentation labels. UI labels may change without changing persisted meaning.

Legacy `history.month_boundary_rule` is compatibility residue. It may be read defensively when canonical month keys are absent, but it is not current canonical design.

`pages.order` may remain persisted, but MainWindow consumption remains deferred. Persistence does not imply active behavior.

Settings may later split into focused internal editor components if page growth harms maintainability.

---

# 6. Product / Purchase / Store Ownership

- Product owns identity, editable metadata, inventory state, and accepted cached product summaries.
- Purchase owns immutable receipt/batch facts.
- Store owns store identity and location facts.
- Product View, Lists View, and History View own no domain facts; they render service-prepared data.

Accepted ownership:

- Product owns `average_duration_days` and `expected_next_purchase` as purchase-rhythm summaries.
- Product owns `average_shelf_life_days` and `expected_expiration_date` as shelf-life summaries.
- Purchase owns optional `expiration_date`.
- Purchase date remains a factual stored value.
- Store owns nullable `address`.
- Average price, latest/delta display values, History totals, and analytics rows remain derived.

---

# 7. Rhythm and Time Separation

Markei separates these temporal meanings:

- Purchase rhythm: how often the user buys a product.
- Shelf-life rhythm: how long a bought batch lasts before expiration.
- History period grouping: how purchases are bucketed for display/reporting.
- Operational date: a derived date after applying an operational-day rollover time.
- Analytics frame timelapse: average interval between parsed purchases in a selected frame.

Canonical mapping:

```text
average_duration_days                 -> purchase-to-purchase rhythm / product cycle
expected_next_purchase                -> prediction from purchase rhythm
average_shelf_life_days               -> purchase-to-expiration rhythm
expected_expiration_date              -> shelf-life prediction/state
history.week_boundary                 -> History weekly bucket boundary
history.month_boundary_mode           -> operational month strategy
history.month_boundary_weekday        -> weekday for first_weekday mode
history.month_boundary_day            -> day 1-28 for day_of_month mode
time_reference.day_boundary_time      -> operational-day rollover time
operational_date                      -> derived service interpretation
analytics frame average               -> selected-frame purchase interval average
```

Temporal invariants:

- Factual purchase date is not replaced by operational date.
- Operational date is derived in ProductService.
- Existing date-only purchase rows are not shifted by day-boundary time.
- Cycle 04 does not apply operational-day semantics to Lists classification, purchase rhythm, depletion prediction, or expected next purchase.
- History settings do not change shelf-life meaning or analytics-frame meaning.

---

# 8. Persistence and Migration Position

- Settings remain generic key/value rows.
- New canonical defaults are inserted non-destructively.
- Existing settings are not overwritten by default insertion.
- Legacy month-boundary data may remain present but becomes inert once canonical keys exist.
- A future migration/removal decision requires separate authorization.
- Production first launch is schema-only: `schema.sql` initializes the database and configuration defaults without seeding business records.
- `seed.sql` is a development fixture and is not part of the production runtime.
- The writable desktop database belongs under `%LOCALAPPDATA%\Markei`, outside application installation files.
- Installed application replacement or removal must not implicitly delete user data.

---

# 9. Mobile Readiness Boundary

Cycles 03 and 04 provided portable read-model and Settings semantics. Cycle 05 Sprint 01 adds desktop delivery without promoting desktop delivery mechanics into platform-neutral contracts.

Prepared:

- service-owned Lists and History analytics read models;
- platform-neutral primitive/dictionary outputs;
- service-owned Settings validation and interpretation;
- semantic stored values separated from desktop labels;
- operational-date interpretation outside PySide6;
- Windows packaging isolated from ProductService and Repository contracts.

Not ready:

- mobile UI implementation;
- server/shared backend;
- authentication or synchronization;
- mobile persistence;
- formal typed contracts;
- service factory/dependency injection;
- comprehensive date/time storage strategy;
- automated service and UI interaction coverage;
- desktop/mobile migration or coexistence architecture.

Mobile preparation must not expand into a mobile rewrite without a later design cycle.

SQLite remains the current desktop persistence implementation. It is not a mobile, synchronization, shared-backend, or cross-device contract.

---

# 10. Boundary Drift Guards

- UI must not calculate averages, shelf-life summaries, latest/delta prices, product status, History period buckets, analytics values, predictions, or operational dates.
- Repository must not decide business meaning, period semantics, settings interpretation, status classification, analytics frames, or aggregates.
- ProductService remains the owner of Product View, Lists, grouped History, History analytics, and behavior-affecting Settings interpretation.
- SettingsPage must not mutate HistoryPage directly or bypass service/repository persistence.
- HistoryPage must not duplicate grouping logic.
- ListsPage must not interpret `time_reference.day_boundary_time`.
- MainWindow must not consume `pages.order` until explicitly designed and materialized.
- Register must not become a store-management surface.
- Mobile preparation must not silently introduce mobile, backend, synchronization, or external-integration architecture.
- Packaging and installer configuration must not become a business layer.
- ProductService and Repository contracts must not expose PyInstaller, Inno Setup, installation paths, shortcuts, uninstall behavior, or Windows path policy.

---

# 11. Windows Desktop Distribution Architecture

Cycle 05 Sprint 01 establishes this accepted delivery boundary:

```text
source application
→ PyInstaller one-folder runtime
→ Inno Setup per-user installer configuration
```

This delivery boundary wraps the existing application architecture. It does not replace or extend the business-layer chain.

## 11.1 Runtime and Installation Separation

Canonical persistent-state boundary:

```text
installed application files
≠
%LOCALAPPDATA%\Markei user data
```

Installed application files include:

- `Markei.exe`;
- frozen Python and PySide6 dependencies;
- Qt runtime plugins;
- bundled read-only `schema.sql`;
- executable metadata.

Writable user data includes:

- `market.sqlite`;
- SQLite WAL/SHM sidecars when present;
- startup diagnostics;
- future user-owned backups or exports.

The production frozen runtime must not contain:

- `seed.sql`;
- `market.sqlite`;
- WAL/SHM files;
- sample products, purchases, stores, or categories.

## 11.2 Delivery Responsibility Map

```text
PyInstaller
    runtime freezing
    Python/PySide6 and Qt collection
    schema.sql bundling
    executable metadata

Inno Setup
    per-user placement
    shortcuts
    uninstall registration
    stable upgrade identity

Database lifecycle
    resource discovery
    schema initialization
    settings defaults
    migrations
    external user-data preservation
```

The executable builder does not own installer lifecycle. The installer does not own SQL, schema interpretation, migrations, or business records.

## 11.3 Validation Boundary

The PyInstaller one-folder runtime, frozen launch, working-directory-independent schema discovery, schema-only initialization, external user-data path, startup logging, first receipt without seeded store, and public-page construction are validated.

The Inno Setup source configuration is accepted, but the installer lifecycle is not yet validated because `ISCC.exe` was unavailable. The following remain configured or unresolved rather than validated:

- compiled installer artifact;
- Start Menu launch;
- installed upgrade preservation;
- uninstall preservation;
- reinstall recovery;
- SmartScreen and antivirus behavior;
- signing and rollback policy.

## 11.4 Runtime-Path Coupling

For the shortest sound Sprint 01 route, runtime resource and user-data helpers remain in `app/core/database.py`.

This is accepted desktop infrastructure coupling, not a new platform-neutral contract. Possible extraction to a desktop runtime-path module is deferred. The coupling must not spread into ProductService, Repository contracts, models, or read models.
