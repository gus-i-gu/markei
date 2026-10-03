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


## 2026-10-02 — Flutter release packaging evidence

Direct human-authorized Flutter packaging work completed. See G_OPS_CODEX.md section dated 2026-10-02 for exact source changes, environment recovery, validation, and evidence limits. This append is observational evidence, not semantic promotion. Windows setup compiled and installation lifecycle checks passed; Android release signing awaits explicit human choice. Existing C11 staging was retained.


2026-10-02 Android follow-up: human approved signing key creation. Signed APK built and signature verified. G_OPS_CODEX.md contains exact evidence and the remaining Auth0 fingerprint registration requirement. This supersedes the earlier signing-pending statement; no semantic promotion or provider mutation.


## 2026-10-03 — Marc brand presentation

Original northern emblem with the human-approved steely-green M is the selected artwork. MarcBrand uses the full logo on wide navigation and the emblem on compact/medium layouts; tapping opens About. Windows ICO and Android legacy/adaptive resources are packaged separately. Functional theme colors and application identifiers are retained. No new dependency; earlier work preserved. Builds and 44 focused existing checks passed; physical-device review remains open. Detailed evidence: C:\Users\gyg29\Documents\Codex\2026-10-03\g-we-need-now-to-check\outputs\Marc-branding-integration.txt.

## 2026-10-03 — New-account migration evidence

Direct human-authorized migration retained Flutter source, package identities, signing key, Marc branding and beta notice. New Auth0 native clients/API and Render service are configured; existing empty development Neon schema is reused through restricted markei_runtime. GRM hosting/auth metadata checks and Windows/Android build 1.0.0+2 pass. Real-user sign-in, guarded membership provisioning, enrollment and cross-device sync remain open. Clean remote-aligned source is still required for GRM-AUTH-03. See the same-date G_OPS_CODEX migration section for exact evidence. No semantic promotion, methodology edits, data purge or publication.

## 2026-10-03 — First-beta bundle evidence

Human-authorized AAB preparation and safety checks completed locally. Existing Flutter suite: 286 pass / 4 skip; backend: 61 pass, lint/type/build pass and zero npm advisories after compatible patches. Release Android callback restricted to configured HTTPS; AAB/APK signatures, manifest and 16KB native alignment verified. Security patches have NOT been deployed. Native sign-in/provisioning/enrollment/sync and store acceptance remain open; see same-date G_OPS_CODEX details. No semantic promotion or public release.
