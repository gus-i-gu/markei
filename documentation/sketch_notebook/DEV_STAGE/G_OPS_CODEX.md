# G_OPS_CODEX - C10-GCM03-ST04-R1-C2

> Role: Codex operational report
> Unit: `C10-GCM03-ST04-R1-C2`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry: `1af1d887e4fe8370ab988a80e4af16eafcd4699c`
> Evidence boundary: repository inspection, Windows PowerShell 5.1 fixtures,
> Flutter static tests, analyzer and Android debug build; no live
> authentication, enrollment, Query, Sync, Retry, recovery, provider mutation,
> install, launch, commit or push

## Operational Result

The checkout was on the required branch and `1af1d887` was an ancestor of
HEAD. D/E/F were read and all named the C2 unit, branch and ancestry.

Human follow-up narrowed the writable surface after work started:
`documentation/G_SCRIPTS.md`, `documentation/GRM.md`,
`documentation/I_SCRIPTS.ps1`, `documentation/NS_COORDINATES.md`,
`documentation/DB_MGMT.sql`, `documentation/ERR_DIAGNOSTICS.md` and
`documentation/REC_DIAGNOSTICS.md` were made non-writable. The interrupted
`G_SCRIPTS.md` edit was reverted with `git restore -- documentation/G_SCRIPTS.md`.
Those protected files are clean.

Because `GS-FLUTTER-AND` lives in `documentation/G_SCRIPTS.md`, the owning
launcher repair could not be materialized after the updated protection. The
root cause and equivalent repair contract were still reproduced and validated
without mutating the protected procedure.

## DEVSEL

Windows PowerShell 5.1 reproduction:

```text
PSVersion: 5.1.26100.8875
count=1
type=System.Object[]
selectedCount=1
selectedIds=windows,edge,emulator-5554
adbArgs=-s|windows|edge|emulator-5554|shell|getprop|sys.boot_completed
```

Classification:

```text
DEVSEL-01=POWERSHELL_5_1_TOP_LEVEL_JSON_ARRAY_NESTING
```

Equivalent non-mutating fixture result:

```text
PASS_INLINE_DEVICE_SELECTION_FIXTURE
PSVersion: 5.1.26100.8875
```

The fixture covered mixed Windows/Edge/Android, physical Android, no Android,
two Android targets, malformed JSON, unsupported target, missing/empty/
non-scalar IDs, exact ADB serial match, missing ADB serial and ambiguous ADB
serial. The captured ADB vector was:

```text
-s|emulator-5554|shell|getprop|sys.boot_completed
```

No `windows` or `edge` value reached the fixture ADB vector.

Required launcher correction, not materialized under the updated protected
surface:

- parse Flutter machine JSON once;
- enumerate parsed top-level members before filtering;
- accept only Android platform, `isSupported -eq $true`, scalar non-empty ID;
- preserve zero/one/multiple target cardinality;
- require selected ID to be one safe scalar and exactly present in `adb devices`;
- call ADB through explicit argument arrays;
- preserve AVD name `DEV-GRM` as definition while discovering the runtime serial.

## Auth0 Scan

Changed-path verification:

```text
db17f47..231a762 targeted Auth0/Android identity paths: no changes
231a762..1af1d887 targeted Auth0/Android identity paths: no changes
```

Static contract inspected:

```text
NS_COORDINATES public keys
GS-FLUTTER-AND coordinate loading
MARKEI_AUTH0_DOMAIN
MARKEI_AUTH0_AUDIENCE
MARKEI_AUTH0_ANDROID_CLIENT_ID
ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN
Gradle manifest placeholders
merged Android callback scheme/domain
package com.gusigu.markei
NativeAuthConfiguration
Auth0 native client selection
Closure Sign in
sanitized terminal/error mapping
```

No Auth0 source/configuration defect was proved. Auth0 source was not changed.

Classification:

```text
AUTHAND-06=INSUFFICIENT_RUNTIME_SYMPTOM_EVIDENCE
```

## Validation

Commands and results:

```text
git status --short
  clean before report edits

git merge-base --is-ancestor 1af1d887e4fe8370ab988a80e4af16eafcd4699c HEAD
  PASS

GS-FLUTTER-AND heading/fence extraction
  PASS, chars=12150

Windows PowerShell 5.1 AST parse of extracted GS-FLUTTER-AND body
  PASS, 5.1.26100.8875

Windows PowerShell 5.1 DEVSEL reproduction
  PASS, reproduced aggregate nested array and expanded ADB IDs

Windows PowerShell 5.1 inline equivalent correction fixture
  PASS

flutter test test/infrastructure/native_auth_composition_test.dart
  PASS, 17 tests

flutter test test/app/native_closure_surface_test.dart
  PASS, 2 tests

flutter test test/app/native_closure_diagnostics_test.dart
  PASS, 26 tests

flutter test
  PASS, 199 passed, 4 skipped

flutter analyze
  PASS, no issues found

flutter build apk --debug with non-secret placeholder defines
  PASS
  APK: clients/markei_flutter/build/app/outputs/flutter-apk/app-debug.apk
  bytes: 179136301
  sha256: 4969BD99771F14C494431FACD6824B349E915394C2D60346F24DE79B31ED2FF3

generated/merged manifest inspection
  PASS: package/activity marker present; Auth0 marker present;
  HTTPS scheme marker present; host marker present and redacted

git diff --check
  PASS before report edits
```

Skipped or unavailable:

```text
live Android install/launch: not executed
interactive Android Sign in: not executed
provider/dashboard verification: not executed
GS-FLUTTER-AND repository repair validation: blocked by updated protected surface
```

## Worktree Inventory

Changed files after report replacement:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Protected files explicitly restored or left unmodified:

```text
documentation/G_SCRIPTS.md
documentation/GRM.md
documentation/I_SCRIPTS.ps1
documentation/NS_COORDINATES.md
documentation/DB_MGMT.sql
documentation/ERR_DIAGNOSTICS.md
documentation/REC_DIAGNOSTICS.md
```

## Terminals

```text
DEVSEL_CLASSIFICATION=DEVSEL-01
ANDROID_DEVICE_ENUMERATION=BLOCKED_BY_UPDATED_PROTECTED_SURFACE
NON_ANDROID_ID_REACHES_ADB=YES_IN_CURRENT_GS_FLUTTER_AND_SOURCE
NON_ANDROID_ID_REACHES_ADB_IN_EQUIVALENT_FIXTURE=NO
ANDROID_SIGN_IN_CLASSIFICATION=AUTHAND-06
AUTH_SOURCE_CHANGE=NONE
ANDROID_LIVE_SIGN_IN=NOT_EXECUTED
LIVE_PROVIDER_ACTIONS=ABSENT
COMMIT_OR_PUSH=NOT_EXECUTED
ST04=BLOCKED_PENDING_MAIN_RESTAGING
GCM03_ST05_AND_LATER=HELD
```
