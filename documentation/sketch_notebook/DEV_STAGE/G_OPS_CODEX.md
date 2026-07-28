# G_OPS_CODEX - C10-GCM03-ST04-R1 operational report

Sequence: FLX-ORD-01
Role: Codex materialization evidence
Round or unit: C10-GCM03-ST04-R1
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: db17f47f3bb7a032afbd8892754dff971ae20b56
Authority: D_OPS_STAGE.md / E_DDC_STAGE.md / F_DSN_STAGE.md
Writable surfaces: Flutter Closure/provenance source, Flutter tests, GRM/G_SCRIPTS, G/H/I reports
Evidence boundary: repository inspection, Git history, local Flutter tests/analyze/build, non-mutating PowerShell parse and changed-content sensitive scan; no live Android/provider action

## Diagnosis

- Branch check: active branch `grm-guarded-provisioning-20260727`.
- Remote ancestry: `ec96f93d71efd261adc2b3b75a17453130e437a0` is an ancestor of HEAD.
- Alternate local-equivalent commit `035352e58c8fb6bc887724f8f6f7607c8d455b93` is not present locally; no reconciliation action was needed because required remote ancestry is present.
- Initial worktree: clean.
- Current source composes one shared `NativeClosurePage` from `MarkeiApp`.
- Android package/activity source: `com.gusigu.markei`, `.MainActivity`.
- Git history: `301ea19` contains the legacy `Status`, `Query`, and `Refresh diagnostics` Closure controls. `ad1f228` is the verified Diagnostics consolidation boundary.
- Current repository search found no Android-specific Closure substitute, duplicate Closure page, flavor, alternate target, or conditional import replacing the shared page.

Controlling classification:

```text
ANDROID_PARITY_ROOT_CLASS=PROV_05
```

Reason: repository and tests prove the shared source surface, and history proves the screenshot labels match an older pre-consolidation page, but this Codex host did not directly inspect the installed Android package or live rendered target. The contradiction remains host-unvalidated until the human reruns the hardened Android procedure and compares visible provenance.

Evidence classes:

- repository-proven: one shared page, Android package identity, history correlation.
- test-validated: compact and wide Closure behavior, provenance rendering, old controls absent.
- human-observed: prior ST03 Android build/install/launch and screenshot only.
- inferred: screenshot likely came from stale/generated/installed artifact lineage.
- host-unvalidated: installed package identity and live Android rendered provenance.

## Changes

- Created `clients/markei_flutter/lib/app/build_provenance.dart` with public `MARKEI_BUILD_PROVENANCE` projection, 7-12 lowercase hex validation, and `unavailable` fallback.
- Updated `clients/markei_flutter/lib/app/pages/native_closure_page.dart` to render `nativeClosure.buildProvenance` and align the grouped lifecycle title.
- Updated `clients/markei_flutter/test/app/native_closure_surface_test.dart`.
- Updated `clients/markei_flutter/test/app/native_closure_diagnostics_test.dart` for compact Android dimensions, provenance safety, and absence of legacy controls.
- Updated `documentation/G_SCRIPTS.md` `GS-FLUTTER-AND` to resolve root/client, report branch/HEAD, reject dirty source overlap, pass `MARKEI_BUILD_PROVENANCE`, build one APK, report path/bytes/SHA-256, install `com.gusigu.markei` with data preservation, print non-secret package evidence, and stop for human verification.
- Updated `documentation/GRM.md` `GRM-FLUTTER-AND` description.

Files created:

- `clients/markei_flutter/lib/app/build_provenance.dart`

Files deleted:

- none

## Validation

- `dart format clients/markei_flutter/lib/app/build_provenance.dart clients/markei_flutter/lib/app/pages/native_closure_page.dart clients/markei_flutter/test/app/native_closure_surface_test.dart clients/markei_flutter/test/app/native_closure_diagnostics_test.dart`: PASS.
- `flutter test test/app/native_closure_surface_test.dart`: PASS.
- `flutter test test/app/native_closure_diagnostics_test.dart`: PASS after compact scroll-test correction.
- `flutter test test/infrastructure/native_auth_composition_test.dart`: PASS.
- `flutter test`: PASS, 199 passed / 4 lab-gated skips; existing Drift multi-database warnings observed.
- `flutter analyze`: PASS, no issues.
- `flutter build apk --debug --dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=true --dart-define=MARKEI_BUILD_PROVENANCE=db17f47`: PASS.
- Local generated APK: `clients/markei_flutter/build/app/outputs/flutter-apk/app-debug.apk`, 159516500 bytes, SHA-256 `86204EBCFDB60FF25D1985FA2EDA5FE17D61B8715925C18E6125CC3358B6CB51`.
- `git diff --check`: PASS with Git line-ending warnings only.
- `GS-FLUTTER-AND` PowerShell fenced body parse: PASS.
- Changed-content sensitive-pattern scan: PASS.

Skipped/unavailable:

- Live Android install/launch/retest: NOT RUN.
- Installed-package hash or runtime provenance comparison: NOT RUN.
- Auth0, Render, Neon, enrollment, Sync, Retry, recovery, logout, storage clear: NOT RUN.

## Terminals

```text
ST01=PASSED_PRIOR_HUMAN_SCOPE
ST02=PASSED_PRIOR_READ_ONLY_SCOPE
ST03=PASSED_HUMAN_OBSERVED_BUILD_LAUNCH_SCOPE
ST04=READY_FOR_HUMAN_RETEST
ANDROID_PARITY_ROOT_CLASS=PROV_05
SHARED_CLOSURE_PAGE=CONFIRMED
ANDROID_COMPACT_DIAGNOSTICS=TEST_PASS
BUILD_PROVENANCE=IMPLEMENTED
ANDROID_GRM_PROVENANCE=HARDENED
APPLICATION_DATA_PRESERVATION=PASS
LIVE_ANDROID_RETEST=NOT_RUN
AUTH_ENROLL_SYNC_PROVIDER_ACTION=ABSENT
GCM03_ST05_AND_LATER=HELD
```

Residual operator boundary: rerun `GRM-FLUTTER-AND` only after review/commit/publish, verify the visible `Build provenance #<short HEAD>` and consolidated Diagnostics surface on Android, and return that screenshot/evidence to Main. Do not Enroll, Sync, Retry, recover, clear storage, sign out, or mutate providers during ST04 retest.
