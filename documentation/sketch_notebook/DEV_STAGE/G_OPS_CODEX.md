# C11-PH04-R01 Operational Codex Evidence

Activation marker: `<!-- ACTIVATION_MARKER:C11-PH04-R01-2026-07-31 -->`

Starting remote HEAD: `35cf23602060fd3a186a2470d7ac322c795e5fce`.
Required PH03 ancestor: `0924e743931ea7aba2c9cc5d2e28063e737b2ff5`.

## Changed Paths

- `clients/markei_flutter/lib/domain/analytics/analytics_models.dart`
- `clients/markei_flutter/lib/application/analytics.dart`
- `clients/markei_flutter/lib/application/analytics_workspace.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_analytics_repository.dart`
- `clients/markei_flutter/lib/app/pages/analytics_page.dart`
- `clients/markei_flutter/lib/app/widgets/analytics_components.dart`
- `clients/markei_flutter/test/application/analytics_workspace_test.dart`
- `clients/markei_flutter/test/app/analytics_page_test.dart`
- `clients/markei_flutter/test/app/analytics_components_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

## Operational Result

Analytics now uses a functional `Create analysis` composer instead of hard-coded card creation. It exposes Group by, Choose, Variables, Operation, Timeframe, Run & save analysis, and Clear draft. Determinant choices are derived from the active Account dataset with stable keys, including duplicate-label coverage. Invalid custom UTC intervals, missing determinant values, missing measures, unavailable Purchased for, unsupported operations, stale/foreign selections, invalid Difference operands, and invalid Percentage containment block Run with explicit explanations.

`Run & save analysis` appends and selects an immutable session-local record. Records are newest-first, fingerprinted with the existing crypto dependency, retained only by the Analytics workspace, and not serialized, synchronized, edited, deleted, or reordered. The browser uses `Saved analyses — this session` and older/newer navigation.

Grouped calculation now applies Account dataset, timeframe, selected Item scope, determinant selection, determinant-plus-breakdown grouping, compatibility validation, checked fixed-point calculation, typed unavailable entries, and immutable record freezing. Difference remains comparison B minus baseline A. Percentage remains part/whole, not percentage change.

The selected record owns Chart/Table and export behavior. Chart and Table consume the same frozen grouped entries. Chart uses Flutter `CustomPainter`, bounded height, horizontal accommodation, units/currencies, semantics, and zero baseline for signed Difference. Table remains available for all results and is the fallback for mixed or unplottable compatibility keys. CSV/PDF export writes exactly one temp file per explicit successful export and preserves the record on sanitized failure.

The lower surface is now `Variables` with the subtitle `Registered Purchase evidence available locally for analysis.` It includes Purchase and Contained item projections, search, deterministic sort, 20-row pagination, selected-row counts, Purchase-to-Item expansion, exact Item selection, and `Use selected rows` handoff back to the composer without calculation.

## Counts And Evidence

- Repository requests: initial visible Analytics load = 1; explicit Retry adds +1; composer, Run, record selection, Chart/Table switch, export builders, Variables filter/sort/page/selection/focus and Clear draft add +0.
- Analytics database writes: 0, except explicit CSV/PDF temp-file writes outside the database.
- Analytics network requests: 0.
- Export file writes measured in widget test: CSV = 1, PDF = 1, total = 2.
- Ordinary fixture: 1,000 Purchases / 5,000 Items; rendered Variables page size = 20; load = 58 ms; grouped record creation = 66 ms; chart build proxy = 16 ms; table build proxy = 18 ms.
- Stress fixture: 10,000 Purchases / 50,000 Items; selected scope = 500 Item IDs; load = 263 ms; grouped record creation = 586 ms.

## Validation

- `flutter pub get`: PASS.
- `git diff --exit-code -- pubspec.yaml pubspec.lock`: PASS.
- `dart format --output=none --set-exit-if-changed lib test`: PASS after formatting five carried Dart files.
- `flutter analyze`: PASS.
- `flutter test test/analytics_registry_test.dart`: PASS, 5 tests.
- `flutter test test/application/analytics_test.dart`: PASS, 1 test.
- `flutter test test/application/analytics_workspace_test.dart`: PASS, 11 tests.
- `flutter test test/infrastructure/local_analytics_repository_test.dart`: PASS, 1 test.
- `flutter test test/app/analytics_page_test.dart`: PASS, 1 test.
- `flutter test test/app/analytics_components_test.dart`: PASS, 2 tests.
- `flutter test test/app/history_analytics_handoff_test.dart`: PASS, 1 test.
- `flutter test test/app/markei_visual_foundation_test.dart`: PASS, 6 tests.
- `flutter test test/app/markei_app_test.dart`: PASS, 26 tests.
- `flutter test --concurrency=1`: PASS, 272 passed / 4 skipped in about 92 seconds; existing Drift multiple-database debug warnings appeared in Sync tests.
- `flutter build windows --release`: PASS; produced `build\windows\x64\runner\Release\markei.exe`; existing Boost/CMake developer warning only.
- `flutter build apk --debug`: PASS; produced `build\app\outputs\flutter-apk\app-debug.apk`; Flutter emitted existing Kotlin Gradle Plugin migration warning for `auth0_flutter`.
- `node scripts/generate_sync_diagnostics.mjs --check`: PASS.
- `git diff --check`: PASS; CRLF normalization warnings only.

## Audits

Changed paths are within D section 34. No schema, migration, generated Drift, dependency, lockfile, platform, API, Auth, Sync, provider, diagnostic, Settings, Audit, Closure, Lists, History, shell/composition/navigation, D/E/F, A/B/C, J, Main-root, permanent memory, methodology, environment or secret surface was changed. Live Sign in, enrollment, hosted connection, Sync, Retry, Recovery, Auth0, Neon, Render and provider operations were not performed.

Human rendered screenshot review, assistive-technology acceptance, locale review, real-device review and learner comprehension review were not performed.

Publication was not performed because the final pre-commit fetch advanced
`origin/grm-guarded-provisioning-20260727` from
`35cf23602060fd3a186a2470d7ac322c795e5fce` to
`7d9b82cb7ed7c1abb9788b553e71d245f3189662`. The publication gate required the
remote to still equal the recorded starting head exactly.

## Terminal

```text
CYCLE=C11
PHASE=C11-PH04
ROUND=C11-PH04-R01
PH03_IMPLEMENTATION_ANCESTOR=0924e743931ea7aba2c9cc5d2e28063e737b2ff5
STARTING_HEAD=35cf23602060fd3a186a2470d7ac322c795e5fce
ANALYTICS_COMPOSER=PASS
DETERMINANT_VALUE_SELECTION=PASS
VARIABLE_OPERATION_VALIDATION=PASS
IMMUTABLE_SESSION_RECORDS=PASS
RECORD_FINGERPRINT=PASS
CHART_TABLE_PARITY=PASS
CSV_EXPORT=PASS
PDF_EXPORT=PASS
VARIABLES_PURCHASE_ITEM_PROJECTIONS=PASS
VARIABLES_SELECTION_HANDOFF=PASS
ANALYTICS_REPOSITORY_REQUESTS=initial:1; retry:+1; local_ui:+0
ANALYTICS_DATABASE_WRITES=0
ANALYTICS_NETWORK_REQUESTS=0
EXPLICIT_EXPORT_FILE_WRITES=2
ACCOUNT_ISOLATION=PASS
PH02_CALCULATION_REGRESSION=PASS
RESPONSIVE_ACCESSIBILITY=PASS
FOCUSED_TESTS=PASS
FULL_FLUTTER_TEST=PASS
WINDOWS_RELEASE_BUILD=PASS
ANDROID_DEBUG_BUILD=PASS
SCHEMA_MIGRATION=NONE
GENERATED_SOURCE_CHANGED=NO
DEPENDENCY_CHANGED=NO
PH03_SURFACES_CHANGED=NO
LIVE_PROVIDER_OPERATIONS=NOT_PERFORMED
PUBLICATION=NOT_PUSHED
NEXT_MAIN_ACTION=Reconcile C11-PH04 G/H/I evidence and schedule human rendered review.
```
