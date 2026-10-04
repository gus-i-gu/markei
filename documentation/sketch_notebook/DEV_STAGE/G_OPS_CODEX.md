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
## 2026-10-03 — Windows human test result and debut-test continuation

Authority: human instruction to proceed with debut testing. Bounded current unit: Windows restart/re-authentication check, read-only backend monitoring and preparation of same-Account Windows/Android purchase synchronization. No new source repair, provider mutation, database reset, deployment, commit/push or canonical promotion is authorized by this evidence record.

The latest human report supersedes the previous pending Windows login result: successful sign-in and Device connection were reported after the callback repair. Following the explicit close/reopen/re-authenticate/Device/History check, the human answered: "login works. Connect/Enroll device Works. Purchase Works". This is human evidence, not a fresh machine assertion of token exchange, hosted row contents, exact Device identity retention or all purchase operations. Earlier screenshots 1/2 depict authentication-cancelled/no-connected-Device state; screenshot 3 depicts one saved Purchase in History. No personal purchase values or raw identities are reproduced here.

Publication outcome: GitHub development prerelease v1.0.0-dev.2 is public at source 0a4523fc70d6928dd6b92c79c169b60868bdd26a. Seven uploaded assets were verified against local SHA-256 and byte sizes, and the published tag resolves to that source. Windows Debug build from that source completed; required runtime files were checked, the Release executable hash was preserved, and installed-app callback registration was verified afterward. Debug app launch/live acceptance was not performed by Codex. A local VS Code test workspace switches to Debug callback preparation and restores the installed callback on normal debugger stop.

Fresh read-only Render monitoring: confirmed existing Gus y. Garus workspace; marc-sync-api is not suspended and auto-deploy is off. Live deployment dep-db0nkktg1s2s73espbs0 still uses 09bf1c40e26189a769ab12d413f797d97354abc4. Both /health/live and /health/ready returned HTTP 200 with expected status. Published backend dependency security updates are not deployed. Health does not establish authenticated synchronization or account isolation.

Current next gate: determine Android readiness, then test one distinct newly created Purchase from Windows to Android on the same Marc Account, reverse direction, repeated-sync duplicate behavior and restart retention. Do not mark these gates passed from Windows login/enrollment or the existing History screenshot. Prior human report of working sync remains inherited evidence until the current two-Device test returns results. Stop on an unexpected failure and preserve data for bounded diagnosis. Memory-only credentials still require sign-in after application restart.
## 2026-10-03 — Approved Marc save-the-date landing-page preview

Authority: the human requested a landing-page preview for the domain being acquired, accepted its desktop/mobile presentation, requested saving and wrap-up, and explicitly approved this observational notebook append on 2026-10-03. Bounded scope: record approved page, private preview and pending Android test; stop after verifying the append. No canonical promotion, app-source change, provider-production change or branch publication is part of this append.

Materialization: separate static-site checkout in the Codex task workspace at `marc-save-the-date`; approved cream/deep-green design reuses the existing Marc emblem. Portuguese page announces 21 October 2026 explicitly as tentative, with a downloadable all-day tentative calendar invitation. No waitlist, credentials, app authentication, payment or custom-domain change was added.

Fresh saved outcome: Sites source commit `80b9b57233aec35f3eea74eaa3d9d864b04314f0`; owner-private deployment succeeded at https://marc-save-the-date.gus-y-gu.chatgpt.site . Site ID `appgprj_6ac19d5d349081919e09de95dd01c9b7`; deployment `appgdep_6ac19f445dc88191bc5bdd007ee2722b`. Domain acquisition and connection remain pending. Use this final successful deployment URL, not the prepublication expected origin.

Validation: local HTTP 200; desktop and 390px mobile browser visual inspection; mobile document width equals viewport width; brand image loaded; calendar invitation download completed. Calendar import is untested. Desktop/mobile screenshots, deployment package and `marc-landing-page-handoff.json` retained in the task outputs directory. Task workspace: `C:/Users/gyg29/.codex/.chatgpt-projects/g-p-6a496144252881918be358acc002a03d`. Temporary local preview server stopped after successful private hosting. Source preparation encountered sandbox network access, checkout ownership, missing WSL bash and GNU tar Windows-path issues; bounded process-local settings resolved these without global trust changes or source redesign.

Pending human Android test: install/update `Markei-Android-1.0.0-2.apk` from GitHub prerelease `v1.0.0-dev.2`; use the same Account as Windows; enroll tablet; create a distinct Purchase on Windows and verify exactly once on Android after synchronization; repeat in reverse; reopen/re-authenticate, verify retention and repeat synchronization to check duplicate prevention. Stop on an unexpected failure and report the step/message. The human intends to check the updated build immediately; no Android result has yet been supplied. Existing Windows successes remain human-reported. This landing-page evidence does not establish app launch readiness, cross-device synchronization or Account/Device isolation.

Notebook write gate: automatic approval review initially rejected this append because permanent-documentation authority was not explicit. No indirect retry was made. The human subsequently answered "yes please" to the exact append request; this supplies the bounded authority for the present write.

## 2026-10-03 — Marc 1.1.0 interim branding, Household profile and enrollment diagnosis

Authority: direct human requests to implement an intermediate minimal-futurist UI as Marc 1.1.0, preserve semantic colours/modern fonts, diagnose or correct the observed Sync blocker, add Household with explicit signed-in email, publish the development version, and reorganize/brief the Notion project. Bounded source scope: Flutter shared visual components, Home/Lists/Household, native profile claims, session reuse during enrollment, typed enrollment rejection, startup-binding guard and successful-Sync projection refresh. Acceptance gate: analysis, contract check, full client regressions, native release builds/artifact checks and synthetic widget previews; stop before provider mutation, offline Account reassignment or unobserved automatic recovery. Human interim UI authority does not declare Cycle 13 definitive UI acceptance or Cycle 12 Sync complete.

Implementation source: cea002338ccd52a3043fcac955360f5fa090d8bc on markei-season-02. Version 1.1.0+3. Warm paper/deep-green/lime branding, bundled licensed Roboto, purple generic information, green Storage, pastel-yellow/mild-orange Shortage and blue Market. Household reads Auth0 profile name/email in memory with openid/profile/email scopes, explicit unavailable/signed-out states and profile invalidation after session changes. Invitations/member management remain planned.

Fresh machine diagnosis: installed Windows SQLite was read in read-only mode. It records no active hosted binding and two pending events in the offline Account. Pending counts are not successful synchronization. Render's observed enrollment request completed with HTTP 403; the precise authorization/membership cause is unproven. The service remains deployed from 09bf1c40e26189a769ab12d413f797d97354abc4 with auto-deploy off. No provider mutation/deployment was performed. Source inspection confirms enrollment redundantly launched sign-in despite SignedIn; the correction reuses the valid session. Enrollment 401/403 now yield safe typed rejection instead of generic service-unavailable. A newly recorded or changed binding requires restart before repositories use it; missing enrollment is distinguished. Successful Sync now refreshes app references and projections. These are validated client corrections, not a claim that live Sync is repaired.

Fresh validation: Flutter analysis and diagnostics generation check passed. Complete serial suite: 299 passed, 4 intentional lab-gated skips. Two performance-budget tests exceeded limits in a parallel run; serial validation passed without relaxing thresholds. Windows Release build and Inno Setup installer passed, executable version 1.1.0.3. Signed Android APK passed apksigner verification; com.gusigu.markei, versionName 1.1.0, versionCode 3, min SDK 24/target 36 and arm64-v8a/armeabi-v7a/x86_64 retained. Existing release signing material was reused outside Git. Source commit and SHA-256 of the LF git-tree client manifest are embedded. Four final native-widget previews passed rendering and visual review using synthetic fixtures. Physical 1.1.0 install/update and live Auth0/two-Device Sync remain pending. Windows publisher signature remains absent.

Human evidence: Windows and TL10 Android Purchase registration are reported green. Earlier Windows login/enrollment success is human-reported; latest Android enrollment remains uncertain due a second browser login. Fresh machine evidence and earlier human reports are retained separately. New connected-workspace Purchases in both directions, exactly-once display on repeated Sync, restart retention and declared Account/Device isolation are the next acceptance gate. Existing pre-enrollment Purchases remain in their original offline Account; no silent migration, database reset or queue replay was added.

Notion: human-authorized definitive Marc hub is GMR / 06_Projects / Marc, page 3efa3e26eacd81b0873fda55dfdcb0a0. History page 3efa3e26eacd81e18f4eebd91e3400ed contains the original Season 02 page 3e5a3e26eacd81da9e42db69daa42cb0, moved with all seven direct child pages and their descendants intact. Existing page identity/inbound links were preserved; old claims remain dated history, not fresh acceptance. Marc Launch Prep, page 3efa3e26eacd81ab84acf05f68f4be90, contains development status, technical preview/tokens/source boundaries, diagnosis, conditional remaining source work and ordered launch gates. Repository/package identifiers remain stable. Mycology work is outside this app task.

Distribution evidence, artifact SHA-256/byte sizes and update instructions are retained in the task outputs manifest and development notes. The tentative 21 October 2026 debut and domain acquisition/verification/hosting remain open. No canonical domain promotion, branch pruning, production release or full season closure is asserted.

Distribution outcome: v1.1.0-dev.3 is public at https://github.com/gus-i-gu/markei/releases/tag/v1.1.0-dev.3 . All nine uploaded assets matched local SHA-256 digests and byte sizes; the release tag resolves to source cea002338ccd52a3043fcac955360f5fa090d8bc. Both installer and signed APK were built after that source commit. Marc Launch Prep now includes stable download links and all four synthetic previews with the technical description. Physical update and live two-Device Sync remain pending.
