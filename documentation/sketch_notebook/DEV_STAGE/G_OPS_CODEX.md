# G_OPS_CODEX - C11-ANALYTICS-CORRECTION-R01

## Authority

- Repository: `gus-i-gu/markei`
- Branch: `grm-guarded-provisioning-20260727`
- Starting remote HEAD: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`
- Activation commit: `0e647e76aa8275bda48cea1e9d08427e3d949134`
- Controlling source authority: latest `C11-ANALYTICS-CORRECTION-R01` sections in D/E/F.
- PH05 evidence boundary: J section 14 only.

## Diagnosis

Confirmed diagnosis: Analytics calculation did not evidence silent default-Quantity insertion. The defect was user-facing projection of fixed-point storage integers and raw compatibility keys, plus insufficient end-to-end tests proving one frozen record controls Chart, Table, interpretation, CSV and PDF.

Corrected competing hypothesis: wrong-variable display was not treated as evidence of a second calculation path or implicit Quantity fallback.

## Changed Paths

- `clients/markei_flutter/lib/domain/analytics/analytics_models.dart`
- `clients/markei_flutter/lib/domain/analytics/analytics_registry.dart`
- `clients/markei_flutter/lib/application/analytics.dart`
- `clients/markei_flutter/lib/application/analytics_workspace.dart`
- `clients/markei_flutter/lib/app/pages/analytics_page.dart`
- `clients/markei_flutter/lib/app/widgets/analytics_components.dart`
- `clients/markei_flutter/test/application/analytics_workspace_test.dart`
- `clients/markei_flutter/test/app/analytics_page_test.dart`
- `clients/markei_flutter/test/app/analytics_components_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

## Operational Evidence

- Preserved one `AnalyticsWorkspaceController`, one Account-local dataset load, one live draft, immutable session-only saved records and pure Analytics export builders.
- Added one typed `AnalyticsVariable` selection owner. Purchased by and Payment method derive categorical breakdowns; Purchased for is unavailable; Quantity, Unit price, Price paid, Purchase total and Evidence count derive numeric measures.
- Categorical-only selections block with guidance and do not insert Evidence count or Quantity.
- Unsupported operation-variable combinations block with selection-specific guidance.
- Compatible and incompatible numeric series remain separate. Incompatible axes default the selected record to Table while preserving Table/CSV/PDF evidence.
- Replaced the ISO/UTC interval control with Initial date and Final date in strict `dd-mm-yyyy`; both dates are inclusive and convert to the existing UTC half-open interval.
- Human-facing result/export formatting now converts microunits, minor currency units, unit-price minor units and basis points. Difference retains sign through exact integer aggregation before display.
- Ordinary Variables presentation hides Purchase/Product/Store/Item UUIDs while retaining stable IDs internally for selection, History handoff, pagination, fingerprints and reconstruction.
- Analytics request/effect budget remains: initial local evidence read 1, Retry +1, other local Analytics actions +0, database writes 0, network calls 0.

## Regression Matrix

- Product + Price paid and Quantity + Mean: PASS.
- Store + Price paid + Sum: PASS.
- Time by month + Quantity + Sum: PASS.
- Product + Payment method + compatible numeric variable: PASS.
- Purchase + Purchase total + Mean and Sum counted once per Purchase: PASS.
- Inclusive one-day custom range: PASS.
- Invalid and reversed dates: PASS.
- Incompatible numeric units with Table/export retained and Chart unavailable by default: PASS.
- Categorical-only selection without implicit count/Quantity: PASS.
- History-selected Purchase scope requested/matched/unavailable counts and matched-row calculation: PASS.

## Validation

- `flutter pub get`: PASS.
- `git diff --exit-code -- pubspec.yaml pubspec.lock`: PASS.
- `dart format --output=none --set-exit-if-changed lib test`: PASS.
- `flutter analyze`: PASS.
- Focused serial Analytics suite: PASS, 24 tests.
- `flutter test --concurrency=1 --no-pub`: PASS, 286 passed and 4 lab-gated skips. Existing Drift multiple-database warnings appeared and were not suppressed.
- `flutter build windows --release`: PASS; built `build\windows\x64\runner\Release\markei.exe`; existing Boost/CMake developer warning.
- `flutter build apk --debug`: PASS; built `build\app\outputs\flutter-apk\app-debug.apk`; existing `auth0_flutter` KGP future-compatibility warning.
- `node ..\..\scripts\generate_sync_diagnostics.mjs --check`: PASS.

## Forbidden-Surface Audit

- Schema/migrations/generated files: unchanged.
- Dependencies and `pubspec.yaml`/`pubspec.lock`: unchanged.
- Native platform files: unchanged.
- `documentation/GRM.md`, `documentation/G_SCRIPTS.md`, `documentation/I_SCRIPTS.ps1`, `documentation/NS_COORDINATES.md`, `documentation/DB_MGMT.sql`: unchanged.
- J, A/B/C, permanent domains and methodology: unchanged.
- Auth, API, Sync, provider, diagnostics, PH03, Closure and unrelated pages: unchanged.

## Terminal

```text
CYCLE=C11
UNIT=C11-ANALYTICS-CORRECTION-R01
CALCULATION_SELECTION_INTEGRITY=PASS
RAW_FIXED_POINT_PRESENTATION=REMOVED
UNIFIED_VARIABLES=PASS
CUSTOM_DATE_RANGE=PASS
FINAL_DATE_INCLUSIVE=PASS
VISIBLE_UUIDS=ABSENT
CHART_TABLE_EXPORT_PARITY=PASS
ANALYTICS_REQUESTS=initial:1; retry:+1; other:+0
ANALYTICS_DATABASE_WRITES=0
ANALYTICS_NETWORK_CALLS=0
SERIAL_FULL_FLUTTER_TEST=PASS
WINDOWS_RELEASE_BUILD=PASS
ANDROID_DEBUG_BUILD=PASS
SCHEMA_MIGRATION=NONE
DEPENDENCY_GENERATED_PLATFORM_CHANGE=NO
GRM_GS_FILES_CHANGED=NO
PUBLICATION=PUSHED
NEXT_MAIN_ACTION=Reconcile G/H/I and perform human wide/compact, keyboard, locale and real-device review.
```

## 2026-10-02 — Flutter release packaging

Sequence: FLX-ORD-01
Role: Codex
Unit: Flutter Windows installer and Android release preparation
Branch: markei-season-02
Inspected HEAD: 09bf1c40e26189a769ab12d413f797d97354abc4
Authority: direct human request in Build the app quickly, 2026-10-02. Existing D/E/F describe an older C11 unit and were not used as authority for these changes.
Evidence boundary: local build and installer checks; no live account/provider mutation or Beta acceptance claim.

Implemented:
- scripts/build_flutter.ps1: locked dependencies, analysis, validated public environment settings, platform build, matching Android manifest domain, diagnostic Closure surface disabled.
- scripts/build_flutter_installer.ps1 and installer/MarkeiFlutter.iss: complete Flutter bundle plus Visual C++ runtime, pubspec/executable version agreement, separate stable Flutter AppId, per-user installation, shortcuts, callback registration, owned callback cleanup, SHA-256 output.
- clients/markei_flutter/android/app/build.gradle.kts: release signing from ignored key.properties; missing release signing fails instead of using debug keys.
- clients/markei_flutter/.gitignore and RELEASE.md: private release configuration exclusion and build/acceptance instructions.
- Reused platform configuration in an ignored release JSON; no secret was printed or committed.

Environment recovery:
- Copied required existing Android SDK components and Inno compiler from the old profile into Documents/Codex/tools.
- Configured Flutter to use the accessible SDK; Android tools and accepted licenses pass doctor.
- Completed the existing Visual Studio Desktop C++ installation; Windows tools pass doctor.
- Preserved the stale generated Windows build in build/windows-before-flutter-setup-20261002 and regenerated its compiler configuration.

Validation:
- flutter pub get --enforce-lockfile: PASS.
- flutter analyze --no-pub: PASS, no issues.
- Four existing auth/callback/runtime packaging test files: 29 tests PASS.
- flutter build windows --release --no-pub with release definitions: PASS.
- Inno Setup compilation: PASS, Markei-Flutter-Setup-1.0.0-1-x64.exe.
- Temporary installation, same-version upgrade, required bundle files, callback registration, uninstall and callback cleanup: PASS. Test copy removed; prior handler restored if present.
- git diff --check: PASS before final evidence append.

Remaining:
- Automatic approval review blocked generating a new Android release signing key; explicit human choice is pending. No new key or signed release APK was produced.
- Windows installer is unsigned and targets the existing Season-02 development backend.
- Application launch, live browser sign-in, real Android installation, cross-device sync and account isolation remain unverified in this unit.
- No commit, push, destructive cleanup of existing user data, or semantic promotion occurred. The pre-existing stray untracked file was preserved.
## 2026-10-02 — Android signed APK completion

Authority: human explicitly approved creation of the Android signing key in this chat.
Supersedes the signing-approval-pending statement in the preceding packaging report.

- Created one RSA-3072 release key, alias markei, in ignored android/upload-keystore.jks; ignored key.properties supplies its generated password.
- Working signing files and local backup are restricted to the current Windows account and SYSTEM. Passwords were not printed or placed in deliverables.
- Local backup: Documents/Codex/markei-private/android-signing. Keystore and properties hashes match their originals. This same-machine backup still needs an independent encrypted backup.
- flutter pub get --enforce-lockfile: PASS; flutter analyze --no-pub: PASS; Android assembleRelease: PASS.
- APK signature verification: PASS using APK Signature Scheme v2; exactly one signer; certificate SHA-256 C2:F2:99:28:CE:2F:D2:35:43:CE:DC:0B:DF:85:14:95:BD:6D:E2:1B:EA:6A:03:1D:ED:FC:AF:A9:69:8C:EB:57 matches the generated certificate.
- APK identity: com.gusigu.markei, version 1.0.0, code 1, minimum SDK 24, target SDK 36; arm64-v8a, armeabi-v7a and x86_64.
- Merged release manifest includes INTERNET and the expected HTTPS Auth0 redirect with autoVerify.
- Deliverable: outputs/Markei-Android-1.0.0-1.apk (65,790,988 bytes); SHA-256 3c3714514c006c2c5ce25a3a910777eb8d905cb74358196dbe32910a06b3cd3c.
- Public Auth0 assetlinks.json contains the package but NOT the new release certificate. Registration is still required; instructions and public fingerprint delivered in Android-install-and-signing.txt. No authenticated dashboard session was available through the connected browser. No provider mutation performed.
- No real-phone installation, live sign-in, account isolation or two-device synchronization was claimed. No commit or push performed.

## 2026-10-03 — Marc branding integration

Direct human instruction authorized the approved steely-green logo integration. Branch: markei-season-02; inspected HEAD: 09bf1c40e26189a769ab12d413f797d97354abc4. Earlier release work retained. Added Flutter branding assets and MarcBrand navigation/About control; updated visible names, Windows icon/resource metadata, Android legacy/adaptive launcher resources, and existing Flutter installer branding. Package ID, executable name, installation folder, AppId and callback routes retained.

Validation: Flutter analyze passed; 44 existing app/visual-foundation and Windows runtime/protocol/runner tests passed. Windows release, Inno installer and Android release builds passed. apksigner verify passed; packaged Android label is Marc. Windows installer remains unsigned. Real-device installation, upgrade, login and sync are unverified. No publication performed. Local deliverables and detailed evidence: C:\Users\gyg29\Documents\Codex\2026-10-03\g-we-need-now-to-check\outputs\Marc-branding-integration.txt.

## 2026-10-03 — New-account infrastructure and Flutter build 1.0.0+2

Authority: direct human instructions to start fresh, configure the new Auth0 tenant, migrate Render to Gus y. Garus, connect the existing Neon project/database, and rebuild the Flutter application. Existing C11 D/E/F staging was retained; methodology was not edited. This is observational evidence, not semantic promotion.

Materialization: updated documentation/NS_COORDINATES.md and ignored release/Android/Windows debug public definition files for dev-vxt0inrppc8jfz45.us.auth0.com and https://marc-sync-api.onrender.com. Incremented pubspec version to 1.0.0+2 while preserving branding/assets and other work. Backed up changed public configuration before editing. Created Markei Android and Markei Windows native clients and Markei Sync API in the new tenant; saved callbacks and existing Android release certificate. Created free Render service srv-db0ncigu01pc73b4ljo0 from branch markei-season-02, Node 24, with new issuer/audience and the existing Neon markei_runtime connection. Auto-deploy remains disabled. No source files were recreated wholesale and no old service/data was deleted.

Validation: GRM-HOST-01 returned live=200/live and ready=200/ready. GRM-AUTH-01 returned issuer/JWKS matches, RS256 and two keys. Render deployment dep-db0nkktg1s2s73espbs0 is live at source 09bf1c40e26189a769ab12d413f797d97354abc4. Unsigned /v1/identity request returned 401. Auth0 public assetlinks includes the Android package and existing certificate. Read-only Neon SQL confirmed zero accounts/identities/memberships/devices/events, with migration ledger 002 through 007. Temporary credential transfer file was removed; no secret was added to source, reports or delivery outputs. Initial Render attempts failed for missing MARKEI_SYNC_DATABASE_URL; this was resolved by supplying the restricted runtime connection. Initial API creation using the old .invalid audience was rejected by automatic approval review; the actual Render HTTPS origin was used successfully instead.

Builds: scripts/build_flutter.ps1 for Windows and Android passed with new public definitions and analysis reporting no issues. scripts/build_flutter_installer.ps1 produced Markei-Flutter-Setup-1.0.0-2-x64.exe. APK signature verification passed, matching the existing RSA-3072 certificate; package com.gusigu.markei, code 2, visible label Marc, minimum SDK 24, target 36. Versioned artifacts/checksums and detailed status are in C:\Users\gyg29\Documents\Codex\2026-10-02\g-x20\outputs. Windows publisher signature remains absent. Auth0 Flutter emitted a future Kotlin Gradle migration warning, not a build failure.

Outstanding: real-user native sign-in, guarded initial membership provisioning, enrollment, restart and cross-device sync/account-isolation acceptance. GRM-AUTH-03 requires clean remote-aligned source; the working tree has legitimate packaging/branding/configuration changes and this prerequisite has not been bypassed. No commit/push in this unit. Earlier 1.0.0-1 deliverables use old provider configuration. Infrastructure health and successful builds do not establish complete app-account migration or store readiness.

## 2026-10-03 — Android App Bundle and first-beta checks

Direct human request authorized an AAB, first-beta checks, installers and a manifest. Added -AndroidFormat apk/appbundle to scripts/build_flutter.ps1 (APK remains the default) and instructions in clients/markei_flutter/RELEASE.md. Added android/app/src/release/AndroidManifest.xml to replace the Auth0 dependency's inherited test-domain/test callback with exactly one configured auto-verified HTTPS callback; rebuilt both AAB and APK for unpublished 1.0.0+2. Existing signing key/package identity retained. Windows build 2 is unchanged.

Validation: Flutter analysis passes; full existing Flutter suite 286 passed / 4 skipped. Initial backend suite 60/61 passed; failure was CRLF versus LF comparison of generated files. scripts/generate_sync_diagnostics.mjs now normalizes line endings before comparison without ignoring semantic differences. Initial npm audit reported 13 high-severity dependency entries including runtime packages. Updated compatible dependencies in package-lock.json and typescript-eslint to 8.71.0 in package.json; final npm audit reports zero. Backend lint, typecheck, all 61 tests and build pass locally. No backend patches were pushed/deployed; live Render still runs the prior commit/dependency lock, which remains a release blocker.

Google bundletool 1.18.3 was downloaded from its official release and checked against the published SHA-256. Bundle validation and APK/AAB signature verification pass; certificate matches the existing key. Packaged callback assertion passes with no test-domain filter, release is not debuggable, and archive filenames contain no private signing/definition files. Eight packaged 64-bit native libraries have at least 16KB ELF load alignment. Jarsigner reports valid signature plus self-signed/no-timestamp and streaming-order warnings; no Play acceptance is claimed. APK/AAB build-2 checksums were refreshed after the callback fix. Versioned release manifest, actual Android XML manifest and test instructions are in this chat's outputs directory.

Remaining: user-run Windows/phone tests, guarded initial membership provisioning, enrollment/restart/cross-device sync/account isolation, publication of reviewed source and deployment of security fixes, Play signing/certificate/registration/declarations and privacy/deletion checks. No upload, store publication, commit or push. No methodology edits or semantic promotion.

## 2026-10-03 — Auth0 return diagnosis and development publication gate

Authority: direct human request to inspect the latest sign-in failure and publish the current version to gus-i-gu/markei for development. Bounded scope: latest known Flutter packaging/branding/configuration/dependency delta, installed Windows callback registration, focused validation, existing G evidence and development release. Stop at verified normal branch publication and prerelease asset upload; no account reset, provider deployment or purchase-flow rewrite.

Fresh evidence: branch markei-season-02 and fresh GitHub head 09bf1c40e26189a769ab12d413f797d97354abc4; empty index before publication. Installed and build-release Windows executables both version 1.0.0+2 with SHA-256 404d94166092280cc21d582fe431ec2a1d7c9411f993067fbf1dfd401a2c587a. Running process was the installed per-user executable. Both HKCU and effective HKCR lacked auth0flutter callback registration. Read-only diagnosis was repeated outside the sandbox and confirmed through the .NET registry API. Restored the missing per-user protocol key and quoted executable/URI command, then verified the exact value. Existing installer already declares it. Read-only WaitNamedPipe confirmed the running callback listener is ready. Cause of registration disappearance is unproved; real Auth0 login after this repair remains pending.

Source inspection: successful SDK login stores credentials in the one authentication object shared by the runner/support adapters. Settings refreshes account status after the sign-in action. Credentials are memory-only; cold restart explicitly returns SignedOut in current implementation and test. Browser identity creation, native callback/code exchange, local session, hosted membership and enrollment remain separate gates. No credential persistence or authentication-provider changes were made here.

Fresh checks: Flutter analyze passed; 28 focused authentication/settings/Windows tests passed; full Flutter suite 286 passed with 4 existing skips; backend diagnostics check, typecheck and lint passed, all 61 backend tests passed, runtime npm audit zero. Initial sandbox backend run failed in node os.userInfo before tests; outside-sandbox retry passed. Installer/APK/AAB hashes match the prior build manifest. Source publication selection excludes private definitions, signing keys, local data, generated builds, .vscode and the malformed root scratch filename. Public source scan and manual signing-placeholder review passed.

Publication is authorized as a development prerelease of build 1.0.0+2 using the existing packages. Its final source SHA, upload result and complete asset hashes are recorded in the publication manifest/release after verification, not asserted by this prepublication gate. No Render deployment, live membership provisioning, Android acceptance or purchase correction is claimed. Existing human report of solved sync is preserved as a regression boundary; no new cross-device proof is claimed. Methodology/permanent memory were not promoted.