# H_DDC_CODEX - Cycle 07 Sprint 05 Didactic Codex Report

> Status: Sprint 05 Android identity, device identity, and workflow evidence registered
> Branch: `cycle-07-mobile-preparation`
> Source stage: `E_DDC_STAGE.md`
> Date: 2026-07-12

## Concept Boundaries Preserved

Sprint 05 did not change the meaning of Product identity, Purchase aggregate, sync event envelope, JSON Schema fixtures, or analytics registry boundaries created in prior Sprint work. It materialized Android-local execution and replaced the temporary device placeholder at the app composition boundary.

The following distinctions were kept explicit in implementation and evidence:

- Flutter SDK: `H:\Users\Gus\develop\flutter`.
- Inspected but unmodified alternate Flutter SDK: `C:\Users\gusrm\flutter`.
- Android SDK: `C:\Users\gusrm\AppData\Local\Android\Sdk`.
- Android Studio: installed host IDE/tool distribution, not the Flutter SDK.
- VS Code: not used as the Android SDK or compiler.
- Android application ID: `com.gusigu.markei`.
- Android label: `Markei`.
- Local account ID: still `local-account`.
- Device ID: database-owned UUID v4, not `windows-device`, hardware ID, Android ID, account ID, package name, or emulator serial.

## Device Identity Evidence

Implemented `LocalDeviceIdentityRepository` in the Flutter client local persistence boundary.

Behavior demonstrated by tests:

- Fresh database creates a UUID v4 Device ID.
- Device ID is not the old `windows-device` placeholder.
- Close/reopen of the same file database reuses the same Device ID.
- Two fresh databases receive different Device IDs.
- Purchase registration after close/reopen continues the same device sequence.
- Historical non-UUID Device rows are preserved but not selected as the current app Device identity.

Android runtime evidence:

```text
devices [('a1b5ce87-41d8-4dd1-9ddb-28dac01836d4', 'local-account', 2)]
accounts [('local-account', 'BRL')]
purchases 1
```

This shows a UUID v4 device row in the emulator app-private Drift database and a sequence advanced by registration evidence.

## Android Identity Evidence

APK badging showed:

- package name: `com.gusigu.markei`
- application label: `Markei`
- launchable activity: `com.gusigu.markei.MainActivity`
- compile SDK version: 36

The Kotlin package/path and Gradle namespace/applicationId were updated together so Android identity is coherent across source and built APK.

## Workflow Evidence

Automated Flutter widget evidence:

- Multi-item purchase registration still passes.
- History projection still displays store, item count, and BRL total.
- Added phone-width workflow test for staged total and history behavior.
- Total Flutter tests increased to 27 passing tests.

Android runtime/manual evidence:

- Emulator booted and Markei launched.
- User manually confirmed purchase upsert/registration works on the emulator.
- App-private database inspection showed persisted purchase count and device sequence advancement.

The Android manual confirmation is classified as runtime workflow evidence, distinct from widget tests.

## Similarity And Product Concepts

No new automatic Product merge behavior was added. Prior semantics remain:

- Product similarity checks warn only.
- Similarity does not merge Product identities.
- Product code, internal Product ID, semantic identity key, display facts, and normalized facts remain separate concepts.

Sprint 05 touched Android/device bootstrap and mobile workflow readiness, not catalogue semantics.

## Validation Evidence

- `dart format --output=none --set-exit-if-changed .`: passed after formatting.
- `flutter analyze`: passed with no issues.
- `flutter test`: passed, 27 tests.
- `flutter build apk --debug`: passed.
- Android emulator launch/install: passed.
- Android app-private database inspection: passed.
- Human manual Android purchase workflow: confirmed by user.
- `flutter build windows`: passed.
- `python -m unittest discover -s tests`: passed, 5 tests.

## Evidence Classification

- Implemented and tested: database-owned UUID v4 Device identity, close/reopen reuse, monotonic sequence, historical placeholder preservation, phone-width Purchase/History widget workflow.
- Implemented and host-validated: Android SDK/AVD setup, debug APK build, APK identity, emulator launch, app-private database persistence, Windows build.
- Human-confirmed: Android purchase registration/upsert workflow.
- Host-limited: automated Android text-entry workflow due emulator OS input/stylus overlays.
- Deferred: physical device, production signing, Android release, iOS runtime, cloud sync, auth, server work.

## No Maturity Change

No permanent didactic maturity update is authorized or implied by this report.

