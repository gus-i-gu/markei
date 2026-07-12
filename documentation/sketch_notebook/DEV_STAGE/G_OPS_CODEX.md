# G_OPS_CODEX — Cycle 06 Operational Codex Report

> Status: Codex implementation evidence
> Branch: `sketch-notebook-recovery`
> Source stages: `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`
> Date: 2026-07-12

## Files Changed

Modified:

- `Markei.spec`
- `scripts/build_windows.ps1`
- `main.py`
- `app/desktop/main_window.py`

Created:

- `app/startup_diagnostics.py`
- `requirements-build.txt`
- `installer/Markei.iss`
- `scripts/build_installer.ps1`
- `tests/test_release_configuration.py`

Deleted:

- none

Generated but not committed:

- PyInstaller `build/` and `dist/` outputs
- Python `__pycache__` files

## Implementation Summary

- Made `Markei.spec` the authoritative one-folder PyInstaller packaging source.
- Changed the production spec to include `app/database/schema.sql` and exclude `app/database/seed.sql`.
- Disabled UPX and configured the distributable executable as windowed.
- Attached `build/markei_version_info.txt` version metadata.
- Refactored `scripts/build_windows.ps1` to invoke `Markei.spec` rather than duplicate package contents.
- Added `requirements-build.txt` with versions observed in the successful build: PyInstaller 6.21.0 and PySide6 6.11.1.
- Added startup diagnostics at root `main.py`, writing UTF-8 logs to `%LOCALAPPDATA%/Markei/logs/startup.log` on unhandled startup exceptions.
- Added `installer/Markei.iss` with per-user install path, stable AppId, Markei 0.1.0 identity, Start Menu shortcut, optional desktop shortcut task, and default user-data retention.
- Added `scripts/build_installer.ps1` to locate `ISCC.exe`, require the frozen distribution, compile the `.iss`, and report the installer artifact.
- Added focused release-configuration tests covering spec policy, installer policy, identity consistency, startup log creation, and schema-only production first launch.
- Added a bounded `MainWindow.closeEvent()` coordinator after validation showed the isolated SQLite file remained held open without it.

## Commands Run

```text
git branch --show-current
```

Result: `sketch-notebook-recovery`.

```text
python -c "import sys; print(sys.version); import PySide6; print('PySide6=='+PySide6.__version__); import PyInstaller; print('pyinstaller=='+PyInstaller.__version__)"
```

Result: Python 3.14.6, PySide6 6.11.1, PyInstaller 6.21.0.

```text
python -m compileall app main.py
```

Result: passed after implementation and after shutdown correction.

```text
python -m pytest
```

Result: blocked. Active Python reported `No module named pytest`.

```text
python -m unittest discover -s tests
```

Result: passed, 5 tests.

```text
.\scripts\build_windows.ps1
```

Result: passed after correcting build cleanup so committed version metadata remained available. Produced `dist\Markei\Markei.exe`.

```text
Get-ChildItem -Recurse dist\Markei | Where-Object { $_.Name -match 'schema\.sql|seed\.sql|market\.sqlite|sqlite-wal|sqlite-shm|startup\.log|Markei\.exe' }
```

Result: distribution contained `Markei.exe` and `_internal\app\database\schema.sql`; no `seed.sql`, live database, WAL, SHM, or startup log was observed.

```text
Get-FileHash dist\Markei\Markei.exe -Algorithm SHA256
```

Result: `E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B`.

```text
.\scripts\build_installer.ps1
```

Result: blocked. `ISCC.exe` was not found.

## Validation Evidence

Gate A — static/source integrity:

```text
validated
```

Evidence:

- `compileall` passed.
- `unittest` suite passed.
- identity values match `Markei` / `0.1.0` / `Markei.exe`.
- tests verify spec includes schema and excludes seed/transient data.
- tests verify installer source consumes `dist\Markei`.

Gate B — clean frozen build:

```text
built / launched
```

Evidence:

- `scripts/build_windows.ps1` completed successfully.
- `dist\Markei\Markei.exe` exists.
- distribution inspection found `schema.sql` and did not find `seed.sql`, live database, WAL, SHM, or startup logs.
- isolated frozen launch from outside the repo working directory stayed alive, created `%LOCALAPPDATA%\Markei\market.sqlite`, and a second isolated launch also stayed alive.
- first-launch database contained zero category, store, product, and purchase rows, plus structural/default settings.

Gate C — first-launch database state:

```text
validated
```

Evidence:

- standard-library test simulating frozen resources without `seed.sql` passed.
- isolated frozen database query showed no sample business rows and expected default settings.

Gate D — shutdown and reopen:

```text
validated after correction
```

Evidence:

- initial focused source probe failed because the isolated SQLite file could not be removed after `MainWindow.close()`.
- added bounded `MainWindow.closeEvent()` service-close coordination.
- rerun probe reported repositories open before close, all closed after close, and isolated database directory removable.
- frozen launch/reopen smoke check succeeded after rebuilding.

Gate E — installer compilation:

```text
blocked
```

Evidence:

- `scripts/build_installer.ps1` failed because `ISCC.exe` was not found.

Gate F — installed lifecycle:

```text
blocked
```

Reason:

- installer compilation did not produce an installer, so clean install, Start Menu launch, installed workflows, uninstall retention, and reinstall checks could not be executed.

## Artifact Evidence

- Built executable path: `dist\Markei\Markei.exe`
- Built executable SHA256: `E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B`
- Installer artifact: none, blocked by unavailable `ISCC.exe`

## Deviations From D/E/F

- `python -m pytest` could not run because pytest is not installed. `python -m unittest discover -s tests` was added and passed so validation assets remain executable with the standard library.
- Permanent Didactic and Design domain files were not modified after human correction; implementation evidence is reported only through G/H/I.
- Installed lifecycle validation was not attempted because installer compilation was blocked.

## Prohibited Scope Check

No mobile, backend, API, synchronization, authentication, cloud, schema redesign, transaction redesign, broad service/repository decomposition, one-file packaging, auto-update, signing, rollback framework, or optional uninstall data deletion UX was introduced.

## Remaining Risks

- Inno Setup is required to compile and validate the installer.
- Installed lifecycle remains unvalidated.
- Human workflow validation remains required before acceptance.
- Workflow atomicity remains inherited validation debt and was not redesigned.
