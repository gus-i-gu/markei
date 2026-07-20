# G_OPS_CODEX - Explicit Purchase Store Selection Evidence

- Authority marker: C10-MCG02-STORE-SELECTION-CORRECTION_20260720T201904Z
- Branch: intermid-cycle-recovery
- Baseline HEAD before correction: f37dfb49502756a21c6de02fc1a8c662311b1e6a
- Final commit SHA: self-referential Git SHA is reported in the Codex terminal response.
- Provider access: none. No Auth0, Render, Neon, provider credential, token, connection string, real Enroll, Query or Sync endpoint was accessed.

## Changed Paths

- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved untracked private files:

- `clients/markei_flutter/Exact Auth0 API audience`
- `clients/markei_flutter/Windows Native Application Client ID`

## Reproduction and Diagnosis

Before the source fix, Codex added `no implicit Store selection after load` and ran:

- `flutter test test/app/markei_app_test.dart --name "no implicit Store selection after load"`: failed, 0/1 tests passed. The assertion for visible `Select Store` failed because Purchase had already selected the first Store after catalogue load.

Proven cause: Purchase state stored a `Store` object and `_loadCatalogue()` silently assigned `stores.first` whenever there was no prior selected Store. The blocked human flow was therefore not proven to be hosted registration, Product staging, IndexedStack navigation, or server/provider authorization. The local UI/application cause was implicit first-row selection plus object-instance-based selection state across refreshed Store lists.

## Commands and Results

- `git branch --show-current`: `intermid-cycle-recovery`.
- `git fetch origin`: passed.
- `git pull --ff-only`: passed; already up to date.
- `git merge-base --is-ancestor f37dfb49502756a21c6de02fc1a8c662311b1e6a HEAD`: passed.
- `git merge-base --is-ancestor bf78a3908ad05b3e7a0decc197fa2f99970059f1 HEAD`: passed.
- `git status --short --branch`: clean tracked state before editing; two private untracked provider-note files preserved.
- Methodology and stage boot reads completed for root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, current J/D/E/F and latest G/H/I.
- `dart format lib/app/pages/purchase_page.dart test/app/markei_app_test.dart`: passed, 2 files, 0 changed.
- `flutter test test/app/markei_app_test.dart --name "no implicit Store selection after load"` after fix: passed, 1 test.
- `flutter test test/app/markei_app_test.dart`: passed, 20 tests.
- `flutter test test/catalogue_store_repository_test.dart test/local_purchase_repository_test.dart`: passed, 15 tests.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed, 115 tests and 2 existing disposable lab skips; retained existing Drift multi-database debug warnings in sync tests.
- `dart format --set-exit-if-changed lib test`: passed, 83 files, 0 changed.
- `flutter build apk --debug`: passed; built `build\app\outputs\flutter-apk\app-debug.apk`; retained existing Auth0 Flutter Kotlin Gradle Plugin warning.
- `flutter build windows --release`: first two attempts failed at MSBuild/CMake install with no source compile error. The generated CMake install command then passed directly, and a final `flutter build windows --release` passed; built `build\windows\x64\runner\Release\markei.exe`; retained existing Boost CMP0167 developer warning.
- `git diff --check`: passed.
- `git diff --name-only`: listed only the two Flutter source/test paths before G/H/I replacement.
- Diff secret scan: no matches for credential assignments, connection strings, provider URLs, API keys, or authorization header values.
- Tracked binary/generated scan: found only pre-existing tracked desktop/package binaries under `app/database`, `build/Markei`, and `dist/`; no changed binary, APK, database, provider artifact or generated credential file is part of this unit.

No Drift schema or generated source changed. No TypeScript/API regression was required because no shared server contract, API, event version or authorization path changed.

## Counts and Evidence

- `complete Catalogue-create-to-Purchase-register flow` created 1 Purchase, 1 SyncEvent, and 1 PendingEvent.
- Existing repository tests preserved local-only and hosted-bound registration, payload-version-3 event creation, exactly one pending outbox row, rollback with zero partial mutation, and close/reopen preservation.
- Device sequence, hosted binding, local-only facts, immutable events, content hashes, outbox rows and existing local history were not rewritten by this UI/application correction.

## Exclusions

No provider resource was accessed or mutated. No migration, Drift schema, dependency, API, event payload, server authorization, sync protocol, navigation architecture, Analytics, PIN, Settings, deployment, permanent documentation, MCG-03 or MCG-04 work was performed.

## Terminal

~~~text
C10_MCG02_STORE_SELECTION_CORRECTED
~~~
