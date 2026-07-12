# I_DSN_CODEX — Cycle 06 Design Codex Report

> Status: Codex evidence report
> Branch: `sketch-notebook-recovery`
> Source stage: `F_DSN_STAGE.md`
> Date: 2026-07-12

## Design Materialization Status

Permanent Design files were not modified in the final materialization state after human correction.

The Design evidence from Cycle 06 is reported here for later Design Chat classification rather than being written directly into:

- `documentation/sketch_notebook/design/01_ARCHITECTURE.md`
- `documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md`
- `documentation/sketch_notebook/design/09_DESIGN_STATE.md`
- `documentation/sketch_notebook/design/03_DECISION_LOG.md`

## Release Boundaries Materialized In Source

- Root `main.py` remains the packaged launcher adapter and now owns the outer startup diagnostic boundary.
- `app.main.main()` remains the Qt application-construction function.
- `Markei.spec` is the authoritative one-folder PyInstaller definition.
- `scripts/build_windows.ps1` is an invocation wrapper, not an independent package definition.
- `installer/Markei.iss` defines installer identity, placement, shortcuts, and uninstall behavior.
- `scripts/build_installer.ps1` is the installer compile wrapper.

## Resource And State Classifications Implemented

| Item | Implemented classification |
| --- | --- |
| `schema.sql` | Bundled read-only production resource |
| `seed.sql` | Development/test fixture excluded from production frozen package |
| `market.sqlite` | Writable user data under `%LOCALAPPDATA%/Markei` |
| WAL/SHM | Transient writable companions, not bundled |
| startup logs | Generated writable diagnostics under `%LOCALAPPDATA%/Markei/logs` |
| version metadata | Replaceable release identity content |

## Seed And Retention Policies Implemented

- Production package includes `schema.sql`.
- Production package excludes sample-bearing `seed.sql`.
- Fresh production first launch creates schema and structural/default settings without sample category, store, product, or purchase rows.
- Installer source preserves `%LOCALAPPDATA%/Markei` by default because it contains no data-removal directives.

## Identity And Shortcut Contract

Implemented configuration:

```text
Display name: Markei
Executable: Markei.exe
Version: 0.1.0
Publisher: Markei
Installer AppId: {9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}
Primary target: Windows x64 controlled beta
```

Installer source creates a Start Menu shortcut and exposes an optional desktop shortcut task.

## Startup Diagnostic Boundary

`main.py` catches unhandled startup exceptions before normal UI operation and calls `app.startup_diagnostics.report_startup_exception()`.

The helper writes UTF-8 logs to:

```text
%LOCALAPPDATA%/Markei/logs/startup.log
```

Tests validated log path selection and log content creation.

## Shutdown And Lifecycle Outcome

Initial focused shutdown validation failed:

```text
MainWindow.close()
→ SQLite file still held open
→ isolated LOCALAPPDATA directory removal failed with WinError 32
```

Evidence-triggered correction:

```text
app/desktop/main_window.py
→ MainWindow.closeEvent()
→ close_page_services()
→ idempotently closes Register, Lists, History, and Settings page services
```

Rerun result:

```text
before close: [True, True, True, True]
after close:  [False, False, False, False]
isolated database directory removed: True
```

This is a bounded close-path correction, not a composition-root or dependency-injection redesign.

## Deployment Map For Later Design Absorption

```text
Source tree
    main.py
    app/
    app/database/schema.sql

Build layer
    Markei.spec
    scripts/build_windows.ps1
    dist/Markei

Install layer
    installer/Markei.iss
    scripts/build_installer.ps1
    compiled installer blocked by missing ISCC.exe

User-state layer
    %LOCALAPPDATA%/Markei/market.sqlite
    transient WAL/SHM
    startup logs
```

## Evidence Status

```text
configured: yes
built: yes
launched: yes, frozen isolated launch/reopen smoke check
installed: blocked
validated: partial, source/static/frozen/resource/shutdown gates only
accepted: no
blocked: installer compile and installed lifecycle
```

## Explicit Deferrals Preserved

No mobile, backend/API, synchronization, authentication, cloud persistence, auto-update, signing, rollback framework, migration ledger, ProductService/Repository decomposition, broad schema redesign, typed view-model conversion, UI/navigation redesign, optional uninstall data-removal UX, or one-file packaging was introduced.

## Suggested Design Follow-Up

Design Chat should classify this report and G evidence before deciding whether to update permanent Design memory. Any future checkpoint must avoid claiming installed lifecycle validation or beta acceptance until installer and human workflow evidence exist.
