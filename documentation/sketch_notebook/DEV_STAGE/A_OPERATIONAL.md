# A_OPERATIONAL — Cycle 06 Windows Primary Beta

> Status: Complete Cycle 06 functional Operational stage
> Role: Operational Chat [O]
> Branch inspected: `sketch-notebook-recovery`
> Branch head at inspection: `7dfef693b5589456d6535c36858346710d5fae0a`
> Persistence class: DEV_STAGE / functional analysis
> Authority: Operational analysis only; not implementation authority and not canonical truth
> Main reconciliation target: `documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`

---

## 1. Stage Status and Authority

This file replaces the stale Cycle 05 retrospective previously stored in `A_OPERATIONAL.md`.

It records the Cycle 06 execution, packaging, installation, validation, reproducibility, failure-state, and beta-risk analysis required for Main reconciliation.

Operational Chat may inspect application, packaging, installer, test, and notebook files as required, but may modify only this stage file during the current functional phase.

This report does not authorize:

- application-source changes;
- test changes;
- packaging or installer changes;
- permanent Operational-memory promotion;
- methodology changes;
- Design decisions;
- production seed classification;
- uninstall data-retention policy;
- final beta acceptance.

Evidence-status language used here:

```text
configured
built
launched
installed
validated
accepted
blocked
unknown
```

No source inspection result is promoted as runtime proof.

---

## 2. Cycle 06 Operational Objective

Cycle 06 has one operational objective:

> Produce and validate a fully executable and installable Windows primary beta of Markei.

Required user-facing lifecycle:

```text
Windows installer
→ ordinary-user installation
→ installed Markei executable
→ launch without Python or repository checkout
→ external writable user database
→ principal desktop workflows
→ normal close
→ immediate reopen
→ persistence verification
→ accepted upgrade/uninstall/reinstall behavior
→ reconciled evidence chain
```

The following remain insufficient:

```text
source execution
PyInstaller configuration
successful PyInstaller build alone
executable launched only inside the build environment
installer configuration without compilation
compiled installer without installation and exercise
```

The Operational stage therefore defines both the implementation work required before artifact generation and the evidence gates required after materialization.

---

## 3. Sources and Exact Files Inspected

### Recovery and methodology surfaces

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/12_OPERATIONAL_MODEL.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
```

### Packaging and build surfaces

```text
Markei.spec
requirements.txt
requirements-dev.txt
scripts/build_windows.ps1
build/markei_version_info.txt
```

### Runtime and persistence surfaces

```text
main.py
app/main.py
app/core/config.py
app/core/database.py
app/core/repository.py
app/core/services.py
app/database/seed.sql
app/desktop/main_window.py
app/desktop/ui/pages/register_page.py
```

### Exact branch-qualified paths tested but not found

```text
installer/Markei.iss
installer/markei.iss
installer/MarkeiInstaller.iss
installer/markei_installer.iss
installer/MarkeiSetup.iss
installer/markei_setup.iss
Markei.iss
scripts/build_installer.ps1
README.md
.gitignore
tests/test_cycle05_installation.py
```

These failed exact-path probes do not prove that no installer or test file exists elsewhere. They prove that the current installer definition and current installer compile script were not located through the bounded branch-qualified inspection route available to this chat.

Historical Cycle 05 notebook statements that an Inno Setup installer was configured remain historical evidence only until the exact contemporary file is identified on `sketch-notebook-recovery`.

---

## 4. Current Operational Baseline

Markei is a local PySide6 desktop application backed by SQLite.

Current execution spine:

```text
main.py
→ app.main.main()
→ QApplication
→ MainWindow
→ Register / Lists / History / Settings
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

Current public desktop surfaces:

```text
Register
Lists
History
Settings
```

Storage, Shortage, and Market are implemented as Lists modes:

```text
in-house
shortage
to-buy
```

Current persistence boundary:

```text
bundled resources
    app/database/schema.sql
    app/database/seed.sql

writable user state
    %LOCALAPPDATA%/Markei/market.sqlite
```

The source code resolves frozen resources through `sys.frozen` and `_MEIPASS`, and resolves the live database outside the application bundle.

Current application construction creates four page-owned service/repository/connection chains:

```text
RegisterPage → ProductService → Repository → SQLite connection
ListsPage    → ProductService → Repository → SQLite connection
HistoryPage  → ProductService → Repository → SQLite connection
SettingsPage → ProductService → Repository → SQLite connection
```

Repository and ProductService close capability exists. Application-wide shutdown ownership remains implicit.

Repository mutations commit individually. Receipt registration and purchase deletion/recalculation remain multi-commit workflows rather than one atomic business transaction.

---

## 5. Packaging and Installer Topology

### 5.1 PyInstaller specification

Current file:

```text
Markei.spec
```

Observed configuration:

```text
entrypoint          main.py
artifact name       Markei
mode                one-folder
console             True
UPX                 True
schema resource     included
seed resource       included
icon                not configured
version resource    not configured
hidden imports      none declared
runtime hooks       none declared
```

Operational classification:

```text
PyInstaller specification: configured
contemporary build: unknown
contemporary frozen launch: unknown
```

Important defects or gaps:

1. `seed.sql` is unconditionally bundled although production seed policy is unresolved.
2. `console=True` is unsuitable for the intended ordinary GUI beta unless retained only as a diagnostic build.
3. `upx=True` is enabled without current evidence that UPX is available or desirable for the beta.
4. `build/markei_version_info.txt` exists but is not connected to the spec.
5. No executable icon is connected to the spec.
6. No startup runtime hook or packaged diagnostics hook is declared.

### 5.2 Windows build script

Current file:

```text
scripts/build_windows.ps1
```

Observed behavior:

```text
moves to repository root
checks for main.py
runs python -m PyInstaller
uses --clean and --noconfirm
uses --onedir
adds schema.sql
adds seed.sql
uses console mode by default
supports optional -Windowed switch
outputs the normal dist/Markei directory
```

Operational classification:

```text
repository-defined build command: configured but unexecuted in Cycle 06
```

The script duplicates resource declarations already present in `Markei.spec` instead of selecting one authoritative packaging configuration. This creates drift risk: future changes can update the spec while leaving the script stale, or vice versa.

### 5.3 Dependency declarations

Current files:

```text
requirements.txt
    PySide6

requirements-dev.txt
    pyinstaller
```

Operational classification:

```text
runtime dependency declaration: present but unpinned
build dependency declaration: present but unpinned
```

No supported Python version is encoded in these files. The recovered environment historically used Python 3.14, but current PySide6/PyInstaller compatibility with the exact builder interpreter must be validated rather than assumed.

### 5.4 Version metadata

Current application constant:

```text
app/core/config.py
VERSION = "0.1.0"
```

Current Windows version resource:

```text
build/markei_version_info.txt
file version    0.1.0.0
product version 0.1.0.0
company name    Markei
product name    Markei
filename        Markei.exe
```

Operational classification:

```text
version metadata file: configured
metadata inclusion in executable: unknown / currently unreferenced by Markei.spec
installer identity: unknown
publisher identity: human/Main decision required
```

### 5.5 Installer topology

Historical notebook memory reports an Inno Setup per-user installer configured during Cycle 05 and blocked by unavailable `ISCC.exe`.

Contemporary branch-qualified inspection did not locate the exact `.iss` file or an installer compile script through the bounded known-path probes.

Operational classification:

```text
historical installer claim: historical evidence only
current installer definition path: unknown
current installer compilation: not validated
current installer artifact: not validated
installed lifecycle: not validated
```

Before D/E/F, Main must require one of:

1. exact discovery of the existing current-branch installer definition; or
2. explicit classification that the installer definition is missing and must be materialized.

---

## 6. Source / Frozen / Installed Runtime Boundaries

### Source execution

Supported source entrypoints:

```powershell
python main.py
python -m app.main
```

Source execution uses the repository root as the resource base.

### Frozen execution

`app/core/database.py` uses:

```text
if sys.frozen:
    resource base = sys._MEIPASS
else:
    resource base = repository root
```

Expected frozen resource path:

```text
<PyInstaller resource base>/app/database/schema.sql
<PyInstaller resource base>/app/database/seed.sql
```

Expected frozen writable database path:

```text
%LOCALAPPDATA%/Markei/market.sqlite
```

The code boundary is configured for source/frozen separation, but inclusion and discovery must be validated against the generated artifact.

### Installed execution

The installed executable must launch independently from:

- repository checkout;
- active virtual environment;
- Python command;
- repository working directory;
- build directory.

The installer must place replaceable program files separately from persistent user data.

Expected boundary:

```text
installed application directory
    executable, Qt libraries/plugins, Python runtime, bundled resources

%LOCALAPPDATA%/Markei
    market.sqlite
    SQLite WAL/SHM files when active
    startup/error log if approved
```

No installed behavior has contemporary validation evidence.

---

## 7. Resource and Writable-Data Boundary

### Must enter the frozen runtime

```text
main.py and imported app package modules
PySide6 runtime and required Qt plugins
app/database/schema.sql
approved seed resource, only if policy retains it
Windows executable version resource
approved icon/resource files
startup diagnostics components
```

### Must not enter the production runtime

```text
market.sqlite
market.sqlite-wal
market.sqlite-shm
ordinary user data
isolated test profiles
sample/demo business records unless explicitly accepted
__pycache__ directories
*.pyc files
build/ and dist/ stale artifacts as inputs
notebook files
source-control metadata
development-only tests and temporary files
```

### Current seed behavior

`app/core/database.py` executes `seed.sql` automatically whenever the resource exists.

Current `seed.sql` contains:

```text
Food category
Muffato store in Curitiba
six default settings
example Rice product
```

Both `Markei.spec` and `scripts/build_windows.ps1` currently bundle `seed.sql`.

Therefore the current configured frozen first launch will execute example/business data unless materialization changes either:

- seed contents;
- seed inclusion;
- initialization behavior;
- or an explicit production/development seed split.

This is a beta-blocking configuration conflict until Design/Main/human classify the seed rows.

### Live database behavior

Current database behavior:

```text
missing database
→ create %LOCALAPPDATA%/Markei
→ open market.sqlite
→ configure SQLite
→ execute schema.sql
→ execute seed.sql when present
→ commit and close
→ reconnect
→ run compatibility migration
```

Existing databases are preserved unless `initialize(recreate=True)` or `reset()` is explicitly used.

The live database is correctly separated by source configuration, but install/upgrade/uninstall/reinstall preservation remains unvalidated.

---

## 8. Toolchain and Dependency Requirements

### Repository requirements

```text
Windows-compatible Python source tree
main.py
Markei.spec
scripts/build_windows.ps1
requirements.txt
requirements-dev.txt
schema.sql
accepted seed resource policy
version and icon resources
installer definition
```

### Developer-machine prerequisites

```text
64-bit Windows target environment
compatible 64-bit Python
PowerShell
virtual environment tooling
pip
Inno Setup compiler if Inno Setup remains selected
sufficient disk space for clean build outputs
```

### Build-time dependencies

```text
PyInstaller
PySide6 and its deployment hooks
Python standard library
optional UPX only if explicitly retained and validated
```

### Runtime dependencies

The installed user should not need:

```text
Python installation
pip
PyInstaller
virtual environment
source checkout
PowerShell
Inno Setup
```

Runtime content must include all required Python, PySide6, Qt plugin, and SQL-resource dependencies.

### Installer-time dependency

Historical selection:

```text
Inno Setup / ISCC.exe
```

Current exact installer toolchain version and discovery path are unknown.

Required discovery sequence:

```powershell
$possibleIscc = @(
    "$env:ProgramFiles(x86)\Inno Setup 6\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
)
$possibleIscc | Where-Object { Test-Path $_ }
```

This is a proposed environment probe, not a verified repository command.

---

## 9. Reproducible Build and Installer Sequence

Every command below must be executed from a clean checkout of `sketch-notebook-recovery` or an exact commit derived from it.

### 9.1 Environment preparation

Status: proposed

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip install -r requirements-dev.txt
python --version
python -m pip freeze
```

Acceptance evidence:

- exact Python version;
- exact PySide6 version;
- exact PyInstaller version;
- clean dependency install without unresolved errors.

### 9.2 Source integrity

Status: repository-defined / unexecuted in Cycle 06

```powershell
python -m compileall app main.py
```

Then use an isolated profile:

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-localappdata"
Remove-Item -Recurse -Force $env:LOCALAPPDATA -ErrorAction SilentlyContinue
python main.py
```

### 9.3 Clean build

Status: proposed

```powershell
Remove-Item -Recurse -Force build, dist -ErrorAction SilentlyContinue
Remove-Item -Force Markei.spec -ErrorAction SilentlyContinue
```

The final clean command must not delete a reviewed authoritative spec if `Markei.spec` remains the chosen source. Main must choose whether the spec or build script is authoritative before Codex instructions are finalized.

### 9.4 Frozen runtime build

Current repository command:

```powershell
.\scripts\build_windows.ps1
```

Current status:

```text
repository-defined but unexecuted
```

Target release build after materialization should use one authoritative configuration and should produce:

```text
dist/Markei/Markei.exe
```

A diagnostic console build should precede the final windowed build.

### 9.5 Artifact inspection

Status: proposed

```powershell
Get-ChildItem -Recurse dist\Markei
Get-ChildItem -Recurse dist\Markei | Where-Object {
    $_.Name -match 'market\.sqlite|\.sqlite-wal$|\.sqlite-shm$|seed\.sql$'
}
```

Expected:

- `schema.sql` present at the path expected by resource discovery;
- `seed.sql` presence exactly matches accepted policy;
- no live database;
- no WAL/SHM files;
- Qt platform plugin present;
- version metadata attached;
- final icon attached.

### 9.6 Frozen launch validation

Status: proposed

```powershell
$env:LOCALAPPDATA = "$PWD\.tmp-frozen-localappdata"
Remove-Item -Recurse -Force $env:LOCALAPPDATA -ErrorAction SilentlyContinue
Push-Location $env:TEMP
& "$PWD\..\<absolute-path-to-repo>\dist\Markei\Markei.exe"
Pop-Location
```

The exact absolute path must be resolved on the builder. The key condition is launch from outside the repository and outside `dist/Markei` as the working directory.

### 9.7 Installer compilation

Status: blocked until the exact `.iss` path and `ISCC.exe` are confirmed

Command shape:

```powershell
& "<path-to-ISCC.exe>" "<exact-current-installer-script>.iss"
```

The command is proposed, not repository-verified.

### 9.8 Installer artifact inspection

Status: proposed

Expected artifact identity:

```text
Markei-Setup-<approved-version>.exe
```

Verify:

- publisher and version metadata;
- per-user installation path if accepted;
- Start Menu shortcut;
- optional desktop shortcut according to decision;
- no database shipped as program content;
- uninstall behavior matches accepted data policy.

---

## 10. Existing Validation Assets and Gaps

| Capability | Classification | Evidence |
| --- | --- | --- |
| Syntax/import command | present and usable | `python -m compileall app main.py` recorded in Operational memory |
| Isolated database profile convention | present and usable | `%LOCALAPPDATA%` redirection documented |
| Source desktop smoke | present but manual | `python main.py` and public-page checks |
| PyInstaller spec | present but incomplete | current `Markei.spec` |
| Windows build script | present but incomplete | `scripts/build_windows.ps1` |
| Version resource | present but disconnected | `build/markei_version_info.txt` |
| Icon resource | missing or undiscovered | no reference in inspected packaging files |
| Startup error logging | missing from inspected entrypoints | `main.py` and `app/main.py` have no exception log/dialog wrapper |
| Frozen resource tests | missing or undiscovered | no current test source confirmed |
| Installer script | unknown | historical claim only; exact current path not located |
| Installer compile script | missing or undiscovered | known path probe failed |
| Clean install test | missing contemporary evidence | Cycle 05 did not complete it |
| Upgrade test | missing contemporary evidence | unresolved policy and no artifact evidence |
| Uninstall/reinstall test | missing contemporary evidence | unresolved policy and no artifact evidence |
| Shutdown connection test | missing contemporary evidence | structural risk retained |
| Multi-commit failure injection | missing | inherited validation debt |
| Human desktop walkthrough | incomplete / stale | inherited Cycle 04/05 debt |
| Generated artifact evidence on current branch | missing | no contemporary Cycle 06 build report |

Historical main-branch frozen runtime evidence may inform expected commands but cannot satisfy Cycle 06 gates.

---

## 11. Installed Lifecycle Validation Matrix

| Transition | Precondition | Action | Expected application-file result | Expected user-data result | Evidence | Failure symptoms | Acceptance |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Fresh install | no installed Markei; isolated or clean user profile | run installer | program files and shortcuts created once | no DB until first launch unless explicitly initialized | installer log, file inventory, shortcut paths | admin request when per-user intended, missing files, duplicate install roots | installer exits successfully and registered app is launchable |
| First launch | installed app; no `%LOCALAPPDATA%/Markei/market.sqlite` | launch installed entrypoint | executable and resources load from install directory | user directory and DB created; seed behavior matches policy | startup log, DB path, schema/table inventory | silent exit, missing schema, DB under Program Files, unwanted sample data | visible MainWindow and valid external DB |
| Principal workflow | first launch successful | exercise Register, Lists, History, Settings | app files unchanged | test record and settings/store changes persisted | screenshots, DB query, timestamps | UI error, stale dependent pages, partial write | all required workflows succeed |
| Close | workflows complete | close MainWindow normally | process exits | DB remains readable; WAL state settles acceptably | process list, repository probes, file handles | hung process, cleanup exception, retained lock | process terminates and DB can reopen |
| Immediate reopen | previous close completed | relaunch immediately | same installed executable starts | same DB opens without lock or corruption | reopen log, persisted record visible | locked DB, migration reruns destructively, missing data | usable app and retained record |
| Ordinary reopen | later user session | launch from shortcut | installed files unchanged | retained state available | shortcut launch evidence | working-directory dependency | normal launch independent of repository |
| Upgrade install | older accepted beta installed with data | install newer approved package in place | application files replaced consistently | DB retained and migrated compatibly | before/after version, installer log, DB backup/hash | parallel install, old DLL mix, migration failure, data overwrite | one updated app reads retained data |
| Uninstall | accepted beta installed | invoke normal uninstall | program files, shortcuts, registry uninstall entry removed | result must match accepted policy | uninstall log, file inventory, user-data inventory | retained program files, unexpected DB deletion | behavior matches explicit policy |
| Reinstall | prior uninstall completed | install same or newer beta | clean program-file deployment | retained DB reused if policy preserves it | reinstall log, first-launch/reopen evidence | incompatible retained DB, duplicate data, reset | app opens retained data or follows accepted removal policy |
| Retained-data recovery | preserved DB exists; app reinstalled | launch and inspect | executable loads current resources | existing DB remains readable and migrated once | record/settings verification | schema mismatch, overwritten settings, duplicate defaults | intended data remains usable |

The uninstall data-result cells remain conditional until Design/Main/human accept one policy.

---

## 12. Principal Desktop Smoke-Test Route

Use an isolated beta test profile.

```text
1. Install generated beta installer.
2. Launch Markei from Start Menu or approved installed shortcut.
3. Confirm no console window in final GUI build.
4. Confirm MainWindow title is Markei.
5. Open Register, Lists, History, and Settings.
6. In Settings, create or edit a store if current UI supports it.
7. In Register, enter an approved synthetic product and receipt record.
8. Confirm success dialog and purchase identifier.
9. Confirm Lists refreshes and all three modes can be selected.
10. Confirm History refreshes and shows the persisted purchase.
11. Change one approved setting and confirm its persistence.
12. Close through the normal window close action.
13. Confirm the Markei process exits.
14. Relaunch immediately from the installed shortcut.
15. Confirm the receipt, product, store, and setting remain available.
16. Confirm `%LOCALAPPDATA%/Markei/market.sqlite` is the live database.
17. Confirm no live database exists under the install directory.
18. If a startup-error test build is available, trigger a missing-resource failure and inspect the approved log/dialog surface.
```

Register currently exposes product ID, category, product, brand, quantity, unit, unit price, total price, promotion, store ID, purchase date, expiration date, and notes.

Receipt registration calls `ProductService.register_receipt()` and then `MainWindow.refresh_pages()`, which refreshes Lists and History.

---

## 13. Shutdown, Reopen, and Database-Lock Analysis

### Confirmed structure

```text
4 pages
→ 4 ProductService instances
→ 4 Repository instances
→ 4 SQLite connections and cursors
```

`Repository.close()` closes its connection.

`ProductService.close()` is recorded as delegating to Repository close.

No authoritative application-level shutdown owner is visible in inspected `app/main.py` or `MainWindow`.

### Classification

```text
distributed connection ownership: confirmed
local close capability: confirmed
runtime leak: not proven
release-impacting retained lock: unknown
application-level deterministic close: unvalidated
```

### Required test

A test or instrumented smoke run must:

1. construct the complete MainWindow;
2. capture all four page repository instances;
3. assert all are open before closure;
4. close the window through the normal Qt route;
5. process pending events and exit the event loop;
6. assert all repositories are closed;
7. reopen the database immediately;
8. perform a read and write transaction;
9. close it;
10. delete the isolated profile directory after accounting for WAL/SHM files.

Possible outcomes:

- all close deterministically: risk resolved by validation;
- process exit releases handles but page cleanup is not deterministic: may be accepted only through Design/Main/human classification;
- one or more connections remain usable after normal close: confirmed lifecycle defect;
- immediate reopen fails with lock/corruption: beta blocker.

---

## 14. Failure-State and Diagnostics Map

| Failure state | Detection | Expected diagnostic surface | Severity | Required mitigation or validation |
| --- | --- | --- | --- | --- |
| Missing bundled schema | launch isolated frozen/install build without schema | startup dialog plus persistent log | blocker | bundle schema and validate exact resource path |
| Invalid `_MEIPASS` resource path | launch outside build working directory | startup log with resolved paths | blocker | correct resource mapping and test source/frozen paths |
| User-data directory creation failure | deny/write-fail isolated LOCALAPPDATA | actionable dialog/log with target path | blocker | catch OS error and avoid silent exit |
| Seed policy violation | inspect first-launch tables | validation report and DB query | blocker | classify seed rows and package only accepted content |
| Migration failure | open prepared old/partial DB | startup log with migration exception; original DB preserved | blocker | isolate migration, capture error, define recovery |
| Startup exception | raise before MainWindow display | dialog/log rather than disappearing | blocker | wrap top-level startup and persist traceback |
| Stale build output | compare clean and dirty builds | build log and artifact inventory | high | mandatory clean build and output removal |
| Missing Qt platform plugin | launch on clean machine | Qt plugin error captured in diagnostic build/log | blocker | verify PyInstaller Qt collection and clean-machine launch |
| Missing installer compiler | discover `ISCC.exe` | explicit blocked status | blocks installer gate | install/locate accepted compiler; do not misclassify config |
| Installer compile failure | run compiler | compiler output and exit code | blocker | correct exact `.iss` inputs and metadata |
| Windows reputation/blocking | download/launch beta artifact | Windows dialog/screenshot | release risk | record behavior; signing may remain deferred if accepted |
| Database locked on reopen | close then immediate launch/open | startup/database error log | blocker | deterministic cleanup and lock-state test |
| Partial receipt workflow | inject failure after each commit | DB state diff | high; blocker if user-visible corruption unacceptable | decide transaction policy after evidence |
| Upgrade mixes old/new files | install newer package over prior version | version/file inventory mismatch | blocker | installer AppId/version/replace rules and clean upgrade test |
| Uninstall deletes retained data unexpectedly | uninstall and inventory LOCALAPPDATA | uninstall log/file comparison | blocker | implement accepted retention policy |
| Reinstall cannot open compatible retained DB | reinstall and launch | migration/startup log | blocker | validate compatibility and preserve backup |
| Version metadata mismatch | inspect executable and installer properties | artifact metadata report | high | one accepted version source propagated consistently |
| Console shown in final build | launch installed app | visible console | acceptance failure | final windowed build after diagnostic validation |
| UPX unavailable or problematic | build/launch output | PyInstaller warning or antivirus/runtime failure | medium/high | disable UPX for first beta unless explicitly validated |

Current `main.py` and `app/main.py` do not expose a top-level startup logging or error-dialog boundary. Historical claims of startup logging therefore require contemporary source/path confirmation or reimplementation.

---

## 15. Ordered Operational Workstreams

### Must resolve before D/E/F

1. Identify the exact current installer definition path or classify it as missing.
2. Choose one authoritative PyInstaller configuration: reviewed spec or build script.
3. Obtain explicit production seed classification.
4. Obtain explicit uninstall data-retention policy.
5. Approve application display name, executable name, installer name, version, publisher, and install directory convention.
6. Approve Start Menu and desktop-shortcut policy.
7. Decide whether current shutdown and multi-commit risks require code change before beta or validation-first treatment.
8. Define supported builder Python/PySide6/PyInstaller versions.

### Must implement during materialization

1. Reconcile spec and build script into one source of packaging truth.
2. Make seed inclusion match accepted policy.
3. Connect Windows version metadata to the executable.
4. Add approved icon/resource metadata.
5. Produce diagnostic console and final windowed configurations.
6. Disable UPX unless specifically retained and validated.
7. Add startup exception logging and actionable user diagnostics.
8. Add or repair installer definition and reproducible compile script.
9. Encode accepted per-user install, shortcut, upgrade, and uninstall behavior.
10. Add targeted automated tests for resource paths, isolated initialization, migration convergence, and shutdown ownership where feasible.
11. Ensure package exclusions prevent live database, WAL/SHM, caches, and sample artifacts.

### Must validate after materialization

1. Source integrity and isolated source smoke.
2. Clean PyInstaller build.
3. Artifact inventory and resource discovery.
4. Frozen launch outside repository/build working directory.
5. Immediate close/reopen and database lock test.
6. Installer compilation.
7. Clean per-user installation.
8. Installed principal workflow smoke.
9. Persisted-data close/reopen verification.
10. Upgrade behavior if accepted in scope.
11. Uninstall and reinstall behavior under accepted retention policy.
12. Matching G/H/I evidence reports and Main reconciliation.

### Requires human decision

```text
production seed policy
uninstall data-retention policy
shortcut policy
beta identity and publisher
whether unsigned beta warnings are acceptable
whether non-atomic workflow risk blocks primary beta
whether distributed shutdown ownership is acceptable after direct validation
```

### May defer beyond primary beta

```text
code signing, if unsigned controlled beta is explicitly accepted
automatic updates
rollback installer
one-file packaging
MSIX or alternate installer architecture
full versioned migration framework
broad service/repository decomposition
mobile, backend, synchronization, identity, and cloud work
```

---

## 16. Beta-Blocking Risks

### Confirmed configuration blockers

1. `seed.sql` is bundled and automatically executed while seed policy is unresolved.
2. Version-resource file exists but is not connected to `Markei.spec`.
3. No icon is connected to the inspected packaging configuration.
4. Final GUI mode is not the default in the current spec or script.
5. Spec and script duplicate packaging authority and can drift.
6. Dependency versions are unpinned.
7. Startup diagnostics are absent from inspected entrypoints.
8. Exact installer file and compile command remain unknown.

### Validation blockers

1. No contemporary Cycle 06 frozen build evidence.
2. No contemporary frozen launch evidence.
3. No installer compilation evidence.
4. No clean installation evidence.
5. No installed workflow evidence.
6. No immediate-reopen lock evidence.
7. No upgrade/uninstall/reinstall data evidence.
8. No complete retained human desktop walkthrough.

### Structural risks requiring evidence before redesign

1. Four distributed repositories/connections and implicit application shutdown ownership.
2. Multi-commit receipt and deletion/recalculation workflows.
3. Additive migration without schema-version ledger.

These are not automatically beta defects merely because alternatives exist. They become blockers if validation demonstrates release-impacting failure or if Design/Main/human classify the risk as unacceptable.

---

## 17. Decisions Required from Design, Main, or Human Review

### Production seed policy

Classify each row/resource as:

```text
required production baseline
optional first-launch default
example/demo data
development fixture
excluded from beta package
```

The example Rice product must not enter the beta by inertia.

### Uninstall data policy

Choose one explicit behavior:

```text
preserve %LOCALAPPDATA%/Markei by default
offer explicit optional data removal
remove data automatically
```

Operational recommendation is not a decision. Validation will test the accepted policy.

### Shortcut policy

Approve:

```text
Start Menu entry
optional desktop shortcut
both
```

### Beta identity

Approve:

```text
display name
version string
executable name
installer artifact name
publisher
installation directory convention
AppId / upgrade identity
```

### Lifecycle and transaction blockers

After direct tests, decide whether:

- current distributed shutdown ownership is acceptable;
- current non-atomic workflows are acceptable for controlled beta;
- either requires a narrowly bounded pre-beta correction.

---

## 18. Explicit Deferrals

Cycle 06 must not absorb:

```text
mobile implementation
backend/API architecture
cloud synchronization
authentication/account systems
major ProductService decomposition
major Repository decomposition
broad view-model redesign
general schema redesign
complete migration-framework replacement
visual redesign unrelated to beta usability
one-file optimization
installer technology migration without blocker evidence
automatic updater
broad release-channel infrastructure
```

A deferred item may re-enter only if a direct beta-blocking defect requires the smallest possible correction.

---

## 19. Proposed Operational Acceptance Criteria

Cycle 06 Operational acceptance requires observable evidence for every item below.

### Source gate

- `python -m compileall app main.py` succeeds.
- isolated initialization creates a valid external database.
- repeated migration converges without overwriting user settings.
- source desktop launches and the four public surfaces appear.

### Frozen gate

- clean approved PyInstaller command succeeds.
- `dist/Markei/Markei.exe` exists.
- executable launches from a working directory outside the repository.
- required Qt plugins and `schema.sql` are present.
- seed behavior matches accepted policy.
- no live DB/WAL/SHM is bundled.
- external DB is created under the approved user path.
- startup failure is inspectable.
- executable closes and reopens immediately.

### Installer gate

- exact installer compiler and script are recorded.
- installer compiles successfully.
- artifact identity/version/publisher match approved values.
- per-user installation behavior matches accepted design.
- installed launch requires no Python or source checkout.

### Workflow gate

- Register writes an approved test receipt.
- Lists refreshes and all current modes work.
- History refreshes and shows the purchase.
- Settings/store workflow performs the supported write.
- close and reopen preserve the test state.

### Lifecycle gate

- all active repositories either close deterministically or produce an explicitly accepted non-blocking result.
- immediate reopen succeeds without retained lock.
- upgrade behavior matches accepted scope.
- uninstall behavior matches accepted retention policy.
- reinstall behavior is recorded.
- expected retained data remains readable.

### Evidence gate

- A/B/C describe the same accepted scope.
- J reconciliation classifies all conflicts and decisions.
- D/E/F match materialized work.
- G/H/I report the same materialization.
- human validation is recorded.
- no required blocker is silently deferred.

Only then may the result be classified:

```text
accepted Windows primary beta
```

Otherwise use the narrowest accurate partial status.

---

## 20. Handoff to Main Chat

Main should reconcile this report with Didactic and Design outputs using:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

The highest-value Main actions are:

1. confirm current installer topology;
2. reconcile seed and uninstall policy decisions;
3. approve beta identity and shortcut policy;
4. choose one authoritative packaging configuration;
5. classify shutdown and multi-commit risks as validation-first or required beta changes;
6. prepare D_OPS_STAGE only after those decisions are explicit.

Operational current-state classification:

```text
source/runtime boundaries: configured
PyInstaller packaging: configured but internally inconsistent
contemporary frozen artifact: unknown
installer definition: unknown / historical claim only
installer compilation: not validated
installed lifecycle: not validated
Cycle 06 beta: not accepted
```

No application source, test, permanent-memory, methodology, Main-root, or non-A stage file was modified by Operational Chat.
