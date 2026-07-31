# G_OPS_CODEX - C11-ANALYTICS-CORRECTION-R01

## Authority

- Repository: `gus-i-gu/markei`
- Branch: `grm-guarded-provisioning-20260727`
- Starting remote HEAD: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`
- Activation commit: `0e647e76aa8275bda48cea1e9d08427e3d949134`
- Controlling source authority: latest `C11-ANALYTICS-CORRECTION-R01` sections in D/E/F.
- PH05 evidence boundary: J section 14 only.

## Diagnosis

Confirmed diagnosis: Analytics calculation did not evidence silent default-Quantity insertion. The defect was user-facing projection of fixed-point storage integers and raw compatibility keys, plus insufficient end-to-end tests proving one frozen record controls Chart, Table, interpretation, CSV and PDF.

Corrected competing hypothesis: wrong-variable display was not treated as evidence of a second calculation path or implicit Quantity fallback.

## Changed Paths

- `clients/markei_flutter/lib/domain/analytics/analytics_models.dart`
- `clients/markei_flutter/lib/domain/analytics/analytics_registry.dart`
- `clients/markei_flutter/lib/application/analytics.dart`
- `clients/markei_flutter/lib/application/analytics_workspace.dart`
- `clients/markei_flutter/lib/app/pages/analytics_page.dart`
- `clients/markei_flutter/lib/app/widgets/analytics_components.dart`
- `clients/markei_flutter/test/application/analytics_workspace_test.dart`
- `clients/markei_flutter/test/app/analytics_page_test.dart`
- `clients/markei_flutter/test/app/analytics_components_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

## Operational Evidence

- Preserved one `AnalyticsWorkspaceController`, one Account-local dataset load, one live draft, immutable session-only saved records and pure Analytics export builders.
- Added one typed `AnalyticsVariable` selection owner. Purchased by and Payment method derive categorical breakdowns; Purchased for is unavailable; Quantity, Unit price, Price paid, Purchase total and Evidence count derive numeric measures.
- Categorical-only selections block with guidance and do not insert Evidence count or Quantity.
- Unsupported operation-variable combinations block with selection-specific guidance.
- Compatible and incompatible numeric series remain separate. Incompatible axes default the selected record to Table while preserving Table/CSV/PDF evidence.
- Replaced the ISO/UTC interval control with Initial date and Final date in strict `dd-mm-yyyy`; both dates are inclusive and convert to the existing UTC half-open interval.
- Human-facing result/export formatting now converts microunits, minor currency units, unit-price minor units and basis points. Difference retains sign through exact integer aggregation before display.
- Ordinary Variables presentation hides Purchase/Product/Store/Item UUIDs while retaining stable IDs internally for selection, History handoff, pagination, fingerprints and reconstruction.
- Analytics request/effect budget remains: initial local evidence read 1, Retry +1, other local Analytics actions +0, database writes 0, network calls 0.

## Regression Matrix

- Product + Price paid and Quantity + Mean: PASS.
- Store + Price paid + Sum: PASS.
- Time by month + Quantity + Sum: PASS.
- Product + Payment method + compatible numeric variable: PASS.
- Purchase + Purchase total + Mean and Sum counted once per Purchase: PASS.
- Inclusive one-day custom range: PASS.
- Invalid and reversed dates: PASS.
- Incompatible numeric units with Table/export retained and Chart unavailable by default: PASS.
- Categorical-only selection without implicit count/Quantity: PASS.
- History-selected Purchase scope requested/matched/unavailable counts and matched-row calculation: PASS.

## Validation

- `flutter pub get`: PASS.
- `git diff --exit-code -- pubspec.yaml pubspec.lock`: PASS.
- `dart format --output=none --set-exit-if-changed lib test`: PASS.
- `flutter analyze`: PASS.
- Focused serial Analytics suite: PASS, 24 tests.
- `flutter test --concurrency=1 --no-pub`: PASS, 286 passed and 4 lab-gated skips. Existing Drift multiple-database warnings appeared and were not suppressed.
- `flutter build windows --release`: PASS; built `build\windows\x64\runner\Release\markei.exe`; existing Boost/CMake developer warning.
- `flutter build apk --debug`: PASS; built `build\app\outputs\flutter-apk\app-debug.apk`; existing `auth0_flutter` KGP future-compatibility warning.
- `node ..\..\scripts\generate_sync_diagnostics.mjs --check`: PASS.

## Forbidden-Surface Audit

- Schema/migrations/generated files: unchanged.
- Dependencies and `pubspec.yaml`/`pubspec.lock`: unchanged.
- Native platform files: unchanged.
- `documentation/GRM.md`, `documentation/G_SCRIPTS.md`, `documentation/I_SCRIPTS.ps1`, `documentation/NS_COORDINATES.md`, `documentation/DB_MGMT.sql`: unchanged.
- J, A/B/C, permanent domains and methodology: unchanged.
- Auth, API, Sync, provider, diagnostics, PH03, Closure and unrelated pages: unchanged.

## Terminal

```text
CYCLE=C11
UNIT=C11-ANALYTICS-CORRECTION-R01
CALCULATION_SELECTION_INTEGRITY=PASS
RAW_FIXED_POINT_PRESENTATION=REMOVED
UNIFIED_VARIABLES=PASS
CUSTOM_DATE_RANGE=PASS
FINAL_DATE_INCLUSIVE=PASS
VISIBLE_UUIDS=ABSENT
CHART_TABLE_EXPORT_PARITY=PASS
ANALYTICS_REQUESTS=initial:1; retry:+1; other:+0
ANALYTICS_DATABASE_WRITES=0
ANALYTICS_NETWORK_CALLS=0
SERIAL_FULL_FLUTTER_TEST=PASS
WINDOWS_RELEASE_BUILD=PASS
ANDROID_DEBUG_BUILD=PASS
SCHEMA_MIGRATION=NONE
DEPENDENCY_GENERATED_PLATFORM_CHANGE=NO
GRM_GS_FILES_CHANGED=NO
PUBLICATION=PUSHED
NEXT_MAIN_ACTION=Reconcile G/H/I and perform human wide/compact, keyboard, locale and real-device review.
```
