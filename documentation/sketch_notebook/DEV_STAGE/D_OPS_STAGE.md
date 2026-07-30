# D_OPS_STAGE — C10-GCM03-S10-R05 truth-plane completion

## Active authority

Authority state: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED AFTER PUBLICATION

Sequence: FLX-ORD-01 entered from FLX-PRM-04 reconciliation

Primary unit: C10-GCM03-S10-R05

Human-assay continuity alias: C10-GCM03-S09-R05

Previous unit: C10-GCM03-S10-R04

Repository: gus-i-gu/markei

Existing branch: grm-guarded-provisioning-20260727

Required pre-stage head: 0fdd2b9fbadbf935d8e20f09f597516a93f4e7dd

Required Codex starting head: the published R05 D/E/F staging commit, as pinned
by Main.

D controls executable scope and terminals. E constrains evidence meaning. F
controls responsibility and compatibility boundaries. J, REC_DIAGNOSTICS.md,
preserved client data, and provider state are read-only.

## 1. Entry state

R04 is accepted at implementation and automated scope for:

- replacing whole-event strongest-evidence selection with cumulative merging;
- retaining trusted download and committed apply through later defaults;
- containing diagnostic begin, row, and completion persistence failures;
- direct Product ambiguity, immutable-UUID, unexpected-apply, poison-page, and
  mixed-client replay tests;
- full Flutter regression and Android/Windows packaging.

Main did not promote R04 as complete because the cumulative model still merges
facts from different transactions into generic fields:

1. upload lease/result persistence and inbound page application share one
   `localMutationState`;
2. upload provider result and acknowledgement share one
   `providerTransactionState` and one `trustedResponseState`;
3. acknowledgement has no independent not-started/request-started/response/result
   dimension;
4. a valid `upload committed -> inbound apply rolled-back` sequence is classified
   as `diagnostic-causal-invariant-conflict`;
5. an earlier upload provider commit can remain visible when acknowledgement
   later starts and fails without a trusted response, making acknowledgement
   truth ambiguous in the cumulative and terminal projections.

These are source-proved modeling defects. No live client operation is required
to justify R05.

## 2. Runtime checkpoint disposition

R05 is source-only and may proceed without collecting a new WIN/AND/provider
snapshot first because it is prohibited from touching installed clients,
preserved databases, diagnostic history, or provider state.

A read-only preserved-state checkpoint remains mandatory after R05 Main
reconciliation and before any corrected-client installation or live assay.
Taking that checkpoint after source materialization but before installation
still anchors the unchanged pre-install runtime state.

Codex shall not collect that checkpoint and shall not convert this source round
into an operator round.

```text
PRE_R05_SOURCE_JUSTIFICATION=SOURCE_PROVED
PRESERVED_RUNTIME_STATE_DURING_R05=UNTOUCHED
POST_R05_PRE_INSTALL_READ_ONLY_CHECKPOINT=REQUIRED_PENDING
LIVE_ASSAY_AUTHORITY=NONE
```

## 3. Accepted baseline to preserve

- The R03 Product resolver and remote-to-local Product UUID map.
- Same-code/different-identity, split-key, ambiguity, and established-UUID
  mutation remain bounded conflicts.
- Local Product code/display remains preserved.
- Product/Store reconciliation, Purchases/Items, inbox, and Account cursor remain
  in one Drift transaction.
- Apply exceptions translate only outside the rolled-back transaction.
- R04 diagnostic persistence remains best-effort and cannot change core truth.
- Acknowledgement remains ineligible without a committed contiguous cursor.
- Protocol v3, hosted API, schema, Auth0, enrollment, Account/Device binding,
  Store behavior, Person/Payment restrictions, and Product selector behavior
  remain unchanged.

If direct source inspection proves one of these accepted properties false, stop
and record the blocker in G/H/I instead of broadening or redesigning silently.

## 4. Writable scope

Default production paths:

- `clients/markei_flutter/lib/app/native_auth_closure_runner.dart`
- `clients/markei_flutter/lib/application/sync/sync_ports.dart`
- `clients/markei_flutter/lib/application/sync/sync_use_cases.dart`

Use only when required to preserve coordinator ordering or expose a bounded
terminal result:

- `clients/markei_flutter/lib/application/hosted_sync_coordinator.dart`
- `clients/markei_flutter/lib/application/closure_diagnostics.dart`

Default test paths:

- `clients/markei_flutter/test/app/native_closure_diagnostics_test.dart`
- `clients/markei_flutter/test/sync/local_sync_application_test.dart`
- `clients/markei_flutter/test/sync/two_device_system_harness_test.dart`

Regression-only test paths may be updated only when an R05 evidence-model API
change requires a mechanical fixture adaptation:

- `clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart`
- `clients/markei_flutter/test/infrastructure/remote_purchase_event_applier_test.dart`

Do not touch the Product resolver, fact writer, page applier, database schema,
migrations, hosted API, JavaScript service, generated files, dependencies, or
configuration. A required path outside this list is a stop condition.

Replace only:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

No other Sketch Notebook, GRM, script, or operator file is writable.

## 5. Required truth-plane model

Replace the operation-wide generic cumulative interpretation with independently
owned planes. The exact Dart type layout is an implementation choice, but one
coherent recorder snapshot must expose at least:

### Upload plane

- upload request not-started/started;
- trusted upload response not-received/received;
- upload provider outcome not-started/unknown/committed/rejected or equivalent;
- upload lease local outcome not-started/committed/failed/unknown;
- upload-result local persistence not-started/started/committed/failed/unknown.

### Download and inbound-apply plane

- download request not-started/started;
- trusted download response not-received/received;
- inbound apply not-started/committed/rolled-back/unknown;
- committed cursor proof available/unavailable/unknown where required for
  acknowledgement eligibility.

### Acknowledgement plane

- acknowledgement not-started/request-started;
- acknowledgement trusted response not-received/received;
- acknowledgement outcome not-started/unknown/applied/rejected or equivalent.

### Diagnostic and terminal plane

- diagnostic persistence durable/degraded;
- latest entered phase;
- latest proved phase;
- bounded terminal result/outcome;
- safe action and retryability;
- sanitized exception class/category;
- safe counts, sequences, timing bands, and fingerprints already authorized.

The cumulative snapshot and lifecycle projection must not require a consumer to
infer acknowledgement from upload provider state or inbound apply from a
generic operation-wide local mutation field.

## 6. Compatibility handling

Existing generic fields on a single `SyncDiagnosticPhaseEvidence` or
`SyncDiagnosticEnvelope` may remain for event-row compatibility. They describe
that event only and must not act as the canonical cumulative representation of
multiple transactions.

R05 may add bounded optional application/in-memory evidence fields and lifecycle
JSON keys. It must not:

- add a Drift column or migration;
- change the hosted protocol or payload;
- alter provider logs or database contracts;
- persist a new unsanitized identifier or business fact;
- reinterpret old durable rows as proof they cannot contain.

If durable event rows cannot store the new cumulative planes without migration,
retain phase-specific legacy fields for durable chronology and project the
independent cumulative state in memory/lifecycle. Report that compatibility
boundary explicitly in G/H/I.

## 7. Merge laws

Merge authority is scoped to a plane.

- Later placeholders cannot erase earlier proof within the same plane.
- Trusted response `received` cannot regress within its request plane.
- Upload local persistence cannot satisfy or contradict inbound apply.
- Upload provider outcome cannot satisfy or contradict acknowledgement.
- Inbound apply cannot satisfy acknowledgement.
- Diagnostic durability cannot establish provider, apply, cursor, or
  acknowledgement truth.
- Terminal evidence adds a result and guidance without overwriting core planes.
- A runner exception may add a sanitized terminal category, but cannot rewrite
  previously proved upload, download, apply, or acknowledgement facts.
- A contradiction between authoritative declarations about the same transaction
  must produce the bounded invariant category.
- Different outcomes in different transactions are valid compound state.

Required valid compound states include:

```text
upload persistence committed + inbound apply rolled-back
upload provider committed + acknowledgement unknown
inbound apply committed + acknowledgement request-started/response-not-received
diagnostics degraded + inbound apply committed + acknowledgement applied
```

Required bounded invariant:

```text
inbound apply failed or unproved + acknowledgement request-started
```

Do not infer plane identity from severity or arbitrary string strength alone.
Use explicit fields, a typed internal event, or a deterministic phase-to-plane
adapter covered directly by tests.

## 8. Producer and runner behavior

Update the phase producers so each upload, download/apply, and acknowledgement
event contributes only to its owning plane.

The recorder must update cumulative state synchronously before awaiting
diagnostic persistence.

The runner success and catch paths must consume the same cumulative snapshot.
Lifecycle declarations must expose the independent planes with bounded keys.
The runner catch must preserve all prior proved planes while adding the terminal
classification and sanitized exception class.

Acknowledgement begins only after committed inbound apply and a committed
contiguous cursor. A failed, rejected, rolled-back, or unproved apply prohibits
acknowledgement. Diagnostic degradation does not remove eligibility when cursor
proof independently exists.

If acknowledgement transport throws after committed apply:

- inbound apply remains committed;
- acknowledgement remains request-started;
- acknowledgement trusted response remains not-received unless proved;
- acknowledgement outcome becomes unknown/failed according to authoritative
  evidence;
- upload state remains exactly what upload established;
- no retry, recovery, query, or second operation starts automatically.

## 9. Required direct deterministic tests

Add coordinator/runner-level tests that inspect independent fields, not only
final result strings:

1. no upload, committed inbound apply, acknowledgement success;
2. no upload, committed inbound apply, acknowledgement transport exception;
3. successful upload/result persistence followed by inbound apply rollback;
4. successful upload/result persistence followed by committed inbound apply and
   acknowledgement transport exception;
5. upload unknown or rejected causes the existing early stop with no download or
   acknowledgement proof;
6. failed or unproved inbound apply keeps acknowledgement not-started;
7. begin diagnostic failure across a compound upload/download/ack operation;
8. diagnostic row failure across a compound upload/download/ack operation;
9. diagnostic completion failure across a compound upload/download/ack
   operation;
10. terminal success and runner fallback preserve every independent plane;
11. valid cross-plane outcomes do not create a false diagnostic invariant;
12. a contradiction within one authoritative plane creates the bounded
    invariant category;
13. lifecycle and cumulative snapshots contain no payload, business fact, UUID,
    token, SQL, exception message, stack, secret, path, or full hash;
14. R03/R04 Product decision, unexpected apply, poison-page recovery, mixed
    replay, and idempotency remain passing.

Each applicable compound test must assert:

- upload request, trusted response, provider outcome, lease, and result
  persistence;
- download request and trusted response;
- inbound apply and cursor/eligibility truth;
- acknowledgement request, trusted response, and outcome;
- diagnostic durability;
- latest entered/proved phase;
- terminal result, safe action, retryability, and sanitized class;
- absence of automatic second operations.

## 10. Validation

Run from `clients/markei_flutter` and report exact outcomes:

1. `dart format --output=none --set-exit-if-changed lib test`
2. `flutter analyze`
3. focused R05 runner/coordinator/truth-plane tests
4. `flutter test test/app/native_closure_diagnostics_test.dart`
5. `flutter test test/sync/local_sync_application_test.dart`
6. `flutter test test/sync/two_device_system_harness_test.dart`
7. `flutter test test/sync/v3_contract_test.dart`
8. focused R03/R04 Product/apply/replay regression tests
9. stable catalogue/Store/Product-selector regression tests
10. `flutter test`
11. `flutter build apk --debug`
12. `flutter build windows`
13. inspect the merged Android manifest using the established procedure
14. repository-root `git diff --check`
15. established diagnostics generator/check
16. changed-content sensitive scan
17. exact changed-file inventory, ancestry, and branch guard

Four disposable provider labs skipped because `MARKEI_RUN_SYNC_LAB=1` is absent
remain skipped evidence. They are not live acceptance.

## 11. Prohibited operations

Do not perform:

- live Android or Windows Sync;
- Retry, Recovery, Query, enrollment, or live acknowledgement;
- new Purchase registration;
- app installation or launch against preserved data;
- WIN/AND SQLite or provider-state collection;
- diagnostic clearing or local database repair/reset;
- provider mutation or hosted-event rewrite;
- schema, migration, API, payload, auth, enrollment, dependency, build-config,
  or environment change;
- branch creation/rename, rebase, force push, PR, or unrelated cleanup.

Do not modify J, REC_DIAGNOSTICS.md, permanent memory, methodology, D/E/F after
implementation begins, `DB_MGMT.sql`, `G_SCRIPTS.md`, or `I_SCRIPTS.ps1`.

## 12. G/H/I contract

G records:

- starting and final heads;
- exact changed paths;
- implementation mapping to every D requirement;
- exact commands, counts, skips, builds, and warnings;
- terminals and zero runtime/provider mutation confirmation.

H records:

- requirement-to-test mapping;
- independent plane assertions for every compound case;
- same-plane contradiction and cross-plane compatibility evidence;
- negative and sensitive-content assertions;
- PRC-01 ceilings and every partial/missing test.

I records:

- the truth-plane architecture and state vocabulary;
- producer-to-plane ownership;
- merge laws and invariant scope;
- event-row compatibility;
- runner/terminal projection;
- acknowledgement eligibility;
- frozen R03/R04 boundaries and residual design risks.

## 13. Terminals

Report exactly:

```text
C10_GCM03_S10_R05=IMPLEMENTED_VALIDATED | BLOCKED
TRUTH_PLANES_PARTITIONED=PASS | FAIL
UPLOAD_PROVIDER_PLANE=PASS | FAIL
UPLOAD_LOCAL_PERSISTENCE_PLANE=PASS | FAIL
DOWNLOAD_TRUSTED_RESPONSE_PLANE=PASS | FAIL
INBOUND_APPLY_PLANE=PASS | FAIL
ACKNOWLEDGEMENT_INDEPENDENT_PLANE=PASS | FAIL
VALID_UPLOAD_COMMIT_PLUS_APPLY_ROLLBACK=PASS | FAIL
ACK_FAILURE_RETAINS_PRIOR_PLANES=PASS | FAIL
SAME_PLANE_CONTRADICTION_BOUNDED=PASS | FAIL
DIAGNOSTIC_DEGRADATION_INDEPENDENT=PASS | FAIL
R03_R04_ACCEPTED_BASELINE_REGRESSION=PASS | FAIL
PRESERVED_CLIENT_STATE_TOUCHED=NO
LIVE_SYNC_EXECUTED=NO
PROVIDER_MUTATION=NONE
POST_R05_PRE_INSTALL_READ_ONLY_CHECKPOINT=REQUIRED_PENDING
```

## 14. Publication

If and only if implementation and required validation succeed:

1. replace G/H/I;
2. confirm every changed path is authorized;
3. create one intentional commit whose direct parent is the published R05
   staging commit;
4. push to the existing `grm-guarded-provisioning-20260727` branch;
5. use a non-forced fast-forward;
6. do not create a branch or PR;
7. read the remote branch back and verify exact identity.

R05 success does not promote practical Sync. Main must reconcile the commit
before publishing any preserved-state checkpoint or operator packet.
