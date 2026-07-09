# Cycle 04 Operational Report

> Status: Active functional stage
> Role: Operational Chat [O]
> Scope: Settings implementation sequencing, validation, risks, and mobile-start readiness
> Constraint: No application source, methodology file, permanent operational file, or Main materialization stage edits performed.

---

## 1. Recovery Notes

Files read:

- `sketch_notebook/INDEX.md` was attempted first and returned not found.
- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
- `documentation/sketch_notebook/methodology/FLUX.md`
- `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
- `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
- `documentation/sketch_notebook/00_PROJECT_STATE.md`
- `documentation/sketch_notebook/06_SESSION_SCHEME.md`
- `documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md`
- `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
- `app/desktop/ui/pages/settings_page.py`
- `app/core/services.py`
- `app/core/repository.py`
- `app/core/database.py`
- `app/database/schema.sql`
- `app/desktop/main_window.py`

Operational checkpoint status:

- `operational/10_OPERATIONAL_STATE.md` is present and non-empty.
- It preserves Cycle 03 as the last validated application baseline.
- It records existing SQLite settings persistence through a `settings(key, value)` table.
- It records Settings as the current store-management surface.
- It records remaining manual UI QA and mobile-prep risks.

Path drift / mismatch:

- The prompt requested `sketch_notebook/INDEX.md`.
- The repository-backed root found through GitHub is `documentation/sketch_notebook/`.
- This is the inverse of the prompt warning and should be reconciled by Main before generating future domain prompts.

---

## 2. Immediate Execution Problem

Restart Cycle 04 Sprint 01 from repository-backed staging and convert Settings from a narrow History/Stores page into a validated configuration surface.

Current implementation facts:

- Settings already exists.
- Store creation/update already exists.
- Key/value settings persistence already exists.
- Settings currently exposes only one week boundary option: Wednesday.
- Settings currently exposes only one month boundary option: First Wednesday.
- `pages.order` is persisted but not consumed by MainWindow tab ordering.
- History and Lists can be refreshed through `MainWindow.refresh_pages()` after Settings saves.

Immediate next work is therefore not new foundation work. It is an extension and validation pass over an existing Settings surface.

---

## 3. Settings Implementation Task List

### Must-do

1. Expand Week Boundary.
   - Add seven weekday options.
   - Persist semantic values such as `monday`, `tuesday`, `wednesday`, etc.
   - Keep `wednesday` as default unless Main/Design changes it.
   - Validate unsupported persisted values.

2. Define and expand Month Boundary.
   - Current implementation only supports `first_wednesday`.
   - Minimum safe extension is first selected weekday of month.
   - Fixed day-of-month mode should wait for Main/Design clarification.
   - History grouping must consume the selected rule.

3. Add Time Reference Time.
   - Add a persisted setting such as `history.time_reference_time`.
   - Store a normalized 24-hour `HH:MM` value.
   - Proposed default: `00:00`, pending Main/Design confirmation.
   - Validate format before saving.
   - The service layer must own interpretation.
   - Blocker: Main/Design must define whether this is only a label/reference value or an operational-day cutover that changes grouping.

4. Centralize Settings validation in ProductService.
   - Avoid direct generic writes from SettingsPage for critical values.
   - Add a validated service method for saving History settings.
   - Keep Repository as low-level key/value persistence.

5. Update defaults and migration behavior.
   - Add new defaults in database migration and initial schema/seed where appropriate.
   - Preserve existing user DB values.
   - Do not destructively reset the user database.

6. Verify History read-model consumption.
   - Ensure History grouping reads the persisted week boundary.
   - Ensure month boundary is used consistently.
   - Apply time reference only after its meaning is approved.

### Should-do

7. Compact the Stores section.
   - Preserve existing create/update behavior.
   - Do not add deletion unless Main authorizes it.

8. Add passive API/reward placeholders only if Main confirms scope.
   - No network behavior.
   - No provider-specific integration.
   - No token/secret handling until storage rules exist.

9. Resolve `pages.order` status.
   - Hide it, remove it from UI, or implement actual tab ordering.
   - Current state is risky because persisted values still mention old public tab names.

### Defer

10. Mobile implementation branch.
11. NFC-e/photo recognition.
12. Live supermarket API integration.

---

## 4. Priority and Risk Table

| Task | Priority | Risk | Dependency | Validation Need |
| --- | --- | --- | --- | --- |
| Seven weekday week boundary | Must | Medium | Existing settings and History grouping | Smoke each weekday and manual History grouping check |
| Month boundary expansion | Must | High | Main/Design semantic decision | Boundary-date grouping smoke |
| Time reference time | Must as staged feature; implementation blocked pending semantics | High | Main/Design definition | Valid/invalid time checks and boundary-time fixture |
| Service-level validation | Must | Medium | ProductService settings API | Invalid value checks |
| Defaults/migration update | Must | Medium | SQLite settings table | Existing DB and fresh DB smoke |
| History consumption | Must | High | ProductService read model | History read-model smoke |
| Compact Stores UI | Should | Low/Medium | Current SettingsPage form | Manual store create/update check |
| Passive integration placeholders | Should/Defer | Medium | Main scope confirmation | Persistence-only smoke |
| `pages.order` cleanup | Should | Medium | Main decision | Tab-order or hidden-setting check |
| Mobile branch | Defer | High | Stabilized desktop semantics | Separate mobile-readiness audit |

---

## 5. Mobile-Start Risk Register

Repository risks:

- Current app is desktop PySide6-oriented.
- Old Storage/Shortage/Market files remain transitional.
- No clear mobile branch/package structure exists.
- Branching before Settings stabilization would duplicate unfinished behavior.

Packaging risks:

- Desktop startup differs from mobile packaging.
- No mobile build target exists.
- Offscreen Qt startup is not mobile runtime validation.

UI framework risks:

- Current widget layout is desktop-first.
- Settings is not yet compact/mobile-ready.
- UI labels and semantic values still need stricter separation.

Data persistence risks:

- SQLite path, migration, backup, import/export, and sync strategy are undefined for mobile.
- Settings currently store raw strings.
- Typed validation is not centralized yet.

Validation risks:

- Full manual UI QA remains incomplete.
- Formal automated service tests are not present.
- Invalid analytics date input still behaves like omitted boundary.
- Same-day and boundary-time behavior need clearer checks.
- Multi-store analytics needs richer fixtures.

Integration risks:

- API/reward fields are placeholder-level only.
- Provider-specific mapping and authentication are undefined.
- NFC-e/photo recognition is a separate future effort.

---

## 6. Validation Plan

Codex should later validate with:

- `python -m compileall app`
- import probes for `MainWindow`, `SettingsPage`, `HistoryPage`, and `ProductService`
- existing database smoke for `Repository.get_settings()`
- non-destructive persistence smoke for new settings keys
- History read-model smoke for weekday and month boundary changes
- offscreen Qt startup smoke confirming tabs remain `Register`, `Lists`, `History`, `Settings`
- manual Settings UI checks:
  - seven weekday options visible;
  - approved month boundary options visible;
  - time reference accepts valid `HH:MM` and rejects invalid input;
  - save refreshes dependent pages;
  - store create/update still works;
  - History grouping changes when boundary settings change;
  - `pages.order` is either implemented, hidden, or clearly deferred.

---

## 7. Main Chat Handoff

Operational conclusions ready for Main synthesis:

- Cycle 04 can restart from clean repository-backed staging.
- Settings already has a persistence base and store editor.
- The highest-value path is validation-first Settings extension, not mobile branching.
- Mobile work should wait until Settings semantics, date/boundary behavior, and manual UI QA are stabilized.
- API/reward work should remain placeholder-only unless Main explicitly expands scope.

Blockers requiring human or design clarification:

- Exact meaning of time reference time.
- Exact month boundary model.
- Whether `pages.order` should remain visible, become functional, or be hidden.
- Whether API/reward placeholders belong in Cycle 04 Sprint 01.
- Whether future prompts should use `documentation/sketch_notebook/` or the repository should be restructured to expose `sketch_notebook/` at root.
