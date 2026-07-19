# G_OPS_CODEX - Windows Native Authentication Callback Evidence

- Authority marker: C10-MCG02-WINDOWS-AUTH-CALLBACK_20260719T011836Z
- Baseline SHA after fast-forward: fc4af17c766f39715fe909b9fbda587e1bb7b881
- Required ancestor retained: 65ae6a7dac349db0512d604c940d01a6f500d1a4
- Final commit SHA: reported by Codex terminal response after commit publication.
- Evidence environment: Windows host, Flutter/Dart local toolchain, Auth0 Flutter 2.4.0 pinned.
- Result classification: local Windows callback handoff and credential diagnostic correction ready for provider retest.

## Changed Paths

- `clients/markei_flutter/windows/runner/main.cpp`
- `clients/markei_flutter/lib/infrastructure/auth/auth0_native_authentication.dart`
- `clients/markei_flutter/lib/app/native_auth_closure_runner.dart`
- `clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart`
- `clients/markei_flutter/test/infrastructure/windows_runner_callback_contract_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved without reading or staging:

- `Enter only the POOLED Neon hostname`
- `clients/markei_flutter/Exact Auth0 API audience`
- `clients/markei_flutter/Windows Native Application Client ID`

## Commands and Results

- `git fetch origin intermid-cycle-recovery`: passed.
- `git pull --ff-only origin intermid-cycle-recovery`: fast-forwarded to `fc4af17c766f39715fe909b9fbda587e1bb7b881`.
- `git merge-base --is-ancestor 65ae6a7dac349db0512d604c940d01a6f500d1a4 HEAD`: passed.
- `dart format --set-exit-if-changed lib test windows/runner/main.cpp`: failed because Dart formatter cannot parse C++; two Dart files were formatted before failure.
- `dart format --set-exit-if-changed lib test`: passed, 81 files checked, 0 changed.
- `flutter test test/infrastructure/native_auth_composition_test.dart`: passed, 17 tests.
- `flutter test test/infrastructure/windows_runner_callback_contract_test.dart`: passed, 4 tests.
- `flutter test test/app/native_closure_surface_test.dart`: passed, 2 tests.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed, 86 tests and 2 existing skips.
- `flutter build windows --release`: passed, built `build\windows\x64\runner\Release\markei.exe`; retained existing Boost/CMake policy warning.
- `flutter build apk --debug`: passed, built `build\app\outputs\flutter-apk\app-debug.apk`; retained existing KGP plugin warning for `auth0_flutter`.
- `git diff --check`: passed.

One initial parallel focused Flutter run produced a startup-lock/read-only cleanup failure for
`native_auth_composition_test.dart`; the test passed when rerun serially.

## Evidence

- Runner now uses the Auth0 Flutter 2.4.0 `plugin_startup_url_lock.h` write lock when changing
  `PLUGIN_STARTUP_URL`, matching the pinned SDK's polling lock contract.
- Runner keeps exact `auth0flutter://callback` prefix validation, current-user SID pipe security,
  bounded 2048 wchar pipe reads and no callback logging.
- Closed diagnostics now distinguish callback, code-exchange, missing-token, expired-token,
  confused-token, provider-unavailable and unknown rejection outcomes.
- `authenticated` is returned only after SDK credentials contain non-empty, distinct and unexpired
  access and ID tokens.
- Closure UI now surfaces exact neutral authentication states instead of collapsing all rejections
  into `authentication-rejected`.

## Exclusions

No Auth0, Neon, Render, provider credential, registry, Device enrollment, hosted synchronization,
migration, Drift schema, server authorization, dependency upgrade, installer, permanent memory,
methodology, MCG-03 or MCG-04 operation was performed.

Human evidence retained: Windows release build, protocol dispatch, Auth0 signup/email
verification/login and provider configuration are accepted; native credential acceptance still
requires provider retest after this correction.
