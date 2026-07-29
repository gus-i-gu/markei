# D_OPS_STAGE — Android target selection and sign-in regression diagnosis

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Operational materialization stage
> Unit: `C10-GCM03-ST04-R1-C2`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry:
> `1af1d887e4fe8370ab988a80e4af16eafcd4699c`
> Authority: **ACTIVE — DIAGNOSTIC AND BOUNDED FIX AUTHORIZED**
> Evidence boundary: repository/history inspection, PowerShell fixture tests,
> Flutter tests and static validation; no live authentication, enrollment,
> Query, Sync, Retry, recovery, provider mutation, deployment, commit or push

## 1. Reconciled starting state

The published `C10-GCM03-ST04-R1-C1` correction remains accepted for:

```text
procedure-local branch/HEAD/provenance producers
one shared NativeClosurePage
compact/wide Closure tests
public build-provenance projection
Flutter local validation
absence of protocol, persistence, schema and provider expansion
```

The first human Windows rerun at published HEAD `1af1d88` reached Android AVD
startup and then stopped:

```text
Starting configured Android AVD: DEV-GRM
adb.exe: unknown command windows
```

The invocation stopped before:

```text
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build apk
adb install
application launch
Markei Sign in
```

Therefore this invocation proves a launcher/device-selection failure. It does
not prove an Android Auth0 failure and could not have replaced the installed
application.

Current gates:

```text
ANDROID_GRM_PROVENANCE_INITIALIZATION=CORRECTED
ANDROID_TARGET_SELECTION=CONTRADICTED_ON_WINDOWS_POWERSHELL_5_1
ANDROID_SIGN_IN_REGRESSION=HUMAN_OBSERVED_UNCLASSIFIED
ST04=BLOCKED
ST05_AND_LATER=HELD
```

The preserved Windows `purchase.registered` sequence-2 event remains pending.

## 2. Controlling launcher diagnosis

Inspect and verify this candidate cause against Windows PowerShell 5.1
semantics:

```powershell
$FlutterDevices = @($FlutterDevicesJson | ConvertFrom-Json)
```

Flutter returns a top-level JSON array. Windows PowerShell 5.1 may preserve
that result as one nested array element. `Where-Object` can then evaluate
member-enumerated aggregate properties:

```text
targetPlatform -> windows-x64, web-javascript, android-*
isSupported    -> true, true, true
id             -> windows, edge, emulator-*
```

The aggregate passes because it contains an Android member. The later `.id`
read yields multiple IDs, which native argument expansion passes to:

```powershell
adb -s <ids...> shell getprop sys.boot_completed
```

ADB consequently encounters `windows` as a command/argument and stops.

Classify the launcher cause as:

```text
DEVSEL-01=POWERSHELL_5_1_TOP_LEVEL_JSON_ARRAY_NESTING
```

only after a focused fixture reproduces the aggregate selection. Otherwise
record the exact alternative cause before changing code.

## 3. Required launcher correction

Modify `GS-FLUTTER-AND` in `documentation/G_SCRIPTS.md` narrowly.

Required behavior:

1. Parse Flutter's JSON once.
2. Enumerate every top-level device object before filtering.
3. Select objects individually only when:

   ```text
   targetPlatform starts with android
   isSupported is exactly true
   id is one non-empty scalar string
   ```

4. Keep the caller-side array capture so zero/one/multiple supported Android
   targets remain distinguishable.
5. Before any `adb -s` call, prove the selected ID is exactly one scalar and
   occurs as an exact serial in `adb devices`.
6. Reject aggregate IDs, `windows`, web targets, whitespace/control-bearing
   IDs, missing IDs and ambiguous ADB inventories.
7. Use one explicit native argument array/splat for each ADB command.
8. Preserve the existing rules:

   ```text
   zero Android targets -> start only configured AVD
   one Android target   -> select it
   multiple targets     -> stop without guessing
   preserve application data
   package              -> com.gusigu.markei
   ```

Do not solve this with a hard-coded `emulator-####` serial. The AVD name is
stable; the ADB serial is transient.

Add a non-mutating PowerShell contract harness or equivalent testable fixture
that covers:

- Windows + Edge + one Android emulator;
- one Android physical target;
- no Android target;
- two Android targets;
- malformed JSON;
- supported false;
- missing/empty/non-scalar ID;
- exact ADB serial match and mismatch.

The mixed Windows/Edge/Android fixture must return only the Android object and
must never pass `windows` or `edge` to ADB.

## 4. Complete sign-in investigation

The user separately reports that recent changes make the Android app fail or
misbehave when trying to sign in. Treat this as:

```text
AUTHAND-00=HUMAN_OBSERVED_UNCLASSIFIED
```

Do not infer its cause from the launcher terminal.

### 4.1 History and changed-path proof

Inspect the complete relevant ranges:

```text
db17f47..231a762
231a762..1af1d88
```

Confirm which Auth0, Android, Flutter, GRM and build-input files changed.
Current Main evidence indicates:

- `231a762` changed build provenance, Closure presentation/tests and
  `G_SCRIPTS.md`;
- `1af1d88` changed GRIMOIRE/reconciliation surfaces;
- neither commit changed the Auth0 implementation, Android Gradle file,
  Android manifest, application ID or Flutter Auth0 dependency.

Report contradiction if repository inspection differs.

### 4.2 Static end-to-end contract scan

Trace:

```text
NS_COORDINATES public keys
→ GS-FLUTTER-AND coordinate loading
→ MARKEI_AUTH0_* Dart defines
→ ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN
→ build.gradle.kts manifest placeholders
→ merged Android callback scheme/domain
→ package com.gusigu.markei
→ NativeAuthConfiguration
→ Auth0 native client selection
→ Sign in action
→ sanitized terminal/error mapping
```

Inspect at minimum:

```text
documentation/GRM.md
documentation/G_SCRIPTS.md
documentation/I_SCRIPTS.ps1
documentation/NS_COORDINATES.md
clients/markei_flutter/pubspec.yaml
clients/markei_flutter/android/app/build.gradle.kts
clients/markei_flutter/android/app/src/main/AndroidManifest.xml
clients/markei_flutter/lib/infrastructure/auth/native_auth_config.dart
clients/markei_flutter/lib/infrastructure/auth/auth0_native_authentication.dart
clients/markei_flutter/lib/app/markei_composition.dart
clients/markei_flutter/lib/app/pages/native_closure_page.dart
clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
```

Also inspect generated/merged-manifest evidence when it can be produced
locally without provider access. Never print coordinate values.

### 4.3 Required classification

Classify the sign-in observation as exactly one:

```text
AUTHAND-01 public build-input propagation defect
AUTHAND-02 package/callback/manifest identity defect
AUTHAND-03 Android Auth0 composition or error-mapping defect
AUTHAND-04 stale or wrong installed artifact/provenance
AUTHAND-05 provider/dashboard mismatch requiring human verification
AUTHAND-06 insufficient runtime symptom/evidence
```

Repository inspection and tests may exclude causes but must not fabricate a
runtime failure. If no static/test-backed defect is proved, do not change Auth0
source. End at `AUTHAND-05` or `AUTHAND-06` with an exact sanitized human
retest packet.

If a specific static/test failure proves `AUTHAND-01`, `02` or `03`, apply the
smallest correction and add a regression test. Do not alter provider
configuration.

## 5. Validation

Run and report:

```text
exact GS-FLUTTER-AND fence extraction
Windows PowerShell 5.1 AST parse when available
PowerShell mixed-device fixture
PowerShell zero/one/multiple/malformed/invalid-ID fixtures
ADB argument capture proving one scalar -s value
Flutter focused native-auth and Closure tests
Flutter full test suite
Flutter analyze
Android debug APK build with reviewed non-secret placeholder defines
generated/merged Android manifest contract inspection
git diff --check
changed-content sensitive-pattern scan
```

Codex must not launch the app or perform live Sign in merely to satisfy
validation. If the host lacks Windows PowerShell 5.1, Android SDK or Gradle
capability, report the exact check as host-unvalidated.

## 6. Writable scope

Always writable:

```text
documentation/G_SCRIPTS.md
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Conditionally writable only for a proved `AUTHAND-01`, `02` or `03`:

```text
clients/markei_flutter/android/app/build.gradle.kts
clients/markei_flutter/android/app/src/main/AndroidManifest.xml
clients/markei_flutter/lib/infrastructure/auth/native_auth_config.dart
clients/markei_flutter/lib/infrastructure/auth/auth0_native_authentication.dart
clients/markei_flutter/lib/app/markei_composition.dart
relevant focused Flutter tests
documentation/GRM.md
```

Stop for Main restaging if the fix requires any other source surface or changes
the provider/public coordinate model.

## 7. Prohibited scope

Do not:

- disclose Auth0 values, tokens, subjects, Device IDs or hosted URLs;
- change `NS_COORDINATES.md` values;
- mutate Auth0, Render, Neon or hosted data;
- authenticate, log out, enroll, Query, Sync, Retry or recover;
- clear Android storage, uninstall, reset the AVD or alter the local database;
- consume, recreate or discard the preserved Windows event;
- change API, schema, migrations, RLS, synchronization or enrollment behavior;
- edit J, REC_DIAGNOSTICS, A/B/C, permanent memory, methodology or D/E/F;
- commit, push, deploy or open a PR.

## 8. G report

Replace `G_OPS_CODEX.md`. Include:

- exact DEVSEL root cause and reproduction;
- exact launcher correction;
- PowerShell version/evidence boundary;
- Auth0 changed-path and full contract scan;
- one AUTHAND classification;
- any conditional auth fix, or explicit no-auth-source-change conclusion;
- validation commands/results/skips;
- changed-file and dirty-worktree inventory;
- explicit absence of live/provider actions.

Required terminals:

```text
DEVSEL_CLASSIFICATION=DEVSEL_01_OR_EXACT_ALTERNATIVE
ANDROID_DEVICE_ENUMERATION=CORRECTED_OR_BLOCKED
NON_ANDROID_ID_REACHES_ADB=NO_OR_BLOCKED
ANDROID_SIGN_IN_CLASSIFICATION=AUTHAND_01_TO_06
AUTH_SOURCE_CHANGE=EVIDENCE_BACKED_OR_NONE
ANDROID_LIVE_SIGN_IN=NOT_EXECUTED
ST04=BLOCKED_PENDING_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```
