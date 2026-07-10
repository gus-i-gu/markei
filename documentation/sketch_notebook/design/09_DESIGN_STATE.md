# 09_DESIGN_STATE.md

> Version: 0.5
> Status: Active Checkpoint
> Persistence Class: Checkpoint
> Knowledge Class: Design State
> Authority: Design Chat
> Scope: Low-token recovery surface for current Markei design state

---

# Current Design State

Markei has completed four application-boundary design cycles and has materialized the Windows desktop-distribution architecture for Cycle 05 Sprint 01.

## Cycle 01 — Product View

- Product View is a reusable read-only `ProductDetailPanel`.
- RegisterPage owns placement below the receipt form, not Product View calculations.
- ProductService owns Product View read-model assembly and shelf-life meaning.
- Repository owns SQL retrieval, persistence support, and row mapping.
- Product owns cached purchase-rhythm and shelf-life summaries.
- Purchase owns optional `expiration_date` as receipt/batch history.
- Store owns nullable `address`.
- Average price remains derived from purchases.
- Purchase rhythm and shelf-life rhythm remain separate.

## Cycle 02 — History + Settings

Cycle 02 established the History/Settings boundary. Its original fixed Wednesday grouping is historical and was generalized by Cycle 04.

- History uses a service-prepared grouped read model.
- ProductService owns History period grouping, read-model assembly, and aggregate/total-row meaning.
- Repository retrieves purchase/store/settings data without deciding period semantics.
- HistoryPage renders grouped sections, purchase rows, summaries, and total rows.
- SettingsPage owns configuration surfaces and store editing placement.
- Store create/update belongs in Settings, not RegisterPage.
- SQLite key/value settings persistence is accepted.
- `pages.order` persistence exists, but MainWindow consumption remains deferred.

## Cycle 03 — Lists + History Analytics

- ListsPage is the public inventory surface.
- Former Storage / Shortage / Market meanings are internal Lists views.
- ProductService owns Lists read-model assembly, product status classification, global latest/delta price meaning, remaining-days meaning, and row labels.
- History analytics is embedded in HistoryPage and read-only.
- ProductService owns History analytics frame interpretation, totals, expenditure percentages, average purchase timelapse, and product-cycle comparison.
- Repository/schema were not expanded for analytics caching or list-specific persisted fields.
- Register remains purchase-entry-only.
- `pages.order` remains inert.
- Mobile readiness improved through service/read-model contracts, but mobile implementation remained unready.

## Cycle 04 — Settings Stabilization

Cycle 04 generalized History configuration while preserving the existing layer boundary.

Accepted settings contract:

```text
history.week_boundary
history.month_boundary_mode
history.month_boundary_weekday
history.month_boundary_day
time_reference.day_boundary_time
```

Accepted ownership:

```text
SettingsPage
    renders controls, collects edits, and triggers save

ProductService
    defines defaults, validates user edits, normalizes persisted values,
    interprets week/month settings, and derives operational dates

Repository
    reads and writes generic key/value settings

SQLite
    stores settings and existing application facts
```

Cycle 04 design state:

- Week boundary accepts all seven lowercase semantic weekday values.
- Month boundary supports `first_weekday` and `day_of_month` modes.
- Month weekday accepts all seven weekdays.
- Month day is constrained to 1–28.
- `time_reference.day_boundary_time` is canonical and uses normalized `HH:MM` values.
- UI labels are separated from stored semantic values.
- Strict user-edit rejection and tolerant persisted-value fallback are separate service responsibilities.
- Legacy `history.month_boundary_rule` is compatibility residue, not current canonical design.
- Purchase date remains factual; operational date remains derived.
- Current purchase records are date-only, so day-boundary time has no material effect on existing grouped History rows.
- Lists status, purchase rhythm, depletion prediction, and expected-next-purchase behavior were not changed.
- Store create/update remains in Settings.
- `pages.order` remains persisted but inert.
- No mobile, backend, synchronization, external-integration, or receipt-recognition architecture was introduced.

## Cycle 05 Sprint 01 — Windows Desktop Installation

Accepted distribution boundary:

```text
source application
→ PyInstaller one-folder runtime
→ Inno Setup per-user installer configuration
```

Accepted persistent-state boundary:

```text
installed application files
≠
%LOCALAPPDATA%\Markei user data
```

Stable ownership:

```text
PyInstaller
    freezes the Python/PySide6 runtime
    collects Qt dependencies and plugins
    bundles schema.sql as a read-only resource
    carries executable metadata

Inno Setup
    defines per-user placement
    configures shortcuts
    registers uninstall
    carries stable upgrade identity

Database lifecycle
    resolves bundled schema resources
    initializes a missing user database
    inserts configuration defaults
    applies migrations
    preserves writable user data outside installation files
```

Materialized and validated:

- PyInstaller one-folder runtime.
- Frozen executable launch.
- Working-directory-independent `schema.sql` discovery.
- Schema-only production initialization.
- Seed-free empty business database.
- User database under `%LOCALAPPDATA%\Markei`.
- First receipt flow without a seeded store.
- Startup failure logging under user data.
- Pinned PySide6 and PyInstaller dependencies.
- Public pages constructed successfully: Register, Lists, History, Settings.
- Fresh production database state was verified as `products: 0`, `purchases: 0`, `stores: 0`, `categories: 0`, `settings: 6`.

Production runtime contains:

```text
schema.sql
```

Production runtime does not contain:

```text
seed.sql
market.sqlite
SQLite WAL/SHM files
sample business records
```

Configured but not yet validated:

- Inno Setup per-user installer script.
- Start Menu shortcut behavior.
- Installed upgrade preservation.
- Uninstall preservation.
- Reinstall recovery.
- Stable upgrade identity as exercised by compiled artifacts.

Active blocker:

```text
Inno Setup ISCC.exe unavailable
```

The unavailable compiler prevents the installer artifact and installed lifecycle from being treated as validated.

Desktop-specific shortest-route coupling remains accepted:

```text
runtime-path helpers remain in app/core/database.py
```

Possible extraction into a desktop runtime-path module is deferred. This coupling must not spread into ProductService, Repository contracts, models, or read models.

# Boundary Status

- No intentional application-layer boundary drift was introduced through Cycle 05 Sprint 01.
- UI owns rendering, controls, view selection, navigation hooks, and events.
- ProductService owns Product View, Lists, grouped History, History analytics, Settings validation, Settings fallback, and temporal interpretation.
- Repository owns SQL retrieval, persistence operations, generic settings access, and row mapping.
- Repository must not own period, setting, packaging, installer, or Windows-path semantics.
- SQLite owns persisted facts and key/value settings for the desktop application.
- PyInstaller and Inno Setup remain delivery infrastructure outside the business boundary.
- Packaging configuration must not become a business or persistence layer.
- RegisterPage remains receipt-focused.
- SettingsPage remains the configuration and store-management surface.
- HistoryPage continues to render service-prepared grouping and does not own bucket calculations.
- ListsPage does not interpret `time_reference.day_boundary_time`.
- MainWindow continues to mount static public tabs and does not consume `pages.order`.

Implementation watch point:

- The Cycle 04 source appears to calculate the displayed first-weekday operational-month end differently from day-of-month mode. Operational verification should confirm that first-weekday period-end labels end one day before the next operational month begins. This remains an implementation correctness risk, not an accepted design change.
- Manual interactive UI QA remains unresolved despite successful construction and automated/offscreen evidence.

# Desktop-to-Mobile Isolation

Current classification: desktop installation architecture materialized; mobile architecture remains deferred to Sprint 02.

Preserved isolation:

- Packaging configuration and Windows path policy remain desktop infrastructure.
- ProductService contracts remain free of PyInstaller, Inno Setup, shortcut, installation, and uninstall concerns.
- Repository contracts remain free of installer concerns.
- SQLite remains the current desktop persistence implementation and is not promoted into a mobile, shared-backend, synchronization, or cross-device contract.
- The future repository clone may omit Windows packaging files without changing business meaning.

Prepared now:

- service-owned Lists and History analytics read models;
- platform-neutral dictionary/list outputs;
- service-owned Settings validation and interpretation;
- stored semantic values separated from desktop labels;
- operational-date interpretation available outside PySide6;
- UI logic limited primarily to rendering and events;
- desktop packaging isolated from the application-service boundary.

Not yet ready:

- mobile presentation implementation;
- server/shared-backend architecture;
- authentication or synchronization design;
- mobile persistence strategy;
- formal typed service contracts;
- service factory/dependency injection boundary;
- broader date/time storage strategy;
- automated service-level and UI interaction coverage;
- desktop-to-mobile data migration or coexistence architecture.

# Deferred Design Questions

- Should runtime-path resolution later move from `app/core/database.py` to a desktop infrastructure module?
- What installer upgrade code and versioning policy will be accepted after compiled lifecycle validation?
- Should uninstall expose an explicit optional user-data deletion action while preserving data by default?
- What rollback policy is required for future schema-changing upgrades?
- When should production signing and SmartScreen reputation become release requirements?
- Should future purchase records store time-of-day so `time_reference.day_boundary_time` can materially affect grouping?
- Should operational-day semantics later affect Lists status, purchase rhythm, depletion prediction, or expected next purchase?
- Should legacy `history.month_boundary_rule` be migrated/removed or remain inert compatibility data?
- When should Settings split into smaller internal editor components?
- Should invalid analytics date input surface explicit validation instead of acting like an omitted boundary?
- Should same-day purchase intervals be handled specially in average timelapse display?
- Should old Storage/Shortage/Market page files be retired after manual QA?
- Should future Lists delta price support store/frame scoping?
- Should cycle comparison gain configurable tolerance?
- Should detachable History analytics become a separate lifecycle?
- Should `pages.order` drive MainWindow ordering in a later cycle?
- What referential behavior is required before supporting store deletion?
- Where should `expected_expiration_date` appear beyond Product View?
- Should shelf-life ever influence inventory list classification?

# Next Recovery Targets

- Canonical architecture: `documentation/sketch_notebook/design/01_ARCHITECTURE.md`
- Design history: `documentation/sketch_notebook/design/03_DECISION_LOG.md`
- Derived model map: `documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md`
- Latest Codex design evidence when reconciling materialization: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
- Installer compilation and installed-lifecycle evidence when `ISCC.exe` becomes available.
