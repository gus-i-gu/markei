# G_OPS_CODEX - C10-GCM03-S09-R06

Sequence: FLX-ORD-01
Role: Codex operational evidence
Round or unit: C10-GCM03-S09-R06
Branch: grm-guarded-provisioning-20260727
Baseline / inspected HEAD: 832c433896d9ba425e14891d9cbed9b58dcd8057
Authority: D_OPS_STAGE.md, E_DDC_STAGE.md, F_DSN_STAGE.md
Writable surfaces: D-approved source, procedure, focused test, helper, and G/H/I report paths only
Evidence boundary: shared source identity, Closure presentation, focused tests, host builds, artifact hashes

## Files Changed

- clients/markei_flutter/lib/app/build_provenance.dart
- clients/markei_flutter/lib/main.dart
- clients/markei_flutter/lib/app/markei_app.dart
- clients/markei_flutter/lib/app/pages/native_closure_page.dart
- clients/markei_flutter/tool/resolve_markei_source_identity.ps1
- clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
- clients/markei_flutter/test/app/native_closure_surface_test.dart
- documentation/G_SCRIPTS.md
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

## Implementation Mapping

- Full revision and tree digest validation now live in one immutable `BuildProvenance` value.
- `main.dart` resolves `BuildProvenance.current` after binding initialization and before `runApp`.
- `MarkeiApp` carries that immutable value through shared composition.
- `NativeClosurePage` renders only the supplied value and no longer resolves identity on page load.
- `resolve_markei_source_identity.ps1` owns Git HEAD/tree resolution, relevant dirty-tree refusal, and the domain-separated SHA-256 algorithm.
- `GS-FLUTTER-WIN`, `GS-FLUTTER-DBW`, and `GS-FLUTTER-AND` consume the helper and inject `MARKEI_SOURCE_REVISION` plus `MARKEI_SOURCE_TREE_SHA256`.

## Commands Run

- `git fetch origin grm-guarded-provisioning-20260727` -> passed.
- `git rev-parse HEAD` -> `832c433896d9ba425e14891d9cbed9b58dcd8057`.
- `git status --short` -> clean before implementation.
- Methodology boot and D/E/F reads -> completed.
- `dart format ...` -> formatted changed Dart files.
- `flutter analyze` from `clients/markei_flutter` -> passed, no issues.
- `flutter test test\app\native_closure_surface_test.dart` -> passed, 3 tests.
- `flutter test test\app\markei_app_test.dart` -> passed, 26 tests.
- `flutter test test\app\native_closure_diagnostics_test.dart` -> first run timed out at 124s; rerun with longer timeout passed, 40 tests.
- Source identity calculation for build defines -> revision `832c433896d9ba425e14891d9cbed9b58dcd8057`, tree `d62ea525584bdafa82aaee1b403c29e9e69d009d`, source-tree SHA-256 `73cd614674b574bd23d989f15c3105adaa241ef5e503e6f854048d51b26b4084`.
- `flutter build apk --debug --dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=true --dart-define=MARKEI_SOURCE_REVISION=832c433896d9ba425e14891d9cbed9b58dcd8057 --dart-define=MARKEI_SOURCE_TREE_SHA256=73cd614674b574bd23d989f15c3105adaa241ef5e503e6f854048d51b26b4084` -> passed.
- `flutter build windows --release ...same R06 identity...` -> first run failed because existing `markei.exe` process locked the Release artifact.
- `Get-Process -Name markei -ErrorAction SilentlyContinue | Select-Object Id,ProcessName,Path` -> found PID 14548 at the local Release build path.
- `Stop-Process -Id 14548` -> stopped the blocking local build process; no install or launch performed.
- `flutter build windows --release --dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=true --dart-define=MARKEI_SOURCE_REVISION=832c433896d9ba425e14891d9cbed9b58dcd8057 --dart-define=MARKEI_SOURCE_TREE_SHA256=73cd614674b574bd23d989f15c3105adaa241ef5e503e6f854048d51b26b4084` -> passed with existing CMake Boost policy warning.
- `git diff --check` -> passed; line-ending warnings only.
- Changed-path inspection -> only D-authorized implementation, procedure, helper, focused test, and G/H/I report paths changed.

## Artifacts Built

- Windows Release executable:
  - Path: `H:\Users\Gus\source\repo\markei-mobile\clients\markei_flutter\build\windows\x64\runner\Release\markei.exe`
  - Bytes: `97792`
  - SHA-256: `d348ec4e6b0ccca3d235a3f953d7ee9414f44d8f7c3f88492e84d2949f7c7c3e`
- Android Debug APK:
  - Path: `H:\Users\Gus\source\repo\markei-mobile\clients\markei_flutter\build\app\outputs\flutter-apk\app-debug.apk`
  - Bytes: `179200937`
  - SHA-256: `0387852b35af60663dc27b5b9da42c4106584bcf7b3136c39349609da3b173b9`

## Skipped / Not Performed

- No complete GRIMOIRE, SQLite, Neon, Render, Auth0, hosted-provider, or preserved-state suite was run.
- No install or launch against preserved Windows or Android clients was performed by Codex.
- No live Sync, Retry, Recovery, Query, Enroll, new Purchase, provider mutation, database repair/reset/clear, or preserved-state action was performed.

## Unresolved Risks

- Codex host builds prove local package materialization only; final preserved-client visible identity remains a human check.
- Final commit creation changes the repository HEAD/tree after pre-commit artifact builds; the final human procedure must rebuild from the exact pushed commit and compare visible source fields.
- `GS-FLUTTER-DBA` still contains the older Android VS Code debug provenance field; D did not authorize changing that separate procedure in R06.

## Terminals

C10_GCM03_S09_R06=IMPLEMENTED_VALIDATED
COMMON_BOOT_IDENTITY=PASS
FULL_SOURCE_REVISION_VALIDATION=PASS
COMMON_SOURCE_TREE_SHA256=PASS
ANDROID_IDENTITY_INJECTION=PASS
WINDOWS_RELEASE_IDENTITY_INJECTION=PASS
WINDOWS_DEBUG_IDENTITY_INJECTION=PASS
CLOSURE_COMMON_PRESENTATION=PASS
WINDOWS_ARTIFACT_SHA256_REPORT=PASS
ANDROID_ARTIFACT_SHA256_REPORT=PASS
SYNC_SOURCE_CHANGED=NO
PRESERVED_CLIENT_STATE_TOUCHED=NO
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
NEXT_HUMAN_CHECK=TWO_PLATFORM_VISIBLE_IDENTITY_ONLY
