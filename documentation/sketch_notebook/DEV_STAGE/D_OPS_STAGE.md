# D_OPS_STAGE — Android convergence and Purchase Product-identity correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Operational materialization stage
> Unit: `C10-GCM03-S10-R02`
> Continuity alias: `C10-GCM02-S09-R02`
> Branch: `grm-guarded-provisioning-20260727`
> Required published ancestry:
> `716ae7f082714944b6b51042d98a56e685978c38`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Evidence boundary: repository source inspection at the required ancestry;
> one failed Android ordinary-Sync assay; frozen Android SQLite snapshot;
> human-visible Android History/Diagnostics projection; one transactionally
> read-only provider postflight; and one Android Flutter assertion screenshot
> produced after Catalogue-to-Purchase Product lookup
> Live boundary: no Windows/Android Sync, Retry, recovery, enrollment,
> acknowledgement, provider mutation, migration or deployment is authorized

## 1. Namespace and provenance guard

Keep the two branch namespaces distinct:

```text
GitHub repository branch:
  grm-guarded-provisioning-20260727

Configured Neon development branch alias:
  markei-c10
```

The prior observational marker:

```text
BRANCH PROVENANCE = CONFIRMED_MARKei-c10
```

did not create or name a GitHub branch. It was historical shorthand for the
provider target configured under the Neon development alias `markei-c10`.
`GS-NEON-11` explicitly cannot independently prove the human-readable alias,
so new reporting must retain that evidence ceiling.

Use this unambiguous terminal in new reports:

```text
CONFIGURED_PROVIDER_BRANCH_ALIAS=markei-c10
PROVIDER_BRANCH_ALIAS_LAUNCHER_INDEPENDENT_PROOF=NO
GITHUB_BRANCH=grm-guarded-provisioning-20260727
```

Do not rename either external resource. Do not create a branch.

## 2. Reconciled starting state

The following conclusions are accepted at their stated boundaries:

```text
C10_GCM03_S10_I02=PASS_LOCAL_TRANSACTION_ROLLBACK
C10_GCM03_S10_I03=PASS_UI_PROJECTION_MATCHES_LOCAL_ROLLBACK
C10_GCM03_S10_I04_PROVIDER_CONTAINMENT=PASS
C10_GCM03_S10_I05=PASS_ACTIONABLE_DIAGNOSIS
C10_GCM02_S09_R01=CONCLUDED
```

The failed Android ordinary Sync proved:

```text
authentication accepted
binding accepted
empty upload lease accepted
trusted download response received
local Drift apply failed
page transaction rolled back
Android inbox rows retained = 0
Android hosted Purchase rows retained = 0
Android hosted Purchase-item rows retained = 0
Android Account cursor advanced = no
acknowledgement started = no
Android provider producer/acknowledgement state advanced = no
```

The read-only provider postflight showed Account totals consistent with the
two already hosted Windows events while the exact Android Device still owned:

```text
next expected sequence = 1
submissions = 0
events = 0
acknowledgements = 0
acknowledged cursor = 0
```

Preserve the existing Android SQLite snapshot and manifest. They are evidence,
not an implementation input and not a writable test database.

## 3. Source-confirmed correction boundaries

### 3.1 Remote SQLite materialization gap

At the required ancestry:

- `RemotePurchaseFactWriter` resolves Stores and Products only by incoming UUID;
- local SQLite also enforces Account-scoped Product uniqueness for
  `normalized_user_product_code` and `exact_identity_key`;
- Purchase Items retain incoming Product UUIDs directly;
- Purchases retain incoming Store UUIDs directly;
- `DriftRemoteEventApplier.applyPage()` already owns one page-wide Drift
  transaction covering facts, inbox rows and Account cursor;
- unexpected Drift failures can escape to the Closure runner, whose broad
  exception fallback replaces known causal evidence with
  `lastProvedPhase=terminal` and `trustedResponseState=not-received`.

This is a source-confirmed identity-reconciliation gap and a high-confidence
explanation of the failed assay. The exact SQLite extended result code was not
retained in the live diagnostic record. Do not claim that one specific
constraint was runtime-proved.

### 3.2 Purchase selector gap

The Android screenshot shows Flutter's exactly-one-matching-menu-item
assertion after a Product already present in Catalogue is found from Purchase
through the code lookup button.

At the required ancestry:

- `Product` uses ordinary Dart object/reference equality;
- `_products` is populated by `listProducts()`;
- `_findProductByCode()` obtains another materialized `Product` instance from
  `productByCode()`;
- `_applyProductFacts()` assigns that instance to `_selectedProduct`;
- `DropdownButton<Product?>` uses `_selectedProduct` as its `value`, while its
  item values are the separate objects in `_products`.

Therefore a unique database row may still produce zero matching menu values.
Flutter's assertion text combines zero matches with two-or-more matches. The
screenshot does not prove duplicate Product rows.

## 4. Required implementation — stable Purchase selection identity

Correct `PurchasePage` so Product selection is keyed by stable Product ID, not
by object instance.

Required behavior:

1. The Product dropdown value and each non-null menu item value use the
   Product ID scalar, preferably `String`, rather than `Product`.
2. The selected Product is resolved from the current Account-scoped
   `_products` projection by that ID.
3. Find-by-code binds the returned Product to its ID and then resolves the
   current menu member with that ID.
4. A Catalogue refresh rebinds a still-existing selection to the newly loaded
   projection object.
5. If the selected ID no longer exists, clear the selection and show a
   sanitized `product-selection-invalidated` recovery message.
6. Code, name, brand, package facts, mode, measurement kind and staging of an
   existing Product continue to use the selected current Product.
7. The null menu item continues to mean `Create new Product`.
8. Read-only behavior of immutable Product fields remains unchanged.
9. Product database identity and `Product.operator ==` must not be globally
   changed merely to satisfy this widget.
10. Do not clear a valid selection as a workaround.

Before building menu items, enforce one item per Product ID:

- equivalent duplicate projections with the same ID may be collapsed
  deterministically;
- conflicting projections with the same ID must invalidate selection and
  produce safe UI feedback rather than reaching Flutter's assertion;
- do not describe this UI guard as database deduplication.

Required widget regressions:

```text
Catalogue-created Product -> Purchase -> enter exact code -> Find code
  => no Flutter exception
  => one selected Product by ID
  => immutable facts projected
  => Add selected Product succeeds

find-by-code returns a distinct Product object with the same Product ID
  => exactly one menu match

Catalogue refresh returns new Product objects
  => valid selection remains bound by ID

selected Product disappears on refresh
  => selection cleared with product-selection-invalidated feedback

duplicate equivalent projection with the same ID
  => no assertion and one deterministic menu identity

conflicting duplicate projection with the same ID
  => safe invalidation/error, not silent arbitrary choice
```

## 5. Required implementation — Account-scoped remote identity convergence

Keep protocol payload version 3 and the hosted API unchanged. Reconcile remote
snapshots into the existing local Account rather than assuming that remote
surrogate UUIDs are the only identity.

### 5.1 Product resolution

For each incoming Product snapshot, evaluate within the incoming Account:

```text
incoming Product UUID
normalized user Product code
exact identity key
```

Required decision table:

1. If the incoming UUID exists, all immutable identity facts must agree.
   Reuse that local row.
2. If the UUID does not exist and neither natural key exists, insert the
   incoming Product under its incoming UUID.
3. If the UUID differs but both natural keys resolve to the same coherent
   local Product, reuse that local Product.
4. If only one natural key matches, compare the complete immutable Product
   identity. Reuse only when both the incoming normalized code and exact
   identity equal the existing row.
5. If the normalized code and exact identity resolve to different local rows,
   return a typed identity conflict.
6. Same normalized code with contradictory exact identity is a typed conflict.
7. Same exact identity with contradictory normalized code is a typed conflict.
8. An existing incoming UUID with a different Account or contradictory
   immutable facts is a typed conflict.

Maintain an event-local:

```text
incoming Product UUID -> selected local Product UUID
```

map. Every Purchase Item must use the selected local Product UUID. Never
rewrite hosted event content or mutate an existing local Product's identity to
force a match.

### 5.2 Store resolution

Resolve each incoming Store within its Account by:

```text
incoming Store UUID
stable local display identity used by current Store creation
```

Required behavior:

- matching UUID plus coherent Account/name reuses the row;
- different UUID plus one coherent Account/name match reuses the local row;
- no match inserts the incoming Store;
- conflicting UUID, Account or display identity returns a typed conflict;
- the Purchase references the selected local Store UUID.

Do not add a migration or silently invent a new Store normalization scheme in
this unit.

### 5.3 Transaction and replay integrity

Preserve one atomic `applyPage()` transaction across:

```text
Account bootstrap
Store/Product reconciliation
Purchase/Purchase Item facts
Sync inbox rows
Account cursor
```

A typed identity conflict or SQLite write failure must roll back every one of
those changes. Acknowledgement must not begin after a failed local apply.

Preserve:

- canonical page and content-hash validation;
- cursor ordering;
- duplicate-equivalent inbox behavior;
- idempotent page replay;
- Person and Payment Method v3 null restriction;
- local-only producer queue separation.

Do not weaken a unique constraint or delete/rewrite an existing catalogue row
to make the page apply.

## 6. Required implementation — typed and causal failure diagnostics

Convert local apply failures into bounded results after the page transaction
has rolled back.

Required classifications:

```text
natural identity contradiction
  => SyncStatusCode.conflict
  => SyncOutcome.notApplied
  => sanitized protocol code

known SQLite constraint/write category after trusted response
  => SyncStatusCode.unknownOutcome or another existing safe terminal
  => SyncOutcome.unknown
  => allowlisted sanitized local category
```

Do not persist:

- SQL text;
- exception messages containing values;
- Product/Store names or codes;
- UUIDs;
- event payloads;
- connection details;
- stack traces.

For every failed local apply after the page is received, diagnostics must
retain:

```text
code = MKS-LDB-001 or MKS-DNL-006 as appropriate
phase = download-local-apply
lastProvedPhase = download-local-apply
providerContactState = request-started
trustedResponseState = received
providerTransactionState = not-applicable
localMutationState = rolled-back or none
acknowledgement = not started
```

The ordinary-Sync Closure boundary must not replace that causal evidence with
`trustedResponseState=not-received`. If an unexpected exception still reaches
the runner, preserve the latest recorded causal phase/state through a bounded,
sanitized snapshot rather than hard-coded unknown values.

## 7. Writable scope

Codex may modify only the smallest necessary subset of:

```text
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/lib/app/native_auth_closure_runner.dart
clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
clients/markei_flutter/lib/application/sync/sync_ports.dart
clients/markei_flutter/lib/application/sync/sync_use_cases.dart
clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_event_applier.dart
clients/markei_flutter/lib/infrastructure/local/sync/remote_purchase_fact_writer.dart
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
clients/markei_flutter/test/sync/local_sync_application_test.dart
clients/markei_flutter/test/sync/real_convergence_harness_test.dart
clients/markei_flutter/test/infrastructure/remote_purchase_event_applier_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

The new focused test file is authorized if it is the narrowest coherent home.

Do not modify:

- migrations, Drift table definitions or generated database code;
- API routes, server code, payload version or hosted schema;
- authentication, enrollment, RLS or provider configuration;
- GRM/GRIMOIRE files;
- D/E/F or J;
- A/B/C, permanent notebook domains or methodology;
- dependencies or lockfiles;
- production configuration.

If a migration, protocol version, provider mutation, dependency change or
different source surface is required, stop and report the blocker in G/H/I.

## 8. Required validation

Run from `clients/markei_flutter`:

```text
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test test/app/markei_app_test.dart
flutter test test/app/native_closure_diagnostics_test.dart
flutter test test/infrastructure/remote_purchase_event_applier_test.dart
flutter test test/sync/local_sync_application_test.dart
flutter test
```

Run the disposable HTTP/PostgreSQL convergence harness only if its documented
Docker prerequisites are available and it cannot contact Neon or production:

```text
MARKEI_RUN_SYNC_LAB=1 flutter test test/sync/real_convergence_harness_test.dart
```

Also run:

```text
flutter build apk --debug with reviewed public placeholder defines
git diff --check
changed-content sensitive-pattern scan
changed-file inventory
```

The focused local-apply tests must cover:

```text
fresh target database
same Product UUID and coherent facts
different Product UUID with equivalent natural identity
same normalized code with contradictory identity
same identity with contradictory normalized code
natural keys resolving to different rows
equivalent Store with different UUID
two events sharing Store/Product identities
Purchase Item remote-to-local Product remapping
duplicate page replay
mid-page conflict and complete rollback
mid-page SQLite failure and complete rollback
inbox/cursor advancement only after fact commit
acknowledgement not started after local failure
trusted-response evidence retained after local failure
no raw value/SQL/payload leakage
```

Do not use the preserved live Android snapshot as a test target.

## 9. Live and publication stop conditions

During Codex materialization:

```text
WINDOWS_SYNC=HELD
ANDROID_SYNC=HELD
RETRY=HELD
RECOVERY=HELD
ENROLL=DO_NOT_REPEAT
PROVIDER_MUTATION=NONE
DEPLOYMENT=NONE
LIVE_SNAPSHOT_MUTATION=NONE
```

Do not run a live Android retest, install to the operator's emulator, press a
Closure control, or acknowledge hosted cursor 2. A later Main/human packet
will authorize exactly one corrected Android Sync only after source validation
and published artifact provenance are reconciled.

## 10. G report

Replace `G_OPS_CODEX.md` and report:

- inspected baseline and branch;
- exact source and test files changed;
- Product selector identity behavior before/after;
- Product/Store reconciliation decision table materialized;
- remote-to-local mapping behavior;
- page transaction and rollback evidence;
- diagnostic categories and causal fields;
- exact commands, results, skipped checks and environment limits;
- explicit absence of live/client/provider actions;
- worktree inventory and unrelated pre-existing changes preserved.

Required terminals:

```text
PRODUCT_SELECTOR_IDENTITY=STABLE_PRODUCT_ID_OR_BLOCKED
FIND_BY_CODE_DROPDOWN_ASSERTION=REGRESSION_PASS_OR_BLOCKED
REMOTE_PRODUCT_IDENTITY_RECONCILIATION=PASS_OR_BLOCKED
REMOTE_STORE_IDENTITY_RECONCILIATION=PASS_OR_BLOCKED
REMOTE_ITEM_ID_REMAP=PASS_OR_BLOCKED
REMOTE_PAGE_ATOMICITY=PASS_OR_BLOCKED
LOCAL_APPLY_CAUSAL_DIAGNOSTICS=PASS_OR_BLOCKED
TRUSTED_RESPONSE_STATE_AFTER_LOCAL_FAILURE=RECEIVED_OR_BLOCKED
ACKNOWLEDGEMENT_AFTER_FAILED_LOCAL_APPLY=NOT_STARTED_OR_BLOCKED
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
C10_GCM03_S10_R02=IMPLEMENTED_VALIDATED_OR_PARTIAL
```
