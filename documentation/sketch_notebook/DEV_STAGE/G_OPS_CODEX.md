# G_OPS_CODEX - Final Combined C11 PH01-R01 + PH02 Evidence

Source stages:

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

Starting remote HEAD:

```text
e802d435cf562e422b7f9118db929235488899bf
```

R02 pre-mutation recovery:

- explicit fetch of `grm-guarded-provisioning-20260727` completed without pull,
  merge, rebase, reset, clean, stash or branch switch;
- local HEAD and remote branch HEAD were both
  `e802d435cf562e422b7f9118db929235488899bf`;
- activation commit sole parent was
  `4d599c9ea7fdfe65eb3c9270041055b828d8f971`;
- activation commit changed only D/E/F;
- R01 carry-forward implementation paths were present;
- before-edit `git diff --check` passed with line-ending warnings only.

R01 materialization preserved:

- Purchase and Catalogue field geometry received bounded spacing and wrapping
  fixes while preserving the accepted PH01 visual system.
- History retained one unambiguous row-selection checkbox and a separate detail
  action.
- Analytics remained local, deterministic, read-only and Account-scoped, with
  session-local cards, twelve-field evidence rows, 100-row rendered pages,
  500-ID selected-scope cap and typed History Purchase-ID handoff.

R02 corrective evidence:

- The focused timeout/process-lock cause was isolated to animated
  `Scrollable.ensureVisible` helper calls in app-shell tests and to eager hidden
  Analytics page loading inside the shell.
- `test/app/markei_app_test.dart` now uses the tester-owned bounded
  `ensureVisible` path for helper scrolling while keeping the same assertions.
- Analytics page loading is gated by visible destination state, so hidden tabs
  do not start background SQLite work in app-shell tests.
- History wide and compact rows now preserve the checkbox as the only selection
  control while row/card activation opens detail.
- Overflow execution now returns a typed unavailable result instead of
  propagating checked-integer overflow.

Validation evidence:

- `flutter pub get`: PASS.
- `dart format --output=none --set-exit-if-changed lib test`: PASS.
- `flutter analyze`: PASS, no issues found.
- Focused tests: PASS.
- Formerly blocked cases:
  - `Store selected plus no Item reports item-required`: PASS independently.
  - `complete Catalogue-create-to-Purchase-register flow`: PASS independently.
  - `flutter test test/app/markei_app_test.dart --concurrency=1`: PASS, 26
    tests.
- Full suite:
  - `flutter test --concurrency=1`: PASS, 258 tests passed, 4 skipped, wall
    time approximately 82.7 seconds.
- Builds:
  - `flutter build windows --release`: PASS, built
    `build\windows\x64\runner\Release\markei.exe` in 40.1 seconds with the
    existing Boost CMake dev warning.
  - `flutter build apk --debug`: PASS, built
    `build\app\outputs\flutter-apk\app-debug.apk` in 13.6 seconds with the
    existing auth0_flutter Kotlin Gradle Plugin warning.
- Audits:
  - `git diff --check`: PASS with line-ending warnings only.
  - dependency, pubspec/lockfile, schema, generated-source, provider and Sync
    forbidden-surface audits: PASS.
  - validation-owned Dart/Flutter/sqlite processes after focused and full
    validation: none observed.

Request-count evidence:

- `analytics_workspace_test.dart` observed one repository request on initial
  load.
- Retry added exactly one repository request.
- Filtering, selection, execution, focus, reset and reorder added zero
  repository requests.
- `local_analytics_repository_test.dart` covered one complete Account-scoped
  joined evidence load without History 50-row reuse or an N+1 path.

Ordinary and stress evidence:

- Ordinary fixture:
  - host: Windows local validation host;
  - size: 1,000 Purchases and 5,000 Items;
  - rendered page size: 100 rows;
  - selected scope size: 0 IDs;
  - operation: Sum over line totals;
  - initial complete load: 2 ms;
  - calculation after load: 22 ms;
  - result: PASS, under 250 ms target.
- Stress fixture:
  - host: Windows local validation host;
  - size: 10,000 Purchases and 50,000 Items;
  - rendered page size: 100 rows;
  - selected scope boundary: 500 IDs;
  - operation: Mean over selected-scope line totals;
  - complete load: 6 ms;
  - calculation after load: 302 ms;
  - overflow typed-block behavior: exercised through registry overflow test;
  - result: PASS, calculation under one second target.

Evidence limits:

- Automated evidence includes unit/widget tests, app-shell tests, request-count
  tests, fixed-point tests, ordinary/stress timing tests, analysis and builds.
- Rendered evidence is limited to widget-test layout assertions and build
  artifacts; no screenshot review was performed.
- Build evidence covers Windows release and Android debug artifacts only.
- Human acceptance, screen-reader review, real-device review and Sync/provider
  live operation were not performed.

## Terminal

```text
CYCLE=C11
ROUND=C11-PH01-S02-R01+C11-PH02
STARTING_HEAD=e802d435cf562e422b7f9118db929235488899bf
PH01_BASELINE_COMMIT=2e59f35dd7b45902f707fcf33c73024e868787de
PH01_CORRECTIONS=PASS
PURCHASE_VERTICAL_REACHABILITY=PASS
CATALOGUE_VERTICAL_REACHABILITY=PASS
FORM_FIELD_GEOMETRY=PASS
HISTORY_SINGLE_SELECTION=PASS
ANALYTICS_LOCAL_ACCOUNT_SCOPE=PASS
EVIDENCE_QUERY_COMPLETENESS=PASS
EVIDENCE_QUERY_COUNT=initial_load:1; retry:+1; local_transitions:+0
OPERATION_COMPATIBILITY=PASS
FIXED_POINT_AND_OVERFLOW=PASS
HISTORY_HANDOFF=PASS
WIDE_COMPACT_STATE_PARITY=PASS
ORDINARY_FIXTURE=1000 purchases/5000 items; rendered_page=100; selected_scope=0; load=2ms; calculation=22ms; PASS
STRESS_FIXTURE=10000 purchases/50000 items; rendered_page=100; selected_scope=500; load=6ms; calculation=302ms; PASS
FOCUSED_TESTS=PASS
FULL_FLUTTER_TEST=PASS
FLUTTER_ANALYZE=PASS
WINDOWS_BUILD=PASS
ANDROID_BUILD=PASS
SCHEMA_OR_DEPENDENCY_CHANGED=NO
LIVE_SYNC_OR_PROVIDER_OPERATION=NONE
PUBLICATION=PUSHED
NEXT_MAIN_ACTION=Reconcile final G/H/I into permanent Operational, Didactic and Design memory.
```
