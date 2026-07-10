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
- Canonical month-boundary settings implemented:
  - `history.month_boundary_mode`;
  - `history.month_boundary_weekday`;
  - `history.month_boundary_day`.
- Month modes `first_weekday` and `day_of_month` implemented and service-tested.
- `time_reference.day_boundary_time` implemented with strict `HH:MM` save validation.
- ProductService strict save validation implemented.
- Tolerant fallback for corrupt persisted settings implemented.
- Non-destructive defaults/migration implemented for existing databases.
- Legacy `history.month_boundary_rule` compatibility implemented when canonical month keys are absent.
- SettingsPage delegates History settings persistence to ProductService.
- Visible page-order editing was removed from the History settings save path.
- Store create/update service regression passed.
- Store deletion remained excluded.
- No mobile implementation was introduced.

## Remaining TODO

- Perform human Settings save-feedback QA for valid and invalid values.
- Perform human store create/update UI QA and confirm dependent-page refresh.
- Decide future cleanup, migration, or retention of legacy `history.month_boundary_rule`.
- Decide future handling of inert persisted `pages.order`.
- Consider purchase time-of-day support only in a later authorized cycle; do not assume the current day-boundary setting changes date-only History rows.
- Perform full manual UI QA for Register, Lists, History analytics, Settings, and Product View double-click/edit flow.
- Validate Lists double-click behavior in every internal view.
- Validate receipt save refreshes Lists and History in real UI interaction.
- Add explicit invalid analytics date input handling instead of treating invalid text as an omitted boundary.
- Review same-day average timelapse behavior because dense same-day purchases can produce sub-day averages.
- Decide when old `storage_page.py`, `shortage_page.py`, and `market_page.py` files should be removed or retained as transitional reference.
- Consider automated Qt interaction/smoke tests for core widgets.
- Continue checking History behavior with older or manually edited date formats.
- Validate multi-store analytics totals with richer fixture data.
- Continue mobile-prep validation of platform-neutral service contracts without starting mobile implementation.

## Validation Gaps

- Cycle 04 Settings controls were verified offscreen, not through human interaction.
- Store create/update passed at service level, not through the actual Settings UI.
- Offscreen construction does not prove save-message, focus, masked-input, click, or refresh behavior.
- Current purchases remain date-only, so operational-day time behavior is not materially exercised by existing History rows.
- Analytics invalid date input, same-day timelapse semantics, multi-store totals, and old inventory page cleanup remain open from Cycle 03.

## Deferred Operational Items

- Store deletion remains deferred until referential behavior is explicitly designed.
- Active tab/page sorting from `pages.order` remains deferred.
- Time-of-day purchase persistence and operational-day effects beyond the helper remain deferred.
- Store editing through Register remains deferred; Register remains purchase-entry-only.
- Mobile UI, sync/backend, external integrations, and receipt recognition remain deferred.
- Store/frame-scoped price delta remains deferred.
