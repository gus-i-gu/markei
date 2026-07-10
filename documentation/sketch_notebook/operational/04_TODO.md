# Operational TODO

## Completed In Cycle 02

- History page implemented and manually validated as functional.
- Settings page implemented and manually validated as functional.
- Store editing through Settings implemented.
- Store editing updates confirmed across pages.
- Register and Product View confirmed operational.
- History first-Wednesday month behavior and Wednesday week bucketing validated at service level.
- SQLite-backed settings persistence and non-destructive migration validated.

## Completed In Cycle 03

- Public inventory navigation consolidated into `Lists`.
- Public tabs changed to Register / Lists / History / Settings.
- Former Storage/Shortage/Market meanings moved into internal Lists views.
- Lists service read model, shared row shape, latest/delta price display, and embedded History analytics implemented.
- Compile, database, service, History, analytics, import, and offscreen startup validation passed.

## Completed In Cycle 04

- Seven semantic weekday values implemented for History week boundaries.
- Canonical month-boundary settings implemented.
- Month modes `first_weekday` and `day_of_month` implemented and service-tested.
- `time_reference.day_boundary_time` implemented with strict `HH:MM` save validation.
- ProductService strict save validation and tolerant persisted fallback implemented.
- Non-destructive defaults/migration implemented for existing databases.
- Legacy month-boundary compatibility implemented.
- Store create/update service regression passed.
- No mobile implementation was introduced.

## Completed In Cycle 05 Sprint 01

- PyInstaller one-folder runtime materialized.
- Frozen executable build and launch validated.
- Schema discovery made independent of the process working directory.
- Production initialization changed to schema-only behavior.
- `seed.sql`, packaged databases, WAL/SHM files, and sample business records excluded from production runtime.
- Writable user database retained under `%LOCALAPPDATA%\Markei`.
- Empty first-launch database validated with zero products, purchases, stores, and categories and six settings.
- First receipt workflow validated without a seeded store.
- Startup failure logging implemented and validated.
- PySide6 and PyInstaller dependencies pinned.
- Inno Setup per-user installer configuration materialized.
- Application boundary preserved as Desktop UI → ProductService → Repository → SQLite.

## Remaining TODO

### Active Sprint 01 Blocker

- Provide Inno Setup `ISCC.exe`.
- Compile the installer artifact.
- Do not classify Sprint 01 release validation as complete before installer compilation and lifecycle evidence exist.

### Installed Lifecycle Validation

- Validate Start Menu launch.
- Validate clean-profile installation with no Python or repository checkout.
- Validate installed upgrade preserves `%LOCALAPPDATA%\Markei`.
- Validate uninstall preserves user data.
- Validate reinstall recovers compatible retained data.
- Record SmartScreen and antivirus behavior.
- Confirm installer placement, shortcut creation, uninstall registration, and upgrade identity from the compiled artifact.

### Manual Application QA

- Perform full manual UI QA for Register, Lists, History analytics, Settings, and Product View.
- Perform human Settings save-feedback QA for valid and invalid values.
- Perform human store create/update UI QA and confirm dependent-page refresh.
- Validate Lists double-click behavior in every internal view.
- Validate receipt save refreshes Lists and History in real UI interaction.

### Retained Operational Follow-Up

- Decide future cleanup, migration, or retention of legacy `history.month_boundary_rule`.
- Decide future handling of inert persisted `pages.order`.
- Add explicit invalid analytics date input handling.
- Review same-day average timelapse behavior.
- Decide when old `storage_page.py`, `shortage_page.py`, and `market_page.py` should be removed.
- Consider automated Qt interaction tests.
- Continue checking History behavior with older or manually edited date formats.
- Validate multi-store analytics totals with richer fixture data.

## Validation Gaps

- Installer source exists, but no compiled installer artifact has been validated.
- Start Menu, upgrade, uninstall, reinstall, SmartScreen, and antivirus behavior remain unverified.
- Frozen runtime construction does not prove all manual click, focus, validation-message, or refresh behavior.
- Current purchases remain date-only, so operational-day time behavior is not materially exercised by existing History rows.

## Deferred Operational Items

- Production signing and rollback.
- Automatic update behavior.
- Store deletion until referential behavior is explicitly designed.
- Active tab/page sorting from `pages.order`.
- Time-of-day purchase persistence beyond the existing helper.
- Mobile UI, sync/backend, external integrations, and receipt recognition.
- Store/frame-scoped price delta.
