# D_OPS_STAGE — Cycle 06 Windows Primary Beta

> Status: Main-approved materialization stage
> Authority: Main Chat [M]
> Branch: `sketch-notebook-recovery`
> Source: `[M]_STAGE/J_[M]_STAGE.md`
> Codex report target: `DEV_STAGE/G_OPS_CODEX.md`

## 1. Objective

Materialize the first bounded Cycle 06 release-enablement unit. Produce recoverable packaging and installer sources, enforce the accepted resource/data boundary, add startup diagnostics, and create focused validation assets. Do not broaden the task into application redesign.

Current evidence status before execution:

```text
configured
```

Do not report `built`, `installed`, `validated`, or `accepted` without matching evidence.

## 2. Accepted Policies

Implement exactly these policies:

```text
Production seed:
    exclude app/database/seed.sql from the production package
    retain it as a development/test fixture

Production schema:
    include app/database/schema.sql

Writable user data:
    %LOCALAPPDATA%/Markei
    preserve during uninstall

Identity:
    display name Markei
    executable Markei.exe
    version 0.1.0
    publisher Markei
    one stable installer AppId
    Windows x64 primary beta

Packaging:
    one-folder
    Markei.spec is authoritative
    distributable build is windowed
    UPX disabled unless a later report proves it safe

Shortcuts:
    Start Menu required
    desktop shortcut optional through an installer task

Shutdown:
    validate current behavior first
    patch only a demonstrated release blocker
```

## 3. Required Repository Inspection Before Editing

Read the current versions of:

```text
Markei.spec
scripts/build_windows.ps1
main.py
app/main.py
app/core/config.py
app/core/database.py
app/database/schema.sql
app/database/seed.sql
build/markei_version_info.txt
requirements.txt
requirements-dev.txt
app/desktop/main_window.py
```

Search the branch for existing:

```text
*.iss
installer compile scripts
*.ico
release/build documentation
startup log helpers
packaging tests
```

If a suitable current installer or icon exists, repair/reuse it. Do not create duplicate authorities. If no icon exists, do not invent or generate a binary icon; leave the default executable icon and report the absence as non-blocking for the controlled beta.

## 4. Packaging Materialization

### 4.1 `Markei.spec`

Make `Markei.spec` the single reviewable packaging authority.

Required behavior:

- entrypoint is root `main.py`;
- one-folder output name is `Markei`;
- include `app/database/schema.sql` at the runtime path expected by `app.core.database`;
- exclude `app/database/seed.sql`;
- attach `build/markei_version_info.txt` or a repaired equivalent to the executable;
- use a windowed distributable executable;
- disable UPX;
- do not bundle any `market.sqlite`, `*.sqlite-wal`, `*.sqlite-shm`, logs, caches, tests, sample data, or repository build residue;
- preserve Qt/PySide6 collection required by a clean build;
- keep configuration explicit and minimal.

A diagnostic console build may be supported through a separate deliberate option or second spec only if it does not become a competing production authority. Prefer one spec with a controlled parameter/environment input only when the implementation remains easy to reproduce.

### 4.2 `scripts/build_windows.ps1`

Refactor the script so it invokes `Markei.spec` rather than repeating `--add-data`, name, entrypoint, and topology arguments.

The script must:

- run from the repository root regardless of caller working directory;
- fail fast if Python, PyInstaller, or the spec is missing;
- provide a clean-build option or clean by default;
- remove only generated build/release output, never user data;
- invoke PyInstaller through the active Python interpreter;
- identify the resulting distribution path;
- support a production windowed build;
- avoid embedding seed or database files through command-line duplication;
- return a failing exit code when the build fails.

Do not add unrelated build-system frameworks.

### 4.3 Build dependency record

Create or repair one bounded build dependency surface, such as:

```text
requirements-build.txt
```

It must record the supported build dependencies needed for Cycle 06, including PyInstaller and the PySide6 version used by the successful contemporary build. Do not guess unsupported versions.

Procedure:

1. inspect the active environment and existing dependency declarations;
2. use compatible versions available to the execution environment;
3. after a successful build, record exact versions used;
4. if no successful build is possible, leave clearly bounded compatible constraints or document the unresolved pin in G rather than fabricating success.

Record the builder Python version in release/build documentation or a generated evidence file committed only if it is stable project guidance.

## 5. Identity Materialization

Coordinate these values:

```text
APP_NAME = Markei
VERSION = 0.1.0
executable = Markei.exe
publisher = Markei
```

Repair `build/markei_version_info.txt` as needed so its executable/product/file descriptions and numeric/string versions agree with `app/core/config.py`.

Avoid introducing multiple manually divergent version declarations when a small generated step or documented synchronization check can keep them aligned. Do not redesign the whole configuration system solely to deduplicate one beta value.

Generate and commit one stable installer AppId if none exists. The value must remain unchanged across compatible upgrades and must be documented in the installer source. Do not regenerate it on each build.

## 6. Startup Diagnostics

Add an outer startup diagnostic boundary at the executable entrypoint.

Requirements:

- catch unhandled startup exceptions that occur before normal UI operation;
- write an inspectable UTF-8 log under a writable per-user path, preferably `%LOCALAPPDATA%/Markei/logs/startup.log`;
- create the log directory safely;
- include timestamp, exception type, message, and traceback;
- avoid placing logs under installed program files;
- avoid suppressing a nonzero/failing startup result;
- where Qt is safely available, show a concise visible error telling the user where the log is; otherwise stderr is acceptable for diagnostic mode;
- preserve normal successful startup behavior.

Keep the boundary in `main.py` or a small dedicated startup-diagnostics helper. Do not move business logic into the launcher.

Add focused tests for path selection and log creation where practical without requiring an interactive desktop.

## 7. Installer Materialization

Locate a current `.iss` first. If none exists, create a bounded installer source under a clear path such as:

```text
installer/Markei.iss
```

Also add a compile wrapper such as:

```text
scripts/build_installer.ps1
```

The installer definition must:

- consume the built one-folder distribution rather than source files;
- install per-user unless current evidence requires otherwise;
- avoid requiring administrator privileges for ordinary installation;
- install application files into a normal per-user program location;
- create a Start Menu shortcut;
- expose an optional desktop-shortcut task;
- register uninstall information;
- use the accepted name, version, publisher, executable name, and stable AppId;
- preserve `%LOCALAPPDATA%/Markei` during uninstall;
- never install a live database, WAL, SHM, logs, source tree, tests, or seed fixture;
- support same-AppId compatible reinstall/upgrade replacement of program files;
- fail clearly if the frozen distribution is absent.

The compile wrapper must:

- locate `ISCC.exe` through an explicit parameter, environment variable, or common installed locations;
- fail with an actionable message if unavailable;
- invoke the installer source;
- report the generated installer path;
- return failure on compile error.

Do not implement optional user-data deletion UI in Cycle 06.

## 8. Validation Assets

Add the smallest maintainable validation assets needed to prove the following gates.

### Gate A — static/source integrity

- `python -m compileall app main.py` passes;
- configuration identity is internally consistent;
- production spec includes schema and excludes seed/live/transient data;
- installer source consumes only the frozen distribution.

### Gate B — clean frozen build

- clean one-folder build completes;
- expected executable exists;
- `schema.sql` exists at the expected runtime resource path;
- `seed.sql`, `market.sqlite`, WAL, SHM, and sample business data are absent;
- build dependency versions and Python version are recorded;
- executable launches from a working directory outside the repository and build directory;
- first launch creates/reuses `%LOCALAPPDATA%/Markei/market.sqlite`.

### Gate C — first-launch database state

Using an isolated temporary/local-app-data root where safely supported, prove:

- schema initializes;
- required structural/default settings exist;
- sample store/product/purchase/category fixture rows are absent;
- repeated open does not duplicate defaults or overwrite user settings.

Never point automated validation at an ordinary user's real Markei database.

### Gate D — shutdown and reopen

Prove through focused instrumentation or an isolated smoke test:

- normal application closure reaches all intended page/service/repository cleanup paths;
- no cleanup exception is raised;
- the database can be reopened immediately;
- the isolated data directory can be removed after closure when Windows semantics permit.

If this gate passes, do not change shutdown architecture.

If it fails, add only the smallest correction in the existing desktop composition boundary, preferably a `MainWindow`-owned close coordination path that idempotently closes each page/service/repository. Re-run the gate and report both failure and correction evidence.

Do not perform a composition-root or dependency-injection redesign.

### Gate E — installer compilation

When Inno Setup is available:

- compile the installer;
- record compiler path/version;
- inspect resulting artifact name and metadata;
- report cryptographic hash if practical.

If `ISCC.exe` is unavailable, report Gate E as `blocked`; do not claim installation validation.

### Gate F — installed lifecycle

When environment access permits, validate:

```text
fresh install
→ Start Menu launch without Python/source checkout
→ Register workflow
→ Lists and History refresh/read
→ Settings/store workflow
→ close
→ immediate reopen
→ persistence check
→ same-version reinstall or compatible upgrade
→ uninstall
→ %LOCALAPPDATA%/Markei retained
→ reinstall
→ retained data opens
```

Capture paths, command/output, screenshots or logs where available, and exact data-state observations.

Codex must not label the beta `accepted`; acceptance remains Main/human responsibility.

## 9. Required Tests and Commands

Use repository-supported commands where possible. At minimum attempt and report:

```powershell
python -m compileall app main.py
python -m pytest
.\scripts\build_windows.ps1
.\scripts\build_installer.ps1
```

Adjust test invocation only to the repository's actual test topology. Do not hide failing tests.

For each command report:

```text
command
working directory
environment/Python version
exit status
essential output
classification
```

## 10. Prohibited Changes

Do not implement:

- mobile/backend/API/synchronization/authentication/cloud work;
- broad ProductService or Repository decomposition;
- workflow transaction redesign unless an ordinary beta validation exposes a blocking defect and Main has not prohibited the narrow correction;
- general migration framework or schema-version ledger;
- broad schema redesign;
- unrelated UI/visual redesign;
- one-file packaging;
- automatic updating;
- rollback framework;
- production signing;
- optional uninstall data deletion UX;
- generated sample business data in production.

## 11. `G_OPS_CODEX.md` Report Contract

Write a concise report containing:

1. exact files created/modified/deleted;
2. final packaging and installer topology;
3. accepted policies implemented;
4. exact commands and results;
5. artifact paths and hashes where available;
6. evidence status for Gates A–F;
7. first-launch database row/state summary;
8. startup diagnostic evidence;
9. shutdown/reopen evidence and whether a code correction was required;
10. installer/lifecycle evidence or exact blocker;
11. deviations from D and reasons;
12. unresolved risks;
13. confirmation that no prohibited scope was introduced.

Use only:

```text
configured
built
launched
installed
validated
blocked
unknown
```

Do not write permanent Operational memory.
