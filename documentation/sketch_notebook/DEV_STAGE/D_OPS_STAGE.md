# D_OPS_STAGE.md — Cycle 07 Sprint 05 Android Materialization

> Status: Main-approved temporary implementation directive  
> Authority: Main Chat [M]  
> Branch: `cycle-07-mobile-preparation`  
> Reconciliation: J §23  
> Inputs: Sprint 05 A/B/C, 00/05/06, repository truth, human Windows evidence  
> Scope: Android debug parity and bounded shared-client correction

---

# 1. Outcome

Materialize and validate Markei as an Android debug application while preserving the validated Flutter Windows workflow and protected Python/PySide6 beta.

Success is runtime evidence, not generated files:

```text
one Flutter SDK
+ Android doctor ready
+ one Android runtime online
+ stable application ID
+ persistent installation UUID
+ debug APK
+ Android Purchase/History
+ lifecycle and persistence evidence
+ Windows/Python regressions
+ G/H/I
```

# 2. Fixed Main decisions

- selected Flutter SDK: `H:\Users\Gus\develop\flutter`;
- do not delete or mutate `C:\Users\gusrm\flutter`;
- Android namespace/application ID: `com.gusigu.markei`;
- display label: `Markei`;
- primary runtime: emulator; physical device is fallback;
- Device identity: database-owned persisted UUID v4;
- Account remains `local-account`;
- debug signing only;
- UI changes limited to Android workflow blockers;
- production release, cloud, synchronization, authentication, and broad redesign are deferred.

# 3. Authorized writes

Codex may modify only:

- `clients/markei_flutter/android/**` except secrets, production keystores, and host-local `local.properties` in commits;
- `clients/markei_flutter/lib/**`;
- `clients/markei_flutter/test/**`;
- `clients/markei_flutter/pubspec.yaml` and lockfile only if a dependency is strictly required and justified;
- generated Dart outputs corresponding to authorized schema changes;
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`;
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`;
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`.

Codex may run formatting and generators that update only their owned generated files. Do not modify Python source, Cycle 06 databases, contracts unrelated to Device bootstrap, permanent documentation, J, 00, 05, 06, A/B/C, D/E/F, or methodology.

# 4. Host-mutation authority

After preflight, Codex may guide or invoke installation of:

- current stable Android Studio compatible with Flutter 3.44.6;
- Android SDK Platform 36;
- Build-Tools;
- Command-line Tools latest;
- Emulator;
- Platform-Tools;
- CMake;
- NDK side-by-side matching `flutter.ndkVersion`;
- one compatible x64 emulator system image.

Human must confirm GUI choices, UAC prompts, licence text, install locations, virtualization changes, physical-device debugging, and any reboot. Do not automate acceptance of licences without the human present. Do not install preview/canary channels, global package managers, production signing tools, or unrelated workloads.

# 5. Preflight and stop gate

From repository root, capture without mutation:

```powershell
git status --short --branch
git branch --show-current
git rev-parse HEAD
git rev-parse origin/cycle-07-mobile-preparation
where.exe flutter
Get-Command flutter -All | Format-List Source,Version
flutter --version
dart --version
flutter doctor -v
$env:Path -split ';' | Where-Object { $_ -match 'flutter|dart|android' }
Test-Path "H:\Users\Gus\develop\flutter"
Test-Path "C:\Users\gusrm\flutter"
```

Requirements:

- clean or fully understood worktree;
- correct branch;
- H: resolves first;
- Flutter 3.44.6/Dart 3.12.2;
- existing C: clone remains untouched;
- sufficient disk;
- no unreviewed personal/device data in logs.

If VS Code, shell, doctor, or `android/local.properties` disagree, update user/editor configuration and regenerate host-local properties so all use H:. Do not commit `local.properties`. Stop if convergence cannot be demonstrated.

# 6. Android installation gate

Before installation, record existing Android Studio, SDK, Java, adb, emulator, virtualization, and environment-variable state. Prefer Android Studio Setup Wizard/SDK Manager.

After installation, with human confirmation:

```powershell
flutter doctor --android-licenses
flutter doctor -v
flutter emulators
flutter devices
adb devices -l
```

Pass only when Android toolchain is doctor-ready and one intended runtime is online. Sanitize serial numbers in reports. Do not root, unlock, bypass security, request broad storage, or inspect personal device contents.

# 7. Source Unit A — stable Android identity

Replace `com.example.markei` consistently in:

- Gradle namespace;
- Gradle application ID;
- Kotlin package declaration/path;
- tests/configuration that directly reference the placeholder.

Set label to `Markei`. Preserve Flutter embedding v2. Do not add product logic to Kotlin. Do not introduce release keystore material.

Validate with repository search showing no active `com.example.markei` reference.

# 8. Source Unit B — persistent Device UUID

Remove `windows-device` from shared production composition.

Implement one local identity boundary that:

1. opens the app-private Drift database;
2. loads the persisted Device record;
3. creates UUID v4 only when absent;
4. stores it transactionally;
5. reuses it before sequence allocation;
6. survives process restart;
7. yields distinct UUIDs for distinct fresh databases.

Keep Device identity coupled to its sequence state. Do not use hardware identifiers, email, Product data, path, platform name, timestamp alone, preferences, or secure storage. Do not change `local-account`.

If schema changes, increment schema version, provide an additive migration, preserve all Purchase/Product/History facts, regenerate owned code, and add migration/reopen tests. Never reset the database as migration.

# 9. Source Unit C — bounded mobile behavior

Run the existing shared Dart entrypoint on Android. Correct only demonstrated blockers involving:

- narrow-screen overflow/scrolling;
- keyboard obstruction and input actions;
- focus/validation visibility;
- bottom navigation and Android Back;
- safe areas;
- portrait/landscape rebuild;
- readable text scale/tap targets;
- background/resume;
- committed-data recovery after process restart.

Unsaved staged Items may reset on rotation only if deterministic and visible. They must never partially commit. Do not add a new state-management/navigation framework or redesign the interface.

# 10. Controlled validation data

Use non-personal test data:

```text
Store: Sprint 05 Test Store
Product 1: Test Rice / Markei Test / 1 KG
Product 2: Test Milk / Markei Test / 1 L
Currency: BRL
```

Register one two-item Purchase, verify calculated total and History, then background/resume, use Back, open/close keyboard, rotate, terminate process without clearing data, relaunch, verify facts, register a second Purchase, and verify Device UUID stability plus monotonic sequence.

Do not uninstall or clear app data during the persistence pass.

# 11. Build and automated evidence

From `clients\markei_flutter`:

```powershell
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
flutter run -d <device-id>
```

Then regress:

```powershell
flutter build windows
cd ..\..
python -m unittest discover -s tests
```

Use the repository’s actual Python test command if inspection proves it differs; report the correction. Record exact exit codes, versions, device class, APK path/size, changed files, and human versus automated evidence.

# 12. Required tests

At minimum add/retain tests proving:

- fresh database creates a valid UUID v4;
- reopen reuses the same UUID;
- two fresh databases receive different UUIDs;
- sequence remains monotonic for the persisted Device;
- migration preserves existing facts and gives them a stable Device owner if needed;
- Purchase aggregate remains atomic;
- History derives from committed facts;
- narrow widget layout has no blocking overflow at the chosen phone width;
- existing Flutter test suite remains green.

Do not claim emulator/device lifecycle from widget tests.

# 13. Failure and rollback

Stop on:

- unresolved Flutter SDK identity;
- destructive tool replacement;
- licence/UAC action without human confirmation;
- no runtime online;
- application ID unresolved;
- Device UUID changes after ordinary relaunch;
- duplicate/reused sequence;
- silent database reset or lost facts;
- broad storage permission;
- Cycle 06 path access;
- unrelated dependency/framework expansion;
- Windows or Python regression not explainable within scope.

Preserve logs and data. Revert only Sprint 05 source changes through an intentional later patch; never delete evidence or user databases.

# 14. Required reports

Replace G/H/I.

G: host/tool versions, installations, licences, SDK convergence, commands, build/run/device/lifecycle/persistence evidence, paths without private data, regressions, failures, changed files.

H: evidence ladder, application/device/account/Product/event identity distinctions, Android concepts exercised, responsive/lifecycle evidence, learner limits, no automatic maturity change.

I: final topology, application ID, Device bootstrap ownership, schema/migration, platform-host boundary, responsive deviations, dependency direction, reversibility, deferred cloud/UI work.

# 15. Publication

After implementation and validation:

```powershell
git status --short
git diff --stat
git diff --name-only
```

Commit only authorized source/tests/generated outputs and G/H/I to `cycle-07-mobile-preparation`. Pull/rebase safely if remote advanced; never force-push. Report commit SHA and clean status.
