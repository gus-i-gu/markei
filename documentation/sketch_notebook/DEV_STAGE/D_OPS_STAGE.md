# D_OPS_STAGE — C10-GCM03-S10-R04 completion materialization

## Active authority

Authority state: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED AFTER PUBLICATION

Primary unit: C10-GCM03-S10-R04

Human-assay continuity alias: C10-GCM03-S09-R04

Previous unit: C10-GCM03-S10-R03

Repository: gus-i-gu/markei

Existing branch: grm-guarded-provisioning-20260727

Required pre-stage head: 5d7cd6c9784f0fa169a5ed6fb6ca8cb3db4037ce

Required Codex starting head: the published R04 D/E/F staging commit, as pinned by Main.

This is one bounded FLX-ORD-01 completion round entered from Main's R03
post-materialization reconciliation. D controls implementation scope and
terminals; E constrains evidence interpretation; F constrains architecture.
J and REC_DIAGNOSTICS.md remain append-only and are not writable by Codex.

## 1. Entry diagnosis

R03 corrected the observed Product exact-identity/different-code failure at
source and focused-test scope, retained one-transaction page application,
introduced bounded post-rollback translation, projected the sanitized exception
class, and kept acknowledgement behind committed cursor exposure.

Main did not promote R03 as complete because:

1. `_DiagnosticOperationRecorder` keeps one replaceable
   `SyncDiagnosticPhaseEvidence`, not cumulative operation truth;
2. an acknowledgement-request or later terminal phase can replace an earlier
   trusted download and committed local apply with weaker defaults;
3. `beginDiagnosticAttempt` failure becomes `attemptId == null` without marking
   persistence degraded;
4. row/complete diagnostic failures are not consistently reflected in the final
   operation declaration;
5. the exact R03 Product, apply, persistence-failure, replay, and runner-fallback
   test matrix is incomplete.

No evidence indicates a schema, provider, API, authentication, enrollment,
payload-v3, dependency, or hosted-event change is required.

## 2. Accepted baseline that R04 must preserve

- A previously unseen remote Product UUID may reuse one exact semantic local
  Product despite a different user code.
- Same-code/different-identity, split-key, ambiguity, and established-UUID
  mutation remain typed conflicts.
- Local Product code/display is preserved and dependent Purchase Items use the
  remote-to-local Product UUID map.
- Product/Store reconciliation, Purchases/Items, inbox, and Account cursor remain
  in one Drift transaction.
- Apply failures translate only outside the rolled-back transaction.
- Acknowledgement is ineligible unless the local page and cursor committed.
- Stored `sanitizedExceptionClass` reaches summary/current action/Closure UI.
- Protocol v3, Store rules, Account scope, Person/Payment restrictions, and
  stable Product selector behavior remain unchanged.

If implementation discovers that one of these accepted properties is false,
stop and report the exact blocker in G/H/I rather than redesigning silently.

## 3. Writable scope

Default production scope:

- `clients/markei_flutter/lib/app/native_auth_closure_runner.dart`
- `clients/markei_flutter/lib/application/sync/sync_ports.dart`
- `clients/markei_flutter/lib/application/sync/sync_use_cases.dart`

Use only when required by the diagnostic-persistence contract:

- `clients/markei_flutter/lib/application/closure_diagnostics.dart`
- `clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart`

Default test scope:

- `clients/markei_flutter/test/app/native_closure_diagnostics_test.dart`
- `clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart`
- `clients/markei_flutter/test/infrastructure/remote_purchase_event_applier_test.dart`
- `clients/markei_flutter/test/sync/local_sync_application_test.dart`
- `clients/markei_flutter/test/sync/two_device_system_harness_test.dart`

Minimal test-only seams may touch
`remote_purchase_event_applier.dart` or `remote_purchase_fact_writer.dart` only
when deterministic coverage cannot be achieved through existing public seams.
Such a touch must preserve production decisions and be justified in G/H/I.

Codex shall replace only `G_OPS_CODEX.md`, `H_DDC_CODEX.md`, and
`I_DSN_CODEX.md`. No other Sketch Notebook or GRIMOIRE file is writable.

Any additional production path, generated file, schema, migration, API,
dependency, or configuration requirement is a stop condition.

## 4. Cumulative causal state

Replace single-object strongest-evidence selection with one per-operation
cumulative causal state. It may be a dedicated immutable model or an equivalent
recorder-owned structure, but it must retain these dimensions independently:

- latest entered phase;
- latest proved phase;
- provider contact;
- provider transaction;
- trusted response;
- download/local-apply outcome;
- local mutation commit/rollback/unknown;
- result/diagnostic persistence;
- acknowledgement not-started/started/result;
- bounded outcome/result code;
- retryability and safe action;
- sanitized exception class/category;
- safe queue/sequence/fingerprint metadata already authorized.

Merge rules are monotonic:

- `received` trusted-response proof cannot regress to `not-received`, a default,
  `unknown`, or `see-causal-event`;
- `committed` local mutation cannot be erased by an acknowledgement-request or
  terminal declaration;
- proved rollback cannot become committed without a later authoritative core
  result, and contradictory authoritative core states must produce a bounded
  invariant failure rather than first/last-writer wins;
- acknowledgement-request may advance acknowledgement/provider-contact state
  while retaining download/apply truth;
- terminal placeholder fields cannot erase causal facts;
- a generic runner exception may add its sanitized class and terminal outcome,
  but cannot rewrite earlier provider, trusted-response, apply, or commit proof.

Update the cumulative state synchronously before any awaited durable diagnostic
write. Do not retain payloads, business facts, UUIDs, SQL, tokens, messages,
stacks, secrets, or full hashes.

## 5. Diagnostic-persistence containment

Treat begin, row/event, and completion persistence as best-effort observability:

- begin failure initializes the operation recorder as persistence-degraded;
- row/event failure marks degradation without throwing through the coordinator;
- completion failure marks degradation after the core result is known;
- final lifecycle/result projection exposes
  `diagnostics-persistence-degraded` when any of those failures occurred;
- degradation must not change committed versus rolled-back transaction truth;
- degradation after committed apply must not make acknowledgement ineligible;
- degradation must not manufacture acknowledgement or provider success;
- do not recursively attempt to diagnose a failing diagnostic write.

If no durable attempt row exists, the in-memory/lifecycle declaration must still
retain the bounded degradation state. If some durable writes remain possible,
persist only the already-authorized sanitized degradation category.

Pure diagnostic failure must not turn an otherwise completed/no-new-events core
Sync result into `sync-failed`.

## 6. Runner and acknowledgement boundary

The runner safety catch must consume the cumulative snapshot after every phase.
It must preserve any trusted download, committed/rolled-back local apply, and
acknowledgement state already proved.

Acknowledgement may begin only from a committed contiguous cursor. A failed,
rejected, rolled-back, or unproved apply prohibits it. A committed apply remains
eligible even if diagnostics are degraded. An acknowledgement transport failure
must retain the committed local-apply truth while recording acknowledgement as
started/unknown or failed according to authoritative evidence.

## 7. Required deterministic tests

### Causal and persistence tests

- committed download apply followed by acknowledgement-request preserves trusted
  response and committed local mutation;
- acknowledgement exception preserves committed apply and reports
  acknowledgement uncertainty without rewriting transaction truth;
- terminal declaration preserves all earlier causal facts;
- runner fallback after apply/ack failure consumes the cumulative state;
- begin-diagnostic failure is visible as degraded while core Sync continues;
- row-write failure before apply is contained and visible;
- row-write failure while reporting rollback preserves rollback truth;
- row-write or completion failure after commit preserves commit truth;
- committed apply with diagnostic degradation remains acknowledgement-eligible;
- diagnostics cannot create provider, transaction, or acknowledgement proof;
- sanitized output contains no message, SQL, value, payload, UUID, token, stack,
  secret, or full hash.

### Product decision table completion

- ambiguous normalized-code match is a bounded conflict;
- ambiguous exact-identity match is a bounded conflict;
- established incoming UUID immutable mutation is a bounded conflict;
- exact identity under another code still reuses and preserves local display;
- same code/different identity and split-key conflicts remain;
- every dependent Purchase Item uses the remote-to-local Product map.

If a database uniqueness invariant makes an ambiguity impossible through normal
rows, test the resolver branch through a minimal seam and separately prove the
invariant; do not weaken or bypass production constraints.

### Apply, replay, and poison-page completion

- an arbitrary non-SQL/non-payload/non-invariant exception maps to
  `unexpected-local-apply-failed` after total rollback;
- facts, inbox, and cursor remain unchanged on every failed page;
- no acknowledgement follows failed or unproved apply;
- the formerly rejected exact-identity/different-code event can apply on replay;
- a later page/event then advances without the earlier event poisoning progress;
- mixed two-client events converge without duplicate Product, Store, Purchase,
  Purchase Item, inbox, or cursor effects;
- a repeated page remains idempotent.

### Regression

- stable Product-ID selection and Find Item;
- Store convergence;
- upload-result persistence and queue behavior;
- v3 Person/Payment restrictions and contract;
- prior local sync, two-device harness, and Closure UI diagnostics suites.

## 8. Validation

Run from `clients/markei_flutter` and report exact outcomes:

1. `dart format --output=none --set-exit-if-changed lib test`
2. `flutter analyze`
3. focused R04 runner/diagnostic/Product/apply/replay tests
4. `flutter test test/sync/local_sync_application_test.dart`
5. `flutter test test/sync/two_device_system_harness_test.dart`
6. `flutter test test/sync/v3_contract_test.dart`
7. stable catalogue/Store/Product selector regression tests
8. `flutter test`
9. `flutter build apk --debug`
10. `flutter build windows`
11. merged Android manifest inspection where the existing procedure applies
12. repository-root `git diff --check`
13. changed-content sensitive scan
14. exact changed-file inventory and ancestry guard

Skipped disposable labs are environment-limited evidence, never live acceptance.

## 9. Prohibited operations

No live client Sync, Retry, Recovery, Enroll, Query, acknowledgement, new
Purchase registration, install/launch against preserved data, diagnostic
clearing, data reset, database surgery, provider mutation, hosted event rewrite,
schema/migration/API/auth/enrollment/dependency/configuration change, branch
creation/rename, rebase, force push, or unrelated cleanup.

Do not modify J, REC_DIAGNOSTICS.md, permanent notebook memory, methodology,
D/E/F after starting, `DB_MGMT.sql`, `G_SCRIPTS.md`, or `I_SCRIPTS.ps1`.

## 10. G/H/I evidence contract

G records starting/ending heads, exact paths, implementation mapping, commands,
results, skips, builds, terminals, and confirmation of zero live/provider action.

H maps every required test and negative assertion to direct evidence and applies
PRC-01 ceilings. Missing direct coverage is reported as missing, not inferred
from the full-suite count.

I records the cumulative-state design, merge laws, recorder failure boundaries,
acknowledgement ordering, preserved R03 architecture, compatibility, and any
residual design risk.

## 11. Terminals and publication

```text
C10_GCM03_S10_R04=IMPLEMENTED_VALIDATED | BLOCKED
CUMULATIVE_CAUSAL_STATE=PASS | FAIL
ACK_TRANSITION_TRUTH_PRESERVED=PASS | FAIL
DIAGNOSTIC_BEGIN_FAILURE_VISIBLE=PASS | FAIL
DIAGNOSTIC_ROW_FAILURE_CONTAINED=PASS | FAIL
DIAGNOSTIC_COMPLETE_FAILURE_CONTAINED=PASS | FAIL
COMMITTED_APPLY_ACK_ELIGIBLE_WHEN_DIAGNOSTICS_DEGRADED=PASS | FAIL
PRODUCT_DECISION_MATRIX_DIRECT_EVIDENCE=PASS | PARTIAL | FAIL
UNEXPECTED_LOCAL_APPLY_DIRECT_EVIDENCE=PASS | FAIL
POISON_PAGE_RECOVERY=PASS | FAIL
MIXED_CLIENT_REPLAY_IDEMPOTENCY=PASS | FAIL
R03_ACCEPTED_BASELINE_REGRESSION=PASS | FAIL
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
```

Publish one non-forced fast-forward commit containing only authorized
source/test/G/H/I paths. Do not open a competing branch or PR.
