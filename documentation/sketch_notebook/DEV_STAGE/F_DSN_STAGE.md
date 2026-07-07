# [M] Session 004 | 11:??_07_07_2026 | Markei

# F_DSN_STAGE — Main Design Materialization Stage

> Source stages:
> - `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> - `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
> - `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
>
> Purpose: Codex-ready design notebook update brief for the simplified installable/user-facing Markei application milestone.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Design Synthesis

The product goal is:

```text
Markei should become a local-first desktop application that non-developer users can open, understand, and use without running Python commands or managing repository files.
```

Design, Operational, and Didactic reports agree that user-readiness has two linked dimensions:

```text
1. runtime/distribution readiness
2. user-facing workflow simplicity
```

The simplified user-facing version should preserve the current architecture:

```text
UI
↓
ProductService
↓
Repository
↓
database.py / SQLite
```

But the user-facing surface should no longer feel like a development/debugging view of internal categories.

---

# 2. Design Decisions Approved for Materialization

## Decision 1 — Markei MVP remains local-first and offline-capable

Status:

```text
Accepted for simplified installable MVP.
```

Decision:

```text
Markei should not require accounts, cloud sync, scraping, barcode services, remote price APIs, or analytics for MVP use.
```

Consequences:

- user data remains local;
- SQLite remains the persistence mechanism;
- backups/exports should be user-controlled;
- packaging should prioritize local data safety before installer polish.

## Decision 2 — First-user flow should be Add-first

Status:

```text
Accepted for simplified MVP direction.
```

Decision:

```text
The first useful moment in Markei is registering a purchase.
```

Recommended first-user flow:

```text
Open app
↓
Create/load local database automatically
↓
If empty, show empty state
↓
Guide user to add first product/purchase
↓
Save receipt line
↓
Refresh inventory summary
↓
Explain that predictions improve after repeated purchases
```

## Decision 3 — User-facing navigation should be simplified

Status:

```text
Accepted as design direction; implementation may be phased.
```

Current top-level tabs:

```text
Register
Storage
Shortage
Market
History
Settings
```

Recommended simplified MVP surfaces:

```text
Add Purchase
Inventory
History
Settings
```

Storage, Shortage, and Market should become sections or filters inside Inventory rather than three equal top-level workflows.

Suggested user-facing vocabulary:

```text
Register -> Add Purchase
Storage -> In stock / Inventory
Shortage -> Ending soon
Market -> Buy again / Shopping list
History -> History
Settings -> Settings
```

Important boundary:

```text
This naming/navigation simplification does not require immediate internal module renaming.
```

Internal concepts can remain while user-facing labels become simpler.

## Decision 4 — Settings owns preferences and safe data-management commands

Status:

```text
Accepted for MVP design direction.
```

Settings should expose:

```text
default reorder threshold
data location display
backup/export local data
restore/import later
reset database with strong confirmation
app version/about
```

Settings should not expose:

```text
raw SQL
table editing
schema internals
manual database initialization
normal product operations that bypass ProductService
```

## Decision 5 — Installed app must separate program files from user data

Status:

```text
Accepted for packaging architecture.
```

Design distinction:

```text
Program files:
    executable, bundled Python/runtime files, bundled resources, UI resources.

User data:
    market.sqlite, settings, logs, backups/exports.
```

The user should not need to know that Markei uses SQLite, but should be able to see where local data lives and how to back it up.

---

# 3. Permanent Design Updates Required

Create or update design files under:

```text
documentation/sketch_notebook/design/
```

Recommended files if not already present:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISIONS.md
documentation/sketch_notebook/design/09_DOMAIN_MODEL.md
documentation/sketch_notebook/design/11_PRODUCT_INTERFACE.md
```

If these files already exist, append/update conservatively.

Do not edit methodology files.

---

# 4. Architecture Note to Persist

Add/update architecture content stating:

```text
Core dependency direction remains:

UI -> ProductService -> Repository -> database.py -> SQLite
```

Add packaging/user-run refinement:

```text
Installed builds must separate bundled application resources from user-writable runtime data.

schema.sql and seed.sql are application resources.
market.sqlite is user data.
```

Add product-interface refinement:

```text
User-facing navigation may simplify internal concepts without renaming internal modules immediately.

Storage, Shortage, and Market are domain/status interpretations. In the simplified UI they may be presented as Inventory sections or filters: In stock, Ending soon, and Buy again.
```

---

# 5. Decision Notes to Persist

Add/update decision content:

```text
Decision: Keep Markei local-first for MVP.

Status: Accepted.

Context:
Markei is a household purchase-memory app. Its MVP value does not require accounts, cloud services, scraping, barcode services, remote APIs, or analytics.

Decision:
Keep supermarket/product/purchase data local to the user's machine. Future sync or cloud features must be optional and explicitly user-controlled.
```

```text
Decision: Simplify user-facing navigation.

Status: Accepted as MVP design direction.

Context:
The current UI exposes Register, Storage, Shortage, Market, History, and Settings as equal top-level tabs. This mirrors internal project concepts but may overburden first users.

Decision:
Move toward Add Purchase, Inventory, History, and Settings as the primary user-facing surfaces. Treat Storage, Shortage, and Market as sections/filters inside Inventory.

Consequences:
Internal modules may remain unchanged initially. User-facing labels and navigation can be simplified first.
```

```text
Decision: Separate installed program files from user data.

Status: Accepted.

Context:
A packaged app should not store live user data inside the application bundle or installation folder.

Decision:
Bundled resources such as schema.sql and seed.sql belong with application resources. The live market.sqlite database belongs in a user-writable app data folder.

Consequences:
Packaging work must update database path handling before Markei is treated as reliably installable for non-developer users.
```

---

# 6. Product Interface Note to Persist

Add/update product-interface content:

```text
First-user flow should be Add-first.

When the database is empty, Markei should guide the user to register the first supermarket purchase rather than showing all conceptual tabs with no data.

After the first save, Markei should show what was saved and communicate that predictions improve after repeated purchases of the same product.
```

Add simplified MVP IA:

```text
Add Purchase
    manual receipt entry and save feedback

Inventory
    In stock / Ending soon / Buy again sections or filters

History
    read-only audit trail of registered purchases

Settings
    preferences, data location, backup/export, reset with confirmation, version/about
```

---

# 7. Scope Boundary for Codex

This F_DSN_STAGE authorizes permanent design notebook updates.

It does not automatically authorize a full UI rewrite.

For application implementation, Codex should follow D_OPS_STAGE first:

```text
make database path handling packaging-safe
add packaging runbook/build script
validate source and packaged startup
```

User-facing navigation simplification may be staged as a later implementation milestone unless the user explicitly asks to implement it now.

---

# 8. Expected Codex Report

Codex must report:

1. design files created/updated;
2. architecture note added/updated;
3. local-first decision added/updated;
4. navigation simplification decision added/updated;
5. program-files/user-data separation decision added/updated;
6. product-interface note added/updated;
7. whether source code UI navigation was left unchanged unless separately authorized;
8. unresolved design risks.
