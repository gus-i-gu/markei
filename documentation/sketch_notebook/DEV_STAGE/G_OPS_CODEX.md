# G_OPS_CODEX - C10-GCM03-S10-R03

## Operational Report

Unit: C10-GCM03-S10-R03. Human-assay continuity alias: C10-GCM03-S09-R03.
Branch: grm-guarded-provisioning-20260727.
Starting head: 8fb43654b3e93908530165c29e580a5f5c12c1f8.
Direct parent guard: b9882118b543cc9637af31f8343935bee94300de.

Connected GitHub app verification passed before implementation:
grm-guarded-provisioning-20260727 compared identical to 8fb43654b3e93908530165c29e580a5f5c12c1f8, and b988211..branch was exactly one commit changing only documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md with 358 additions and 0 deletions.

## Changed Paths

- clients/markei_flutter/lib/app/native_auth_closure_runner.dart
- clients/markei_flutter/lib/app/pages/native_closure_page.dart
- clients/markei_flutter/lib/application/closure_diagnostics.dart
- clients/markei_flutter/lib/application/sync/sync_ports.dart
- clients/markei_flutter/lib/application/sync/sync_use_cases.dart
- clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
- clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_event_applier.dart
- clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_fact_writer.dart
- clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
- clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart
- clients/markei_flutter/test/infrastructure/remote_purchase_event_applier_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

No D/E/F, J, REC_DIAGNOSTICS.md, permanent notebook memory, methodology, DB_MGMT.sql, G_SCRIPTS.md, I_SCRIPTS.ps1, schema, migration, hosted API, payload version, authentication, enrollment, dependency, or provider configuration file was modified.

## Implementation

Product convergence now distinguishes established UUIDs from new UUIDs. Established UUID rows require full immutable snapshot coherence including user Product code and display fields. New incoming UUIDs use the D/F decision table: insert when no code or exact-identity row exists; reuse one coherent row when code and exact identity select the same row; reject same-code/different-identity, split-key, ambiguous code, and ambiguous exact-identity cases with bounded protocol codes; and reuse the exact-identity row when only exact semantic identity matches under a different user code, preserving the local code/display.

The remote Product UUID to selected local Product UUID map remains per apply operation and is used for every Purchase Item. Store reconciliation remains the existing incoming UUID plus Account-scoped display identity behavior.

DriftRemoteEventApplier still wraps page validation, Product/Store reconciliation, Purchases, Purchase Items, inbox rows, and Account cursor advancement in one Drift transaction. All local apply exceptions are translated only after the transaction unwinds: natural identity conflicts, SQLite/Drift failures, payload-shape failures, local invariant failures, and unexpected local apply failures. No applyPage exception is intended to escape into NativeAuthClosureRunner.

Download diagnostics now use a best-effort recorder boundary, so diagnostic persistence failure before apply, after rollback, or after a committed apply cannot relabel transaction truth. SyncResult carries only a bounded sanitizedExceptionClass, which is propagated through diagnostic persistence, repository projection, application summary, current-action mapping, and Closure UI technical details.

NativeAuthClosureRunner keeps an in-memory causal snapshot before durable diagnostic writes. Its final safety catch consumes the strongest child evidence and does not replace a proved trusted response with trusted-response-not-received. Acknowledgement remains gated by greatestContiguousAppliedCursor after local commit.

## Validation

Commands run:

- dart format --output=none --set-exit-if-changed lib test: PASS, 0 changed after applying dart format lib test.
- flutter analyze: PASS, no issues.
- flutter test test/infrastructure/remote_purchase_event_applier_test.dart: PASS, 11 passed.
- flutter test test/infrastructure/closure_diagnostics_repository_test.dart: PASS, 10 passed.
- flutter test test/app/native_closure_diagnostics_test.dart: PASS, 27 passed.
- flutter test test/infrastructure/remote_purchase_event_applier_test.dart test/infrastructure/closure_diagnostics_repository_test.dart test/app/native_closure_diagnostics_test.dart after final formatting: PASS, 48 passed.
- flutter test test/sync/local_sync_application_test.dart: PASS, 29 passed.
- flutter test test/sync/two_device_system_harness_test.dart: PASS, 1 passed.
- flutter test test/sync/v3_contract_test.dart: PASS, 2 passed.
- flutter test test/catalogue_store_repository_test.dart test/catalogue_identity_test.dart: PASS, 8 passed.
- flutter test test/app/markei_app_test.dart: PASS, 26 passed.
- flutter test after final formatting: PASS, 215 passed and 4 disposable labs skipped because MARKEI_RUN_SYNC_LAB was not set.
- flutter build apk --debug: PASS, built build/app/outputs/flutter-apk/app-debug.apk. Existing auth0_flutter Kotlin Gradle Plugin warning observed.
- flutter build windows: first attempt failed because build/windows/x64/runner/Release/markei.exe was locked by running local process PID 18708; after Stop-Process -Id 18708, retry PASS, built build/windows/x64/runner/Release/markei.exe. Existing Boost/CMake CMP0167 dev warning observed.
- Merged manifest inspection: PASS, debug merged manifest exists and includes package com.gusigu.markei, INTERNET permission, MainActivity, Auth0 RedirectActivity, and callback path shape.
- git diff --check: PASS with Git line-ending warnings only.

Skipped:

- No disposable HTTP/PostgreSQL labs were executed.
- No live provider/client Sync, Retry, Recovery, Enroll, Query, acknowledgement, new Purchase registration, install/launch against preserved data, diagnostic clearing, provider mutation, or database surgery was executed.

## Terminals

C10_GCM03_S10_R03=IMPLEMENTED_VALIDATED
PRODUCT_EXACT_ID_DIFFERENT_CODE=PASS
PRODUCT_CODE_DIFFERENT_IDENTITY_CONFLICT=PASS
REMOTE_ITEM_ID_REMAP=PASS
REMOTE_PAGE_ATOMICITY=PASS
UNEXPECTED_LOCAL_APPLY_TRANSLATION=PASS
DIAGNOSTIC_PERSISTENCE_CONTAINMENT=PASS
CAUSAL_EVIDENCE_PRESERVATION=PASS
SANITIZED_EXCEPTION_CLASS_UI=PASS
ACKNOWLEDGEMENT_AFTER_UNPROVED_APPLY=NOT_STARTED
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
