# DEV_STAGE/D_OPS_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Cycle: 05
> Sprint: 01 — Windows Desktop Installation
> Domain: Operational materialization
> Scope: Runtime safety, seed-free SQLite initialization, PyInstaller one-folder build, Inno Setup installer, and release validation
> Codex report target: `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`

---

# Cycle 05 Sprint 01 Operational Materialization Stage

## 1. Purpose

This file is direct implementation authority for Codex.

Materialize the shortest safe path from the current developer-run PySide6 application to an intuitively installable Windows desktop application:

```text
Markei source
→ PyInstaller one-folder runtime
→ Inno Setup per-user installer
→ installed Windows application
```

Preserve the accepted application boundary:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

Do not begin Cycle 05 Sprint 02.

## 2. Mandatory Context Bootstrap

Read first:

```text
AGENTS.md
```

Then load into active context in exactly this order:

```text
documentation/sketch_notebook/INDEX.md
↓
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
↓
documentation/sketch_notebook/methodology/FLUX.md
↓
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
↓
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Keep the combined context active throughout inspection, implementation, validation, and reporting.

Consult only when needed:

```text
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
documentation/sketch_notebook/methodology/METHOD_GLOSSARY.md
```

Then read:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

D/E/F are direct materialization authority. A/B/C are supporting inputs only.

## 3. Recovery Economy

Use the least expensive sufficient source:

```text
AGENTS.md
→ INDEX.md
→ methodology bootstrap
→ D/E/F
→ only implementation files required by D/E/F
→ validation
→ G/H/I reports
```

Do not read complete permanent domain registers, long histories, or unrelated source trees unless a staged instruction, detected drift, or implementation uncertainty requires it.

If D/E/F conflict, are stale, or cannot be followed coherently, stop before editing and report the conflict.

## 4. Strict Notebook Write Boundary

Codex may read protected notebook files but must not modify:

```text
documentation/sketch_notebook/methodology/
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
documentation/sketch_notebook/[M]_STAGE/
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

The only authorized notebook writes are:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Do not create alternative notebook roots or new notebook files.

## 5. Accepted Main Decisions

1. Use PyInstaller one-folder output.
2. Use Inno Setup for a per-user installer.
3. Install application files under `%LOCALAPPDATA%\Programs\Markei\`.
4. Keep writable user data under `%LOCALAPPDATA%\Markei\`.
5. Keep SQLite for Sprint 01.
6. Do not bundle or install an active `market.sqlite`.
7. Bundle `schema.sql` as a mandatory read-only resource.
8. Do not execute the current sample-data seed in production.
9. Mandatory settings must work without sample products, stores, categories, or purchases.
10. Zero business records is a valid first-launch state.
11. Upgrade and normal uninstall must preserve `%LOCALAPPDATA%\Markei`.
12. Packaging remains outside ProductService, Repository, and domain models.
13. Mobile, API, backend, authentication, synchronization, and remote persistence remain deferred.

## 6. Repository Baseline

Current launch chain:

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Qt event loop
```

Current version authority candidate:

```text
app/core/config.py
```

Current user database path:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

Current initialization executes `schema.sql` and executes `seed.sql` whenever the file exists. Production behavior must become seed-safe.

## 7. Authorized Implementation Surface

Inspect and modify only as required:

```text
main.py
app/main.py
app/core/config.py
app/core/database.py
app/core/repository.py
app/core/services.py
app/database/schema.sql
app/database/seed.sql
app/desktop/main_window.py
app/desktop/pages/
requirements.txt
requirements-build.txt
.gitignore
README.md
packaging/
scripts/
tests/
```

Do not include unrelated cleanup or broad architectural refactoring.

## 8. Runtime Requirements

### 8.1 Startup failure boundary

Implement a top-level failure boundary that:

- logs a useful traceback to a writable location;
- shows a concise Qt error dialog where possible;
- includes the diagnostic path;
- exits non-zero;
- never silently deletes, resets, replaces, or recreates user data after failure.

### 8.2 Resource lookup

Ensure packaged execution locates:

```text
app/database/schema.sql
```

Resource lookup must not depend on repository root, current working directory, shortcut directory, or developer Python installation.

Preserve source execution.

### 8.3 User-data location

Keep mutable state outside the installation tree:

```text
application: %LOCALAPPDATA%\Programs\Markei\
user data:  %LOCALAPPDATA%\Markei\
database:   %LOCALAPPDATA%\Markei\market.sqlite
```

### 8.4 Production initialization

Separate schema initialization from sample development data.

Production first launch must create required tables, indexes, and mandatory settings without creating sample products, purchases, stores, dated inventory, or user-looking records.

Acceptable narrow strategies:

1. exclude `seed.sql` from the production artifact;
2. retain sample rows only as an explicit development/test fixture;
3. make seed execution explicit instead of file-existence driven.

Do not distribute a pruned `market.sqlite` as production initialization.

### 8.5 Empty-database robustness

Validate with:

```text
zero products
zero purchases
zero stores
zero user-created categories
```

Required behavior:

- all public pages open;
- list services return empty collections safely;
- aggregates handle no rows;
- no UI indexes an absent first row;
- empty selectors do not crash;
- History opens without purchases;
- Lists opens without products;
- Settings loads mandatory defaults;
- Register supports the first valid workflow or clearly reports a missing prerequisite.

Do not add fake production data to conceal a broken first-use workflow.

### 8.6 Version authority

Use one authoritative version for runtime, executable metadata, installer metadata, and artifact naming. Prefer `app/core/config.py`. Report unavoidable duplication.

## 9. Packaging Requirements

Create only as justified:

```text
packaging/markei.spec
packaging/windows/markei.iss
packaging/windows/version_info.txt
requirements-build.txt
```

Optional when justified:

```text
packaging/windows/markei.ico
scripts/build_windows.ps1
scripts/validate_windows_package.ps1
```

### 9.1 PyInstaller

Configure:

- one-folder output;
- windowed executable;
- root `main.py` entrypoint;
- executable name `Markei`;
- clean build;
- no UPX initially;
- bundled `schema.sql` at the expected runtime path;
- required PySide6 and Qt plugins;
- version metadata;
- icon only when a valid asset exists.

Do not configure one-file output.

Expected runtime artifact:

```text
dist/Markei/Markei.exe
```

### 9.2 Dependencies

Separate runtime dependencies from build-only dependencies. Constrain tested PySide6 and PyInstaller versions. Document the supported Windows Python build version.

### 9.3 Inno Setup

Configure a per-user installer that:

- requires no administrator elevation unless proven necessary;
- installs the complete one-folder runtime;
- installs under `%LOCALAPPDATA%\Programs\Markei`;
- creates a Start Menu shortcut;
- may offer an optional desktop shortcut;
- registers uninstall;
- uses a stable application/upgrade identifier;
- replaces application-owned files during upgrade;
- preserves `%LOCALAPPDATA%\Markei` during normal uninstall;
- does not install `market.sqlite`;
- does not execute SQL or migrations;
- uses the accepted version.

Expected primary artifact:

```text
Markei-Setup-<version>.exe
```

## 10. Documentation Requirements

Document:

- supported Windows target and Python build version;
- clean environment creation;
- runtime and build dependency installation;
- PyInstaller and Inno Setup commands;
- artifact locations;
- source regression launch;
- database and log locations;
- backup procedure;
- upgrade behavior;
- uninstall data-preservation policy;
- production seed policy;
- unsigned-binary and SmartScreen expectations.

## 11. Validation Requirements

Run all available validation and report unavailable validation explicitly.

Minimum layers:

```text
source compile
source launch
clean dependency installation
PyInstaller build
frozen runtime launch
arbitrary-working-directory launch
schema resource discovery
seed-free first launch
empty-page behavior
first real data creation
restart persistence
installer compilation
Start Menu launch
upgrade preservation
uninstall preservation
reinstall recovery
startup failure behavior
clean-profile or clean-machine behavior
SmartScreen or antivirus observations
```

Do not collapse these into a generic “tests passed” statement.

Suggested source/build commands:

```powershell
python -m compileall -q main.py app
python main.py
py -<accepted-version> -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install -r requirements-build.txt
python -m PyInstaller --noconfirm --clean packaging\markei.spec
```

Record exact commands and dependency versions.

## 12. Stop Conditions

Stop and report if:

1. `schema.sql` cannot be found in the frozen runtime;
2. production launch depends on sample seed rows;
3. an empty database crashes a public page;
4. first use requires hidden manual SQL;
5. mutable data is placed inside the installation directory;
6. upgrade replaces or resets `market.sqlite`;
7. uninstall deletes user data;
8. startup failures remain silent;
9. packaging requires unrelated ProductService or Repository redesign;
10. dependency versions cannot be reproduced;
11. methodology or permanent-domain edits appear necessary;
12. D/E/F conflict;
13. materialization expands into Sprint 02;
14. a destructive migration is discovered.

## 13. Explicit Deferrals

```text
PyInstaller one-file
Nuitka
Briefcase restructuring
MSIX
Microsoft Store
automatic updater
production code signing
remote crash reporting
mobile implementation
API/backend
authentication
synchronization
cross-device persistence
receipt recognition
destructive database pruning
installer-managed migrations
```

## 14. G_OPS_CODEX.md Report Contract

Write:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
```

Required sections:

1. Bootstrap and stage files read.
2. Repository baseline confirmed.
3. Files changed, created, and deleted.
4. Dependency versions selected.
5. Startup failure-boundary evidence.
6. Resource and user-data path evidence.
7. Production seed-policy evidence.
8. Empty-database corrections.
9. PyInstaller configuration evidence.
10. Inno Setup configuration evidence.
11. Commands executed.
12. Source regression results.
13. Frozen-runtime results.
14. Seed-free first-launch results.
15. First-user-data persistence results.
16. Installer, upgrade, uninstall, and reinstall results.
17. Failure-path results.
18. SmartScreen or antivirus observations.
19. Instructions completed and skipped.
20. Failures, blockers, and unresolved risks.
21. Suggested follow-up.

Use exact paths and commands. Do not claim validation that was not performed.

## 15. Completion Boundary

Complete only after authorized materialization and evidence reporting, or after stopping at a declared blocker with sufficient evidence.

Do not update permanent memory. Do not begin Sprint 02.
