# DEV_STAGE/D_OPS_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Cycle: 05
> Sprint: 01 — Windows Desktop Installation
> Scope: Runtime safety, seed-free SQLite initialization, PyInstaller one-folder build, Inno Setup installer, and release validation

---

# Cycle 05 Sprint 01 Operational Materialization Stage

## 1. Purpose

This stage authorizes Codex to materialize the operational portion of Cycle 05 Sprint 01.

Target delivery chain:

```text
Markei source
→ PyInstaller one-folder runtime
→ Inno Setup per-user installer
→ installed Windows application
```

Preserve:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

Codex must report execution evidence into:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
```

Codex must not edit methodology files, permanent domain memory, Main-root continuity, or Sprint 02 mobile implementation during this pass.

## 2. Mandatory Bootstrap

Load into active context, in exactly this order:

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
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

Use only:

```text
documentation/sketch_notebook/
```

as the notebook root.

## 3. Accepted Main Decisions

1. Use PyInstaller one-folder output.
2. Use Inno Setup for a per-user installer.
3. Install application files under `%LOCALAPPDATA%\Programs\Markei\`.
4. Keep writable user data under `%LOCALAPPDATA%\Markei\`.
5. Keep SQLite for Sprint 01.
6. Do not bundle or install an active `market.sqlite`.
7. Bundle `schema.sql` as a mandatory read-only resource.
8. Do not execute the current sample-data seed in production.
9. Mandatory settings must remain available without sample products, stores, categories, or purchases.
10. Zero business records is a valid first-launch state.
11. Upgrade and normal uninstall must preserve `%LOCALAPPDATA%\Markei`.
12. Packaging must remain outside ProductService, Repository, and domain models.
13. Mobile, API, backend, authentication, synchronization, and remote persistence remain deferred.

## 4. Repository Baseline

Current entry chain:

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Qt event loop
```

Current metadata authority candidate:

```text
app/core/config.py
```

Current database path:

```text
%LOCALAPPDATA%\Markei\market.sqlite
```

Current initialization executes `schema.sql` and executes `seed.sql` whenever the file exists. This must become production-safe.

## 5. Authorized Runtime Changes

Expected inspection and possible modification targets:

```text
main.py
app/main.py
app/core/config.py
app/core/database.py
app/database/schema.sql
app/database/seed.sql
app/desktop/main_window.py
app/desktop/pages/
app/core/services.py
app/core/repository.py
requirements.txt
.gitignore
README.md
```

Make only narrow changes required by packaging, first launch, and empty-state correctness.

### 5.1 Startup failure boundary

Implement a top-level startup boundary that:

- records a traceback in a writable log location;
- shows a concise Qt error dialog where possible;
- includes the log path;
- exits non-zero;
- never silently deletes, recreates, or resets the user database.

### 5.2 Resource lookup

Ensure packaged execution finds:

```text
app/database/schema.sql
```

Resource lookup must not depend on the repository root, current working directory, shortcut directory, or a developer Python installation.

Preserve source execution.

### 5.3 Production initialization

Separate schema initialization from sample development data.

Production first launch must create required tables, indexes, and mandatory settings without creating sample products, purchases, stores, dated inventory, or user-looking records.

Acceptable narrow approaches:

1. exclude `seed.sql` from the production artifact;
2. move sample rows into an explicit development fixture;
3. make seed execution explicit instead of file-existence driven.

Do not distribute a pruned `market.sqlite` as the production initialization mechanism.

### 5.4 Empty database robustness

Validate with:

```text
zero products
zero purchases
zero stores
zero user-created categories
```

Required results:

- all public pages open;
- list services return empty collections safely;
- aggregate results handle no rows;
- no UI indexes an absent first row;
- empty selectors do not crash;
- History opens without purchases;
- Lists opens without products;
- Settings loads mandatory defaults;
- Register supports the first valid workflow or clearly reports a missing prerequisite.

Do not add fake production data to conceal an incomplete first-user workflow.

### 5.5 Version authority

Use one authoritative version for runtime, executable metadata, installer metadata, and artifact naming. Prefer `app/core/config.py`. Report unavoidable duplication.

## 6. Authorized Packaging Files

Create as required:

```text
packaging/markei.spec
packaging/windows/markei.iss
packaging/windows/version_info.txt
requirements-build.txt
```

Create only when a valid asset exists:

```text
packaging/windows/markei.ico
```

Optional:

```text
scripts/build_windows.ps1
scripts/validate_windows_package.ps1
```

### 6.1 PyInstaller requirements

Configure:

- one-folder output;
- windowed executable;
- root `main.py` entrypoint;
- executable name `Markei`;
- clean build;
- no UPX initially;
- bundled `schema.sql` at the runtime path expected by the application;
- required PySide6 and Qt plugins;
- version metadata;
- icon when available.

Do not configure one-file output.

Expected runtime artifact:

```text
dist/Markei/Markei.exe
```

### 6.2 Dependency declaration

Separate application runtime dependencies from build-only dependencies. Constrain the tested PySide6 and PyInstaller versions. Document the supported Windows Python build version.

### 6.3 Inno Setup requirements

Configure a per-user installer that:

- requires no administrator elevation;
- installs the complete one-folder runtime;
- installs under `%LOCALAPPDATA%\Programs\Markei`;
- creates a Start Menu shortcut;
- may offer an optional desktop shortcut;
- registers uninstall;
- uses a stable application/upgrade identifier;
- supports replacement of application-owned files;
- preserves `%LOCALAPPDATA%\Markei` during normal uninstall;
- does not install `market.sqlite`;
- does not execute SQL or migrations;
- uses the accepted version.

Expected primary artifact:

```text
Markei-Setup-<version>.exe
```

## 7. Documentation Requirements

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

## 8. Validation Requirements

Run all available checks and report unavailable checks explicitly.

### Source regression

```powershell
python -m compileall -q main.py app
python main.py
```

### Clean build

```powershell
py -<accepted-version> -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install -r requirements-build.txt
python -m PyInstaller --noconfirm --clean packaging\markei.spec
```

Record exact dependency versions.

### Frozen runtime

Validate launch without Python, outside the repository, from an arbitrary working directory, with Qt plugins and bundled schema available.

### Seed-free first launch

With no existing user database:

1. launch the frozen application;
2. confirm `%LOCALAPPDATA%\Markei` is created;
3. confirm `market.sqlite` is created;
4. confirm schema and mandatory defaults exist;
5. confirm no sample business rows exist;
6. open every public page;
7. confirm no empty-state failure.

### First real data

Create the first valid real record sequence through the UI where practical, restart, and confirm persistence. If the UI cannot create a required prerequisite, report a blocker instead of seeding fake production data.

### Installer, upgrade, uninstall

Where tooling permits:

- build and install per user;
- launch from Start Menu without Python;
- confirm external user data;
- upgrade over representative data;
- confirm migration idempotence and data preservation;
- uninstall and confirm user data remains;
- reinstall and confirm retained data is reopened.

### Failure behavior

Exercise missing schema, unwritable data directory, damaged database, and migration failure where practical. Require readable error, diagnostics, non-zero exit, and no silent reset.

Record SmartScreen and antivirus observations without treating unsigned reputation as automatic failure.

## 9. Stop Conditions

Stop and report if:

1. the package cannot locate `schema.sql`;
2. production launch depends on sample seed rows;
3. an empty database crashes a public page;
4. first use requires hidden manual SQL;
5. mutable data is placed inside the installation directory;
6. upgrade replaces or resets `market.sqlite`;
7. uninstall deletes user data;
8. startup failures remain silent;
9. packaging requires unrelated ProductService or Repository redesign;
10. dependency versions cannot be reproduced;
11. materialization expands into Sprint 02;
12. a destructive migration is discovered.

## 10. Explicit Deferrals

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

## 11. G_OPS_CODEX.md Report Shape

After materialization write:

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

## 12. Completion Boundary

Complete only after authorized materialization and evidence reporting, or after stopping at a declared blocker with sufficient evidence.

Do not update permanent memory or begin Sprint 02.
