# 03_DECISION_LOG.md

> Version: 0.5
> Status: Draft
> Persistence Class: Observational
> Knowledge Class: Design History
> Authority: Design Chat
> Scope: Architectural decisions, observations, drift, and deferred design questions

---

# Product View Design Absorption — Codex Evidence

Source evidence: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`.

Codex reported that the Product View feature was materialized as a reusable read-only panel, with RegisterPage owning placement, ProductService owning read-model assembly, Repository owning SQL/retrieval/mapping, Product owning cached summaries, Purchase owning optional expiration history, Store owning nullable address, and average price remaining derived.

## Canonical Design Decisions

- Product View is a reusable read-only `ProductDetailPanel`.
- RegisterPage owns ProductDetailPanel placement below the writable receipt form.
- RegisterPage does not own Product View calculations.
- ProductService owns Product View read-model assembly.
- Repository owns SQL retrieval, persistence-shape support, and row mapping.
- Product owns cached summary fields for purchase rhythm and shelf-life summary.
- Purchase owns optional `expiration_date` as receipt/batch history.
- Store owns nullable `address`.
- Average price remains derived from purchases.

## Architectural Observations

- MainWindow double-click navigation was reported as unchanged.
- ProductDetailPanel renders dictionaries and does not access repositories or services directly.
- RegisterPage collects optional receipt expiration input and loads the panel.
- Repository provides explicit SQL read helpers for average price, latest store rows, and last purchase rows.
- ProductService centralizes shelf-life calculation and Product View read-model assembly.

## Derived Architecture Summary

```text
Inventory selection
    ↓
RegisterPage placement
    ↓
ProductDetailPanel rendering
    ↓
ProductService read-model assembly
    ↓
Repository retrieval/mapping
    ↓
Product / Purchase / Store persistence
```

## Deferred Design Questions

- Where should `expected_expiration_date` become user-facing beyond Product View?
- Should shelf-life ever affect inventory list classification, or should classification remain purchase-rhythm based?

## Implementation Drift

- No intentional architecture boundary drift was reported.
- Watch point: RegisterPage has both writable receipt input and Product View placement. This remains acceptable only while calculations stay in ProductService and rendering stays in ProductDetailPanel.

---

# Cycle 02 History + Settings Design Absorption — Codex Evidence

Source evidence: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md` after Cycle 02 materialization.

Cycle 02 established service-owned History grouping, repository retrieval boundaries, SQLite settings persistence, Settings-owned configuration surfaces, and Settings-placed store create/update. Its fixed Wednesday period rules were later generalized in Cycle 04.

## Canonical Design Decisions

- History uses a service-prepared read model.
- ProductService owns History period grouping and aggregate/total-row meaning.
- Repository retrieves purchase/store/settings data without deciding period semantics.
- HistoryPage renders grouped sections, purchase rows, summaries, and total rows.
- SettingsPage owns History configuration surfaces and store editing placement.
- Store create/update belongs in Settings rather than RegisterPage.
- SQLite key/value settings persistence is accepted.
- Product View architecture remains unchanged.
- RegisterPage remains receipt-focused.

## Historical Implementation Context

- Cycle 02 initially used `history.week_boundary = wednesday` and `history.month_boundary_rule = first_wednesday`.
- Service read settings before assembling History.
- Settings page wrote settings through service/repository flow.
- `pages.order` was persisted but not consumed by MainWindow.

## Derived Architecture Summary

```text
SettingsPage
    ↓ edits settings / stores
ProductService
    ↓ interprets settings and validates store flow
Repository
    ↓ persists settings / stores
SQLite
```

```text
HistoryPage
    ↓ requests read model
ProductService
    ↓ groups raw rows using settings
Repository
    ↓ retrieves purchase / store / settings data
SQLite
```

## Deferred Design Questions

- Should `pages.order` drive MainWindow tab/page order in a later cycle?
- What referential behavior is required before supporting store deletion?

## Implementation Drift

- No intentional boundary drift was reported.
- Fixed Wednesday settings are historical behavior, not current canonical design after Cycle 04.

---

# Cycle 03 Lists + History Analytics Design Absorption — Codex Evidence

Source evidence: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`, supported by `G_OPS_CODEX.md` and `H_DDC_CODEX.md`.

Codex reported that Cycle 03 materialized unified Lists navigation, embedded History analytics, and service-owned read-model contracts without schema expansion, backend rewrite, mobile implementation, or direct SQL in UI.

## Canonical Design Decisions

- Cycle 03 extends the Desktop UI -> ProductService -> Repository -> SQLite boundary.
- Public inventory navigation is one Lists page.
- Former Storage / Shortage / Market meanings are internal Lists views.
- Lists supports `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy`.
- Lists default view is the hybrid all-products list with Status.
- ProductService owns Lists classification, read-model assembly, and global latest/delta price meaning.
- History analytics starts embedded in HistoryPage.
- ProductService owns analytics frame interpretation, totals, percentages, average purchase timelapse, and product-cycle comparison.
- Repository and schema were not expanded for analytics caching or list-specific persisted fields.
- Register remains purchase-entry-only.
- Settings remains the store-management surface.
- `pages.order` remains inert.

## Architectural Observations

- Public tabs are Register, Lists, History, and Settings.
- Compatibility helpers route old inventory navigation names to Lists internal views.
- HistoryPage contains embedded analytics controls under grouped History.
- Analytics reports unparsed rows separately from date/store exclusions.
- New service methods expose platform-neutral dictionaries/lists.

## Derived Architecture Summary

```text
ListsPage
    ↓ selected view key
ProductService.get_lists_view(...)
    ↓ status / prices / remaining days / labels
Repository
    ↓ supporting retrieval
SQLite
```

```text
HistoryPage embedded analytics
    ↓ date range + optional store filter
ProductService.get_history_analytics_view(...)
    ↓ totals / percentages / average timelapse / comparison
Repository
    ↓ supporting retrieval
SQLite
```

## Deferred Design Questions

- Should invalid analytics dates surface explicit validation?
- Should same-day intervals be handled specially?
- Should old inventory page files be retired after manual QA?
- Should future delta prices support store/frame scoping?
- Should cycle comparison gain configurable tolerance?
- Should detachable analytics become a separate lifecycle?

## Implementation Drift

- No contradiction or major architecture drift was found.
- UI did not receive direct SQL.
- Schema did not expand for analytics caching.
- Mobile implementation was not introduced.
- Invalid analytics dates acting like omitted boundaries remain an operational/design risk.

---

# Cycle 04 Settings Stabilization Design Absorption — Codex Evidence

Source evidence:

- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- materialized commit `c9e9244a5187c32a2812641f05eac8856801a7d4`

Cycle 04 materialized generalized History settings and an operational-day boundary contract while preserving the existing layer architecture.

## Canonical Design Decisions

- SettingsPage remains the user-facing configuration and store-management surface.
- SettingsPage owns controls, edit state, save events, and validation feedback presentation.
- ProductService owns settings defaults, strict submitted-value validation, tolerant persisted-value fallback, week/month interpretation, and operational-date derivation.
- Repository remains generic key/value persistence and does not own setting semantics.
- SQLite remains generic key/value settings storage.
- Canonical settings keys are:
  - `history.week_boundary`
  - `history.month_boundary_mode`
  - `history.month_boundary_weekday`
  - `history.month_boundary_day`
  - `time_reference.day_boundary_time`
- Weekday values are stored as lowercase semantic values separate from UI labels.
- Month grouping supports `first_weekday` and `day_of_month` modes.
- Month day is constrained to 1–28.
- `time_reference.day_boundary_time` is the canonical operational-day rollover setting.
- Purchase date remains factual and operational date remains derived.
- Date-only purchases are not shifted by operational-day time in Cycle 04.
- Lists status, purchase rhythm, depletion prediction, and expected next purchase remain unchanged.
- `pages.order` remains persisted but inert.
- No mobile, backend, synchronization, external-integration, receipt-recognition, or store-deletion architecture was added.

## Architectural Observations

- `ProductService.DEFAULT_SETTINGS` exposes the current settings contract.
- `validate_history_settings_input()` rejects invalid user-submitted values.
- `validated_settings()` normalizes invalid persisted values to defaults.
- `save_history_settings()` persists canonical keys through Repository.
- Legacy `history.month_boundary_rule` is read only as compatibility input when canonical month keys are absent.
- `SettingsPage` uses combo item data for semantic values and delegates saving to ProductService.
- `Repository.get_settings()` and `Repository.set_setting()` remain generic.
- Migration defaults use non-destructive insertion.
- Fresh-database seed values use the canonical Cycle 04 keys.
- MainWindow still mounts static Register, Lists, History, and Settings tabs.
- HistoryPage did not gain grouping calculations.
- ListsPage did not gain time-reference interpretation.

## Derived Architecture Summary

```text
SettingsPage
    ↓ semantic values / save event
ProductService
    ↓ defaults / validation / fallback / interpretation
Repository
    ↓ generic key/value persistence
SQLite
```

```text
Factual purchase date or datetime
    ↓ ProductService operational_date(...)
Derived operational date
```

## Persistence and Compatibility Position

- No schema redesign was required.
- Canonical settings defaults are inserted without overwriting existing values.
- `history.month_boundary_rule` may remain stored as legacy data.
- Once canonical month keys exist, the legacy key is not the source of current semantics.
- Migration or removal of the legacy key remains a later explicit decision.

## Mobile Readiness Effect

Cycle 04 improves future portability through:

- semantic stored values independent of desktop labels;
- service-owned validation and interpretation;
- an operational-date helper outside PySide6;
- preserved Repository and SQLite boundaries.

This does not make the project ready for mobile implementation.

## Deferred Design Questions

- Should future purchase records store time-of-day?
- Should operational-day semantics later affect Lists or prediction behavior?
- Should legacy month-boundary data be migrated or removed?
- When should Settings split into smaller internal components?
- Should `pages.order` become active in a later cycle?

## Implementation Drift and Watch Points

- No architectural boundary drift was found.
- No direct SQL was added to UI.
- Repository did not acquire period semantics.
- HistoryPage did not acquire grouping logic.
- ListsPage did not acquire time-reference behavior.
- MainWindow did not activate `pages.order`.
- Minor compatibility residue remains through `history.month_boundary_rule`.
- Operational correctness watch: the current `get_history_view()` expression appears to subtract one day from the next month start only for `day_of_month` mode. The first-weekday period-end label should be verified separately. This does not alter the accepted ownership design.
- Human interactive Settings/store QA remains incomplete; offscreen and service-level evidence does not fully validate presentation behavior.

---

# Cycle 05 Sprint 01 Windows Desktop Installation — Design Absorption

Accepted evidence source:

- human-directed Cycle 05 Sprint 01 absorption evidence;
- materialized Windows desktop-installation branch state;
- runtime validation summarized by Operational and Didactic domain absorption.

The repository copies of `G_OPS_CODEX.md`, `H_DDC_CODEX.md`, and `I_DSN_CODEX.md` still described Cycle 04 when this absorption occurred. That mismatch is recorded as evidence-report drift. The human explicitly classified the supplied Sprint 01 evidence as verified, so Design memory was reconciled from the accepted evidence without rewriting DEV_STAGE reports.

## Accepted Architectural Decisions

- The desktop distribution boundary is:

```text
source application
→ PyInstaller one-folder runtime
→ Inno Setup per-user installer configuration
```

- The persistent-state boundary is:

```text
installed application files
≠
%LOCALAPPDATA%\Markei user data
```

- PyInstaller owns runtime freezing, PySide6/Qt collection, `schema.sql` bundling, and executable metadata.
- Inno Setup owns per-user placement, shortcut configuration, uninstall registration, and stable upgrade identity.
- Database lifecycle owns schema discovery, first-launch initialization, configuration defaults, migrations, and external user-data preservation.
- Production initialization is schema-only and seed-free.
- Production runtime contains `schema.sql` and excludes `seed.sql`, `market.sqlite`, WAL/SHM files, and sample business records.
- The current application boundary remains Desktop UI -> ProductService -> Repository -> SQLite.
- Packaging and installer configuration do not become business or persistence layers.
- Runtime-path helpers remain in `app/core/database.py` for the shortest Sprint 01 route.
- Possible extraction into a desktop runtime-path module is deferred.
- SQLite remains desktop-local persistence and is not promoted into a mobile, synchronization, backend, or cross-device contract.

## Validated Runtime Evidence

- PyInstaller one-folder runtime was produced.
- Frozen executable launch succeeded.
- Schema discovery was independent of the working directory.
- Production first launch created an empty business database with six configuration rows.
- Verified fresh state:

```text
products: 0
purchases: 0
stores: 0
categories: 0
settings: 6
```

- First receipt operation no longer depends on a seeded store.
- Startup failures can be logged under writable user data.
- Public pages constructed successfully: Register, Lists, History, Settings.
- PySide6 and PyInstaller dependencies were pinned.

## Configured but Unvalidated Installer Decisions

- Inno Setup source configuration exists for per-user installation.
- Start Menu shortcut configuration exists.
- Uninstall registration and stable upgrade identity are represented in configuration.
- User data is intended to remain outside installer-owned files.

These are accepted configuration decisions, not validated lifecycle behavior.

## Active Blocker

```text
Inno Setup ISCC.exe unavailable
```

Because the installer compiler was unavailable, the following were not promoted as validated:

- compiled installer artifact;
- Start Menu launch from an installed application;
- installed upgrade preservation;
- uninstall preservation;
- reinstall recovery;
- SmartScreen or antivirus behavior.

## Desktop-to-Mobile Isolation

- Windows packaging files and path rules remain desktop infrastructure.
- ProductService and Repository contracts remain free of installer concerns.
- The future Sprint 02 clone may omit packaging and installer configuration without changing business meaning.
- Desktop `%LOCALAPPDATA%` policy does not define future mobile persistence.
- No API, backend, authentication, synchronization, or mobile presentation architecture was introduced.

## Deferred Design Decisions

- Whether runtime-path helpers should later move into a desktop-specific module.
- The exact installed upgrade compatibility and rollback policy.
- Whether uninstall should offer an explicit optional data-deletion action while preserving data by default.
- Production signing and SmartScreen reputation requirements.
- Automatic update strategy.
- Mobile persistence, synchronization, backend, identity, contracts, and framework selection.

## Remaining Watch Points

- Manual interactive UI walkthrough remains incomplete.
- The Cycle 04 first-weekday operational-month period-end calculation remains unresolved.
- Installer lifecycle validation must be performed against a compiled artifact before Sprint 01 can be described as a fully validated installed release.
