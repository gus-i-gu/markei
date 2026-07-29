# G_OPS_CODEX - C10-GCM03-ST04-R1-C3

> Role: Codex operational validation report
> Unit: `C10-GCM03-ST04-R1-C3`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry: `084e637e6771b8713b2504b155a82cd4d3bd792a`
> Evidence boundary: read-only GRM inspection, extracted actual-fence
> PowerShell 5.1 fixtures, Flutter tests, analyzer, debug APK build and
> redacted merged-manifest inspection; no live Android install, launch,
> authentication, enrollment, Query, Sync, Retry, recovery, provider mutation,
> commit or push

## Repository And Authority

```text
HEAD=65c9ab56079c7a9866910db9037c28045efd1d34
BRANCH=grm-guarded-provisioning-20260727
ANCESTRY_084e637=PASS
D_E_F_C3_BRANCH_ANCESTRY=CONFIRMED
```

The worktree was clean before validation. D/E/F identify C3, the required
branch and the required ancestry. The GRM set was treated as read/test/report
only.

## Protected Identities

Before and after validation identities matched:

```text
documentation/GRM.md
  blob=54cc0e3ff96575937c401b5ed61e4fa0ab169d7b
  sha256=2a724a7f8dcc5b2466c17d5fe9e64d9ed185389933c427c928d8539e48b1a11e

documentation/G_SCRIPTS.md
  blob=2c10e3c7c033d059b236389b212542e9bad0b4de
  sha256=6fd109a384f419acf2426c50ea57da9c327020f3499dccb42a44df528b983e9b

documentation/I_SCRIPTS.ps1
  blob=d6d3100ca2ea0f25fc697a853d8564cfc423c054
  sha256=5afbb09326f52ac0789b9a1ad208f25adb3290a0f4792cbc12d71646041c49e2

documentation/NS_COORDINATES.md
  blob=17fc9346e4d9e2c019b59b6bbfa8cd974c206466
  sha256=c442938b1f4b727df8c425e8e6ac119f962d8c2b2e8448287607867a9ec643e5

documentation/DB_MGMT.sql
  blob=d38a14de6b5e3a98047a5bdf749786fce740ae77
  sha256=feee6cd9fc809a4fb52340b4509112249715735767cd4fc41225a4c71bd9df47

documentation/ERR_DIAGNOSTICS.md
  blob=88eca195d55889fac6da1b932522d2e38c9360e8
  sha256=f4424c3f3ba847a73acf1a235dc938b2974e3e295afcbef762c6279be18cb56c

documentation/REC_DIAGNOSTICS.md
  blob=bc9295f46a343a970b25c57c65d49d899a6ec7d9
  sha256=3f058632a168f91560ef4c67444a638974d838034eb7f583cf2a53a5e5327cac
```

## Actual-Fence DEVSEL Validation

The `GS-FLUTTER-AND` heading and fenced PowerShell body extracted exactly and
parsed under Windows PowerShell 5.1. Extracted actual functions:

```text
Get-SupportedAndroidDevices
Assert-AdbTargetSerial
```

Windows PowerShell:

```text
5.1.26100.8875
```

Actual-function fixture results:

```text
MIXED_COUNT=1
MIXED_IDS=emulator-5554
PHYSICAL_COUNT=1
NO_ANDROID_COUNT=0
TWO_ANDROID_COUNT=2
MALFORMED=PASS
UNSUPPORTED_COUNT=0
INVALID_COUNTS=0,0,0,0,0
ADB_EXACT=emulator-5554
ADB_MISSING=PASS
ADB_AMBIG=PASS
ADB_WINDOWS=PASS
```

Captured argument arrays from the actual fence:

```text
BootProbeArguments=-s|emulator-5554|shell|getprop|sys.boot_completed safe=True
InstallArguments=-s|emulator-5554|install|-r|app-debug.apk safe=True
PackagePathArguments=-s|emulator-5554|shell|pm|path|com.gusigu.markei safe=True
PackageInspectionArguments=-s|emulator-5554|shell|dumpsys|package|com.gusigu.markei safe=True
LaunchArguments=-s|emulator-5554|shell|monkey|-p|com.gusigu.markei|-c|android.intent.category.LAUNCHER|1 safe=True
```

Result:

```text
DEVSEL-01=POWERSHELL_5_1_TOP_LEVEL_JSON_ARRAY_NESTING
ACTUAL_GS_FLUTTER_AND_FIXTURES=PASS
ANDROID_DEVICE_ENUMERATION=CORRECTED
NON_ANDROID_ID_REACHES_ADB=NO
ADB_SERIAL_CARDINALITY=EXACTLY_ONE
```

The Main-authored repair satisfies the validation requirements for actual
fence extraction, JSON parse/member enumeration, scalar Android filtering,
cardinality preservation, exact ADB serial binding and targeted ADB argument
arrays. It preserves `DEV-GRM` as the AVD definition and package
`com.gusigu.markei` with `install -r`.

## Auth Classification

The C2 classification remains unchanged:

```text
ANDROID_SIGN_IN_CLASSIFICATION=AUTHAND-06
AUTH_SOURCE_CHANGE=NONE
```

This validation did not execute live Android Sign in and did not mutate Auth0,
Render, Neon, local storage or the preserved Windows event.

## Validation Commands

```text
git merge-base --is-ancestor 084e637e6771b8713b2504b155a82cd4d3bd792a HEAD
  PASS

Windows PowerShell 5.1 actual-fence extraction and AST parse
  PASS

Windows PowerShell 5.1 extracted actual-function fixtures
  PASS

Windows PowerShell 5.1 captured ADB vectors
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

flutter build apk --debug with reviewed placeholder values
  PASS
  APK bytes=179136304
  APK sha256=E6941D7D7EF0C2096D62A8442CD34A788B9ECB1B34C3197483EA9CD49DFC404C

merged-manifest inspection
  PASS: package/activity marker, Auth0 marker, HTTPS scheme marker and
  redacted host marker present
```

Unavailable by design:

```text
ANDROID_INSTALL=NOT_EXECUTED
ANDROID_LAUNCH=NOT_EXECUTED
ANDROID_LIVE_SIGN_IN=NOT_EXECUTED
PROVIDER_DASHBOARD_VERIFICATION=NOT_EXECUTED
```

## Worktree

Changed files:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

No GRM, application source, D/E/F, J, A/B/C, methodology or permanent-memory
file was modified.

## Required Terminals

```text
GRM_PROTECTED_SET_MUTATION=ABSENT
GRM_AUTHORITY=HUMAN_MAIN_ONLY
CODEX_GRM_ROLE=READ_TEST_REPORT
DEVSEL_CLASSIFICATION=DEVSEL-01
ACTUAL_GS_FLUTTER_AND_FIXTURES=PASS
ANDROID_DEVICE_ENUMERATION=CORRECTED
NON_ANDROID_ID_REACHES_ADB=NO
ADB_SERIAL_CARDINALITY=EXACTLY_ONE
ANDROID_SIGN_IN_CLASSIFICATION=AUTHAND-06
AUTH_SOURCE_CHANGE=NONE
ANDROID_LIVE_SIGN_IN=NOT_EXECUTED
API_PERSISTENCE_PROVIDER_SYNC_EXPANSION=ABSENT
ST04=BLOCKED_PENDING_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```
