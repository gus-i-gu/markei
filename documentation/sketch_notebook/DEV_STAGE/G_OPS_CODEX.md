# G_OPS_CODEX - C11-PH05-R01

## Authority

- Round: C11-PH05-R01
- Activation marker: `<!-- ACTIVATION_MARKER:C11-PH05-R01-2026-07-31 -->`
- Starting local HEAD: `b59b2ecdfb69ca98c431b9f36694f011332fbef3`
- Starting remote HEAD: `b59b2ecdfb69ca98c431b9f36694f011332fbef3`
- Direct authority: active D/E/F PH05 tails and J section 13 reconciliation.

## Changed Paths

- `clients/markei_flutter/lib/application/export_destination.dart`
- `clients/markei_flutter/lib/application/home_content.dart`
- `clients/markei_flutter/lib/application/analytics_workspace.dart`
- `clients/markei_flutter/lib/infrastructure/platform/local_export_destination.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart`
- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/markei_composition.dart`
- `clients/markei_flutter/lib/app/pages/analytics_page.dart`
- `clients/markei_flutter/lib/app/pages/guide_page.dart`
- `clients/markei_flutter/lib/app/pages/history_page.dart`
- `clients/markei_flutter/lib/app/pages/home_page.dart`
- `clients/markei_flutter/lib/app/pages/products_page.dart`
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/app/pages/settings_page.dart`
- `clients/markei_flutter/lib/app/widgets/audit_components.dart`
- `clients/markei_flutter/test/application/export_destination_test.dart`
- `clients/markei_flutter/test/infrastructure/local_query_repository_export_test.dart`
- `clients/markei_flutter/test/app/analytics_page_test.dart`
- `clients/markei_flutter/test/app/audit_page_test.dart`
- `clients/markei_flutter/test/app/guide_page_test.dart`
- `clients/markei_flutter/test/app/history_analytics_handoff_test.dart`
- `clients/markei_flutter/test/app/history_page_test.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`
- `clients/markei_flutter/test/app/markei_visual_foundation_test.dart`
- `clients/markei_flutter/test/app/settings_page_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

## Operational Evidence

- Home adds static local News and Updates follow-up cards. Home performs no repository, file, network or database operation.
- Purchase keeps Store/time required and Person/Payment Method independent optional metadata under `Optional purchase details`.
- Catalogue removed ordinary selection state, selected counter, generated DataTable row selection and selected-card highlight. Product detail remains reachable through identifying cells/cards and View details.
- History keeps one selected-for-action Purchase-ID set separate from open detail. Final row can be unchecked. Filter changes prune selection to currently shown rows. Reload intersects selection and detail with returned rows.
- History `Select all shown` applies only to the current filtered loaded recent-History window.
- History `Use in Analytics` hands Purchase IDs only. Analytics reports requested, matched and unavailable Purchase counts and performs no calculation, saved-record creation or Purchase mutation from handoff.
- Shared export boundary added: pure History/Analytics builders remain separate from the destination port and platform adapter.
- Windows export writes one collision-safe final file in Downloads per explicit successful export. Android public Downloads returns typed unavailable and writes zero files.
- History selected export reconstructs the selected bundle with two set-based Account-scoped local reads for non-empty selection; zero database writes and zero network calls.
- Guide is local, anchored and eight-section, with contents navigation and focusable anchors.
- Audit cards `System`, `Readiness summary` and `Diagnostics` project already loaded bounded local Audit state only.
- Settings order is Account, Purchase references and shortage timeframe, Sync and Device, then visible non-collapsible Advanced. Support actions refresh status without overwriting the action result.

## Counts And Measurements

- Home I/O: 0.
- Guide I/O: 0.
- History selected export: 2 local reads, 0 database writes, 0 network calls.
- Successful explicit export: 1 final file write.
- Android unavailable export: 0 writes.
- Analytics: initial evidence request 1, Retry +1, handoff/export/local UI +0 repository requests, 0 database writes, 0 network calls.
- Audit: initial page 2 queries, Retry +2, projection +0, writes 0, network 0.
- Settings: initial calls 5; local Refresh +2; duplicate actions blocked by `_busy`; post-action status refresh completed.
- Ordinary Analytics fixture: 1,000 Purchases / 5,000 Items; rendered page size 20; load 50 ms; grouped calculation/record creation 56 ms; chart build 12 ms; table build 11 ms.
- Stress Analytics fixture: 10,000 Purchases / 50,000 Items; selected scope 500; load 181 ms; grouped calculation/record creation 405 ms.

## Validation

- `flutter pub get`: PASS.
- `git diff --exit-code -- pubspec.yaml pubspec.lock`: PASS.
- `dart format --output=none --set-exit-if-changed lib test`: PASS.
- `flutter analyze`: PASS.
- `flutter test test/application/export_destination_test.dart --no-pub`: PASS.
- `flutter test test/app/history_page_test.dart --no-pub`: PASS.
- `flutter test test/app/history_analytics_handoff_test.dart --no-pub`: PASS.
- `flutter test test/application/analytics_workspace_test.dart --no-pub`: PASS.
- `flutter test test/app/analytics_page_test.dart --no-pub`: PASS.
- `flutter test test/app/guide_page_test.dart --no-pub`: PASS.
- `flutter test test/app/settings_page_test.dart --no-pub`: PASS.
- `flutter test test/app/audit_page_test.dart --no-pub`: PASS.
- `flutter test test/app/markei_visual_foundation_test.dart --concurrency=1 --no-pub`: PASS.
- `flutter test test/app/markei_app_test.dart --concurrency=1 --no-pub`: PASS.
- `flutter test test/app/analytics_components_test.dart --no-pub`: PASS.
- `flutter test test/infrastructure/local_query_repository_export_test.dart`: PASS.
- `flutter test --concurrency=1 --no-pub`: PASS, 278 passed and 4 skipped lab-gated tests.
- `flutter build windows --release`: PASS; built `build\windows\x64\runner\Release\markei.exe`; existing Boost CMake policy warning only.
- `flutter build apk --debug`: PASS; built `build\app\outputs\flutter-apk\app-debug.apk`; existing KGP deprecation warning only.
- `node scripts/generate_sync_diagnostics.mjs --check`: PASS.
- `git diff --check`: PASS.

## Limits

- Screenshots: NOT_PERFORMED.
- Keyboard-only manual review: NOT_PERFORMED.
- Narrator/TalkBack review: NOT_PERFORMED.
- Locale review: NOT_PERFORMED.
- Real-device behavior: NOT_PERFORMED.
- Human comprehension: NOT_ESTABLISHED.
- Live Sign in, enrollment, hosted connection, Sync, Retry, Recovery, Auth0, Neon, Render and provider operations: NOT_PERFORMED.

## Terminal

```text
CYCLE=C11
PHASE=C11-PH05
ROUND=C11-PH05-R01
STARTING_HEAD=b59b2ecdfb69ca98c431b9f36694f011332fbef3
PH04_IMPLEMENTATION_ANCESTOR=1aea7a5b531b56484e999aa8989978902b8db2c0
HOME_LOCAL_INFORMATION=PASS
PURCHASE_REDISTRIBUTION=PASS
CATALOGUE_SELECTION_REMOVAL=PASS
HISTORY_MULTI_SELECTION=PASS
HISTORY_SET_EXPORT_READS=2
ANALYTICS_SCOPE_HANDOFF=PASS
WINDOWS_DOWNLOADS_EXPORT=PASS
ANDROID_PUBLIC_DOWNLOADS=UNAVAILABLE_BY_AUTHORITY
EXPORT_FINAL_WRITE_COUNT=1_PER_SUCCESS
GUIDE=PASS
AUDIT_PROJECTION_IO=initial:2; retry:+2; projection:+0; writes:0; network:0
SETTINGS_INITIAL_CALLS=5
SETTINGS_POST_ACTION_REFRESH=PASS
REFERENCE_CODES=UNCHANGED
FOCUSED_TESTS=PASS
FULL_FLUTTER_TEST=PASS
WINDOWS_RELEASE_BUILD=PASS
ANDROID_DEBUG_BUILD=PASS
SCHEMA_MIGRATION=NONE
GENERATED_SOURCE_CHANGED=NO
DEPENDENCY_CHANGED=NO
PLATFORM_FILES_CHANGED=NO
LIVE_PROVIDER_OPERATIONS=NOT_PERFORMED
PUBLICATION=PUSHED
NEXT_MAIN_ACTION=Reconcile PH05 G/H/I and perform bounded human UI/export review.
```
