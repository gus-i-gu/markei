# 11_OPERATIONAL_RECORD.md

> Version: Cycle 07 Sprint 02 observational record 0.4
> Status: Active observational history
> Persistence Class: Observational
> Knowledge Class: Operational
> Branch: `cycle-07-mobile-preparation`
> Scope: Chronological Operational recovery, materialization, validation, correction, and reconciliation evidence
> Truth boundary: Present rules belong to `12_OPERATIONAL_MODEL.md`, active work to `04_TODO.md`, and current state to `10_OPERATIONAL_STATE.md`.

---

# 1. Reading Rule

This file records what occurred. It does not independently define present Operational truth. Later reconciled canon and checkpoints govern when older observations become stale.

# 2. Recovery and Repopulation — 2026-07-10

The Operational domain was recovered on `sketch-notebook-recovery` after methodology boot from `INDEX.md` and the required methodology sequence.

The initial execution spine recovered was:

```text
main.py
→ app.main.main()
→ MainWindow
→ desktop pages
→ ProductService
→ Repository
→ app.core.database
→ SQLite
```

The first structural A stage was committed as:

```text
ce14d2549311f90144f95f0a54eafcbeb24bc126
```

An initial canonical promotion used an incorrect Main reference and was later replaced. The correct reconciliation route was restored through:

```text
documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md
```

Canonical, derived, and checkpoint reconstruction commits included:

```text
572f7043d2d721e70e6638713054b64237984661  corrected Operational canon
792a6bf32efb658127161e1a628f42a0731879f8  Operational TODO derivative
74e18af3fbedbf7508c4e808568681d5539fed40  first Operational checkpoint
72b6f6f2a6ca8506d1a4435a3f7d9558fec8142d  checkpoint routing correction
```

A temporary extra A-stage filename was created and later corrected. The durable routing rule remains that Operational Chat refreshes only `DEV_STAGE/A_OPERATIONAL.md` unless Main explicitly changes the file map.

The recovery also preserved the distinction between historical artifact success and coherent methodology-cycle closure. Main-branch Cycle 05 packaging claims were treated as history, not current recovery-branch validation.

# 3. Cycle 06 Sprint 01 — First Windows Release-Enablement Unit

## 2026-07-12 — Materialization and reconciliation

Sprint 01 changed or created:

```text
Markei.spec
scripts/build_windows.ps1
main.py
app/desktop/main_window.py
app/startup_diagnostics.py
requirements-build.txt
installer/Markei.iss
scripts/build_installer.ps1
tests/test_release_configuration.py
```

It established:

- `Markei.spec` as authoritative one-folder packaging source;
- schema-only production packaging;
- exclusion of seed, live database, WAL/SHM, logs, tests, and caches;
- per-user installer source and compile wrapper;
- startup diagnostics;
- focused release tests;
- bounded MainWindow shutdown coordination.

Observed toolchain:

```text
Python 3.14.6
PySide6 6.11.1
PyInstaller 6.21.0
```

Observed commands:

```text
python -m compileall app main.py       passed
python -m pytest                       blocked: pytest unavailable
python -m unittest discover -s tests  passed: 5 tests
scripts/build_windows.ps1             passed
scripts/build_installer.ps1           blocked: ISCC.exe unavailable
```

Frozen artifact evidence:

```text
dist\Markei\Markei.exe
SHA256 E35643F282B612A8080B38C45743697673323F2918589D7869CE4E9839535D1B
```

Focused shutdown validation initially failed because the isolated SQLite file remained open after `MainWindow.close()`. A bounded `MainWindow.closeEvent()` coordinator then closed all four page-owned services idempotently. Rerun evidence showed all repositories closed, the isolated database directory became removable, and immediate frozen reopen succeeded.

Sprint 01 ended with:

```text
configured: yes
built: yes
launched: yes — frozen
installed: blocked
validated: partial
accepted: no
```

Permanent Operational reconciliation was committed at:

```text
193a96e2202a649feb86d4259b626a8e553ad0cb
```

# 4. Cycle 06 Sprint 02 — Installer and Installed Lifecycle

## 2026-07-12 — Toolchain prerequisite resolved

Initial failure:

```text
scripts/build_installer.ps1
→ ISCC.exe not found
```

Inno Setup was installed through `winget`:

```text
JRSoftware.InnoSetup 6.7.3
```

Observed per-user compiler path:

```text
C:\Users\gusrm\AppData\Local\Programs\Inno Setup 6\ISCC.exe
```

Bounded correction:

```text
scripts/build_installer.ps1
→ add %LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe discovery
```

Rerun result:

```text
scripts/build_installer.ps1  passed
```

Inno Setup emitted a non-blocking warning that `x64` is deprecated and `x64compatible` is preferred.

## Structural production-default failure and correction

The fresh installed Register-equivalent workflow initially failed with:

```text
sqlite3.IntegrityError: FOREIGN KEY constraint failed
```

The schema-only production database lacked the category and store identifiers required by current Register defaults.

Bounded correction:

```text
category F / General
store 1 / Default Store
```

These rows were added idempotently through database compatibility handling. They are structural application defaults, not sample business data. Tests continue to require zero sample products and zero sample purchases.

After correction:

```text
python -m compileall app main.py       passed
python -m unittest discover -s tests  passed: 5 tests
scripts/build_windows.ps1             passed
scripts/build_installer.ps1           passed
```

## Sprint 02 artifact evidence

Frozen executable:

```text
dist\Markei\Markei.exe
SHA256 E13E276139E5F680D91A9816FC79776EB9837CA901C2DEBCF6B9CFAF8594A282
size 2,173,220 bytes
```

Installer:

```text
dist\installer\Markei-Setup-0.1.0-x64.exe
SHA256 122A772D66BBE7D5522EF2262E7E89D6D2E332B6318135BB25D55A27F75F4623
size 34,448,651 bytes
```

Distribution inspection confirmed `schema.sql` and excluded `seed.sql`, live database, WAL/SHM, and startup logs.

## Automated installed lifecycle evidence

Environment:

- current ordinary Windows user;
- existing `%LOCALAPPDATA%\Markei` backed up before lifecycle testing;
- original user state restored afterward;
- no dedicated clean account used.

Validated transitions:

```text
silent per-user install
→ installed executable under %LOCALAPPDATA%\Programs\Markei
→ Start Menu shortcut launch
→ external database creation
→ Register-equivalent ProductService persistence
→ Lists / History / Settings projection evidence
→ normal close
→ immediate reopen
→ same-version reinstall with retained data
→ uninstall with database retained
→ reinstall and retained-data recovery
```

Technical dataset evidence:

```text
category count  1
store count     1
product count   1
purchase count  1
product         T006 / Cycle 06 Test Product
quantity        2 unit
latest price    3.5
status          in-house
week boundary   wednesday
```

Installed close/reopen succeeded repeatedly, with `CloseMainWindow()` returning true and data remaining present.

## SmartScreen and antivirus boundary

Observed:

```text
Microsoft Defender enabled
real-time protection enabled
installer Authenticode: NotSigned
executable Authenticode: NotSigned
```

No SmartScreen prompt was observed during silent/programmatic execution. Human-visible SmartScreen behavior remains unknown.

## Evidence classification after Main reconciliation

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Human-visible installer wizard behavior, full visible Register/Lists/History/Settings walkthrough, visible close/reopen confirmation, SmartScreen interaction, and final human/Main acceptance remain pending.

# 5. Generated Installer Repository Contradiction

`G_OPS_CODEX.md` states that the installer was generated but not committed. Current branch evidence shows:

```text
dist/installer/Markei-Setup-0.1.0-x64.exe
blob SHA a586406f660e78a58ddf13cc09a061ddb7385269
```

The binary therefore exists in repository history. Operational classification:

```text
report statement: incorrect
repository state: generated installer binary committed
policy: generated release binaries should not remain ordinary source-controlled files
```

This documentation update does not remove the artifact. A separate authorized cleanup should remove it, add ignore coverage, and retain the binary through an approved release/artifact channel with its recorded hash and size.

# 6. Current Record Boundary

Sprint 02 technically completed the compiled-installer and automated installed-lifecycle route. Cycle 06 remains open because acceptance is a separate human/Main gate.

Retained debt:

- workflow atomicity across multi-commit user actions;
- Inno Setup `x64` deprecation warning;
- optional dedicated-account rerun if current-user evidence is later judged ambiguous;
- broader migration/reset failure validation;
- generated-artifact repository cleanup.

Future entries should record human-visible acceptance evidence, artifact cleanup, any bounded correction triggered by manual walkthrough, and final Cycle 06 closure.

# 7. Cycle 07 Sprint 01 — Mobile Portability Investigation and Reconciliation

## 2026-07-12 — Investigation boundary

Cycle 07 began on `cycle-07-mobile-preparation` from the accepted Cycle 06 closure baseline. Sprint 01 was investigation-only. No application code, framework project, toolchain, database, or ordinary desktop user data was modified or opened.

The investigation observed:

```text
reusable behavior exists
≠
the current desktop application is mobile-portable
```

Likely reusable surfaces were Python domain models, validation and calculation rules, workflow meanings, schema semantics, structural defaults, and deterministic desktop behavior as a fixture source. Coupled surfaces included concrete service/repository construction, SQLite lifecycle and global paths, presentation-shaped service projections, incomplete abstract contracts, and separately committed workflow mutations.

No Android/iOS runtime, package, lifecycle persistence, semantic-parity suite, accessibility behavior, or distribution path was demonstrated.

## Preserved pathway 1 — Operational challenger

Operational recorded a time-boxed Python-native Android experiment as the cheapest direct falsification test for existing Python reuse.

The apparent economy is direct: reuse the Python models, calculations, services, repository behavior, and possibly SQLite schema inside one Android package; initialize a fresh app-private store; execute one receipt workflow; close and reopen; verify persistence.

This pathway becomes expensive if the supposedly narrow experiment expands into broad construction refactoring, custom binary recipes, repeated SDK/NDK/JDK/WSL troubleshooting, native bridges, framework-specific lifecycle corrections, accessibility/platform-integration workarounds, or a separate iOS adaptation. Debugging may cross Python, framework runtime, packaging recipes, Gradle/Android tooling, and device behavior. An Android success would not prove iOS feasibility, maintainability, or distribution readiness.

Observed classification:

```text
cheapest direct experiment
bounded challenger
not final architecture evidence
not authorized
```

## Preserved pathway 2 — Design strategic direction

Design recorded a native/cross-platform client with explicit, language-neutral contracts and deterministic fixtures as the stronger current direction for maintained Android/iOS development.

Its cost begins earlier and is more visible: learn and configure another language/framework; establish Android and iOS SDK boundaries; reimplement relevant behavior and persistence; construct shared fixtures; and verify semantic parity with accepted desktop behavior.

That cost may reduce later expense when the mobile client has conventional ownership of navigation, accessibility, lifecycle, local persistence, packaging, and platform integration; contracts keep business facts separate from presentation labels; fixtures expose drift; and Android/iOS maintenance follows supported framework paths rather than a layered embedded-Python packaging boundary.

Android and iOS still have different operational environments. Android development may use Windows-supported tooling, while iOS build, signing, simulator/device, and distribution validation require macOS/Xcode. Cross-platform source does not remove separate platform gates.

Observed classification:

```text
stronger strategic candidate
higher initial setup and behavior-porting cost
potentially lower maintained-product cost
not empirically proven
framework not selected
not authorized
```

## Human/Main planning preference

Human/Main direction currently favors the Design pathway. This is recorded as a planning preference, not as empirical proof, framework acceptance, or implementation authorization.

The two pathways answer different questions:

```text
Operational:
What is the cheapest bounded experiment that can falsify direct Python reuse?

Design:
What architecture is strongest if mobile becomes a maintained Android/iOS product?
```

They remain preserved rather than collapsed into a false consensus.

## Unresolved cost assumptions

The following remain assumptions until measured:

- how much current Python behavior can execute unchanged in a mobile package;
- whether required construction and path seams remain narrow;
- how much business behavior a strategic client must reimplement;
- the cost of producing language-neutral contracts and golden fixtures;
- mobile SQLite/library maturity and migration ownership;
- suspend/resume and terminate/relaunch failure behavior;
- debugging cost across runtime and native-toolchain boundaries;
- accessible UI and platform-integration effort;
- Android-versus-iOS build and device differences;
- dependency upgrade and packaging maintenance over time.

A cheap prototype becomes expensive when success requires continuing exceptions, custom packaging, duplicated lifecycle work, or an architecture that cannot satisfy maintained-product requirements. A costly initial architecture reduces later cost only when its contracts, fixtures, persistence ownership, tests, and supported platform tooling actually prevent drift and repeated rework.

## Reconciliation result

```text
Cycle 06: accepted and closed
Cycle 07 Sprint 01: complete
strategic planning preference: Design pathway
bounded challenger: Operational Python-native Android experiment
backend: deferred
implementation authorization: none
D/E/F: postponed
next work: documentation, contract/fixture specification, and explicit later experiment gates
```

No stable Operational rule was promoted into `12_OPERATIONAL_MODEL.md` during this pass. The pathway comparison and cost assumptions remain observational; current state and active evidence gaps were refreshed separately.


# 8. Cycle 07 Sprint 02 — Flutter Shared-Beta Planning Reconciliation

## 2026-07-12 — Flutter client-basis supersession

Human/Main established Flutter/Dart as the primary planning basis for the maintained Windows/Android/iOS client. This superseded the earlier TypeScript-client exploration direction only at the client boundary.

TypeScript retained a favored role for the custom synchronization API and protocol harness. Neon Postgres remained favored managed shared persistence. Python/PySide6 remained the accepted Cycle 06 application, reference behavior, legacy migration source, and rollback. No embedded Python runtime or cross-language client IPC bridge was accepted.

## Domain-report reconciliation

Operational, Didactic, and Design restaging converged on:

```text
Flutter/Dart shared client
→ application-private local persistence
→ account-private reusable catalogue
→ atomic Purchase + Purchase Items + pending event
→ authenticated TypeScript synchronization API
→ Neon Postgres accepted account-scoped event history
```

The reports also preserved language-neutral JSON contracts, deterministic fixtures, immutable event/device/account identities, idempotent retry, per-device ordering, account-scoped cursor download, transactional local application, versioned analytics, and protected Cycle 06 data.

This was planning reconciliation only. No Flutter project, Dart model, TypeScript API, Postgres schema, authentication integration, external account, or infrastructure was created.

## Operational experiment candidates

The first persistence candidate for a later bounded experiment is Drift because its documented feature set aligns with transactions, migrations, typed queries, tests, and the three target platforms. `sqflite_common_ffi` remains a comparison candidate.

`flutter_secure_storage` is a credential-storage candidate for packaged evaluation. Its advertised targets do not establish secure or correct behavior for Markei. Backup, upgrade, logout, reinstall, token rotation, and platform-specific failure behavior remain untested.

The favored local protocol environment is:

```text
Dart fixtures + two isolated local stores
TypeScript API
disposable local Postgres
fake/test identity issuer
structured correlation logs
```

A later Neon test environment is permitted only after local protocol proof.

## Platform validation direction

Windows and Android are the first paired evidence targets because the current development context can address them without claiming iOS parity. Required evidence includes clean build/run, fresh local database, aggregate/event atomicity, close/reopen, secure storage, fixture parity, sync retry/gap/cursor/bootstrap/account isolation, and proof that the Cycle 06 database remains untouched.

iOS remains an explicit macOS/Xcode boundary. No iOS compatibility, plugin behavior, package, signing, Simulator/device, or lifecycle evidence exists.

## Evidence classification

```text
Flutter/Dart client basis: accepted planning decision
TypeScript API: favored planning decision
Neon Postgres: favored planning decision
Drift: first experiment candidate
sqflite_common_ffi: retained comparison
flutter_secure_storage: candidate
Windows/Android compatibility: assumption until execution
iOS compatibility: unvalidated pending macOS/Xcode
implementation/infrastructure evidence: none
D/E/F: postponed
```

Next Operational evidence target is Sprint 03 preparation: pinned environments, canonical fixtures, isolated local persistence, atomic Purchase/event, local TypeScript/Postgres protocol failures, Windows/Android execution, Cycle 06 isolation, and later iOS/Neon gates.

---

<!-- TEMPORAL_MARKER:C07-S02-CLOSURE -->
> **Temporal boundary — Cycle 07 Sprint 02 closure (2026-07-12).** Content above this marker belongs to the preparation and first-reconciliation state established before Sprint 03 materialization. Content appended below it belongs to Sprint 03 or later. If recovery cost becomes excessive or this file grows beyond approximately 1,000 lines, this reviewed marker is an eligible semantic-partition boundary under human/Main authorization.
# Cycle 07 Sprint 03 Unit 01 — Flutter Foundation Materialization

## 2026-07-12 — Environment and materialization

The authorized Sprint 03 Flutter Foundation was materialized on `cycle-07-mobile-preparation`.

Initial host state:

```text
flutter: unavailable
dart: unavailable
Android SDK: unavailable
Visual Studio C++ desktop workload: unavailable
macOS/Xcode: unavailable
```

After human-approved setup:

```text
Flutter 3.44.6 stable
revision ee80f08bbf
Dart 3.12.2
Windows host detected
Android/Windows build prerequisites incomplete
iOS host unavailable
```

Created implementation surfaces included:

- `clients/markei_flutter/` with Android, iOS, and Windows target directories;
- handwritten Dart domain/application/infrastructure source;
- Drift schema and generated `local_database.g.dart`;
- committed `pubspec.lock`;
- `contracts/shared_beta/v1/` semantic JSON examples.

## Commands and results

```text
flutter create                                      passed
flutter pub get                                     passed
dart run build_runner build --delete-conflicting-outputs  passed
dart format                                         passed
flutter analyze                                     passed, no issues
flutter test                                        passed, 9 tests
python -m unittest discover -s tests                passed, 5 tests
```

The tests evidenced exact packaged/bulk normalization examples, warning-only similarity behavior, dimensional quantity and money structures, atomic Purchase + Items + event + pending queue registration, invalid-item rollback, temporary-file close/reopen persistence, and a minimal analytic registry.

## Generated versus handwritten ownership

```text
handwritten Dart
    reviewed directly

Drift-generated Dart and Flutter platform runners
    reviewed through generator input/configuration
    plus clean regeneration/build evidence

pubspec.lock
    committed dependency-resolution evidence

build outputs and local databases
    generated runtime artifacts, not source truth
```

## Host limits and skipped scope

Android/iOS/Windows directories were generated but none was built or run. Windows was blocked by the missing Visual Studio desktop workload; Android by the missing SDK; iOS by the non-macOS host. No platform lifecycle claim was established.

TypeScript API, authentication/authorization, Postgres/Neon, actual upload/download, cross-device convergence, legacy import, full Purchase UI, and PySide6 retirement were skipped/deferred.

The Flutter implementation did not discover, open, copy, rename, migrate, hash, or inspect the ordinary Cycle 06 database. Python regression execution produced no tracked database change.

## Evidence-triggered defects and risks

Main reconciliation identified:

1. likely device-sequence reset/reuse on repeated registration;
2. missing account/device/sequence uniqueness evidence;
3. `\w`-based normalization risk for accented Portuguese text;
4. deterministic Product ID without fixed cross-language/RFC contract;
5. shallow Purchase/event fixtures rather than complete wire schemas;
6. unrehearsed Drift schema evolution and ambiguous ledger timestamp meaning;
7. exact-name-only Store reuse and no Store deduplication model.

These remain unresolved. Monotonic ordering, Unicode-safe identity, complete protocol contracts, platform execution, and distributed synchronization must not be described as validated.

## Main route orientation

J §19 favors a local shared-client vertical slice before the synchronization harness, with sequence correction and contract hardening first. This is Main orientation, not Sprint 04 implementation authority.

# Cycle 07 Sprint 04 — Operational PDR2 Reconciliation

## 2026-07-12 — Evidence reconciled

PDR2-O reconciled the Sprint 03 Operational Codex report, J §21, Sprint 04 A staging, current Flutter/Python source truth, and all four permanent Operational roles at branch head `32898f56f76895dc0f23d72cd132bcc24830e740`.

Confirmed execution evidence remains:

```text
Flutter 3.44.6 / Dart 3.12.2 installed
flutter pub get passed
Drift generation passed
format passed
flutter analyze passed
flutter test passed: 9
Python regression tests passed: 5
fresh Drift schema and temporary-file close/reopen passed
Windows build/run blocked by missing Visual Studio native-desktop workload
Android build/run blocked by absent SDK/device tooling
iOS host-unvalidated outside macOS/Xcode
```

Repository inspection confirmed that the Flutter presentation remains a foundation label; the local schema remains version 1; Device upsert can reset `nextSequence`; Product display fields and user Product code are absent; normalization v1 remains unsafe for Portuguese/Unicode identity; v1 JSON documents remain examples without executable schemas; and TypeScript/API/Postgres/Neon/authentication/synchronization remain absent. The Flutter store remains distinct from the protected Cycle 06 database.

J §21 accepted the Sprint 04 planning resolution: UUID v4 for new immutable internal Product identities; required account-private user Product code; Unicode NFKC normalization v2 with preserved display text; `shared_beta/v2` using JSON Schema Draft 7 and readable examples; Drift schema v2 migration; sequence uniqueness and 1,2,3 recovery proof; minimal multi-item UI/history; Windows build/run; conditional Android build only if tooling already exists. These are accepted instructions for forthcoming D/E/F, not implementation evidence.

No commands, installations, migrations, builds, tests, or application executions were performed during this reconciliation. No source or user database was modified.

# Cycle 07 Sprint 05 — Android Materialization and PDR2 Confrontation

## 2026-07-12 — Host, build, runtime, and regression evidence

PDR2-O reconciled `G_OPS_CODEX.md`, J §24, Sprint 05 A and D, repository comparison from `c2d74e445a6c7819b9c36573f6d63836d990c471`, current Android/Dart/tests, and all four permanent Operational roles at inspected head `ca53097b346ae42b216188dabc56a6eef45b051c`.

Host/tool evidence:

```text
selected Flutter SDK: H:\Users\Gus\develop\flutter
alternate C:\Users\gusrm\flutter: inspected, not modified
Android Studio: 2026.1.1.10 installed
Android SDK: C:\Users\gusrm\AppData\Local\Android\Sdk
Platform / target: Android 36
Build-Tools: 36.0.0
CMake: 3.22.1
NDK: 28.2.13676358
system image: android-36 google_apis x86_64
AVD: Markei_Sprint05_API36
licenses: accepted with human confirmation
flutter doctor: Android toolchain healthy
```

Materialized runtime identity includes `com.gusigu.markei`, label `Markei`, the moved Kotlin host, compile/target SDK 36, asynchronous composition bootstrap, and a Drift-backed UUID-v4 Device identity that is reused after database reopen. The repository contains tests for fresh identity, reopen reuse, distinct databases, monotonic sequence, historical non-UUID preservation, and a phone-width Purchase/History flow.

Validation evidence:

- formatting and analysis passed;
- 27 Flutter tests passed;
- debug APK built, badging inspected, installed, and launched;
- API-36 emulator booted as the intended target;
- app-private database observed at `/data/data/com.gusigu.markei/files/markei_shared_beta.sqlite`;
- runtime database contained one UUID-v4 Device, `next_sequence = 2`, and one Purchase;
- human confirmed Purchase registration on the emulator;
- Windows release build passed;
- five Python regressions passed;
- Cycle 06 source/database isolation remained reported.

The accepted operation is **Purchase registration**. G's phrase “purchase upsert/registration” is corrected here: source evidence does not support mutable Purchase replacement and “Purchase upsert” is not accepted terminology.

## Evidence limits and required supplement

ADB-driven form entry was blocked by emulator input/stylus overlays and Gboard behavior. Launch, force-stop/relaunch, database inspection, and the human registration prove a meaningful Android-local slice, but do not provide a complete checklist for keyboard obstruction, Android Back, rotation, background/resume, text scale, staged-state behavior, or a human-visible History check after process restart. Physical-device, Android release/signing, upgrade, backup, accessibility, and Play Store evidence are absent.

A supplemental Android lifecycle checklist is therefore required before Sprint 05 closure. It is evidence-first: no source change is authorized unless the checklist exposes a bounded defect and Main separately routes that correction.

## Repository/report contradiction

G says `clients/markei_flutter/devtools_options.yaml` was preserved untracked and not committed. Repository comparison shows it was added as a three-line DevTools extension configuration file. It has no enabled extension and no demonstrated build/runtime effect, but G's scope statement is inaccurate.

Intentional project ownership is not established. The file remains committed during this documentation pass. Main/human should later choose either to retain it as explicit shared DevTools configuration or remove/ignore it in a bounded hygiene change. No source cleanup is implied by PDR2-O.

## Installed-environment recovery and cost

The Android SDK and AVD are reproducible from the recorded component/version manifest; they are not source artifacts. Exact disk consumption was not recorded, so storage cost remains unknown. The system image, emulator, NDK, CMake, build tools, and Gradle caches are expected to be the major host-storage consumers, but no numeric cost is promoted.

Preserve the SDK and AVD until the lifecycle supplement is complete. Later recovery or cleanup must inventory installed SDK packages and AVDs first, remove only named components through supported SDK/AVD tooling under explicit authority, and never delete the whole SDK directory or unrelated user configurations merely to reclaim space.

No commands, installations, runtime actions, or source changes were performed by this reconciliation.

---

<!-- TEMPORAL_MARKER:C08-ENTRY-2026-07-12 -->
> Temporal boundary — Cycle 08 begins here. Content above belongs to Cycle 07 or earlier reviewed project history; content below belongs to Cycle 08 work and later reconciliation.

# Cycle 08 C08-PB-01 — Operational PDR2 Reconciliation

## 2026-07-13 — Materialization and evidence classification

PDR2-O reconciled A, G, latest J orientation, repository comparison from directive head `4f5ef21cb0d31f5efbf386b3e51cff15c543a802` to implementation head `fb3b7f21e007e383e5951f4bb67b95d283f7a6fc`, current Flutter source/tests, and all four permanent Operational roles.

Implemented repository behavior includes responsive Purchase/Products/History navigation; Product browse/search/create and advisory reuse/create-anyway; existing/new Store references; a session-only keyed Purchase draft with edit/remove/review; in-flight duplicate-submit mitigation; detailed History; and compatible same-Product price-change calculation. The existing atomic Drift registration transaction remains unchanged.

Validated automated evidence:

- focused Flutter widget path: 6 tests passed;
- Dart formatting: 34 files checked, none changed;
- Flutter analysis: no issues;
- complete Flutter suite: 31 tests passed;
- Windows release build produced `build\windows\x64\runner\Release\markei.exe`;
- Python regressions: 5 tests passed.

Evidence limits:

- the Windows artifact build passed, but no manual Windows launch or workflow smoke was performed;
- Android APK build is host-unvalidated because `JAVA_HOME` is unset and `java` is unavailable in `PATH`;
- Android runtime, keyboard, Back, rotation, background/resume, restart, and physical-device behavior were not revalidated for this materialization;
- phone-width automated coverage checks shell/local/empty states, while the long-form registration path is covered only at wide width;
- Product creation success is visible in repository/list state, but transient success copy is not asserted;
- duplicate-submit handling is mounted-session busy-state mitigation, not durable idempotency;
- export/restore, corruption recovery, performance budgets, production signing, distribution, and synchronization remain absent.

Repository comparison records tracked validation artifacts:

- `app/__pycache__/__init__.cpython-314.pyc`;
- `app/__pycache__/startup_diagnostics.cpython-314.pyc`;
- `app/core/__pycache__/config.cpython-314.pyc`;
- `app/core/__pycache__/database.cpython-314.pyc`;
- `tests/__pycache__/test_release_configuration.cpython-314.pyc`.

These are generated bytecode, not source truth. They were preserved because materialization prohibited cleanup. Removal and ignore-policy correction require a separate bounded hygiene change.

Source inspection found one existing-Product edit defect in `PurchasePage`: when a staged line was created by selecting a similar existing Product, `_editLine` restores quantity/price fields but not the existing Product selection/reference. The editor can fall into the new-Product path with cleared Product fields, so saving the edited line does not reliably retain the same existing Product. This defect is not covered by the six focused widget tests and remains blocked pending a bounded source fix.

No permanent reconciliation command rebuilt, launched, installed, migrated, or modified application data.

---

<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


## 2026-07-14 — Intermid Recovery existing-Product edit correction

Sequence: `FLX-PRM-04`  
Implementation commit: `409e5f1e013a282165efd5f31bed17a396ad6543`  
Reconciliation baseline: `84fc6e4e49dedc7ce629a97a78dd86486dbf0cf8`  
Evidence: `DEV_STAGE/G_OPS_CODEX.md`, latest `J_MAIN_STAGE.md` post-Codex reconciliation, repository source and widget regression

The bounded D/E/F unit corrected the staged-line edit path for an existing Product. Edit state now retains the original `ProductReference` and Product label while package count, purchased quantity/unit, and line total remain editable. Saving reuses the retained existing Product identity; the regression asserts that registration keeps the original Product ID and does not create a duplicate Product row.

Observed materialization scope:

```text
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/test/app/markei_app_test.dart
DEV_STAGE/G_OPS_CODEX.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/I_DSN_CODEX.md
```

Recorded command outcomes from G:

```text
dart format touched Dart files                 passed
flutter test test/app/markei_app_test.dart    passed: 7 tests
flutter test                                  passed: 32 tests
flutter analyze                               passed: no issues
```

Intermediate focused-test failures occurred while shaping the regression and were resolved before final validation. They are development chronology, not final blockers.

PRC-01 disposition:

- existing-Product edit defect: prior defective state superseded; corrected implementation accepted;
- existing-Product identity retention: validated by the named widget/repository regression;
- edited Item values and absence of duplicate Product: validated within the in-memory widget integration boundary;
- generic `ProductReference` retention for new-Product lines: implemented by source structure, but not separately regression-validated;
- Windows, Android, iOS, file-backed restart/migration, manual workflow, lifecycle, packaging, release, and distribution acceptance: unchanged and not established by this unit;
- schema, migration, dependency, synchronization, transaction-failure infrastructure, and generated-artifact behavior: unchanged.

No source, host, schema, migration, dependency, or permanent non-Operational surface was changed during this reconciliation.


---

## 2026-07-14 — Cycle 09 C09-U02 Operational reconciliation

Sequence: `FLX-PRM-04`  
Implementation commit: `e37cb700feeca4001cc7835b584c46bb81926af3`  
Instruction baseline: `06714d719c22ebd6b64008b7dcec745faee8fcd5`  
Sources: Cycle 09 A, controlling D, G, post-Codex J, implementation diff and targeted source/test inspection  
Evidence boundary: Codex-host commands plus repository inspection; this reconciliation reran no Flutter, platform or host command

Materialization changed 35 paths: 32 Flutter source/test paths and G/H/I. The protected Python/PySide6 source and database were unchanged.

Implemented repository evidence includes schema v3; People, Payment Methods and Account preferences; nullable Purchase references; nullable BULK package count; Product normalization v3; sequential v1/v2 migration handling; typed application failures; comma/point quantity parsing; kg/g/L/ml/un handling with fractional COUNT rejection; exact Product lookup ports; Home-first navigation; Lists projections; Catalogue details; Settings; History selection; deterministic selected-Purchase CSV; and PDF-byte generation/local save.

Recorded validation from G:

```text
flutter pub get                                      passed
Drift/build_runner regeneration                     passed
dart format lib test                                passed
flutter test                                        passed: 39
flutter analyze                                     passed: no issues
git diff --check                                    passed; CRLF notices only
python unittest release configuration               passed: 5
flutter build windows                               passed
Windows bounded five-second process launch          passed
flutter build apk                                   host-blocked: Java/JAVA_HOME absent
pytest                                              unavailable on Codex host
```

PRC-01 dispositions:

- schema v3, migration routes, local reference storage, quantity normalization, projection/export code and navigation: **implemented**;
- 39 Flutter tests and clean analysis: **validated within automated Codex-host scope**;
- Windows release artifact and bounded launch: **validated as build/smoke only**, not manual workflow or lifecycle acceptance;
- Android: **host-unvalidated**, not a product failure;
- Python: five repository `unittest` regressions passed; pytest coverage remains unavailable;
- BULK nullable package count: **implemented**; required price-per-unit entry/half-up total derivation: **contradicted as completed** because UI still requests Line total;
- PDF bytes/local temporary-file save: **implemented**; native/save-destination sharing: **partial/deferred**;
- typed `AppFailure` infrastructure: **implemented**; consistent user-facing code/field/recovery/outcome presentation: **partial** because pages still collapse many errors into generic copy;
- exact Product lookup ports: **implemented**; explicit exact-lookup Catalogue workflow: **partial** because visible search remains substring filtering;
- History checkbox/tap selection: **implemented**; select-all and desktop double-click shortcut: **not found**;
- Product detail panel: **implemented** through tap/long-press; shared adaptive detail route and desktop double-click: **not found**;
- active nickname uniqueness: **partially contradicted** because `(accountId, normalizedNickname, active)` also limits duplicate archived nicknames;
- Product codes: creation/migration populate them, but schema columns remain nullable; no database NOT NULL invariant is accepted;
- full manual Windows workflow, Android, dense phone-width UX, migration failure injection and native sharing: **unvalidated or absent**.

Deferred boundaries remain authentication, API/Neon/synchronization, external analytics, Product correction/merge, Store redesign, SubmissionId, persisted drafts, registered Purchase mutation, native share, Household behavior and production release.

No source, methodology, Main continuity or non-Operational memory changed during this reconciliation.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.


---

## 2026-07-14 — Cycle 09 Sprint 02 current-UI observation

Sequence: evidence-only Operational observation  
Role: Operational Chat [O]  
Sprint boundary: latest `C09-S02-ENTRY-2026-07-14` marker  
Inspected commit: `c67d573f1335ffd55c659a9ee795982ca72c2c32`  
Writable surface: this observational record only  
Evidence boundary: user-described screenshots/current runtime plus GitHub source/test inspection; no local Flutter execution, test rerun, emulator, manual input replay, or pixel inspection was available

### Evidence-source separation

**User-observed runtime behavior**

The user reports from the current Flutter UI that:

- Purchase does not expose the intended time/date field after Store;
- Catalogue Product selection is difficult or non-functional for the intended workflow;
- Catalogue lacks the expected desktop double-click selection;
- Lists do not surface the Catalogue Products associated through Purchase relational data;
- Person and Payment Method expose nickname but no visible ID;
- BULK Product/Purchase flows lack price-per-unit or price-per-volume input and automatic total calculation;
- the current visual presentation remains materially different from the previously accepted mockup direction.

These are valid current-session observations. Exact reproduction inputs, database contents, viewport, platform and action sequence were not captured in this pass.

**Screenshot evidence**

The prompt identifies target mockups 1–5 and current screenshots 6–10. The image binaries are not present in the connected repository or exposed to this Operational chat, so no pixel-level claim about color, spacing, typography, hierarchy or exact control placement is made here. The user’s identification of screenshots 6–10 as the current UI and 1–5 as targets is archived as provenance. A later Main/Design pass should retain the images or a numbered visual inventory in an accessible evidence surface before translating aesthetics into executable acceptance criteria.

**Source evidence at `c67d573`**

- `PurchasePage` sends `DateTime.now().toUtc()` directly during registration. It has no date/time controller, picker or visible purchase-occurrence field after Store. The reported absence is source-confirmed.
- Catalogue rows use `onTap` and `onLongPress` to show an inline Product detail panel. No double-click handler, explicit “Select Product” action or shared selection callback exists in `ProductsPage`. Product selection for Purchase is instead a separate dropdown inside `PurchasePage`. The intended cross-page selection workflow is therefore absent.
- `ListsPage` calls `ProductListProjectionRepository.productListProjection`; `LocalQueryRepository` reads Products and Purchase/PurchaseItem observations and constructs projections. Relational projection code exists. The user-observed empty/failing result may reflect data association, projection classification, refresh, threshold/date logic, or presentation state; source inspection alone does not identify which.
- Settings and Purchase use `LocalReference.id` internally, but Settings renders `reference.historyLabel` plus Active/Archived only. No Person or Payment Method ID text is presented. The reported visible-ID gap is source-confirmed.
- BULK makes `packageCount` null and hides Packages bought, but the quantity area still requests `Line total`. No price-per-unit/volume controller or automatic half-up total derivation exists. The reported BULK pricing gap is source-confirmed.
- The shell supplies ten destinations to one `NavigationRail` or one phone-width `NavigationBar`. No compact overflow menu, grouped secondary navigation, drawer or destination paging is present. Ten labels in the narrow bar create a strong density/legibility risk; actual overflow/clipping remains runtime evidence.
- Major pages use `ListView`, so vertical scrolling exists structurally. The long-form Purchase widget test is performed at wide width; the 390×844 test checks only shell/local notice/empty History. Phone-width form completion, keyboard obstruction and overflow remain unvalidated.
- `IndexedStack` preserves destination widgets while switching between narrow and wide layouts; one widget test confirms the selected destination survives a width change. This is presentation-state continuity evidence, not process restart or complete desktop/mobile workflow continuity.
- History has explicit loading/error/retry/empty states. Lists has loading/error/empty text but no visible retry action. Catalogue and Purchase expose loading plus generic feedback; their error recovery is less explicit and commonly catch-all. Screenshot/runtime behavior is still needed for focus retention, recovery after retry and long-content scrolling.
- Navigation already labels Analytics/Household as planned and disabled. Their presence contributes to current density even though they do not provide executable workflows.

### Target-versus-current Operational gap register

1. **Purchase occurrence editing — confirmed absent.** Required reproduction: choose Store, inspect the next focusable control, register with a non-current intended timestamp, then verify History/storage value and timezone formatting `hh:mm _ dd/mm/yyyy`.
2. **Catalogue selection — confirmed interaction mismatch.** Required reproduction: keyboard, ordinary click/tap, long-press and desktop double-click on an existing Product; record whether detail opens, selection state becomes visible, and Purchase can consume that Product without a separate ambiguous search.
3. **Lists relational projection — runtime failure reported, implementation present.** Required fixture: at least one Product with one Purchase and one with two dated Purchases; capture Product IDs, PurchaseItem links, threshold, current date, selected Storage/Shortage/Market/All view, query result and rendered state.
4. **Reference IDs — confirmed presentation omission.** Required decision: whether users should see the full immutable ID, a short stable display code, or “ID · Nickname,” and on which Settings/Purchase/History/export surfaces.
5. **BULK pricing — confirmed incomplete.** Required fixture: kg/L amount plus price per unit/volume, comma and point decimals, deterministic rounding and derived Line total; confirm whether total remains editable or read-only.
6. **Responsive density — risk supported, failure unmeasured.** Required viewports: 390×844, narrow desktop, 720 px transition, ordinary wide desktop; record clipped labels, rail height, touch target size, horizontal overflow and scroll reachability.
7. **Scrolling and focus — partial source support.** Required tests: complete long Purchase and Settings flows with keyboard open, larger text, focus traversal, Back, rotation/resize and return to prior destination.
8. **Loading/empty/error recovery — uneven implementation.** Required fault fixtures for Catalogue, Lists, Purchase references and History; verify distinct messages, retry affordance, retained selection/draft and successful recovery.
9. **Desktop/mobile continuity — partially evidenced only.** Required paired workflow: same seeded database, Catalogue selection → Purchase → Lists → History on desktop width and phone width, plus close/reopen where file-backed continuity is claimed.
10. **Aesthetic transition — not operationalized.** Numbered mockup elements must be translated into measurable hierarchy, spacing, control order, responsive behavior and state requirements before implementation authorization.

### Archived observations and non-conclusions

Archived as observed: the user’s current-UI gaps, screenshot numbering/provenance, and requested Sprint 02 comparison scope.

Source-confirmed: occurrence field absent; Catalogue selection/double-click mismatch; reference IDs hidden; BULK price-per-unit absent; ten-destination density risk; uneven recovery affordances; insufficient phone-width workflow coverage.

Not concluded:

- Lists repository logic is absent;
- relational data is corrupt;
- a specific query or migration is defective;
- screenshots prove behavior outside the captured frame;
- navigation actually overflows on every device;
- target mockup aesthetics are fully specified;
- any source/schema correction is authorized.

### Questions requiring Main selection

1. Is Purchase occurrence user-editable, default-now editable, or display-only, and what timezone/storage/display contract applies?
2. Does Catalogue selection navigate into Purchase, create a shared selected-Product state, or only open Product details?
3. Is desktop double-click required acceptance or optional convenience after explicit action/tap/keyboard paths?
4. What exact cycle fixture and status thresholds define a correct Lists projection for one versus multiple Purchases?
5. Which visible ID form is acceptable for Person and Payment Method?
6. For BULK, is price per unit authoritative with derived total, and may the derived total be overridden?
7. Which destinations remain primary on phone width, and which move into secondary navigation?
8. Which numbered target-mockup elements are functional acceptance requirements versus aesthetic preference?
9. Should Sprint 02 first authorize an evidence/reproduction pass, or freeze a combined functional-and-aesthetic implementation unit?

Recommended next handoff: Main should reconcile this observation with Design/Didactic Sprint 02 evidence, secure accessible copies or structured inventories of screenshots 1–10, freeze the nine decisions above, then prepare bounded D/E/F. No implementation authority is implied by this record.

---

## 2026-07-14 — Cycle 09 Sprint 02 permanent Operational promotion

`FLX-PRM-04`; ancestry `4bf2e52d9d3e23437c4da1d8bb05e2402e189dd5`; implementation `5ddff3c5..1d817972`. Repository reconciliation only; application commands were not rerun.

Promoted: schema v4; mandatory immutable Product codes; Account-scoped `@001...` Person and `#001...` Payment Method sequences; optional labels; manual occurrence; exact Product-code autofill; same-unit BULK read-only calculation; Catalogue selection/details; History select-all/detail access; narrow Lists language repair.

Inherited evidence: migration tests 3, repository tests 6, application focused tests 5, app widgets 7, full Flutter suite 43, clean analysis, five protected Python tests, Windows release build and bounded hidden launch. Android was host-blocked by absent Java.

Boundaries: Windows is not manually/visually accepted; Android, manual accessibility/keyboard/screen reader and native sharing remain unvalidated; PDF/export is fallback; Lists lacks target composition; History double-click focuses detail rather than toggling selection; visual convergence and oversized-page debt remain open.

---

# Cycle 10 — Permanent Operational Registration

## 2026-07-30 — Guarded hosted synchronization and two-Device development closure

Registration authority: human-directed `SEQ-PRM-04` / `PRC-01` Operational reconciliation. Primary evidence: `documentation/REC_LEGACY.md` Records 001–021 and Appendix I; Main orientation: `J_MAIN_STAGE.md` current prefix §§2–5 and the consolidated Cycle 10 historical track record. Registration anchor: `f3bfd3e6829d0f42951e306c449564fb05d7cc9c`.

### Ordered execution and assay chronology

1. **Initial failed/notApplied state and readiness controls — Records 001–006.** Windows began authenticated and enrolled with a local queue of `0/0/2/0`, next Device sequence 3, and one inspection-only two-member recovery candidate. Records 001–003 established that a prior hosted-readiness result, the current failed/notApplied inspection, and ordinary Sync history were different projections. A hosted connection check could time out without queue mutation or proof of Render ingress; after the intended Render deployment, a later readiness check returned trusted HTTP 200 but still proved no Sync. Records 004–006 then separated cold/warm readiness from one bounded ordinary-Sync control and exposed that flat or stale UI projections could not safely attribute current action, history, provider contact, or sequence ownership.

2. **Diagnostic correction and durable binding — Records 007–009.** Consolidated lifecycle presentation made grouped evidence inspectable, while preserving the ceiling that UI alone did not prove provider truth. Post-enrollment correction established durable client binding and corrected current-action projection. Exact identity and transactionally read-only provider inspection then established the bounded binding/provider baseline required for controlled hosted work. J `Legacy_Progress` preserves the DIAG-01 and Gate 12.7 corrective lineage; Appendix I assigns the maintained runtime registry to `contracts/shared_beta/diagnostics_v1/diagnostics.registry.json` and the generated readable projection to `ERR_DIAGNOSTICS.md`.

3. **Same-Device hosted control and GCM02 closure — Records 010–012.** A frozen Windows local preflight preceded one controlled same-Device ordinary Sync and provider postflight. Client, Render/API and provider evidence were correlated rather than inferred from one surface. Render lifecycle correlation closed `GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE`; this was development-scope hosted evidence, not production acceptance.

4. **Second-Device preparation and exact two-Device baseline — Records 013–017.** Windows candidate state was frozen before Android enrollment. Android authentication, pre-enrollment state, cold-boot readiness and post-restart durable enrollment were checked without creating an Android Purchase or executing Sync. Record 016 accepted client-scope durable enrollment but explicitly held exact hosted binding. Record 017 then proved token acceptance, exact Android Device binding, one Account with two active Device rows, consistent Account/Device cursor and sequence baselines, and zero Android submissions/events through a `BEGIN`/`ROLLBACK` provider inspection. The launcher did not independently prove the human-readable Neon branch alias; that coordinate-provenance ceiling remains recorded.

5. **Preserved-client acceptance and corrective failure chain — Records 018–020.** The preserved Android installation passed offline Purchase selection/review/registration and created one pending event without an observed duplicate Product. Its first hosted operation received trusted upload and download responses, but local apply stopped on a typed natural-identity conflict and acknowledgement did not start. Windows then received trusted upload/download responses but ended in an unclassified runner terminal that incorrectly projected trusted response as absent. These observations justified the R03–R05 corrective line: natural-identity convergence, remote-reference mapping, apply rollback translation, separation of committed transaction truth from diagnostic-persistence truth, preservation of causal/trusted-response evidence, and acknowledgement only after committed local apply/cursor progress. Trusted provider success was not erased by a later local or diagnostic failure.

6. **Reciprocal convergence and golden no-op repeats — Record 021.** Matching preserved Android and Windows source identities completed Windows-to-Android and Android-to-Windows convergence for one Account. The former conflict converged to one natural-identity Product; no duplicate Product or Purchase was observed; both Histories and Catalogue projections converged; both queues settled at `0/0/0/0`. One ordinary no-op repeat per Device produced distinct operation fingerprints, no submission route in the supplied Render window, and authenticated HTTP 200 download/acknowledgement responses. No Retry, Recovery, Query, repeated Enroll, database repair, or provider repair was used.

### Accepted terminals and validation classes

```text
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
PRODUCT_NATURAL_IDENTITY_MERGE=PASS_HUMAN_ASSAY
CLIENT_QUEUES_FINAL=0_0_0_0_BOTH
NO_OP_REPEAT_PER_DEVICE=PASS_CLIENT_RENDER
DIAGNOSTIC_HISTORY_PRESERVED=YES
```

Evidence classes remain separate:

- **local/client:** queue counts, Device sequence, authentication/enrollment projection, operation lifecycle, Catalogue/History convergence and preserved diagnostic history;
- **Render/API:** request correlation, authenticated child routes, trusted HTTP terminals and the absence of a submission route during the golden no-op window;
- **provider/database:** exact binding and bounded row/cursor/sequence inventories collected by explicitly read-only or rollback procedures;
- **automated test/source:** R03–R05 implementation and regression evidence retained in the corresponding G/H/I and J `Legacy_Progress` entries;
- **build:** source/artifact provenance supported the preserved-client assay, but build success alone did not establish practical convergence;
- **human assay:** Purchase acceptance, reciprocal History/Catalogue convergence, natural-identity merge and absence of observed duplicates;
- **host-unvalidated/unproved:** every claim outside the named development fixture and supplied evidence windows.

### Superseded procedures, contradictions and safe-stop history

- Readiness checks were superseded as evidence for ordinary Sync: readiness may prove bounded reachability/response only and must not advance last-successful-Sync or mutate queues.
- A flat `Last result`, stale current-action card, or generic terminal was superseded as an evidence join. Correlation fingerprints and grouped lifecycle evidence became required.
- Recovery execution remained held while the failed/notApplied candidate lacked bounded ownership and evidence; Cycle 10 closure did not require pressing Retry or Recovery.
- Record 016's changed Device fingerprint was explicitly classified as the expected local-to-hosted identity handoff, not lost enrollment and not proof of exact hosted binding.
- Record 020's terminal claim that no trusted response was received contradicted its own recorded download-response phase and Render HTTP 200. Later correction preserved the trusted provider plane and classified local apply, acknowledgement and diagnostic persistence separately.
- Record 021's contemporaneous terminal still said `CYCLE10=OPEN` and `GCM04=READY_FOR_DEFINITION`. Later human/Main reconciliation in J §§2–3 superseded those sequence-control labels with Cycle 10 closed at GCM03 and GCM04 deferred to C12-PHASE02; the underlying Record 021 observations were not rewritten.
- No final provider-table recount followed the golden no-op repeats. Final practical client/Render convergence is accepted; a fresh final provider inventory is not inferred.

### Evidence ceiling and deferred Operational work

Acceptance is limited to **two Devices, one Account, development environment**. It does not prove multiple-Account isolation; membership disablement or Device revocation; outage, timeout or acknowledgement-uncertainty recovery; retention, snapshot or rebootstrap; production deployment, lifecycle or release acceptance; GCM04; or conditional R07 work. These remain deferred to C12-PHASE02 under separate authority.

### Stable operational ownership pointers

- `GRM`: human-readable guarded procedure entrypoints and ordered assay instructions.
- `G_SCRIPTS`: executable guarded launchers selected by GRM.
- `NS_COORDINATES`: non-secret coordinate and environment selection consumed by the launch chain.
- `I_SCRIPTS`: implementation helpers behind guarded launchers; not the ordinary human entrypoint.
- `DB_MGMT`: bounded manual SQL management and read-only/rollback provider queries.
- runtime diagnostic registry: sole source of stable diagnostic definitions.
- `ERR_DIAGNOSTICS.md`: generated/readable diagnostic projection.
- `REC_LEGACY.md`: sanitized client/server/provider assay chronology.
- J `Legacy_Progress`: append-only Main sequence provenance, superseded gates and corrective progression.

This registration reproduces neither the runtime diagnostic registry nor J's historical catalogue.
---

## 2026-07-30 — C11-PH01-S01 visual foundation materialization

Sequence: `FLX-PRM-04` post-evidence Operational absorption  
Role: Operational Chat [O]  
Unit: `C11-PH01-S01`  
Materialization head: `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`  
Evidence: `DEV_STAGE/G_OPS_CODEX.md` and the current mutable J evidence capsule  
Evidence boundary: source, focused/full automated tests, static analysis and Windows/Android builds; no preserved-client launch, live provider operation or human-platform acceptance

### Implemented and validated evidence

- Stable `MarkeiDestinationId` selection replaced positional selected-index state.
- The shell implements compact `<600`, medium `600–1023` and wide `>=1024` policies while retaining page state through `IndexedStack`.
- Compact direct navigation remains Home, Lists, Purchase, History and More.
- Home and Lists were recomposed on the shared visual foundation.
- Lists wide-table and compact-card presentations consume the same local projection/search/sort state.
- Lists exposes distinct loading, read-error, first-use-empty, filtered-empty, insufficient-history and populated states.
- Lists Retry is read-only and repeats only `ProductListProjectionRepository.productListProjection`; it does not execute protocol Retry or Sync.
- Focused visual/List tests, the existing 26-test application suite, the full Flutter suite, `flutter analyze`, Windows release build and Android debug build passed.
- Business, Sync, diagnostics, recovery, provider, Settings and Closure behavior were unchanged. Analytics and Audit were reserved only as later-phase destinations.

The full Flutter suite reported 245 passing and four skipped tests. The Windows artifact was built at `build/windows/x64/runner/Release/markei.exe`; the Android debug artifact was built at `build/app/outputs/flutter-apk/app-debug.apk`. Exact artifact sizes and SHA-256 values remain in G rather than being duplicated here.

### Validation ceiling and remaining acceptance

Automated widget evidence and successful builds establish implemented/test/build evidence only. They do not establish visual parity or human usability on either platform.

Not performed:

- preserved-client installation or launch;
- Windows or Android human visual acceptance;
- Windows keyboard-only and Narrator acceptance;
- Android TalkBack, density and real-device acceptance;
- approved golden-image or pixel-parity acceptance;
- live Sync, Enroll, Query, Retry, Recovery or provider mutation.

Catalogue, Purchase and History recomposition remains later C11-PH01 work. Analytics calculations remain C11-PH02. Settings/Audit redesign and Closure capability disposition remain C11-PH03. GCM04, multiple-Account work, revocation, outage recovery, retention/rebootstrap and production lifecycle remain deferred to C12-PHASE02.

No Cycle 10 terminal, chronology or Canon is restated by this event.

---

## 2026-07-31 — C11-PH01-R01 and C11-PH02 combined materialization

Sequence: `FLX-PRM-04` post-evidence Operational absorption  
Role: Operational Chat [O]  
Implementation parent: `e802d435cf562e422b7f9118db929235488899bf`  
Implementation commit: `20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6`  
Main reconciliation: `J_MAIN_STAGE.md` section 9 at `0bfc02e8363d8119469a5e8627d8350fa97790b4`  
Evidence: complete `DEV_STAGE/G_OPS_CODEX.md`, implementation diff, relevant source and tests  
Evidence boundary: one Windows validation host, automated/widget evidence, static analysis, Windows release build and Android debug build; no screenshot, assistive-technology, real-device or human acceptance

### PH01 correction and R02 lifecycle evidence

- Purchase and Catalogue remained reachable under constrained height with bounded field separation, wrapping and geometry corrections while preserving the accepted PH01 visual system.
- History retained one checkbox as the selection affordance and a separate row/card activation for detail in wide and compact presentations.
- The R01 test timeout/process-lock cause was isolated to animated helper scrolling and eager loading of hidden Analytics content.
- R02 changed the app-shell helper to tester-owned bounded `ensureVisible` behavior and gated Analytics evidence loading by visible destination. Substantive assertions remained active.
- The formerly blocked Store-without-Item and Catalogue-create-to-Purchase-register cases passed independently; the app-shell suite passed 26 tests.

### Analytics execution and request evidence

- Analytics is deterministic, read-only, local and active-Account-scoped.
- `LocalAnalyticsRepository.loadEvidence` performs one complete Account-predicated joined evidence query. It does not reuse History's 50-Purchase projection and does not issue an N+1 detail loop.
- Initial Analytics load issued one repository request. Each local Retry added exactly one request. Filtering, selection, execution, card focus, reset and reorder added zero requests.
- History transfers typed Purchase IDs; Analytics performs the calculation. Wide and compact layouts share one workspace/controller state.
- Sum, Mean, Difference and Percentage passed compatibility coverage. Difference is comparison B minus baseline A. Percentage is part of a named whole.
- Checked fixed-point/rational execution returned typed unavailable results for zero denominator and overflow; it did not wrap or substitute floating-point behavior.
- The evidence matrix renders 100 rows at a time and bounds selected scope at 500 stable row IDs.

### Validation and measured host evidence

- Focused tests: PASS.
- App-shell suite: PASS, 26 tests.
- Full Flutter suite: PASS, 258 tests passed and 4 lab-gated skips, approximately 82.7 seconds.
- `flutter analyze`: PASS.
- Windows release build: PASS, existing Boost CMake development warning retained.
- Android debug build: PASS, existing `auth0_flutter` Kotlin Gradle Plugin warning retained.
- Dependency, lockfile, schema, generated-source, provider, Sync, authorized-path and whitespace audits: PASS.
- Validation-owned Dart, Flutter and SQLite processes remaining after validation: none observed.

Measured committed fixtures from the one Windows validation host:

| Fixture | Purchases / Items | Rendered page | Selected scope | Complete load | Calculation | Result |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| Ordinary Sum | 1,000 / 5,000 | 100 | 0 | 2 ms | 22 ms | PASS under 250 ms |
| Stress Mean | 10,000 / 50,000 | 100 | 500 | 6 ms | 302 ms | PASS under 1 s |

These timings are evidence from that host and fixture only; they are not universal device-performance guarantees.

### Unchanged surfaces and remaining gates

No schema, migration, dependency, lockfile, generated-source, platform, API, Auth, Sync, provider or diagnostic surface changed. No live Sync/provider operation occurred, and no Cycle 10 development or production acceptance boundary reopened.

Still unperformed: screenshot-based rendered review; Narrator, TalkBack and other assistive-technology review; keyboard-only human acceptance; real Windows/Android device review; locale review; and human comprehension/visual acceptance. These are remaining validation gates, not failed implementation.

---

## 2026-07-31 — C11-PH03 Settings, Audit, and Closure disposition materialization

Sequence: `FLX-PRM-04` post-evidence Operational absorption  
Role: Operational Chat [O]  
Implementation parent: `256ee4dbbcb790419b816862ee42933a115ddd87`  
Implementation commit: `0924e743931ea7aba2c9cc5d2e28063e737b2ff5`  
Main reconciliation: `J_MAIN_STAGE.md` section 11 at `33dc1002b4a7b00fa67e863dfe98a43c97d66cee`  
Evidence: complete `DEV_STAGE/G_OPS_CODEX.md`, implementation diff, relevant source and tests  
Evidence boundary: automated/widget evidence, static analysis, one Windows release build, one Android debug build, and bounded human UI acceptance; no screenshot set, assistive-technology acceptance, locale review, real-device review, hosted operation or Sync operation

### Settings execution evidence

- Persisted shortage threshold is loaded and accepts only whole values from 0 through 365.
- Invalid threshold drafts remain available for correction; loading, empty, read-error, save-error and saved states are distinct.
- People and Payment Method lists refresh after archive, and completed archive actions remain visible.
- One pending asynchronous Settings action blocks duplicate actions.
- Local preference and reference operations remain Account-scoped and local.
- Account and Sync/Device sections use capability-narrow adapters over existing behavior. Focused tests use fakes; no live Sign in, sign-out, enrollment, connection check or Sync action was executed.
- Failure handling preserves entered values where applicable and exposes bounded local failure messages rather than silently losing input.

### Audit execution evidence

- Audit is an ordinary local, read-only, Account/environment-scoped and sanitized projection over persisted diagnostic attempts and child events.
- Initial visible load and local Retry each issue exactly one attempt query plus one child-event query: two local reads, zero network calls and zero writes.
- Default page size is 20 attempts and the hard maximum is 50.
- Paging is deterministic and exclusive by UTC start time plus persisted attempt ID; equal timestamps retain stable descending order.
- Visibility-gated first load, generation checks and disposal suppress hidden or stale completion ownership.
- Loading, ready, empty, stale, bounded-window and unavailable states are distinct.
- Audit imports no broad Closure runner, access-token authority, Auth mutation, enrollment coordinator, Sync coordinator, protocol Retry, Recovery or delete-history capability.
- Repository tests validated Account/environment isolation and exclusion of credentials, tokens, raw payloads, SQL, paths, stack traces, private URLs, full hashes, raw identifiers and raw exceptions.

### Closure disposition and lifecycle evidence

- Closure is absent from ordinary wide, medium and compact navigation with `MARKEI_NATIVE_CLOSURE_SURFACE` false and true.
- Native Closure pages, runner methods and diagnostic infrastructure remain only as unreachable development/support implementation where already present.
- No destructive or highly technical Closure action entered ordinary product UI.
- Composition owns one Audit controller and closes the controller and database through an idempotent `close()`.

### Validation chronology and unchanged surfaces

- `flutter pub get`: validated; no dependency or lockfile change.
- `dart format --output=none --set-exit-if-changed lib test`: validated; 119 files, zero changed.
- `flutter analyze`: validated; no issues.
- Focused Settings, Audit, repository, Closure-navigation, app-shell, visual-foundation, composition and Sync-path tests: validated.
- `flutter test --concurrency=1`: validated; 264 tests passed, 4 lab-only tests skipped, 88.4 seconds.
- `flutter build windows --release`: validated in 49.9 seconds with the existing Boost CMake developer warning.
- `flutter build apk --debug`: validated in 80.4 seconds with the existing `auth0_flutter` Kotlin Gradle Plugin migration warning.
- `node scripts/generate_sync_diagnostics.mjs --check`: validated.
- `git diff --check`: validated with line-ending warnings only.
- Schema, migration, generated Drift source, dependency, API, Auth, Sync and provider contracts remained unchanged.
- No live Sign in, enrollment, hosted connection, Sync, Retry, Recovery, Auth0, Neon, Render or provider operation was performed.

### Evidence ceiling and deferrals

Human UI verification accepted PH03 as sufficient for documentation and permanent-domain absorption. Minor non-blocking visual refinements are deferred to C12-PH01 and do not reopen PH03.

Screenshot sets, Narrator, TalkBack, locale coverage, real-device coverage, complete keyboard-only acceptance and broader human accessibility acceptance remain unvalidated. Build and widget evidence do not substitute for those gates. Cycle 10 production, GCM04, multiple-Account, revocation, outage recovery, retention/rebootstrap and provider acceptance remain deferred to C12-PHASE02.

---

## 2026-07-31 — C11-PH05 local product-surface and export materialization

Sequence: `FLX-PRM-04` post-evidence Operational absorption  
Role: Operational Chat [O]  
Authority/rollback head: `b59b2ecdfb69ca98c431b9f36694f011332fbef3`  
Implementation commit: `426235d8b67ac719e494b53cfb23a6c3b06fb489`  
Main reconciliation: `J_MAIN_STAGE.md` section 14 at `e6ced7fe3945925bf5f314ee11c4538029e18d44`  
Evidence: complete `DEV_STAGE/G_OPS_CODEX.md`, implementation diff, relevant source, tests and manifests  
Evidence boundary: automated/widget evidence, static analysis, Windows release build and Android debug build; no manual export host proof, assistive-technology, locale, real-device or complete comprehension acceptance

### Exact changed-path boundary

The implementation commit changes exactly 28 paths: 15 handwritten Flutter library paths, 10 focused/regression test paths and the three Codex evidence reports.

```text
clients/markei_flutter/lib/application/export_destination.dart
clients/markei_flutter/lib/application/home_content.dart
clients/markei_flutter/lib/application/analytics_workspace.dart
clients/markei_flutter/lib/infrastructure/platform/local_export_destination.dart
clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart
clients/markei_flutter/lib/app/markei_app.dart
clients/markei_flutter/lib/app/markei_composition.dart
clients/markei_flutter/lib/app/pages/analytics_page.dart
clients/markei_flutter/lib/app/pages/guide_page.dart
clients/markei_flutter/lib/app/pages/history_page.dart
clients/markei_flutter/lib/app/pages/home_page.dart
clients/markei_flutter/lib/app/pages/products_page.dart
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/lib/app/pages/settings_page.dart
clients/markei_flutter/lib/app/widgets/audit_components.dart
clients/markei_flutter/test/application/export_destination_test.dart
clients/markei_flutter/test/infrastructure/local_query_repository_export_test.dart
clients/markei_flutter/test/app/analytics_page_test.dart
clients/markei_flutter/test/app/audit_page_test.dart
clients/markei_flutter/test/app/guide_page_test.dart
clients/markei_flutter/test/app/history_analytics_handoff_test.dart
clients/markei_flutter/test/app/history_page_test.dart
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/app/markei_visual_foundation_test.dart
clients/markei_flutter/test/app/settings_page_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

No source, test, evidence or repository path outside this exact boundary changed.

### Implemented execution boundary

- Home adds static local News and Updates follow-up cards and performs zero repository, database, file or network operations.
- Guide is one local, anchored, focusable eight-section page and performs zero repository, database, file or network operations.
- Purchase redistribution remains presentation-only; Catalogue ordinary selection ownership and generated selection chrome are removed while Product detail remains reachable.
- History keeps one Purchase-ID action-selection set separate from detail state. Final-uncheck, filter pruning, reload intersection and current filtered loaded-window `Select all shown` behavior are implemented.
- `Use in Analytics` transfers frozen Purchase scope only. Handoff, export and other local UI transitions add zero Analytics repository requests and do not calculate, save or mutate.
- `ExportDestinationPort` and the composition-injected `LocalExportDestination` separate pure builders from file effects.
- A non-empty History selected export reconstructs the bundle through two set-based Account-scoped reads, with zero database writes and zero network calls.
- Each successful explicit History or Analytics export performs one final collision-safe file write.
- Windows resolves the Downloads directory through the already-declared platform dependency. Android public Downloads returns a typed unavailable result and writes zero files.
- Audit System, Readiness summary and Diagnostics cards derive only from the already-loaded bounded local Audit result.
- Settings performs its post-support-action Account/Sync status refresh while retaining duplicate-action exclusion and the action result.
- Stored `@NNN` and `#NNN` reference codes remain unchanged.

### Operation budgets

```text
HOME_IO=0
GUIDE_IO=0
HISTORY_SELECTED_EXPORT=reads:2; database_writes:0; network:0
SUCCESSFUL_EXPLICIT_EXPORT=final_file_writes:1
ANDROID_PUBLIC_DOWNLOADS_UNAVAILABLE=file_writes:0
ANALYTICS=initial_requests:1; retry:+1; handoff_export_local_ui:+0; database_writes:0; network:0
AUDIT=initial_queries:2; retry:+2; projections:+0; writes:0; network:0
SETTINGS=initial_calls:5; local_refresh:+2
```

### Validation and unchanged surfaces

- `flutter pub get`: PASS; dependency-lock guard: PASS.
- `dart format --output=none --set-exit-if-changed lib test`: PASS.
- `flutter analyze`: PASS.
- Focused export, History, handoff, Analytics workspace/page, Guide, Settings, Audit, visual-foundation, app-shell and local export-repository tests: PASS.
- `flutter test --concurrency=1 --no-pub`: PASS, 278 tests passed and 4 lab-gated tests skipped.
- `flutter build windows --release`: PASS; existing Boost CMake policy warning only.
- `flutter build apk --debug`: PASS; existing Kotlin Gradle Plugin deprecation warning only.
- `node scripts/generate_sync_diagnostics.mjs --check`: PASS.
- `git diff --check`: PASS.
- Schema, migrations, generated Drift source, dependencies, lockfile, native platform files, API/Auth/Sync/provider contracts and diagnostic registry authority remained unchanged.
- No live Sign in, enrollment, hosted connection, Sync, Retry, Recovery, Auth0, Neon, Render or provider operation was performed.
- Because the implementation is one commit with no schema, dependency, generated or native-platform conversion, rollback is one commit to `b59b2ecdfb69ca98c431b9f36694f011332fbef3`; no data repair is implied.

### Evidence ceiling, defect and deferrals

Windows Downloads is implemented and automated/build validated only. Manual Windows export, directory/permission/full-disk behavior and real-host file inspection remain unvalidated. Android public Downloads is intentionally unavailable in this build; no real-device public-storage behavior is established.

Human runtime evidence shows an active Analytics wrong-variable/result defect. The root cause is not established, and passing Analytics tests do not prove calculation-variable integrity. The accepted compact composer, unified Variables control, two `dd-mm-yyyy` fields and Date-Time/Store evidence presentation are correction direction only, not implemented state.

Guide ownership, navigation, anchors and zero-I/O structure are implemented. Its learner sequence is only partially faithful: Lists and explicit getting-started/local-data/export/Sync-limit boundaries are not represented as accepted. Human comprehension is not established.

Screenshots were defect-finding rather than complete acceptance. Keyboard-only review, Narrator/TalkBack, locale behavior, real-device behavior, manual Windows export and broader comprehension remain unvalidated. These limits do not reopen the accepted automated/build PH05 boundary.

---

## 2026-07-31 — C11 Analytics correction materialization

Sequence: `FLX-PRM-04` post-evidence Operational absorption  
Role: Operational Chat [O]  
Activation authority: `0e647e76aa8275bda48cea1e9d08427e3d949134`  
Implementation parent: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`  
Implementation commit: `17fd65296e960112787b870363b40339f535f5b6`  
Main reconciliation: `J_MAIN_STAGE.md` section 16 at `34eb4b60fd4f9c6455c1774c055c1615581623af`  
Evidence: complete `DEV_STAGE/G_OPS_CODEX.md`, implementation diff, relevant Analytics source and tests  
Evidence boundary: automated/widget evidence, static analysis, Windows release build and Android debug build; no screenshot review, assistive-technology acceptance, locale review, Windows launch, Android real-device review, learner-comprehension evidence or live provider/Sync operation

### Corrected execution evidence

- One typed `AnalyticsVariable` selection owner now drives visible Variables selection; categorical breakdown and numeric-measure sets are derived views rather than competing mutable owners.
- Purchased by and Payment method derive categorical breakdowns; Purchased for remains typed unavailable. Quantity, Unit price, Price paid, Purchase total and Evidence count derive numeric measures.
- Categorical-only selection blocks with guidance and inserts neither Quantity nor Evidence count. Unsupported operation-variable combinations block with selection-specific guidance.
- `Run & save` freezes determinant, variables, operation, timeframe, evidence scope, labels and grouped entries into one immutable session record. Chart, Table, interpretation, CSV and PDF consume that record; later draft changes and record selection do not mutate it.
- Incompatible numeric axes retain typed Table/CSV/PDF evidence while Chart is unavailable by default.
- Initial date and Final date accept strict `dd-mm-yyyy`. Both dates are inclusive and are converted through local-calendar boundaries to the existing start-inclusive/end-exclusive UTC interval.
- Shared presentation/export conversion exposes readable decimal quantity and canonical unit, money, unit price, percent, signed Difference and integer Evidence count. Raw fixed-point storage integers and compatibility keys are absent from asserted ordinary projections.
- Purchase, Product, Store and Item UUIDs remain internal for identity, selection, handoff, paging, fingerprints and reconstruction but are removed from ordinary Analytics presentation.
- The previously observed wrong-variable/result symptom is no longer an active automated-evidence defect. The confirmed raw-value/internal-key presentation defect is corrected, and the ten-case regression matrix establishes calculation-selection integrity at the automated boundary.
- No silent default-Quantity insertion or second calculation path was evidenced.

### Validation and effects

- `flutter pub get`: PASS; dependency and lockfile diff guard: PASS.
- Dart formatting: PASS.
- `flutter analyze`: PASS.
- Focused serial Analytics suite: PASS, 24 tests.
- Ten-case regression matrix: PASS.
- `flutter test --concurrency=1 --no-pub`: PASS, 286 tests passed and 4 lab-gated tests skipped.
- `flutter build windows --release`: PASS.
- `flutter build apk --debug`: PASS.
- Sync-diagnostics generation check: PASS.
- Analytics effects remain initial Account-local evidence read `1`, Retry `+1`, all other Analytics actions `+0`, database writes `0`, network calls `0`.
- Schema, migrations, generated source, dependencies, lockfile, native platform files, GRM/GS procedures and unrelated systems remained unchanged.
- The serial `G_SCRIPTS.md` gate correction was already satisfied before implementation and was not part of this change.
- Codex correction authority is consumed.

### Warning disposition and evidence ceiling

Existing Drift multiple-database warnings appeared during the full suite and were not suppressed. The existing Windows Boost/CMake developer warning and existing Android Auth0 Kotlin Gradle compatibility warning also remained. None was classified as a correction failure.

Still unperformed: wide/compact screenshot review; keyboard-only human review; Narrator and TalkBack; locale and long-string review; Windows application launch; Android real-device behavior; learner comprehension; manual Windows export; and any live Auth0, Neon, Render, provider or Sync operation.

PH05 Guide sequence deviation remains out of scope. Android public Downloads remains typed unavailable. GCM04, conditional former R07, multiple-Account hosted isolation, revocation, outage recovery, retention/rebootstrap and production lifecycle remain C12-PHASE02 work.
