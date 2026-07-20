# G_OPS_CODEX - Drift v8 Foreign-Key Repair Evidence

- Sequence: FLX-ORD-01
- Role: Codex materialization report
- Unit: C10-MCG02-DRIFT-V8-FK-REPAIR_20260720T221440Z
- Branch: intermid-cycle-recovery
- Baseline HEAD: e9f355c61b76975e99f511e3201e6e815c25f7f1
- Required diagnostic ancestor: 00c78e85c19f4acdc5554fb695c181af10616bc0
- Final commit SHA: reported in the terminal response after commit creation.
- Provider/private data access: none. No Auth0, Render, Neon, human Drift database, provider credential, private database, real Enroll, Query or Sync endpoint was accessed.

## Changed Paths

- `clients/markei_flutter/lib/infrastructure/local/local_database.dart`
- `clients/markei_flutter/test/infrastructure/local_database_migration_test.dart`
- `clients/markei_flutter/test/local_purchase_repository_test.dart`
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved untracked human configuration-note files:

- `clients/markei_flutter/Exact Auth0 API audience`
- `clients/markei_flutter/Windows Native Application Client ID`

## Implementation Evidence

- Drift schema version increased from 7 to 8.
- Fresh creation ledger changed to `create-v8`.
- Added `v7-to-v8-purchase-fk-repair` upgrade ledger entry.
- Rebuilt `purchase_items` and `purchases` inside a Drift transaction while foreign-key enforcement is temporarily disabled for SQLite table rebuild mechanics and restored in `finally`.
- Recreated current constraints:
  - `purchases.account_id -> local_accounts.id ON DELETE RESTRICT`
  - `purchases.store_id -> stores.id ON DELETE RESTRICT`
  - `purchases.person_id -> people.id ON DELETE RESTRICT`
  - `purchases.payment_method_id -> payment_methods.id ON DELETE RESTRICT`
  - `purchase_items.purchase_id -> purchases.id ON DELETE CASCADE`
  - `purchase_items.product_id -> products.id ON DELETE RESTRICT`
  - primary keys, nullability and `currency_code` length checks preserved.
- Validation rejects row-count mismatch, any literal `_old` reference in `sqlite_schema`, non-empty `PRAGMA foreign_key_check`, or missing expected FK targets.
- Test-only `v8RepairHook` injects failure before validation without weakening production validation.
- Drift code generation was run. Generated review found `local_database.g.dart` had line-ending-only churn and no semantic diff, so it was restored.

## Fixture Evidence

- Malformed v7 -> v8:
  - Direct disposable v7 fixture reproduced malformed FK metadata before production open.
  - Production `LocalDatabase` migrated it to v8.
  - Post-migration counts: `purchases=1`, `purchase_items=1`.
  - `sqlite_schema` literal `_old` references: 0.
  - `PRAGMA foreign_key_check` rows: 0.
  - FK targets verified: `people`, `payment_methods`, `products`, `purchases`.
  - Close/reopen preserved `purchases=1`.
- Historical v2 -> v8:
  - Disposable v2 fixture migrated through production path to v8.
  - `products=1`, `purchase_items=1`, `installation_metadata=1`.
  - `sqlite_schema` literal `_old` references: 0.
  - `PRAGMA foreign_key_check` rows: 0.
  - Close/reopen preserved `purchases=1`.
- Fresh v8:
  - `LocalDatabase.memory()` reports schema version 8.
  - Fresh local, recovery and hosted auth tables are created and empty.
- Failure/rollback:
  - Injected `before-validation` failure.
  - Migration failed with `injected v8 validation failure`.
  - Reopening the same disposable source with production database succeeded and repaired to `purchases=1`, no `_old` schema reference, empty FK check.
- Idempotent reopen:
  - Already migrated v8 reopen did not add a second ledger entry.
  - Device `nextSequence` remained unchanged.
  - `purchases=1`, `purchase_items=1`.
- Production Purchase registration after migration:
  - Migrated hosted lifecycle repaired and reopened.
  - Pre-registration counts: `purchases=1`, `purchase_items=1`, `sync_events=2`, `pending_events=2`, hosted Device `nextSequence=2`, cursor `cursor-before-hosted-purchase`.
  - Post-registration counts: `purchases=2`, `purchase_items=2`, `sync_events=3`, `pending_events=3`, hosted Device `nextSequence=3`, cursor unchanged.
  - Exactly one new `purchase.registered` v3 event and one pending outbox row were created.
  - Close/reopen History shows 2 Purchases.

## Commands and Results

- `git branch --show-current`: `intermid-cycle-recovery`.
- `git fetch origin`: passed.
- `git pull --ff-only`: passed; already up to date.
- Required authority ancestor check for `e9f355c61b76975e99f511e3201e6e815c25f7f1`: passed.
- Required diagnostic ancestor check for `00c78e85c19f4acdc5554fb695c181af10616bc0`: passed.
- Methodology/stage boot reads completed for root `AGENTS.md`, notebook `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, J, D, E and F.
- `dart run build_runner build --delete-conflicting-outputs`: passed; option warning noted because current build_runner ignores that removed option; generated semantic diff was empty.
- `dart format ...`: passed on touched files.
- `flutter test test/infrastructure/local_database_migration_test.dart`: passed, 7 tests.
- `flutter test test/local_purchase_repository_test.dart`: passed, 12 tests.
- `dart format --set-exit-if-changed lib test`: passed, 83 files, 0 changed.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed, 119 tests and 2 existing lab skips.
- `flutter build apk --debug`: passed; built `build\app\outputs\flutter-apk\app-debug.apk`; existing Auth0 Flutter Kotlin Gradle Plugin warning retained.
- `flutter build windows --release`: passed; built `build\windows\x64\runner\Release\markei.exe`; existing Boost CMP0167 developer warning retained.
- `git diff --check`: passed.

## Exclusions and Scans

- No Android runtime/provider acceptance claimed from the debug build.
- No Windows runtime/provider acceptance claimed from the release build.
- No Auth0, Render, Neon, provider mutation, deployment, PostgreSQL migration, protocol/API/event-version change, dependency upgrade, UI redesign, permanent documentation promotion, MCG-03 or MCG-04 work performed.
- Changed paths contain no private database, binary, credential, provider artifact, APK, EXE, connection string, Authorization header, API key or token assignment.

## Terminal

~~~text
C10_MCG02_DRIFT_V8_FK_REPAIR_PROVED
~~~
