# [M] Recovery Exploratory Stage

> Status: Active recovery staging
> Authority: Main Chat
> Scope: Contemporary repository collection and domain-chat handoff for the Sketch Notebook recovery cycle
> Repository: `gus-i-gu/markei`
> Branch: `sketch-notebook-recovery`

---

# 1. Recovery Context

The numbered and lettered project-memory files were intentionally emptied for a clean recovery cycle. The methodology boot was completed from:

```text
INDEX.md
↓
METHOD_FOUNDATIONS.md
↓
FLUX.md
↓
PROMOTION_RULES.md
↓
CHAT_PROTOCOL.md
```

The repository is therefore the current implementation-evidence source. Findings in this file are staged observations, not automatically canonical project memory.

The exploratory strategy is module- and package-oriented rather than commit-oriented. Cycle 05 commits contain extensive generated and packaging material that may obscure the application structure.

Primary inspection targets:

```text
app/core/
app/database/
app/desktop/
```

---

# 2. Confirmed Application Spine

```text
root main.py
↓
app/main.py
↓
app/desktop/main_window.py
↓
Desktop pages and widgets
↓
app/core/services.py :: ProductService
↓
app/core/repository.py :: Repository
↓
app/core/database.py
↓
SQLite database + app/database/schema.sql + app/database/seed.sql
```

The root `main.py` delegates to `app.main.main`. `app/main.py` creates the Qt application, creates `MainWindow`, displays it, and starts the Qt event loop.

---

# 3. Database Topography

## 3.1 Resource directory

Confirmed resource files:

```text
app/database/
├── schema.sql
└── seed.sql
```

This directory stores bundled SQL resources. It is not the runtime user-data location.

## 3.2 Database manager

Implementation module:

```text
app/core/database.py
```

Declared responsibilities:

- locate bundled resources;
- locate the user-writable data directory;
- create and initialize the SQLite database;
- configure every SQLite connection;
- execute schema and optional seed scripts during initialization;
- apply idempotent migrations for existing databases;
- provide and close connections;
- reset the database when explicitly requested.

Runtime paths:

```text
Bundled SQL resources:
<resource base>/app/database/

Runtime database:
%LOCALAPPDATA%/Markei/market.sqlite
```

Fallback runtime location:

```text
~/AppData/Local/Markei/market.sqlite
```

Connection configuration:

```text
PRAGMA foreign_keys = ON
PRAGMA journal_mode = WAL
PRAGMA synchronous = NORMAL
row_factory = sqlite3.Row
```

`connect()` initializes the database when absent, opens a configured connection, runs migrations, and returns the connection.

## 3.3 Initialization and migration

Initialization flow:

```text
create user-data directory
↓
preserve existing database unless recreate=True
↓
create SQLite file
↓
execute schema.sql
↓
execute seed.sql when present
↓
commit and close
```

Current migration behavior is additive and idempotent. It ensures selected columns, the settings table, and default setting values. It does not currently expose a numbered migration registry or schema-version table.

Confirmed additive migrations include:

- `purchases.expiration_date`;
- `products.average_shelf_life_days`;
- `products.expected_expiration_date`;
- `stores.address`;
- creation/defaulting of application settings.

## 3.4 Schema

Confirmed tables:

```text
products
purchases
categories
stores
settings
promotions
```

Key relationships:

```text
products.category_id → categories.id
purchases.product_id → products.id
purchases.store_id → stores.id
promotions.product_id → products.id
promotions.store_id → stores.id
```

Purchase-to-product behavior:

```text
ON UPDATE CASCADE
ON DELETE CASCADE
```

The product table stores both identity/description and denormalized current summaries, including:

- current and previous price;
- current and previous purchase date;
- average consumption and duration;
- expected next purchase;
- shelf-life and expected expiration;
- price delta values.

The purchase table stores the historical receipt event. Categories and stores provide references. Settings use a generic key/value representation. Promotions have a dedicated table, although the inspected desktop receipt workflow currently also stores a simple promotion flag on purchases.

Confirmed indexes:

- product name;
- purchase product ID;
- purchase date.

## 3.5 Seed

The seed establishes:

- category `F` / Food;
- store ID 1 / Muffato;
- default history and page-order settings;
- an example Rice product.

Recovery question: distinguish production-required baseline data from demonstration-only seed data.

## 3.6 Persistence boundary

`app/core/repository.py` is the concrete SQLite adapter. It owns SQL operations and row-to-model mapping while delegating connection lifecycle to `app/core/database.py`.

Confirmed dependency direction:

```text
ProductService
↓
Repository
↓
Database Manager
↓
SQLite
```

The repository creates one connection and cursor during initialization. Product, purchase, category, store, and settings operations are concentrated in the same repository class.

---

# 4. Desktop Topography

Confirmed composition:

```text
app/desktop/
├── main_window.py
└── ui/
    ├── pages/
    │   ├── register_page.py
    │   ├── lists_page.py
    │   ├── history_page.py
    │   └── settings_page.py
    └── widgets/
        └── product_detail_panel.py
```

## 4.1 Main window

`MainWindow` composes four tabs:

```text
Register
Lists
History
Settings
```

It also coordinates:

- navigation between tabs;
- selection of internal Lists views;
- opening an existing product in Register edit mode;
- refreshing Lists and History after writes.

Storage, Shortage, and Market are no longer separate primary tabs. They are represented as internal views of the unified Lists page:

```text
Storage  → in-house
Shortage → shortage
Market   → to-buy
```

## 4.2 Register page

`RegisterPage` describes itself as the only writable product/receipt page.

It owns:

- receipt-entry form construction;
- mandatory-field checks;
- UI date and promotion conversion;
- add/update/delete/clear interaction state;
- loading a product for editing;
- delegating workflows to `ProductService`;
- refreshing dependent pages through `MainWindow`;
- presenting a product detail widget.

The form currently exposes technical identifiers such as category ID and store ID directly. This should be examined as a current implementation fact, not assumed to be the intended final UX.

## 4.3 Lists page

`ListsPage` is a read-only inventory table with selectable internal views:

- all products;
- in-house;
- shortage;
- to-buy;
- combined in-house + shortage;
- combined shortage + to-buy.

It requests a prepared view model from:

```text
ProductService.get_lists_view(view_key)
```

The page renders values and applies display coloring. Double-clicking a row loads the product through the service and asks `MainWindow` to open Register in edit mode.

## 4.4 History page

`HistoryPage` is read-only purchase history plus analytics.

It delegates grouping and calculations to the service through:

```text
get_history_view()
get_history_analytics_view(...)
```

Presentation responsibilities include:

- month/week tree rendering;
- period totals;
- store totals;
- average-price labels;
- date/store analytics filters;
- product expenditure and cycle comparison table;
- warnings for unparsed purchase dates.

The service, rather than the page, defines period grouping and analytical meaning.

## 4.5 Settings page

`SettingsPage` is writable configuration UI for:

- history week boundary;
- history month-boundary mode;
- selected month weekday or day-of-month;
- day-boundary time;
- store creation and editing.

It delegates validation and persistence to `ProductService`. After saves it requests `MainWindow` to refresh dependent pages.

## 4.6 Desktop/service lifecycle observation

Each inspected page creates its own `ProductService`, and each service creates its own `Repository`, connection, and cursor. Pages attempt to close their service in `closeEvent()`.

This is a significant cross-domain investigation point:

- Operational: confirm whether page close events reliably release all connections during tabbed-window lifetime and shutdown.
- Design: determine whether service/repository lifetime should remain page-local or move to application composition.
- Didactic: explain object lifetime, dependency construction, connection ownership, and UI composition.

No architectural verdict is promoted here.

---

# 5. Cross-Cutting Recovery Questions

1. Is the runtime database initialization reliable in source and frozen/PyInstaller execution?
2. Do schema, seed, additive migrations, models, repository mappings, and service assumptions remain fully aligned?
3. Which SQL seed values are required defaults, and which are only sample content?
4. Is the `promotions` table active, deferred, or partially superseded by the purchase promotion flag?
5. Are date strings consistently stored and compared across schema, seed, UI, service, and repository?
6. Is one service/repository/connection per desktop page intentional and safe?
7. Are database resources correctly bundled by the build configuration?
8. Which UI responsibilities are pure presentation, and which currently duplicate validation or formatting owned elsewhere?
9. Does the unified Lists page represent an accepted architecture or merely the latest implementation state?
10. Which current repository facts should become canonical, derived, checkpoint, or observational domain memory?

---

# 6. Domain Chat Launch Prompt — Operational [O]

```text
You are the Operational Chat [O] for the Sketch Notebook recovery cycle inside the Markei project.

Your role is to observe the project as execution. Diagnose current implementation state, identify exact files and commands, expose operational risks, and prepare reproducible validation. Do not decide architecture, methodology, or semantic promotion outside the operational domain.

Begin with strict methodology boot from branch `sketch-notebook-recovery` in repository `gus-i-gu/markei`:

1. documentation/sketch_notebook/INDEX.md
2. documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
3. documentation/sketch_notebook/methodology/FLUX.md
4. documentation/sketch_notebook/methodology/PROMOTION_RULES.md
5. documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md

Then recover operational state hierarchically:

1. documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
2. because the checkpoint is intentionally empty, inspect this recovery collection:
   documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
3. inspect repository implementation only as required.

Primary investigation scope:

- app/core/database.py
- app/core/repository.py
- app/core/config.py
- app/database/schema.sql
- app/database/seed.sql
- app/desktop/main_window.py
- app/desktop/ui/pages/register_page.py
- app/desktop/ui/pages/lists_page.py
- app/desktop/ui/pages/history_page.py
- app/desktop/ui/pages/settings_page.py
- build/packaging configuration and tests only where necessary to validate database-resource/runtime behavior.

Investigate:

- source and frozen runtime database paths;
- schema creation and migration behavior;
- schema/model/repository alignment;
- connection and cursor lifetime across multiple page-local ProductService instances;
- close/shutdown behavior;
- date-storage consistency;
- seed safety and repeatability;
- resource bundling for schema.sql and seed.sql;
- minimum startup, database, and desktop smoke tests;
- concrete failures, uncertainties, and exact validation commands.

Do not rewrite files yet.

Produce:

1. current operational state;
2. verified execution flow;
3. exact files inspected;
4. risks classified as confirmed, suspected, or unknown;
5. minimal validation matrix with commands and expected evidence;
6. recovery candidates for operational canonical, derived, checkpoint, and observational memory;
7. a proposed complete update for documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md.
```

---

# 7. Domain Chat Launch Prompt — Didactic [A]

```text
You are the Didactic Chat [A] for the Sketch Notebook recovery cycle inside the Markei project.

Your role is to observe the project as learning. Recover and organize the concepts required to understand the contemporary implementation. Do not decide application architecture, execute patches, or promote implementation observations as design truth.

Begin with strict methodology boot from branch `sketch-notebook-recovery` in repository `gus-i-gu/markei`:

1. documentation/sketch_notebook/INDEX.md
2. documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
3. documentation/sketch_notebook/methodology/FLUX.md
4. documentation/sketch_notebook/methodology/PROMOTION_RULES.md
5. documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md

Then recover didactic state hierarchically:

1. documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
2. because the checkpoint is intentionally empty, inspect:
   documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
3. inspect relevant repository files for project examples.

Primary implementation spine:

Desktop pages
→ ProductService
→ Repository
→ Database Manager
→ SQLite/schema/seed

Focus concepts:

- package, module, and application entry point;
- UI composition and event-driven programming;
- service layer and repository pattern;
- dependency direction and responsibility boundaries;
- object construction and lifetime;
- database connection and cursor ownership;
- SQLite schema, foreign keys, indexes, WAL, and row factories;
- initialization versus migration;
- bundled resource path versus user-data path;
- normalized historical events versus denormalized current summaries;
- model mapping;
- validation, formatting, and view models;
- date representation and parsing;
- canonical, derived, checkpoint, and observational knowledge as applied to this recovery.

Use the established KANBAN marker families and independent numbering rules, but do not invent previous concept status because all didactic files were intentionally wiped.

Do not write permanent didactic files yet.

Produce:

1. a contemporary project learning spine;
2. candidate concepts grouped by marker family;
3. prerequisite and related-concept relationships;
4. project examples with exact source files;
5. concepts that require Operational or Design verification before they can be taught as stable project truth;
6. proposed initial learning statuses with explicit evidence limits;
7. recovery candidates for KANBAN, glossary, checkpoint, and lecture history;
8. a proposed complete update for documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md.
```

---

# 8. Domain Chat Launch Prompt — Design [D]

```text
You are the Design Chat [D] for the Sketch Notebook recovery cycle inside the Markei project.

Your role is to observe the project as architecture. Recover current responsibility boundaries, dependency direction, domain relationships, and unresolved design questions from implementation evidence. Do not execute patches, own operational validation, or convert implementation accidents directly into canonical decisions.

Begin with strict methodology boot from branch `sketch-notebook-recovery` in repository `gus-i-gu/markei`:

1. documentation/sketch_notebook/INDEX.md
2. documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
3. documentation/sketch_notebook/methodology/FLUX.md
4. documentation/sketch_notebook/methodology/PROMOTION_RULES.md
5. documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md

Then recover design state hierarchically:

1. documentation/sketch_notebook/design/09_DESIGN_STATE.md
2. because the checkpoint is intentionally empty, inspect:
   documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
3. inspect source files needed to verify implementation structure.

Primary scope:

- app/core/models.py
- app/core/contracts.py
- app/core/services.py
- app/core/repository.py
- app/core/database.py
- app/database/schema.sql
- app/desktop/main_window.py
- app/desktop/ui/pages/register_page.py
- app/desktop/ui/pages/lists_page.py
- app/desktop/ui/pages/history_page.py
- app/desktop/ui/pages/settings_page.py
- app/desktop/ui/widgets/product_detail_panel.py

Analyze:

- actual dependency direction;
- component responsibility boundaries;
- product current-state summaries versus purchase history ownership;
- category, store, setting, promotion, and purchase relationships;
- service concentration and internal cohesion;
- repository scope and persistence abstraction;
- database-manager responsibility;
- desktop composition and cross-page coordination;
- unified Lists internal views;
- page-local service/repository lifetime;
- presentation formatting versus business/view-model formatting;
- schema/migration ownership;
- accepted structure versus implementation-only evidence;
- architectural drift, ambiguity, and deferred decisions.

Do not prescribe a redesign merely because a file is large. Separate confirmed structure, inferred intent, design tension, and recommended decision questions.

Do not write permanent design files yet.

Produce:

1. current implementation architecture map;
2. responsibility table by module/component;
3. domain relationship map;
4. stable design candidates;
5. ambiguous or conflicting design evidence;
6. decision candidates requiring human acceptance;
7. recovery candidates for architecture canon, decision history, design checkpoint, and model overview;
8. a proposed complete update for documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md.
```

---

# 9. Main Handoff State

The three domain chats should use this file as shared captured evidence, verify their own claims against source, and stage only in their authorized A/B/C files.

Main Chat should later compare the three reports, reconcile contradictions, and decide what may be promoted or materialized.
