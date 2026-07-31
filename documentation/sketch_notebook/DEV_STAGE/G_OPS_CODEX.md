# G_OPS_CODEX — C11-PH01-S01 Operational Evidence

## Classification

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S01
STAGING_BASELINE=1e4cd0aa8e6f0eabd856decfadba21f67d04426c
VISUAL_FOUNDATION=IMPLEMENTED
STABLE_DESTINATION_IDENTITY=PASS
COMPACT_MEDIUM_WIDE_SHELL=PASS
HOME_RECOMPOSITION=PASS
LISTS_RECOMPOSITION=PASS
ANALYTICS_RESERVATION=PASS
SETTINGS_PRESERVED=PASS
AUDIT_RESERVATION=PASS
CLOSURE_BEHAVIOR_CHANGED=NO
BUSINESS_OR_SYNC_SOURCE_CHANGED=NO
FOCUSED_TESTS=PASS
FLUTTER_TEST=PASS
FLUTTER_ANALYZE=PASS
WINDOWS_BUILD=PASS
ANDROID_BUILD=PASS
HUMAN_WINDOWS_ACCEPTANCE=NOT_PERFORMED
HUMAN_ANDROID_ACCEPTANCE=NOT_PERFORMED
PROVIDER_MUTATION=NONE
NEXT_MAIN_ACTION=human Windows and Android visual acceptance for C11-PH01-S01
```

## Changed Paths

Implementation:

- `clients/markei_flutter/lib/application/home_content.dart`
- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/design/markei_theme.dart`
- `clients/markei_flutter/lib/app/navigation/markei_destination.dart`
- `clients/markei_flutter/lib/app/widgets/markei_components.dart`
- `clients/markei_flutter/lib/app/widgets/markei_shell.dart`
- `clients/markei_flutter/lib/app/pages/home_page.dart`
- `clients/markei_flutter/lib/app/pages/lists_page.dart`

Tests:

- `clients/markei_flutter/test/app/markei_visual_foundation_test.dart`
- `clients/markei_flutter/test/app/lists_page_test.dart`

Reports:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No files were deleted. No generated source, pubspec, lockfile, schema, platform manifest, provider, Sync, diagnostics, recovery, Purchase, Catalogue, History, Settings or Closure implementation file was changed.

## Operational Mapping

- Characterized and guarded current shell behavior with tests for compact More, boundary resizing, Closure gate insertion and existing destination reachability.
- Replaced selected array index state with stable `MarkeiDestinationId` state.
- Added compact `<600`, medium `600-1023`, wide `>=1024` shell policies.
- Kept compact direct destinations as Home, Lists, Purchase, History and More.
- Preserved `IndexedStack` retained page state.
- Kept Settings page and Native Closure page implementations unchanged.
- Preserved `ProductListProjectionRepository.productListProjection` as the only Lists projection read.
- Added read-only Lists Retry that only repeats the Lists projection request.

## Commands And Results

- `git fetch origin grm-guarded-provisioning-20260727`: pass.
- `git rev-parse HEAD`: `1e4cd0aa8e6f0eabd856decfadba21f67d04426c`.
- `git rev-parse origin/grm-guarded-provisioning-20260727`: `1e4cd0aa8e6f0eabd856decfadba21f67d04426c`.
- `git rev-list --count 4b1abc01a93351f5910ea8af5001782b59a784f7..1e4cd0aa8e6f0eabd856decfadba21f67d04426c`: `1`.
- `git merge-base --is-ancestor 861c27fdaf6ade2093d481af312d27ff895b8dc0 1e4cd0aa8e6f0eabd856decfadba21f67d04426c`: pass.
- `git diff-tree --no-commit-id --name-only -r 1e4cd0aa8e6f0eabd856decfadba21f67d04426c`: exactly the five staging files named by the prompt.
- `git rev-list --left-right --count HEAD...origin/grm-guarded-provisioning-20260727`: `0 0`.
- `flutter pub get`: pass; dependencies resolved, no dependency changes.
- `dart format --output=none --set-exit-if-changed lib test`: pass, `Formatted 102 files (0 changed)`.
- `flutter analyze`: pass, `No issues found!`.
- `flutter test test/app/markei_visual_foundation_test.dart test/app/lists_page_test.dart`: pass, `All tests passed!`.
- `flutter test test/app/markei_app_test.dart`: pass, `All tests passed!` with 26 tests.
- `flutter test`: pass, `All tests passed!` with 245 passing and 4 skipped tests. The suite printed existing local Sync diagnostic/unit-test logs; no preserved client, live provider workflow or manual Sync action was executed by Codex.
- `flutter build windows --release`: pass; built `build\windows\x64\runner\Release\markei.exe`. CMake emitted existing Boost policy warning.
- `flutter build apk --debug`: pass; built `build\app\outputs\flutter-apk\app-debug.apk`. Flutter emitted existing Auth0 Kotlin Gradle Plugin future-warning.
- `git diff --check`: pass; only Git LF-to-CRLF working-copy warnings were printed.
- `git diff --name-status` plus `git ls-files --others --exclude-standard`: changed paths match D-authorized source/test/report scope.

During validation, one timed-out Flutter widget-test run left Dart/flutter_tester processes holding `build/native_assets/windows/sqlite3.dll`. Codex stopped only those stale validation-tool PIDs before rerunning tests. No preserved client process was launched or terminated.

## Built Artifacts

- Windows Release executable: `clients/markei_flutter/build/windows/x64/runner/Release/markei.exe`
  - Size: `97792` bytes
  - SHA-256: `23C0A337594ECC51437FD6F950F1F8BEC04C40DE7737130DFBFB5EF62EAA3523`
- Android Debug APK: `clients/markei_flutter/build/app/outputs/flutter-apk/app-debug.apk`
  - Size: `179239697` bytes
  - SHA-256: `B55E0FB4AAB70F5C08AC2E4826D7930AC79204B5F9B7F1BA45C3AD897F604983`

## Skipped Or Not Performed

- No golden images were added or rebaselined.
- No Windows or Android human acceptance was performed.
- No preserved-client installation or launch was performed.
- No live provider mutation, credential inspection, database repair/reset/cleanup, Enroll, Query, Recovery or human acceptance action was performed.

## Operational Risks

- Visual parity with PNG references remains human-review evidence, not Codex-claimed pixel parity.
- Full `flutter test` includes existing local Sync test files and diagnostic output because D required the command; this is not promoted to live Sync success.
- Real Windows Narrator, Android TalkBack, device density and preserved-data acceptance remain human evidence.
