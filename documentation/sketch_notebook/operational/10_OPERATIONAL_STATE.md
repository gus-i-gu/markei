# Operational State

> Checkpoint refreshed from Cycle 04 Settings Stabilization evidence.

## Current Implementation State

- Cycle 01 Product View remains implemented and operational.
- Register remains operational and purchase-entry-only.
- Public desktop tabs remain:
  - Register
  - Lists
  - History
  - Settings
- Lists remains the unified inventory page with internal `all`, `in-house`, `shortage`, `to-buy`, `in-house + shortage`, and `shortage + to-buy` views.
- History remains service-driven with Month -> Week grouping and embedded read-only analytics.
- Settings remains the user-facing configuration and store-management surface.
- Store create/update remains implemented through Settings; store deletion remains deferred.
- SQLite-backed settings persistence remains generic key/value storage.
- ProductService now owns Cycle 04 Settings defaults, strict save validation, tolerant fallback normalization, and behavior-affecting interpretation.
- SettingsPage delegates History settings save behavior to `ProductService.save_history_settings()`.
- Week boundary supports seven lowercase semantic weekday values.
- Month boundary supports:
  - `history.month_boundary_mode = first_weekday` or `day_of_month`;
  - `history.month_boundary_weekday` with seven semantic weekday values;
  - `history.month_boundary_day` constrained to 1-28.
- `time_reference.day_boundary_time` is persisted and validated as normalized 24-hour `HH:MM`.
- `ProductService.operational_date()` can derive an operational date from date/datetime input and the configured boundary time.
- Existing purchases are date-only, so day-boundary time does not materially change current History grouping.
- Legacy `history.month_boundary_rule` is read compatibly when canonical month keys are absent; legacy rows are not deleted.
- Migration/default insertion is non-destructive and preserves existing user settings.
- `pages.order` remains persisted but inert; MainWindow continues to mount static public tabs.
- No mobile UI, backend, synchronization, receipt recognition, or other mobile implementation was introduced.

## Cycle 04 Validation Evidence

Completed validation:

- Application compile passed with the explicit project interpreter.
- Temporary-database Settings persistence smoke passed.
- Invalid persisted settings fell back to defaults.
- Invalid user-save time `99:99` raised `ValueError` before persistence.
- Week boundary smoke passed for Monday and Sunday.
- Month boundary smoke passed for `first_weekday` and `day_of_month`.
- `operational_date()` smoke passed with a `04:30` boundary.
- Legacy `first_friday` month rule compatibility smoke passed.
- Offscreen SettingsPage smoke confirmed:
  - 7 week choices;
  - 2 month modes;
  - 7 month weekday choices;
  - month-day range 1-28.
- Offscreen public-tab smoke returned `['Register', 'Lists', 'History', 'Settings']`.
- Store create/update passed at service level on a temporary database.
- `git diff --check` reported only line-ending warnings.
- Generated `__pycache__` files were restored rather than staged.

Validation not completed:

- Human interactive Settings save-feedback QA was not performed.
- Human store create/update through the actual Settings UI was not performed.
- Offscreen widget construction and service smokes do not prove real click, focus, validation-message, or refresh behavior.

## Remaining Operational Work

- Perform human Settings save-feedback QA for valid and invalid inputs.
- Perform human store create/update UI QA and verify dependent-page refresh.
- Decide whether legacy `history.month_boundary_rule` should later be migrated, removed, or left inert.
- Decide whether inert `pages.order` should later be removed, migrated, or implemented.
- Consider time-of-day purchase support only in a later explicitly authorized cycle.
- Perform full manual UI QA for Register, Lists, History analytics, Settings, and Product View double-click/edit flow.
- Validate Lists double-click from every internal view.
- Validate receipt save refresh behavior for Lists and History.
- Add explicit invalid analytics date input handling.
- Review same-day average timelapse behavior for dense same-day purchase data.
- Decide whether old Storage/Shortage/Market page files should be deleted or retained.
- Continue monitoring unsupported historical date formats surfaced through `unparsed_rows`.
- Validate multi-store analytics totals with richer fixture data.
- Continue mobile-prep validation of platform-neutral service contracts without beginning mobile implementation.

## Known Implementation Limitations

- Manual interactive UI validation remains incomplete after Cycle 04 materialization.
- Day-boundary time is contract-ready but has no material effect on current date-only purchase rows.
- Legacy `history.month_boundary_rule` may remain in persisted data as compatibility residue.
- `pages.order` remains persisted but is not applied to MainWindow tab ordering.
- Invalid analytics date input still behaves like an omitted date boundary.
- Same-day purchases can produce sub-day frame average timelapse values.
- Existing unsupported date formats are reported, not repaired.
- Store/frame-scoped price delta remains deferred.
- Old Storage/Shortage/Market page files remain present as transitional source files.
- Full automated PySide6 interaction coverage is not present.

## Active Operational Risks

- Settings save messages, masked time input ergonomics, and dependent-page refresh may still contain interaction defects not covered by offscreen testing.
- Store create/update UI interaction may still regress despite passing service-level smoke.
- Legacy and canonical month-boundary keys can coexist and require a later cleanup decision.
- Persisted inert `pages.order` can continue to mislead future maintainers.
- Time-reference behavior must not be assumed to affect current History rows until reliable purchase time-of-day data exists.
- Mobile readiness has improved only at the reusable service-contract level; the project is not ready for mobile implementation.
- Existing Cycle 03 UI, analytics, old-page, and date-format risks remain open.
