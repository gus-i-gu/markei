# I_DSN_CODEX - Cycle 07 Sprint 05 Design Codex Report

> Status: Android local vertical slice materialized over existing Flutter architecture
> Branch: `cycle-07-mobile-preparation`
> Source stage: `F_DSN_STAGE.md`
> Date: 2026-07-12

## Implemented Topology

```text
clients/markei_flutter/
├── android/
│   └── app/
│       ├── build.gradle.kts
│       └── src/main/
│           ├── AndroidManifest.xml
│           └── kotlin/com/gusigu/markei/MainActivity.kt
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── markei_app.dart
│   │   ├── markei_composition.dart
│   │   └── pages/purchase_page.dart
│   └── infrastructure/local/
│       └── local_device_identity_repository.dart
└── test/
    ├── app/markei_app_test.dart
    └── infrastructure/local_device_identity_repository_test.dart
```

The Sprint 04 architecture remains intact:

- widgets call application/repository ports;
- repositories own Drift interaction;
- domain models remain platform-independent;
- no Android/Kotlin code owns business identity or sequencing;
- no Python source is reused or modified.

## Android Platform Design

Android identity was made explicit and coherent:

- Gradle namespace: `com.gusigu.markei`
- Gradle applicationId: `com.gusigu.markei`
- manifest label: `Markei`
- Kotlin package: `com.gusigu.markei`
- compile SDK: 36
- target SDK: 36
- NDK remains `flutter.ndkVersion`, resolved by Flutter to `28.2.13676358`

This is debug/local Android enablement only. Production signing, store metadata, release build policy, and Play Store work remain out of scope.

## Device Identity Design

The previous composition-level placeholder:

```text
DeviceId('windows-device')
```

was removed from runtime composition.

New design:

```text
main()
  -> MarkeiComposition.appPrivate()
    -> LocalDatabase.appPrivate()
    -> LocalDeviceIdentityRepository.loadOrCreateDeviceId(local-account)
      -> local_accounts insert-or-ignore
      -> devices lookup for UUID v4 row
      -> create UUID v4 device row when absent
      -> return DeviceId to composition
```

The Device ID is app-private database state. It is not derived from hardware, emulator serial, Android ID, package name, account ID, or cloud identity.

## Schema Decision

No Drift schema version change was required in Sprint 05.

Reason:

- Existing schema v2 already has `devices(id, account_id, next_sequence, created_at)`.
- Existing sequence allocation already uses the `devices.next_sequence` ledger.
- F_DSN_STAGE explicitly preferred the smaller route when the existing schema can persist Device identity safely.

Historical facts are preserved. Historical non-UUID rows such as `windows-device` are not deleted, migrated destructively, or selected as the current app Device identity.

## Persistence And Sequence Behavior

Implemented tests verify:

- fresh database bootstraps one UUID v4 Device identity;
- file database close/reopen reuses the same Device identity;
- separate fresh databases receive distinct Device identities;
- after close/reopen, purchase registration continues sequence `1`, then `2` for the same Device;
- historical non-UUID rows remain present but are not reused.

Android runtime database inspection verified:

- app-private SQLite exists at `/data/data/com.gusigu.markei/files/markei_shared_beta.sqlite`;
- `devices` contains UUID v4 Device ID for `local-account`;
- `next_sequence` advanced to `2`;
- one purchase row exists after the manually confirmed Android registration workflow.

## UI And Composition Changes

UI changes were deliberately narrow:

- `MarkeiApp` wraps the active page stack in `SafeArea` for Android system inset behavior.
- Purchase page displays staged BRL total while items are staged.
- Existing Purchase/History navigation and repository boundaries remain unchanged.

The staged total supports mobile acceptance evidence without adding a broad redesign or full purchase UI expansion.

## Tests Added Or Updated

- `test/infrastructure/local_device_identity_repository_test.dart`
  - UUID v4 creation.
  - close/reopen reuse.
  - distinct fresh DB identities.
  - monotonic sequence after reopen.
  - historical non-UUID device preservation.
- `test/app/markei_app_test.dart`
  - retained multi-item Purchase/History workflow.
  - added phone-width Purchase/History workflow with staged totals.

## Dependencies

No new Dart package dependency was required.

Host tools installed/configured:

- Android command-line tools.
- Android SDK Platform 36.
- Android Build-Tools 36.0.0.
- Android Emulator.
- Android Platform-Tools.
- CMake 3.22.1.
- NDK 28.2.13676358.
- Google APIs x86_64 API 36 system image.
- Android Studio 2026.1.1.10.

## Validation Evidence

- `flutter doctor -v`: Android toolchain healthy; Chrome missing only.
- `flutter analyze`: passed.
- `flutter test`: passed, 27 tests.
- `flutter build apk --debug`: passed.
- `aapt dump badging`: package/label/activity/compile SDK verified.
- Emulator `Markei_Sprint05_API36`: booted.
- APK install and launch on emulator: passed.
- Android app-private database inspection: passed.
- Human manual Android purchase workflow: confirmed by user.
- `flutter build windows`: passed.
- `python -m unittest discover -s tests`: passed, 5 tests.

## Deviations And Host Limits

- Automated Android form entry through ADB was blocked by emulator OS input/stylus overlays and Gboard behavior. The app build, launch, database bootstrap, persistence, and manual workflow were still validated.
- `flutter build apk --debug` initially caused the Flutter/Gradle default path to install Android platform 35; the project was then pinned to compile/target SDK 36 and rebuilt successfully.
- `python -m pytest` was tried first and blocked because `pytest` is unavailable. The documented command was `python -m unittest discover -s tests`, and it passed.
- Chrome/web validation remains outside scope.

## Deferred By Scope

Physical device validation, production signing, release build, Play Store work, cloud synchronization, networking, authentication, Neon/Postgres, central catalogue identity, Product-code editing, legacy import, PySide6 retirement, broad UI redesign, and iOS validation remain deferred.

