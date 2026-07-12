# 14_MODEL_OVERVIEW.md

> Version: 0.3-cycle06-sprint02
> Status: Active Derived Overview
> Persistence Class: Derived
> Knowledge Class: Design
> Authority: Design Chat [D]
> Canonical Source: `design/01_ARCHITECTURE.md`
> Scope: Low-cost recovery map of the accepted Markei application and deployment architecture

---

# 1. System at a Glance

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
Database Manager
    ↓
SQLite
```

```text
presentation requests behavior
service owns application meaning
repository owns SQL
Database Manager owns database lifecycle
packaging owns frozen composition
installer owns placement and registration
Main/human own final acceptance
```

---

# 2. Responsibility Map

| Surface | Current responsibility |
| --- | --- |
| `main.py` | Launcher adapter and outer startup-diagnostic boundary |
| `app/main.py` | Qt application construction and event loop |
| `app/desktop/main_window.py` | Page composition, navigation/refresh, and final page-service shutdown coordination |
| `app/core/services.py` | Workflows, validation, calculations, settings, stores, and read models |
| `app/core/repository.py` | SQL, mapping, persistence operations, commits, and connection ownership |
| `app/core/database.py` | Resource/user paths, initialization, structural defaults, additive compatibility, and connection primitives |
| `Markei.spec` | Authoritative one-folder frozen composition |
| `scripts/build_windows.ps1` | Invokes the packaging authority |
| `installer/Markei.iss` | Installer identity, placement, shortcuts, and uninstall registration |
| `scripts/build_installer.ps1` | Locates Inno Setup and invokes installer compilation |

The per-user Inno discovery correction belongs to tooling, not application architecture.

---

# 3. Desktop and Shutdown Model

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

`MainWindow.closeEvent()` idempotently coordinates final closure of all four services. Installed close and immediate reopen passed without a broader composition redesign.

---

# 4. Deployment and Lifecycle Map

```text
Source
    main.py
    app/
    app/database/schema.sql

Build
    Markei.spec
    scripts/build_windows.ps1
    dist/Markei

Installer build
    installer/Markei.iss
    scripts/build_installer.ps1
    Inno Setup compiler
    dist/installer/Markei-Setup-0.1.0-x64.exe

Installed application
    %LOCALAPPDATA%/Programs/Markei/Markei.exe
    Start Menu shortcut — validated
    optional desktop shortcut — configured
    uninstall registration — validated technically

User state
    %LOCALAPPDATA%/Markei/market.sqlite
    market.sqlite-wal / market.sqlite-shm
    %LOCALAPPDATA%/Markei/logs/startup.log
```

Installed program files and retained user state are separate sibling concerns.

---

# 5. Resource and Defaults Map

| Item | Classification |
| --- | --- |
| `schema.sql` | Bundled read-only production resource |
| `seed.sql` | Development/test fixture excluded from production |
| category `F` / `General` | Structural Register default |
| store `1` / `Default Store` | Structural Register default |
| `market.sqlite` | Retained writable user data |
| WAL/SHM | Transient writable companions |
| startup logs | Generated writable diagnostics |
| version metadata/static assets | Replaceable release content |

Fresh production state contains structural defaults but zero sample products and purchases.

---

# 6. Release Contract

```text
Name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Stable AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Target: Windows x64 controlled beta
```

```text
Start Menu shortcut: required and technically validated
Desktop shortcut: optional installer task
Uninstall data policy: preserve %LOCALAPPDATA%/Markei by default
```

---

# 7. Lifecycle Evidence Map

```text
installer compiled
→ per-user install passed
→ Start Menu launch passed
→ external database initialized
→ service-backed principal workflow evidence passed
→ close and immediate reopen passed
→ same-version reinstall preserved data
→ uninstall preserved data
→ reinstall recovered retained data
```

Validation environment:

```text
current ordinary Windows user
existing Markei data backed up and restored
no dedicated clean account
```

---

# 8. Evidence Status

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Still pending:

- human-visible installer wizard observation;
- human-visible Register / Lists / History / Settings walkthrough;
- human-visible close/reopen confirmation;
- human-visible SmartScreen behavior;
- final Main/human acceptance;
- artifact-versioning policy resolution outside Design ownership.

---

# 9. Stable Boundaries

1. Business and persistence responsibilities remain unchanged.
2. Packaging and installer layers remain deployment concerns.
3. Structural defaults are not sample business data.
4. Installed program files and user state remain separate.
5. Same-version reinstall, uninstall preservation, and reinstall recovery are technically validated.
6. MainWindow shutdown coordination remained sufficient in the installed lifecycle.
7. Automated technical workflow evidence is not a complete human visual UI walkthrough.
8. SmartScreen behavior remains unknown.
9. Final beta acceptance is not a Design-domain decision.

---

# 10. Open or Deferred Areas

- human-visible acceptance gates;
- compatible-version upgrade evidence beyond same-version reinstall;
- workflow transaction atomicity;
- broader migration strategy;
- service/repository decomposition;
- composition-root or dependency-injection redesign;
- optional uninstall data-deletion UX;
- signing, rollback, auto-update, one-file packaging;
- mobile, backend, synchronization, authentication, and cloud persistence.

For exact accepted wording, consult `01_ARCHITECTURE.md`. For current status, consult `09_DESIGN_STATE.md`. For chronology, consult `03_DECISION_LOG.md`.