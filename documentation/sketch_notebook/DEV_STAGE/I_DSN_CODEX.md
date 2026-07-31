# I_DSN_CODEX - C11-ANALYTICS-CORRECTION-R01

## Design Result

- `AnalyticsWorkspaceController` remains the single composition-owned Analytics workspace controller.
- The local dataset load remains Account-only and request-counted once per load, with Retry adding one more read.
- `AnalyticsComposerDraft.variables` is the single typed selection owner; `breakdowns` and `measures` are derived compatibility views.
- Run & save freezes determinant, selected keys, variables, operation, timeframe, evidence scope, selected labels and grouped entries into an immutable `AnalyticsRecord`.
- Later draft changes and saved-record selection do not mutate existing records.
- Grouping and calculation remain in the existing workspace path; `executeAnalyticsCard` was not activated as a second workspace calculation engine.
- Display conversion is pure and shared through `analyticsDisplayValue`, converting storage integers only at the presentation/export boundary.
- Fixed-point integer aggregation remains unchanged.
- Compatibility keys remain internal comparison identity and are not normal user-facing units.
- Local date conversion constructs local start and local day-after-final before converting to the existing UTC half-open period condition.
- Stable IDs remain in models, keys, selection, History handoff, pagination, fingerprints and reconstruction; ordinary Variables labels hide UUIDs.
- CSV/PDF builders remain pure; the shared export destination behavior is unchanged.

## Changed Architecture Boundary

- `analytics_models.dart`: typed variables, local-date timeframe labels and pure display-value conversion.
- `analytics_workspace.dart`: unified variable toggling, derived breakdowns/measures, validation messages, frozen-record seed and internal Purchase label presentation.
- `analytics_components.dart`: compact unified Variables presentation, two custom date fields, formatted result/table/chart semantics and UUID-hidden Variables projections.
- `analytics.dart`: formatted CSV/PDF result and evidence projection without ordinary UUID columns.
- `analytics_registry.dart`: categorical variables explicitly unsupported for calculation definitions.

## Terminal

```text
CYCLE=C11
UNIT=C11-ANALYTICS-CORRECTION-R01
COMPOSER_SELECTION_OWNER=SINGLE_TYPED
WORKSPACE_CONTROLLER_OWNER=SINGLE
CALCULATION_PATH=SINGLE_FROZEN_RECORD
DISPLAY_CONVERSION=PURE_SHARED
FIXED_POINT_AGGREGATION=UNCHANGED
COMPATIBILITY_KEYS_USER_VISIBLE=NO
CUSTOM_TIME_BOUNDARY=LOCAL_INCLUSIVE_TO_UTC_HALF_OPEN
INTERNAL_IDS=PRESERVED
VISIBLE_UUIDS=ABSENT
CHART_INCOMPATIBLE_AXIS=TYPED_UNAVAILABLE
EXPORT_BUILDERS=PURE
ANALYTICS_EFFECTS=initial_read:1; retry:+1; writes:0; network:0
SCHEMA_MIGRATION=NONE
DEPENDENCY_PLATFORM_CHANGE=NONE
SECOND_CONTROLLER_REPOSITORY_ENGINE=ABSENT
ROLLBACK=PARENT_OF_CORRECTION_COMMIT
```
