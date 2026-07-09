# Design Stage — Cycle 04 Settings Boundary Review

## 1. Methodology Recovery

`documentation/sketch_notebook/INDEX.md` was read first as the canonical Sketch Notebook entrypoint.

The current boot route was followed:

```text
INDEX
↓
METHOD_FOUNDATIONS
↓
FLUX
↓
PROMOTION_RULES
↓
CHAT_PROTOCOL
```

Recovered methodology constraints relevant to this Design Chat:

- Design Chat observes the project as architecture.
- Design Chat communicates through responsibility analysis, domain ownership, relationship design, UI responsibility, long-term maintainability, and implementation boundaries.
- Active functional staging authority is limited to:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

No application source files, methodology files, Main-root continuity files, Codex reports, or permanent design memory files were modified during this active design staging pass.

## 2. Recovery Path

Design recovery followed the Hierarchical Recovery Principle.

Primary checkpoint read:

```text
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

Deeper design files inspected because Cycle 04 introduces architectural pressure on existing Settings, History grouping, service interpretation, and future integration boundaries:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

Implementation inspection was limited to architectural validation targets:

```text
app/core/services.py
app/core/repository.py
app/desktop/main_window.py
app/desktop/ui/pages/settings_page.py
```

## 3. Recovered Stable Architecture

Canonical layer direction remains:

```text
Desktop UI
    ↓
ProductService
    ↓
Repository
    ↓
SQLite schema / storage
```

Stable boundary rules remain valid:

- Desktop UI owns rendering, controls, page composition, navigation hooks, and event handling.
- ProductService owns business meaning, calculations, workflow coordination, settings interpretation, time-boundary interpretation, and read-model assembly.
- Repository owns SQL retrieval, persistence operations, settings persistence access, and row mapping.
- Schema/storage owns persisted facts, relationships, migration-visible data shape, and key/value settings storage.
- Models describe domain entities and cached summaries, but do not execute SQL or orchestrate workflows.

Cycle 04 must extend these boundaries rather than moving meaning into SettingsPage or Repository.

## 4. Cycle 04 Human Direction Classified As Design Input

Human direction introduces the following architectural concerns:

1. Update Settings page.
2. Correct current UI flaws around week/month boundaries.
3. Week boundary should be free choice among the seven weekdays through a dropdown.
4. Month boundary should support either:
   - a month date/day-of-month choice; or
   - the first chosen weekday of the month.
5. Compact the Stores section into a smaller component.
6. Add a field for future supermarket/reward-system API integration to upload/import products and prices into Products/Purchases during purchase effectuation.
7. Preserve mobile work as later work.
8. Treat photographic NFC-e recognition as future/hard and not part of the current cycle.

Design classification:

- Settings boundary expansion: accepted as active design pressure.
- History boundary semantics: accepted as active design pressure.
- Store UI compaction: accepted as UI composition/refactoring pressure, not a domain ownership change.
- API integration field: accepted as configuration surface / future integration placeholder only.
- API behavior, sync, authentication, provider protocol, NFC-e OCR/photo recognition, and mobile implementation: deferred design questions.

## 5. Implementation Evidence Summary

### 5.1 Settings UI currently under-exposes configured choices

`SettingsPage.build_history_group()` currently creates a week-boundary combo with only `Wednesday / wednesday` and a month-boundary combo with only `First Wednesday / first_wednesday`.

Design conclusion:

- The UI is narrower than the intended settings model.
- The week-boundary flaw is primarily a SettingsPage presentation/input limitation.
- The month-boundary flaw is both a SettingsPage input limitation and a ProductService interpretation limitation.

### 5.2 ProductService already partially supports arbitrary week starts

`ProductService.get_settings()` defaults `history.week_boundary` to `wednesday` and `history.month_boundary_rule` to `first_wednesday`.

`ProductService.week_start(value, boundary)` delegates the boundary string to `weekday_number(name)`.

`weekday_number(name)` maps all `calendar.day_name` values to weekday indices and falls back to Wednesday.

Design conclusion:

- The service already has the architectural location for arbitrary week-start interpretation.
- The UI should expose seven weekday choices rather than creating new week semantics.
- The fallback-to-Wednesday behavior may remain a defensive default, but Settings should prevent invalid values where possible.

### 5.3 ProductService still hardcodes first-Wednesday month semantics

`ProductService.first_wednesday(...)`, `operational_month_start(...)`, and `next_operational_month_start(...)` currently implement first-Wednesday operational month semantics directly.

`get_history_view()` reads `history.week_boundary`, but does not read or pass `history.month_boundary_rule` into operational month calculation.

Design conclusion:

- The canonical boundary owner is still correct: ProductService owns History period grouping semantics.
- The current month implementation is too specific for Cycle 04.
- Month-boundary interpretation should be generalized inside ProductService, not moved into HistoryPage, SettingsPage, or Repository.

### 5.4 Repository settings boundary is sufficient for new simple settings

Repository exposes generic key/value settings through `get_setting`, `set_setting`, and `get_settings`.

Design conclusion:

- New Settings fields can use existing key/value persistence if they are plain configuration values.
- Repository should not parse weekday/month-boundary meanings.
- Schema changes are not required for simple boundary settings or placeholder integration configuration unless secrets/credentials semantics are later introduced.

### 5.5 MainWindow still uses static tab order

MainWindow statically creates `Register`, `Lists`, `History`, and `Settings` tabs.

Design conclusion:

- The previous design decision remains intact: `pages.order` persistence exists but is not consumed by MainWindow.
- Cycle 04 Settings work should not accidentally activate page-order semantics unless Main explicitly accepts that design change.

## 6. Responsibility Analysis

### SettingsPage

Owner of:

- configuration surface layout;
- seven-weekday dropdown rendering;
- month-boundary control rendering;
- compact Store editor component placement;
- integration placeholder field placement;
- save button events;
- user feedback after save.

Must not own:

- week-start arithmetic;
- operational month calculation;
- interpretation of month-boundary modes;
- History regrouping logic;
- SQL persistence semantics;
- external API protocol behavior;
- receipt import/product upload workflow semantics.

### ProductService

Owner of:

- settings defaults;
- validation/normalization of setting values if added;
- week-boundary interpretation;
- month-boundary interpretation;
- History grouped read-model assembly;
- future integration-setting read model if UI needs prepared configuration data;
- deciding how saved settings affect History refresh behavior.

Must not own:

- widget layout;
- direct SQL;
- provider-specific API client behavior unless a later integration boundary explicitly places an application-service adapter under or beside ProductService.

### Repository

Owner of:

- reading/writing setting key/value pairs;
- retrieving purchase/store/product rows;
- row mapping;
- persistence support.

Must not own:

- weekday meaning;
- first-weekday-of-month meaning;
- day-of-month operational boundary meaning;
- UI defaults;
- API-provider semantics;
- product import orchestration.

### HistoryPage

Owner of:

- rendering the service-prepared grouped History view;
- refresh events;
- displaying period labels and rows returned by ProductService.

Must not own:

- grouping purchases into weeks/months;
- interpreting settings values;
- calculating operational boundaries.

### Store editor component

A compact Store editor may be extracted as a UI component if useful.

Owner of:

- store selector rendering;
- store edit form rendering;
- New / Save interactions;
- calling SettingsPage or service-level save hooks.

Must not own:

- store persistence rules beyond invoking service methods;
- ProductService business meaning;
- RegisterPage responsibilities.

### Future integration configuration component

A future integration section may appear in Settings as configuration only.

Owner of:

- displaying provider/system identifier fields;
- storing non-secret placeholder values if accepted;
- making future integration readiness visible.

Must not own yet:

- external network calls;
- credential storage/security design;
- product import execution;
- purchase effectuation workflow;
- NFC-e/photo recognition;
- mobile sync.

## 7. Proposed Architectural Evolution

### 7.1 Generalize week boundary without changing ownership

Keep the setting key:

```text
history.week_boundary
```

Allowed semantic values:

```text
monday
tuesday
wednesday
thursday
friday
saturday
sunday
```

Architecture:

```text
SettingsPage weekday dropdown
    ↓ selected weekday key
ProductService.set_setting(...)
    ↓
Repository.set_setting(...)
    ↓
SQLite settings

HistoryPage refresh
    ↓
ProductService.get_history_view()
    ↓ reads and interprets history.week_boundary
```

Design status:

- Boundary-preserving.
- No schema change required.
- Service already contains most interpretation logic.

### 7.2 Replace fixed first-Wednesday month semantics with a month-boundary model

The existing key may be evolved or supplemented:

```text
history.month_boundary_rule
```

Recommended semantic model:

```text
mode = day_of_month | first_weekday
```

Potential settings keys:

```text
history.month_boundary_mode
history.month_boundary_day
history.month_boundary_weekday
```

or a single structured value if the project wants to preserve one key:

```text
day_of_month:1
first_weekday:monday
first_weekday:wednesday
```

Design preference:

- Separate keys are easier for SettingsPage controls and service validation.
- A single structured key is simpler for persistence but more fragile unless parsed carefully.

Recommended owner:

- SettingsPage displays mode-specific controls.
- ProductService interprets mode and computes operational month start/end.
- Repository persists keys only.

Design status:

- Boundary-preserving if implemented in ProductService.
- Requires canonical design update after Main acceptance.
- Should replace function naming that implies Wednesday-only semantics.

### 7.3 Compact Stores without moving Store ownership

Settings remains the store-management surface.

Recommended UI shape:

```text
SettingsPage
    History Settings section
    Stores compact editor component
    Integration placeholder section
```

The Stores section may be made smaller through UI composition:

- one row selector + New button;
- compact form layout;
- collapsible/boxed component if desired;
- save controls grouped tightly.

Design invariant:

- Store create/update remains in Settings.
- RegisterPage must not become store-management surface.

### 7.4 Add integration placeholder as configuration, not integration behavior

Proposed Settings section:

```text
Reward / Supermarket API Integration
```

Possible placeholder fields:

```text
integration.reward_system_identifier
integration.supermarket_api_endpoint
integration.enabled
```

Design constraint:

- This cycle may stage fields only.
- No external API client, credential storage, network behavior, import parser, receipt effectuation workflow, or NFC-e recognition should be introduced unless Main creates a separate accepted design cycle.

Risk note:

- If the field stores secrets or tokens, the architecture must first define local credential/security handling. Until then, keep it as non-secret endpoint/system metadata or disabled placeholder text.

## 8. Boundary Evaluation

### Boundary-preserving changes

- Expanding SettingsPage dropdown choices for week boundary.
- Persisting additional non-secret key/value settings through existing Repository settings access.
- Moving month-boundary interpretation into generalized ProductService methods.
- Compacting Store UI as a Settings-owned component.
- Adding disabled or non-functional integration configuration placeholders.

### Boundary-risk changes

- Letting SettingsPage compute week/month period boundaries.
- Letting Repository encode first-weekday or day-of-month behavior.
- Letting HistoryPage regroup purchases after receiving raw rows.
- Treating API placeholder fields as a working import pipeline.
- Storing API secrets without a credential boundary.
- Activating `pages.order` while editing Settings unless explicitly accepted.
- Renaming or deleting old Storage/Shortage/Market files as part of this cycle without separate cleanup acceptance.

## 9. Design Risks

### Risk 1 — Month-boundary semantics become duplicated

If SettingsPage, HistoryPage, and ProductService each understand month-boundary modes, the project will drift.

Guard:

- ProductService must be the single owner of month-boundary interpretation.
- UI should pass semantic keys only.

### Risk 2 — Current function names preserve stale Wednesday meaning

Functions named `first_wednesday`, `operational_month_start`, and `next_operational_month_start` encode the old special case.

Guard:

- A later implementation may rename or wrap these internally, but the design requirement is semantic generalization, not name churn for its own sake.

### Risk 3 — Integration field expands into premature API architecture

A simple API field can easily become provider auth, network client, import mapping, and purchase workflow redesign.

Guard:

- Treat this cycle as configuration placeholder only.
- Defer provider protocol, credentials, import mapping, and effectuation workflow.

### Risk 4 — Store compaction reduces clarity

Compacting Store UI may hide required fields or confuse New vs Edit state.

Guard:

- Preserve explicit selector, ID/read-only state, editable fields, and Save/New events.
- Compact layout, not meaning.

### Risk 5 — Page ordering is accidentally activated

Settings still exposes `pages.order`, while MainWindow uses static tab creation.

Guard:

- Do not consume `pages.order` in MainWindow during this cycle unless Main explicitly accepts page-order activation.

### Risk 6 — Mobile/API pressure breaks desktop boundary

Future mobile/API ideas may pressure the app toward backend rewrite too early.

Guard:

- Preserve PySide6 desktop app.
- Improve service/read-model/configuration boundaries only.
- Defer mobile implementation, sync, authentication, and NFC-e recognition.

## 10. Architectural Decisions Proposed For Main Synthesis

### Proposed decision A — Week boundary free choice

Accept seven weekday choices for `history.week_boundary`.

Owner split:

- SettingsPage exposes choices.
- ProductService interprets selected weekday.
- Repository persists the string.

### Proposed decision B — Month boundary mode split

Accept month-boundary semantics as one of:

```text
day_of_month
first_weekday
```

Owner split:

- SettingsPage exposes mode and corresponding field.
- ProductService interprets operational month start/end.
- Repository persists setting values only.

### Proposed decision C — Store section compact component

Accept compacting Stores as UI composition inside Settings.

Owner split remains unchanged:

- Store management belongs in Settings.
- ProductService validates/saves store data.
- Repository persists Store rows.

### Proposed decision D — API integration field is placeholder-only

Accept a Settings integration section only as non-functional configuration staging.

Deferred:

- provider API client;
- authentication/credential storage;
- product/price import mapping;
- purchase effectuation workflow;
- NFC-e recognition;
- mobile integration.

## 11. Design DEV_STAGE Material For Main Chat

Main Chat may synthesize the following Codex-ready design direction if accepted:

```text
Cycle 04 should update Settings without changing the layer architecture.

SettingsPage should expose History boundary settings:
- week boundary as seven weekday options;
- month boundary as either day-of-month or first selected weekday.

ProductService should remain the sole owner of interpreting those setting values into History week/month boundaries.

Repository should continue to persist settings as key/value strings and must not interpret period semantics.

HistoryPage should continue rendering the service-prepared grouped read model only.

The Stores section may be compacted as a Settings-owned UI component, but Store create/update remains in Settings through ProductService.

A supermarket/reward-system API field may be added to Settings as a placeholder configuration surface only. No external API behavior, credential model, import pipeline, purchase effectuation integration, NFC-e recognition, or mobile implementation should be introduced in this cycle.

Do not activate `pages.order` consumption unless Main explicitly expands the cycle scope.
```

## 12. Recommended Permanent Design Memory Updates After Materialization

After Codex materialization and evidence report, Design Chat should update permanent design memory if implementation matches accepted direction:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

Candidate canonical additions:

- History week boundary is configurable across seven weekdays.
- History month boundary supports day-of-month or first-selected-weekday semantics.
- ProductService owns all History boundary interpretation.
- Settings may include integration configuration placeholders without owning integration behavior.

Candidate deferred design questions:

- How should API credentials be stored if integration becomes real?
- Should provider-specific integrations live beside ProductService as separate adapters?
- How should imported products/prices map into Product and Purchase records?
- Should receipt effectuation become a separate application service?
- What formal mobile/API boundary is required before NFC-e recognition?
