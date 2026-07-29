# G_OPS_CODEX - C10-GCM03-S10-R02

## Operational Report

Unit: C10-GCM03-S10-R02, continuity alias C10-GCM02-S09-R02.
Branch: grm-guarded-provisioning-20260727.
Required starting head: 9127a2e8a85ede3a6c881060b4ce47224f59e577.

Connected GitHub app branch-head verification compared the branch to the
required starting head and returned identical: ahead_by=0, behind_by=0,
total_commits=0. Local checkout was on the required branch at the same HEAD
with no dirty files before materialization.

## Changes

Changed source/test files:

- clients/markei_flutter/lib/app/pages/purchase_page.dart
- clients/markei_flutter/lib/application/sync/sync_use_cases.dart
- clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_event_applier.dart
- clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_fact_writer.dart
- clients/markei_flutter/test/app/markei_app_test.dart
- clients/markei_flutter/test/infrastructure/remote_purchase_event_applier_test.dart

Changed report files:

- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

No GRM files, DB_MGMT.sql, G_SCRIPTS.md, D/E/F/J, A/B/C, permanent notebook
memory, methodology files, migrations, API, schema, authentication, enrollment,
dependencies, or provider configuration were modified.

## Behavior

Purchase Product selection now uses one nullable Product-ID scalar as the
Dropdown value. The selected Product is resolved from the current Account-scoped
Product projection. Find code stores the returned row's Product ID and then
resolves the current projected row by that ID. Equivalent repeated Product IDs
are collapsed before menu construction; conflicting repeated Product IDs are
rejected from the menu and reported through bounded recovery feedback. Removed
or ambiguous selected Product IDs are safely invalidated.

Remote Product application now reconciles within the Account by incoming UUID,
normalized user Product code, and exact identity key. Equivalent natural
identity under a different UUID maps the incoming Product UUID to the existing
local Product UUID for the event. Contradictory immutable facts return a typed
remote natural-identity conflict. Remote Stores are reconciled by incoming UUID
and the existing Account-scoped stable display identity. Purchase and
PurchaseItem rows use the selected local Store/Product IDs.

Drift applyPage still owns one page transaction for Product/Store
reconciliation, Purchase facts, Purchase Items, inbox rows, and cursor
advancement. Identity conflicts and SQLite write failures occur inside the
transaction and are translated only after rollback. Failed local apply leaves no
new facts, inbox rows, or cursor advancement and therefore no acknowledgement
cursor.

## Validation

Commands run from clients/markei_flutter unless noted:

- dart format --output=none --set-exit-if-changed lib test: PASS
- flutter analyze: PASS
- flutter test test/app/markei_app_test.dart: PASS
- flutter test test/app/native_closure_diagnostics_test.dart: PASS
- flutter test test/infrastructure/remote_purchase_event_applier_test.dart: PASS
- flutter test test/sync/local_sync_application_test.dart: PASS
- flutter test: PASS; disposable lab tests skipped because MARKEI_RUN_SYNC_LAB was not set
- flutter build apk --debug with reviewed public placeholder defines: PASS
- generated merged Android manifest inspection: PASS; package com.gusigu.markei, MainActivity, Auth0 redirect activity, and callback path shape observed with host/value redacted
- git diff --check: PASS, with Git line-ending warnings only
- changed-content sensitive-pattern scan: PASS; one false positive on non-secret text "Unsupported cursor token"

Unavailable evidence:

- No live Android install, launch, Sync, Retry, Recovery, Enroll, Query, hosted
  acknowledgement, or interactive provider action was executed.
- Disposable HTTP/PostgreSQL convergence harness was not executed because it is
  gated by MARKEI_RUN_SYNC_LAB and was not authorized as a live lab run here.

## Terminals

CONFIGURED_PROVIDER_BRANCH_ALIAS=markei-c10
PROVIDER_BRANCH_ALIAS_LAUNCHER_INDEPENDENT_PROOF=NO
GITHUB_BRANCH=grm-guarded-provisioning-20260727
PRODUCT_SELECTOR_IDENTITY=STABLE_PRODUCT_ID
FIND_BY_CODE_DROPDOWN_ASSERTION=REGRESSION_PASS
REMOTE_PRODUCT_IDENTITY_RECONCILIATION=PASS
REMOTE_STORE_IDENTITY_RECONCILIATION=PASS
REMOTE_ITEM_ID_REMAP=PASS
REMOTE_PAGE_ATOMICITY=PASS
LOCAL_APPLY_CAUSAL_DIAGNOSTICS=PASS
TRUSTED_RESPONSE_STATE_AFTER_LOCAL_FAILURE=RECEIVED
ACKNOWLEDGEMENT_AFTER_FAILED_LOCAL_APPLY=NOT_STARTED
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
C10_GCM03_S10_R02=IMPLEMENTED_VALIDATED
