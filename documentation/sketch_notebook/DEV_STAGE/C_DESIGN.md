# C_DESIGN.md

> Status: Proposed functional design stage
> Scope: Markei Cycle 05 — Sprint 01 Windows desktop distribution
> Authority: Design Chat staging for Main reconciliation
> Persistence class: Non-canonical functional stage
> Materialization authority: None

---

# 1. Stage Purpose

This stage defines the smallest sound Windows desktop-distribution architecture for Markei.

It is design staging for Main Chat synthesis.

It does not authorize source edits, packaging implementation, installer construction, notebook promotion, branch creation, commits or releases.

Human direction divides Cycle 05 into:

```text
Sprint 01
Create the shortest sound route to intuitive Windows desktop installation.

Sprint 02
Clone the repository and prepare the shortest responsible route to immediate mobile implementation.
```

This stage concerns Sprint 01 only.

Older Cycle 05 mobile-first sequencing remains historical planning context and is superseded for the current sprint by direct human direction.

---

# 2. Recovered Baseline

Current accepted application boundary:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

Accepted ownership:

```text
Desktop UI
    rendering
    controls
    navigation
    user events
    page composition

ProductService
    business meaning
    validation
    settings interpretation
    read-model assembly
    temporal interpretation

Repository
    SQL operations
    row mapping
    generic persistence

Database lifecycle
    SQLite connection configuration
    first-run initialization
    schema migration

SQLite
    application facts
    relationships
    settings
```

Current process entrypoint:

```text
root main.py
→ app.main.main()
→ QApplication
→ MainWindow
```

Current packaging-relevant implementation already provides:

```text
frozen resource lookup
    sys.frozen / sys._MEIPASS

writable user-data path
    %LOCALAPPDATA%\Markei

database path
    %LOCALAPPDATA%\Markei\market.sqlite

first-launch initialization
    bundled schema.sql

existing-data preservation
    no recreation unless explicitly requested

connection-time migration
    idempotent schema checks and default insertion
```

Current application metadata includes:

```text
APP_NAME = Markei
VERSION = 0.1.0
DATABASE_NAME = market.sqlite
SCHEMA_NAME = schema.sql
SEED_NAME = seed.sql
```

No verified executable-builder or installer-builder configuration currently exists in the inspected repository material.

---

# 3. Design Objective

Sprint 01 should wrap and distribute the existing application.

It must not create a new business layer.

Target responsibility chain:

```text
source application
↓
desktop entrypoint
↓
executable-builder configuration
↓
frozen one-folder runtime
↓
installer-builder configuration
↓
Windows installer
↓
installed executable
```

Runtime data chain:

```text
installed executable
↓
bundled read-only schema resources
+
external writable user-data directory
↓
SQLite database
```

---

# 4. Recommended Distribution Architecture

Primary release target:

```text
Installed one-folder Windows application
```

Primary user artifact:

```text
Markei-Setup-<version>.exe
```

Secondary artifact, when useful:

```text
portable ZIP of the same frozen one-folder runtime
```

The portable artifact is diagnostic or secondary.

It is not the primary ordinary-user experience.

A single-file executable is not recommended for Sprint 01.

Reasons:

```text
more opaque resource behavior
temporary runtime extraction
harder PySide6 diagnosis
less predictable startup
greater antivirus suspicion
no inherent upgrade or uninstall benefit
```

---

# 5. Executable Builder Boundary

The executable builder owns:

```text
Python runtime freezing
application module collection
PySide6 dependency collection
Qt plugin collection
read-only resource collection
executable icon
Windows executable metadata
one-folder runtime output
```

It does not own:

```text
installation destination
shortcuts
uninstall registration
user-data removal
database creation
database migration meaning
business logic
```

Proposed executable-builder configuration:

```text
packaging/markei.spec
```

The exact tool remains an Operational/Main selection, but PyInstaller is structurally compatible with the existing `sys.frozen` and `_MEIPASS` handling.

---

# 6. Installer Builder Boundary

The installer builder owns:

```text
application installation directory
per-user installation
Start-menu shortcut
optional desktop shortcut
uninstall registration
stable upgrade identity
installer version metadata
replacement of application-owned files
```

It does not own:

```text
Python import discovery
Qt plugin discovery
ProductService construction
Repository construction
SQLite schema interpretation
database initialization
application migration execution
business records
```

Proposed installer configuration when Inno Setup is selected:

```text
packaging/installer/markei.iss
```

The installer consumes the already validated frozen one-folder runtime.

It must not freeze the application itself.

---

# 7. Installation and Data Locations

Recommended per-user installation location:

```text
%LOCALAPPDATA%\Programs\Markei\
```

Installed content:

```text
Markei.exe
frozen Python dependencies
PySide6 / Qt runtime
Qt plugins
application modules
bundled read-only schema resources
release notices
```

Writable user data:

```text
%LOCALAPPDATA%\Markei\
```

Database:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

Possible SQLite companion files:

```text
market.sqlite-wal
market.sqlite-shm
```

The following may never be written inside the installed runtime:

```text
user database
SQLite WAL or SHM files
user settings outside the database
logs
backups
temporary exports
migration recovery copies
user-generated content
```

---

# 8. Bundled Resource Policy

Read-only bundled resources may include:

```text
schema.sql
approved seed.sql
application icons
static UI assets
license notices
default templates
```

Bundled resources are application inputs.

They are not writable runtime state.

`seed.sql` requires an explicit release decision:

```text
include and execute for production initialization
or
exclude from production package
```

The installer must not execute `schema.sql` or `seed.sql`.

The application database lifecycle component owns their interpretation.

---

# 9. Development and Installed Modes

Development mode:

```text
resource base
    repository resources

user data
    %LOCALAPPDATA%\Markei by default
```

Installed mode:

```text
resource base
    frozen bundled resources

user data
    %LOCALAPPDATA%\Markei
```

The normal data location should remain consistent between modes.

Tests may override data locations through test-specific infrastructure, but repository-local data must not become ordinary runtime policy.

The current `resource_base()` and `user_data_dir()` functions implement the required distinction.

Their current location inside `app/core/database.py` is accepted as implementation truth but not necessarily the ideal final responsibility location.

---

# 10. Runtime Path Ownership

Proper design owner:

```text
desktop runtime-path resolver
```

Responsibilities:

```text
resolve bundled read-only resource base
resolve writable Windows user-data location
avoid current-working-directory dependence
```

Consumers:

```text
database lifecycle
desktop startup infrastructure
future logging or backup infrastructure
```

Forbidden consumers:

```text
ProductService
Repository SQL methods
domain models
individual UI pages
```

Smallest-route option:

```text
retain current path functions in app/core/database.py
document them as desktop infrastructure coupling
```

Cleaner optional option:

```text
move path resolution to app/desktop/runtime_paths.py
database lifecycle consumes resolved paths
```

A broad dependency-injection redesign is not required for Sprint 01.

---

# 11. First-Launch Lifecycle

Required first-launch sequence:

```text
1. Start Markei desktop process.
2. Resolve bundled resource directory.
3. Resolve writable user-data directory.
4. Create writable directory when absent.
5. Detect absence of market.sqlite.
6. Create market.sqlite.
7. Execute bundled schema.sql.
8. Execute only approved initialization seed behavior.
9. Apply compatible migrations.
10. Open the normal application UI.
```

The database must not be installed as an active mutable file.

The installer must not own initialization.

Initialization failure should be presented through a desktop startup error boundary rather than only through console output.

---

# 12. Upgrade Lifecycle

Required upgrade behavior:

```text
installer replaces application-owned files
installer preserves writable user-data directory
new application opens existing database
application applies pending compatible migrations
application starts against preserved data
```

Upgrade must never:

```text
replace market.sqlite with a bundled database
delete WAL/SHM files while Markei is running
reset user settings
execute business SQL from installer scripts
silently recreate an incompatible database
```

The installer must retain a stable upgrade/application identity across versions.

Application, executable and installer versions must derive from one authoritative version source.

Current candidate source:

```text
app/core/config.py
```

Current version:

```text
0.1.0
```

A mismatch check should be part of release validation.

---

# 13. Migration Ownership

Current migration mechanism:

```text
application opens connection
→ database lifecycle checks schema shape
→ missing columns/tables/defaults are added idempotently
```

Sprint 01 may retain this mechanism for the shortest sound release.

Future candidate:

```text
explicit schema-version ledger
ordered migration functions
transactional migration boundary
pre-migration backup for destructive changes
```

The installer must never become the migration engine.

Repository methods must not individually own schema evolution.

ProductService must not own migration state.

---

# 14. Uninstall Policy

Default uninstall behavior:

```text
remove installed executable
remove frozen dependencies
remove bundled resources
remove shortcuts
remove uninstall registration
preserve %LOCALAPPDATA%\Markei
```

User data includes purchase history and settings.

Application uninstall is not equivalent to user-data deletion.

Optional refinement:

```text
explicit separately worded choice to remove user data
```

Silent user-data deletion is forbidden.

Expected reinstall behavior:

```text
reinstall application
→ application opens preserved database
→ compatible migrations run
→ user data remains available
```

---

# 15. Startup and Error Responsibility

Process startup owner:

```text
root main.py
app/main.py
optional desktop startup helper
```

Startup infrastructure may own:

```text
top-level initialization orchestration
fatal startup exception handling
user-facing initialization error dialog
optional local diagnostic logging
```

It must not own:

```text
business validation
inventory status calculation
History grouping
settings meaning
SQL query behavior
```

Database lifecycle should raise meaningful failures.

Desktop startup should decide how those failures are presented.

Raw database console prints are insufficient for a windowed ordinary-user release.

---

# 16. Distribution Alternative Assessment

## Portable one-folder

Advantages:

```text
simplest frozen output
transparent Qt/resource layout
easy debugging
useful diagnostic artifact
```

Disadvantages:

```text
manual extraction
manual executable discovery
manual upgrades
manual uninstall
risk of deleting adjacent runtime files
```

Classification:

```text
secondary or diagnostic artifact
```

## Single executable

Advantages:

```text
visually simple download
```

Disadvantages:

```text
temporary extraction
more opaque resource lookup
harder debugging
possible slower startup
greater antivirus suspicion
no native upgrade/uninstall policy
```

Classification:

```text
rejected for Sprint 01
```

## Installed one-folder

Advantages:

```text
ordinary Windows installation
Start-menu launch
clear uninstall
controlled upgrades
transparent frozen runtime
strong PySide6 compatibility
clean packaging/installer separation
```

Disadvantages:

```text
requires executable-builder and installer-builder configuration
```

Classification:

```text
recommended Sprint 01 target
```

---

# 17. Required Boundary Changes

Required for packaging correctness:

```text
resource lookup independent from working directory
external writable user-data directory
explicit bundling of schema resources
Qt plugin collection
startup error boundary
single authoritative version
stable installer upgrade identity
data-preserving uninstall policy
production decision for seed.sql
```

Optional release refinement:

```text
desktop runtime-path module
desktop startup module
schema-version ledger
local log file
portable ZIP
code signing
release checksums
CI Windows build
explicit uninstall data-removal option
```

Forbidden architectural drift:

```text
business rules in packaging code
installer-owned database mutation
database beside executable
ProductService awareness of PyInstaller
Repository ownership of Windows directories
SQLite exposed as mobile/public contract
API/backend/authentication/synchronization in Sprint 01
desktop packaging fields in domain models
silent data deletion
```

Deferred to Sprint 02:

```text
mobile framework
mobile persistence
synchronization
backend/API
identity
shared contracts
repository clone architecture
desktop/mobile coexistence beyond data preservation
```

---

# 18. Proposed Architectural File Map

Existing files requiring verification:

```text
main.py
app/main.py
app/desktop/main_window.py
app/core/config.py
app/core/database.py
app/core/repository.py
app/core/services.py
app/core/contracts.py
app/database/schema.sql
app/database/seed.sql
requirements.txt
.gitignore
README.md
```

Proposed packaging files:

```text
[PROPOSED] packaging/markei.spec
[PROPOSED] packaging/installer/markei.iss
[PROPOSED] packaging/windows/version_info.txt
[PROPOSED] packaging/windows/markei.ico
```

Optional proposed infrastructure:

```text
[PROPOSED] app/desktop/runtime_paths.py
[PROPOSED] app/desktop/startup.py
```

Optional proposed orchestration:

```text
[PROPOSED] scripts/build_windows.ps1
[PROPOSED] scripts/package_windows.ps1
```

Optional proposed validation:

```text
[PROPOSED] tests/test_runtime_paths.py
[PROPOSED] tests/test_database_first_launch.py
[PROPOSED] tests/test_database_upgrade.py
```

These filenames are design candidates.

Main reconciliation must accept, revise or reject them before materialization.

---

# 19. Desktop-to-Mobile Isolation

Sprint 01 packaging must remain replaceable desktop infrastructure.

Desktop-specific concerns:

```text
sys.frozen
_MEIPASS
Windows installation directories
LOCALAPPDATA
exe metadata
installer IDs
shortcuts
uninstall registration
Qt Windows plugins
```

These concerns must not enter:

```text
ProductService contracts
Repository contracts
domain models
service read models
settings semantic values
database entities
```

The future Sprint 02 clone should be able to omit:

```text
packaging/
installer configuration
Windows runtime-path resolver
Windows startup integration
```

without changing the meaning of ProductService or Repository.

The Windows database location is not a mobile data-architecture decision.

Bundling `schema.sql` for Windows does not require mobile to use the same resource mechanism.

Current `app/core/database.py` packaging awareness should be classified as desktop infrastructure coupling, not promoted as a platform-neutral core contract.

---

# 20. Decision Candidates for Main

## D05-S01-01

Decision:

```text
Use an installed frozen one-folder runtime as the primary Windows distribution.
```

Rationale:

```text
best balance of ordinary-user experience, PySide6 reliability,
debuggability, upgrades and future isolation
```

Deferred/rejected:

```text
portable package as primary
single executable
MSIX / store distribution
```

Reversibility:

```text
high
```

## D05-S01-02

Decision:

```text
Keep all writable user data under %LOCALAPPDATA%\Markei.
```

Rationale:

```text
existing implementation
data preservation
no protected-directory writes
```

Rejected:

```text
database beside executable
installer-created active database
```

Reversibility:

```text
medium, because later changes require data migration
```

## D05-S01-03

Decision:

```text
Bundle schema resources read-only and let the application initialize SQLite.
```

Rejected:

```text
installer-run SQL
pre-created mutable database in release
```

Reversibility:

```text
high
```

## D05-S01-04

Decision:

```text
Keep migrations application-owned.
```

Deferred:

```text
external migration executable
full migration framework
```

Reversibility:

```text
medium
```

## D05-S01-05

Decision:

```text
Use one authoritative application version for runtime,
executable and installer metadata.
```

Candidate source:

```text
app/core/config.py
```

Reversibility:

```text
high
```

## D05-S01-06

Decision:

```text
Preserve user data during uninstall by default.
```

Rejected:

```text
silent deletion
```

Reversibility:

```text
high
```

## D05-S01-07

Decision:

```text
Keep executable-builder and installer-builder responsibilities separate.
```

Reversibility:

```text
high
```

## D05-S01-08

Decision:

```text
Do not promote PyInstaller or Windows path mechanics into
ProductService, Repository contracts or domain models.
```

Optional refinement:

```text
extract runtime paths from app/core/database.py
```

Reversibility:

```text
high
```

---

# 21. Required Validation Before Acceptance

Frozen runtime validation:

```text
launch without developer Python
launch outside repository
launch from arbitrary working directory
load all Qt plugins
load bundled schema resource
open every public tab
```

First-launch validation:

```text
start with no %LOCALAPPDATA%\Markei
create user-data directory
create database
apply schema
apply approved seed behavior
apply migrations
open UI
```

Existing-data validation:

```text
prepare representative previous database
install new application
launch
migrate without data loss
repeat launch idempotently
```

Installer validation:

```text
per-user install
Start-menu shortcut
optional desktop shortcut
normal launch
registered uninstall entry
```

Upgrade validation:

```text
install previous package
create representative data
install newer package
preserve database
migrate
reopen existing data
```

Uninstall validation:

```text
remove application files
remove shortcuts
preserve %LOCALAPPDATA%\Markei
reinstall
recover existing data
```

Failure validation:

```text
missing schema resource
unwritable data directory
damaged database
migration failure
clear user-facing error
diagnostic evidence available
no silent reset
```

---

# 22. Immediate Risks and Open Questions

Immediate:

```text
selected executable builder
selected installer builder
Python/freezer compatibility
Qt plugin collection
schema resource collection
production seed.sql policy
windowed versus diagnostic console behavior
startup exception presentation
installer scope: per-user versus machine-wide
icon availability
license notice requirements
unsigned-build antivirus warnings
migration rollback behavior
newer-database/older-application behavior
portable artifact publication policy
```

Sprint 02 carry-forward:

```text
mobile framework
shared service contracts
mobile persistence
backend
identity
synchronization
stable cross-device IDs
desktop/mobile migration
dependency construction
automated cross-platform tests
```

---

# 23. Design Conclusion

The smallest sound Sprint 01 target is:

```text
Markei source application
→ narrow desktop entrypoint
→ frozen one-folder PySide6 runtime
→ per-user Windows installer
→ installed executable and read-only resources
→ external %LOCALAPPDATA%\Markei user data
→ application-owned SQLite initialization and migration
```

This design makes Markei intuitively installable without changing its business architecture.

It preserves:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

It isolates Windows packaging from the future Sprint 02 clone and avoids introducing mobile, API, backend, identity or synchronization architecture prematurely.

Main Chat must reconcile the decision candidates, select the executable and installer builders, and prepare later materialization stages before any repository changes occur.
