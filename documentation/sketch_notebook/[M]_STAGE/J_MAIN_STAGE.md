# J_MAIN_STAGE — Protected Submission Cursor-State Reconciliation

> Sequence: FLX-ORD-01 post-materialization reconciliation
> Authority marker: C10-MCG02-SUBMISSION-500-DIAGNOSIS_20260722
> Materialization commit: `75dc7bed0789d693af93abb3ed15e107fd77433a`
> Status: **LOCAL CAUSE CORRECTED; HOSTED CURSOR-STATE PREREQUISITE UNRESOLVED; REAL SYNC BLOCKED**

## 1. Reconciled result

Codex reproduced the protected-submission failure locally with synthetic identity and disposable
database fixtures. The proved project-owned cause was an absent `account_cursor_state` row for an
otherwise valid Account/Device. `acceptSubmission` updated zero cursor rows and then dereferenced the
missing returned row, producing the provider-observed HTTP `500` before any synchronization fact was
committed.

Commit `75dc7be` materialized a bounded fail-closed correction:

- a zero-row cursor update returns `service-unavailable`, `upload-submission`, `not-applied`;
- hosted protocol failures are mapped through the existing HTTP result mapper;
- `service-unavailable` maps to HTTP `503` and remains distinct in Flutter;
- Closure treats the observed response as Sync unavailable rather than an unknown transport outcome;
- unexpected server exceptions no longer emit `request-failed` with a misleading successful status;
- no client deadline extension or database migration was introduced.

The correction makes the failure safe, classified and observable. It does not initialize or repair the
missing hosted cursor-state row.

## 2. PRC-01 classification

| Claim | Classification and boundary |
| --- | --- |
| Missing Account cursor state locally reproduces the protected `500` | Validated with synthetic regression evidence |
| The historical provider failure is consistent with that reproduced path | Accepted diagnosis by correlated shape; provider internals were not inspected |
| Zero-row cursor handling is corrected | Implemented and locally validated at `75dc7be` |
| Misleading `request-failed status 200` is corrected | Implemented and locally validated |
| Flutter preserves an observed `service-unavailable` result | Implemented and locally validated |
| The historical client timeout should be rewritten | Rejected; preserve client-observed history |
| The hosted cursor-state prerequisite now exists | Rejected; last sanitized Neon baseline showed zero rows |
| Deploying `75dc7be` alone will make Sync succeed | Rejected; the same missing prerequisite should yield bounded HTTP `503` |
| MCG-02 or provider Sync is closed | Rejected; no post-correction hosted proof exists |
| Events 1–2 may be replaced, resequenced or retried now | Rejected |

## 3. Validation accepted

Accepted local evidence reported in G/H/I:

- failing-before/passing-after protected-submission regression;
- API format, lint, typecheck, build and all 51 tests passed;
- Flutter formatting and analysis passed;
- Flutter suite passed: 178 tests with four lab-gated skips;
- disposable convergence and recovery harnesses passed when explicitly enabled;
- Windows release and Android debug builds passed;
- protected Python release-configuration regressions passed through `unittest`;
- migrations 001–006 remained unchanged;
- no provider, credential, human database or human unresolved submission was accessed.

`pytest` itself was unavailable, but the owned five-test Python module passed with the standard-library
runner. Existing Drift, Kotlin and Boost/CMake warnings remain non-blocking observational evidence.

## 4. Preserved boundary

The following remain unchanged:

- local events 1–2 remain `Unknown` with their exact identities and ordering;
- next local Device sequence remains 3;
- last provider baseline remains Account 1, Device 1 and zero cursor/submission/event/acknowledgement rows;
- no hosted commit or duplication is evidenced;
- JWT/JWKS, enrollment authorization, RLS, runtime/migrator separation and migrations 001–006 are preserved;
- real Sync, unresolved retry, re-enrollment, local-data mutation and provider-data mutation remain blocked.

## 5. Reconciliation consequence

The materialization terminal is accepted only in its stated sense:

```text
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED
```

This is not a hosted-readiness terminal. Before another provider retry, Main must resolve the missing
cursor-state lifecycle:

```text
Account creation/provisioning
  -> account_cursor_state(account_id, next_cursor = 1)
  -> enrollment and protected authorization
  -> first exact-identity submission
```

Current source fixtures and harnesses explicitly seed the cursor row, while the protected enrollment
path creates Device/enrollment records without visibly owning Account cursor initialization. The human
provider baseline therefore exposes a provisioning-policy gap, not merely a transient request error.

## 6. Next authorized sequence

1. Run FLX-PRM-04 in Operational, Didactic and Design chats so G/H/I are absorbed into their permanent
   domain memory and checkpoints.
2. Main reconciles those domain updates and stages one bounded cursor-state initialization/repair unit.
3. That unit must decide and test the canonical owner of cursor initialization, including fresh Account,
   existing Account missing state, concurrency, idempotency, transaction, RLS and least-privilege behavior.
4. Only after local materialization and reconciliation may `75dc7be` plus the cursor-state correction be
   deployed to Render.
5. After deployment: run one harmless health correlation and obtain a fresh sanitized Neon baseline.
6. Authorize at most one exact-identity retry only if the cursor-state row is proved present and all
   other counts remain consistent.

Until a new D/E/F authority marker exists, no further implementation or provider mutation is authorized.

```text
C10_MCG02_CURSOR_STATE_PREREQUISITE_UNRESOLVED
```

---

## Append-only reconciliation entry — 2026-07-22 — A/B/C cursor-state lifecycle staging

> Sequence: FLX-PRM-04 functional reconciliation → Main synthesis
> Inspected HEAD: `75dc7bed0789d693af93abb3ed15e107fd77433a`
> Inputs: `DEV_STAGE/A_OPERATIONAL.md`, `DEV_STAGE/B_DIDACTIC.md`, `DEV_STAGE/C_DESIGN.md`
> Persistence boundary: staging only; permanent domain files intentionally unchanged while GCM02 remains open
> Status: **A/B/C COMPLETE; NEXT CHECK-GATHERING UNIT IDENTIFIED; NO MATERIALIZATION OR PROVIDER AUTHORITY YET**

### Achievements and repository track record retained

The functional reconciliation accepts the following bounded lineage and achievements:

```text
5b364216  transport observability diagnostics
  -> 22261751  protected-submission 500 diagnosis staging
  -> 75dc7bed  missing cursor-state reproduction and fail-closed correction
```

- Windows Closure correlated `/health/live` and `/health/ready` under fingerprint `500a78db`; both
  returned HTTP 200.
- One previously authorized exact-identity retry reached `POST /v1/sync/submissions` under Render
  fingerprint `46e9a131`; Render returned final HTTP 500 while Closure crossed its 1000 ms observation
  boundary without response headers.
- The post-attempt provider snapshot remained Account 1, Device 1, and zero cursor-state,
  submissions, Sync events and acknowledgements; no hosted commit or duplication was evidenced.
- Local synthetic reproduction proved the missing `account_cursor_state` row caused a zero-row update
  followed by the unsafe failure.
- `75dc7be` converts that path to sanitized HTTP 503 `service-unavailable` / `not-applied`, fixes the
  misleading successful status on `request-failed`, and preserves timeout/unknown-outcome semantics.
- API format, lint, typecheck, build and 51 tests passed; Flutter formatting, analysis and 178 tests
  passed with four gated skips; disposable convergence and recovery harnesses passed; Windows release
  and Android debug builds passed; five protected Python checks passed through `unittest`.
- Migrations 001–006, provider state, credentials, human local data and events 1–2 were not modified.

These are implementation and validation claims within their stated local/build boundaries. They do
not prove that the correction is deployed, that cursor state exists in the hosted environment, that
protected Sync succeeds, or that GCM02 is closed.

### Cross-domain reconciliation

Operational stages a three-part evidence route: read-only ownership inventory, Main-authorized local
correction proof, and only later a separately authorized provider verification. It requires fresh and
existing-Account cases, idempotency, concurrency, rollback, first-submission behavior, RLS and
least-privilege evidence.

Didactic preserves the distinctions:

```text
schema permits a row
!= lifecycle creates the row
!= runtime may safely assume the row exists

observed 503 not-applied
!= timeout/no trustworthy response
!= successful Sync
```

No KANBAN maturity or learner status changes are inferred from implementation evidence.

Design provisionally recommends the responsibility boundary:

```text
Account provisioning owns atomic Account + account_cursor_state initialization
Enrollment consumes/verifies the provisioned Account
Sync advances existing cursor state or fails closed
Existing incomplete Accounts use a controlled forward-only repair path
```

Main accepts this as the preferred direction for the next investigation, not yet as permanent canon or
implementation authority. Enrollment repair, first-Sync lazy initialization, re-enrollment, ad hoc
provider SQL and edits to migrations 001–006 remain rejected.

### Provisional physical candidates and unresolved decision

The next unit must inspect and prove the narrowest enforcement mechanism before Main freezes it:

1. preferred candidate: additive post-006 migration with database-enforced future Account
   initialization plus idempotent existing-Account backfill;
2. enforcement alternative: a narrowly owned Account-insert trigger;
3. acceptable only if comprehensively exclusive: a provisioning procedure with all direct Account
   inserts revoked or removed.

Repair must preserve existing cursor rows and derive a missing row's `next_cursor` from the Account's
immutable hosted high-water (`max(server_cursor) + 1`, or 1 when no events exist). The next unit must
prove locking, concurrency, rollback, safe ownership/search path, ACL/RLS, runtime denial, fresh and
upgrade paths, and first-submission monotonicity. These are staged design requirements, not authority
to create migration 007 yet.

### Next staging boundary

The next provisional unit name is:

```text
C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR
```

Before D/E/F become active, Main must use the A/B/C evidence to freeze:

1. trigger-backed invariant versus exclusive provisioning procedure;
2. additive migration identity/checksum policy after 006, if the inventory confirms migration need;
3. high-water repair query and lock/transaction strategy;
4. exact producer matrix and ACL/RLS/object-shadowing probes;
5. separation between local materialization, later deployment, provider repair verification, and the
   still-later exact-identity retry gate.

### Active stop and continuation gate

No permanent Operational, Didactic or Design files are edited by this reconciliation. No D/E/F unit is
activated in this entry. No deployment, migration application, Neon mutation, Auth0/Render change,
enrollment, ordinary Sync or unresolved-submission retry is authorized.

```text
A_B_C_RECONCILIATION_COMPLETE
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED
C10_MCG02_CURSOR_STATE_PREREQUISITE_UNRESOLVED
C10_MCG02_ACCOUNT_CURSOR_PROVISIONING_REPAIR_PROVISIONAL
GCM02_OPEN
REAL_SYNC_RETRY_UNAUTHORIZED
```

## Append-only reconciliation entry — 2026-07-22 — cursor provisioning mechanism frozen

> Sequence: FLX-ORD-01 Main decision after bounded repository inventory
> Remote checkpoint: `80935f1c312484d0819e119553a11691ec2216b4`
> Inputs: current A/B/C reconciliation, migrations 001–006, hosted enrollment, Sync service, local
> harnesses and migration-006 readiness proof
> Status: **D/E/F ACTIVE FOR LOCAL MATERIALIZATION; PROVIDER AND REAL SYNC BLOCKED**

### Remote and methodological track record

The A/B/C/J staging checkpoint was published on `intermid-cycle-recovery` as `80935f1c`. It contains
only functional/Main staging and leaves permanent domain memory unchanged. The branch lineage now
retained for this decision is:

```text
5b364216  transport observability
-> 22261751  submission-500 diagnosis authority
-> 75dc7bed  missing-state reproduction and fail-closed correction
-> 80935f1c  A/B/C/J cursor-lifecycle reconciliation
```

### Read-only ownership inventory accepted

Main accepts the following repository facts at `80935f1c`:

- migrations 001–006 create separate `accounts` and `account_cursor_state` tables but do not enforce
  total Account participation in cursor state;
- `account_cursor_state.account_id` is unique and references Accounts, so at most one row exists but
  zero remains representable;
- migration 002 removes runtime Account insertion but leaves direct runtime cursor insertion granted;
- hosted enrollment requires an existing identity/membership/Account and creates Device/enrollment
  state without cursor initialization;
- successful local harnesses and producers manually insert Account and cursor state separately;
- no production Account-provisioning service exists whose exclusive use can be proved;
- `markei_hosted_runtime_ready()` proves migration 006 only and cannot reject this provisioning gap.

These facts resolve the earlier mechanism question. An exclusive provisioning procedure would require
inventing and enforcing a new application boundary across all current direct Account insertions. A
database trigger is the narrower enforceable invariant and protects future trusted Account creation
regardless of orchestration path.

### Frozen implementation decision

Main activates:

```text
C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722
```

through current D/E/F.

The selected physical design is additive migration `007_account_cursor_provisioning` with checksum
`c10-mcg02-account-cursor-provisioning-v1`. It must:

1. backfill only missing cursor rows from `max(server_cursor) + 1`, or 1 with no events;
2. preserve every existing cursor row without update or reset;
3. install an Account `AFTER INSERT` trigger that creates cursor state in the same transaction;
4. revoke runtime cursor insertion while retaining required scoped select/update;
5. add `public.markei_hosted_runtime_ready_v2()` for the exact 006+007 contract;
6. update new API code to use readiness-v2 while preserving the 006 function for rollback;
7. retain Sync's missing-state HTTP 503 as defense in depth.

Enrollment repair, first-Sync lazy initialization, re-enrollment and ad hoc provider SQL remain
rejected. Migration 007 is locally authorized for Codex materialization and disposable proof only; it
is not authorized for Neon application or deployment.

### Required next evidence and continuation gate

Codex must produce G/H/I after failing-first and passing fresh/upgrade/backfill/preservation/
concurrency/rollback/ACL/RLS/readiness proof. Main must reconcile that evidence before any provider
action.

If local materialization passes, the later provider sequence remains separately gated:

```text
reconcile G/H/I
-> authorize migration/deployment order
-> apply 007 with migrator
-> verify readiness-v2 and Account cursor invariant read-only
-> deploy corrected API/client as authorized
-> run one harmless health-correlation check
-> capture fresh six-table baseline
-> authorize at most one exact-identity unresolved retry
```

Current terminals:

```text
A_B_C_RECONCILIATION_PUBLISHED_80935F1C
C10_MCG02_SUBMISSION_500_CAUSE_CORRECTED_LOCAL
C10_MCG02_ACCOUNT_CURSOR_PROVISIONING_REPAIR_AUTHORIZED_LOCAL
GCM02_OPEN
PROVIDER_MIGRATION_DEPLOYMENT_UNAUTHORIZED
REAL_SYNC_RETRY_UNAUTHORIZED
```

---

## Append-only reconciliation entry — 2026-07-22 — account cursor provisioning materialized locally

> Sequence: FLX-ORD-01 Main reconciliation after Codex materialization
> Materialization commit: `fe8976d8e7d9806dcb578994601eef7b76a174b2`
> Parent / controlling staging: `bca5800007453d3bef9f7178c1f534069550a0df`
> Inputs: `DEV_STAGE/G_OPS_CODEX.md`, `DEV_STAGE/H_DDC_CODEX.md`,
> `DEV_STAGE/I_DSN_CODEX.md`, implementation diff and named validation evidence
> Status: **LOCAL REPAIR ACCEPTED; PROVIDER STATE UNCHANGED; `sync-unknown` STILL UNRESOLVED**

### Materialized result accepted within its evidence boundary

Main accepts that `fe8976d8` materializes the bounded local unit:

```text
C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722
```

The implementation adds forward-only migration `007_account_cursor_provisioning`, identified by
checksum `c10-mcg02-account-cursor-provisioning-v1`. Migration 007:

1. backfills only missing `account_cursor_state` rows;
2. derives missing `next_cursor` as `max(sync_events.server_cursor) + 1`, or 1 when no events exist;
3. preserves every existing cursor row and value;
4. installs an `AFTER INSERT` Account trigger so Account and cursor state commit or roll back together;
5. revokes runtime cursor INSERT and DELETE while preserving scoped SELECT/UPDATE under RLS;
6. adds `public.markei_hosted_runtime_ready_v2()` for the exact 006+007 ledger contract;
7. changes new API readiness to v2 only, while retaining readiness-v1 for old-binary rollback;
8. retains the sanitized HTTP 503 `service-unavailable` / `not-applied` path when cursor state is still
   absent.

The trigger function was locally validated as migrator-owned, `SECURITY DEFINER`, fixed to
`pg_catalog, public`, fully qualified, non-dynamic and directly non-callable by PUBLIC/runtime.
Enrollment, re-enrollment, first Sync, Flutter and provider scripts do not acquire cursor-repair
responsibility.

### Validation reconciliation

The following claims are **validated locally** at `fe8976d8`:

- the dedicated migration-007 PostgreSQL producer passed 29/29 cases, including failing-first 006,
  fresh/upgrade, backfill/high-water, existing-row preservation, mixed Accounts, concurrency,
  rollback, trigger security, ACL/RLS, readiness and first protected submission;
- API format, lint, typecheck, build and 53/53 tests passed;
- hosted-local authorization passed 28 cases with zero pending;
- Flutter formatting, analysis and 178 tests passed with four lab-gated skips;
- opt-in disposable convergence passed 3/3 and recovery passed 1/1;
- Windows release and Android debug builds passed with only recorded upstream warnings;
- protected Python `unittest` regressions passed 5/5;
- production dependency audit passed with zero vulnerabilities after a bounded lockfile-only
  transitive `fast-uri` patch.

The following evidence remains qualified:

- `pytest` was host-unavailable because pytest was not installed; the protected `unittest` suite did
  run and pass;
- aggregate `r3_local_orchestrator` was not wholly green because the existing Flutter producer
  reported `query-replay-same-request-id:case-failed`, although direct Flutter, convergence and
  recovery suites passed;
- this contradiction does not invalidate the cursor-provisioning proofs, but it prevents Main from
  describing the complete aggregate recovery matrix as passed and must be resolved or explicitly
  bounded before provider mutation.

No Neon migration, Render deployment, Auth0 change, enrollment, real Sync, human database mutation or
unresolved-submission retry occurred. Therefore production Account provisioning, readiness-v2 and
protected Sync remain **provisional/provider-unvalidated**.

### PRC-01 disposition

```text
Claim: migration 007 and readiness-v2 exist
State: implemented
Evidence: repository inspection at fe8976d8

Claim: migration 007 enforces Account/cursor provisioning and repairs historical gaps
State: validated locally
Evidence: disposable PostgreSQL 29/29 producer and focused protocol/authorization proofs

Claim: complete aggregate local recovery matrix is green
State: contradicted / unresolved evidence composition
Evidence: aggregate Flutter producer query-replay-same-request-id case failed while direct suites passed

Claim: Neon contains migration 007 and the hosted Account has cursor state
State: not performed / provider-unvalidated

Claim: Render runs readiness-v2 code
State: not performed / provider-unvalidated

Claim: the preserved sync-unknown submission has a known terminal result
State: unresolved
```

No permanent-domain promotion is performed by this J append. G/H/I remain observational inputs for
the next Operational, Didactic and Design FLX-PRM-04 runs.

### Check route toward `sync-unknown` resolution

The next sequence is evidence-gated and must not collapse deployment readiness into Sync acceptance:

#### Gate 1 — close the aggregate local contradiction

1. Reproduce `query-replay-same-request-id:case-failed` through the aggregate producer.
2. Compare its inputs/environment with the directly passing convergence and recovery suites.
3. Correct an orchestration/fixture defect if present, or record why the aggregate case is outside the
   migration-007 claim boundary.
4. Require a green aggregate result or a new Main-accepted explicit evidence boundary before any
   provider mutation.

#### Gate 2 — provider migration authorization and preflight

1. Capture a fresh sanitized, read-only six-table baseline and migration-ledger/readiness-v1 state.
2. Confirm the preserved unknown submission identity and human local queue remain unchanged; do not
   transmit it.
3. Confirm exact migration-007 file identity/checksum and migrator/runtime role separation.
4. Authorize a single provider-migration window separately from deployment and Sync.

#### Gate 3 — apply 007 before deploying the new API

1. Apply migration 007 using the migrator identity in one transaction.
2. Verify the exact 006+007 ledger identities/checksums.
3. Verify readiness-v2 exists, is PUBLIC-denied and runtime-callable.
4. Verify the hosted Account has exactly one cursor row with the expected high-water-derived value.
5. Verify runtime cursor INSERT/DELETE and DDL remain denied while scoped SELECT/UPDATE remain allowed.
6. Stop on any mismatch; do not deploy or retry Sync.

Applying 007 first preserves rollback compatibility because the old API retains readiness-v1 support;
deploying the new API before 007 would intentionally make readiness-v2 fail closed.

#### Gate 4 — deploy and correlate the corrected API

1. Deploy commit `fe8976d8` or a reconciled descendant without provider-secret changes.
2. Correlate `/health/live` and `/health/ready` to one new deployment fingerprint.
3. Require live HTTP 200 and ready HTTP 200 backed by readiness-v2.
4. Capture a second sanitized six-table baseline; require no unexpected submissions, events,
   acknowledgements, Devices or cursor advancement.

#### Gate 5 — one exact-identity resolution attempt

Only after Gates 1–4 pass may Main authorize one retry of the preserved submission with the same
request identity and immutable event identities/content hashes.

Interpret the result conservatively:

- accepted or same-identity replay with matching server evidence: correlate response, submissions,
  events, acknowledgements and cursor advancement, then classify `sync-unknown` as resolved;
- HTTP 503 `not-applied`: do not repeat; investigate the provisioning/readiness invariant;
- identity/hash conflict: do not rewrite or retry under a new identity; reconcile local and server
  evidence;
- timeout, disconnect or missing trustworthy terminal response: the outcome remains unknown; capture
  the provider baseline before considering any further action;
- any unexpected count or cursor movement: stop and reconcile before another Sync operation.

`sync-unknown` is resolved only when the exact preserved request has a correlated terminal result and
the six-table provider state proves either one accepted/replayed application or a trustworthy
not-applied result. Deployment success, readiness-v2 HTTP 200 or cursor-row presence alone is not Sync
resolution.

### Current terminals

```text
C10_MCG02_ACCOUNT_CURSOR_PROVISIONING_REPAIR_MATERIALIZED_LOCAL_FE8976D8
C10_MCG02_CURSOR_STATE_INVARIANT_VALIDATED_LOCAL
R3_AGGREGATE_QUERY_REPLAY_EVIDENCE_UNRESOLVED
PROVIDER_MIGRATION_007_NOT_PERFORMED
RENDER_FE8976D8_NOT_DEPLOYED
SYNC_UNKNOWN_UNRESOLVED
REAL_SYNC_RETRY_UNAUTHORIZED
GCM02_OPEN
```


---

## Append-only reconciliation entry — 2026-07-23 — Gate 2 provider preflight blocked on target resolution

> Sequence: FLX-ORD-01 Main reconciliation after bounded read-only provider preflight
> Repository observation: `0c8b37a63c1003431474df0972b846d3c8531a1a`
> Inputs: Codex Gate 2 in-chat report; current published G/H/I; prior J Gate 1 reconciliation
> Status: **GATE 2 BLOCKED; REPOSITORY AND RENDER REVISION OBSERVED; NEON AND PRESERVED-REQUEST TARGETS UNRESOLVED**

### Accepted observations within their evidence boundaries

Main accepts the following current observations:

1. branch and remote HEAD were aligned at `0c8b37a63c1003431474df0972b846d3c8531a1a`;
2. `.gitignore` remained the only tracked dirty path and was preserved;
3. `documentation/SECRET_INPUTS.md` was proven ignored, untracked, absent from history, non-symlinked and was not disclosed;
4. repository migration 007 identity, checksum label, SHA-256, predecessor, readiness-v1/v2 names and trigger objects were observed from source;
5. authenticated Render inspection succeeded and showed a live deployment at abbreviated revision `5b364216`, predating the corrected readiness-v2 code;
6. no deployment was in progress;
7. the selected local Drift candidate was schema version 10 and contained no `unknown` pending event or submission;
8. Neon session validation failed before a read-only transaction or catalog observation;
9. Render health endpoints were unavailable from the Codex host and therefore produced no HTTP-status evidence;
10. no provider, repository, local queue or deployment mutation occurred.

### Evidence conflict and consequence

The prior notebook observation expected one preserved unresolved request. The currently selected local database instead reports:

- pending events: pending 6, failed 2, unknown 0;
- submissions: failed/notApplied 1, superseded/notApplied 2, unknown 0;
- local Accounts 2, Devices 3, sync events 8 and sync attempts 6.

This does not establish that the preserved request was resolved. It remains classified as one of:

- selected-local-database target mismatch;
- genuine local state change;
- representation/status transition not yet correlated;
- unresolved contradiction.

The current evidence cannot safely choose among them. The affected Account selector, exact request identity, immutable event identities/content hashes and expected sequence comparison are unavailable. The prior comparison evidence remains historical context but is insufficient to prove unchanged identity against the currently selected database.

Neon migration, readiness, six-table counts, role separation, ACL and RLS state are unavailable because the supplied Neon sessions failed before validated read-only access. Render metadata independently establishes only that the corrected revision is not deployed. Health success is not evidenced.

### PRC-01 disposition

```text
Claim: repository contains migration 007 and readiness-v2 contract
State: observed / source-validated

Claim: Render currently runs the corrected readiness-v2 revision
State: contradicted
Evidence: authenticated deployment metadata reports older revision 5b364216

Claim: Neon remains at exact migrations 001-006 with readiness-v1 only
State: unavailable
Evidence: session validation failed before catalog inspection

Claim: the preserved sync-unknown request remains unchanged in the inspected local store
State: contradicted / unresolved target
Evidence: selected schema-v10 database contains zero unknown rows

Claim: the preserved request has a known terminal result
State: unresolved

Claim: Gate 2 provider preflight is green
State: rejected / blocked
```

G/H/I on GitHub remain the earlier migration-007 local materialization reports. They contain useful local implementation, didactic and design evidence, but no Gate 2 provider-preflight staging was written during this round.

### Rescheduled GCM-02 route — remaining steps 4 through 14

The remaining closure route contains eleven evidence-gated steps:

4. **Resolve local target identity.** Keep Markei closed. Locate every bounded source-derived schema-v10 candidate and identify which database, if any, contains the historical request or a correlated terminal transition. Record candidate count, schema fingerprint, sanitized path class, status counts and last-change classification; do not retry.
5. **Resolve historical request continuity.** Compare the prior request/event fingerprints and expected Device sequence against the correct local store. If exact fingerprints were never preserved, record comparison unavailable and establish a new current baseline without retroactively claiming unchanged state.
6. **Repair Neon session access only.** Validate migrator and runtime connection parsing, intended development target, TLS/channel binding and distinct identities. Do not use owner access and do not apply SQL.
7. **Repeat Neon read-only preflight.** Capture ledger 001-007, readiness-v1/v2 catalog, six-table counts, cursor/high-water, ACL, RLS and runtime denial evidence inside read-only transactions. Save sanitized success/error messages and session/target fingerprints.
8. **Complete Render preflight evidence.** Capture deployment fingerprint plus direct `/health/live` and `/health/ready` HTTP statuses from an operator-reachable host. The old deployment may be live; ready semantics must be classified against the old readiness contract.
9. **Reconcile and authorize the migration window.** Main compares steps 4-8. Gate 3 is authorized only if provider target, migration 006 integrity and the request baseline are sufficiently resolved. Migration, deployment and Sync remain separate authorizations.
10. **Apply migration 007 once.** Use the migrator identity and the committed SQL file in one transactional run. Capture file SHA-256, ledger identity/checksum, transaction success/error text and provider-target fingerprint. Stop on any mismatch.
11. **Verify post-migration database state.** Read-only verify exact 006+007 ledger, readiness-v2 metadata/callability, one cursor row per Account, high-water-derived backfill, trigger ownership/security, runtime INSERT/DELETE/DDL denial and scoped SELECT/UPDATE allowance. Capture sanitized query outcomes.
12. **Deploy the reconciled corrected revision.** Deploy `0c8b37a` or a later explicitly reconciled descendant, without unrelated provider-secret changes. Capture full/abbreviated Git revision, Render deploy identifier fingerprint, start/finish timestamps and final status.
13. **Correlate health and provider immobility.** Require `/health/live = 200` and `/health/ready = 200` from the same deployment fingerprint, then capture a fresh six-table baseline showing no unexplained submission, event, acknowledgement, Device or cursor movement.
14. **Authorize and perform at most one exact-identity resolution attempt.** Only after steps 4-13 reconcile. Reuse the immutable request/event identities and hashes; capture HTTP result, sanitized response classification, request-correlation fingerprint, before/after six-table counts, cursor range and acknowledgement evidence. Conclude GCM-02 only if the request obtains a trustworthy correlated terminal result; otherwise stop with `sync-unknown` still open.

### Authorization boundary

Migration 007 may be prepared in the Neon SQL Editor, but it must not be executed merely because its text is visible there. The committed file identity and a green repeated preflight must precede execution.

A Render API token is not an application runtime dependency. It is required only for authenticated Render management/inspection automation. The current Codex round successfully read Render deployment metadata, proving that missing Render API access was not the blocker. Markei runtime requires its configured database and authentication variables, not a Render account API token.

Current terminals:

```text
GATE_2_PROVIDER_PREFLIGHT_BLOCKED
LOCAL_PRESERVED_REQUEST_TARGET_UNRESOLVED
NEON_READ_ONLY_SESSION_UNAVAILABLE
RENDER_CORRECTED_REVISION_NOT_DEPLOYED
MIGRATION_007_PROVIDER_APPLICATION_UNAUTHORIZED
REAL_SYNC_RETRY_UNAUTHORIZED
GCM02_OPEN
```


---

# Legacy_Progress

> Persistence rule: this section is append-only Main-stage continuity. Entries
> under `Legacy_Progress` must survive later J refresh, reconciliation,
> compaction, or structural mutation. Corrections are appended as new dated
> entries; prior entries are not removed or silently rewritten.

## 2026-07-23 — GRIMOIRE human-operationalisation inner sprint and Gate 02 closure

### Sprint identity

```text
Sequence: FLX-ORD-01 bounded human-supervised operational materialization
Cycle: 10
Phase: GCM-02 closure recovery
Gate: 02 — account cursor provisioning
Inner sprint: GRIMOIRE human-operationalisation check-up and build
Repository baseline: 837e9e18706b1eccb2bfafc0bf8980b69e1acf0a
Human authority: explicit
```

### Purpose and system mechanics

GRIMOIRE is the human-facing operational interface between project intent and
reviewed automation. It implements a hemi-automated chain:

```text
human selects a minimal indexed command
→ versioned PowerShell launcher validates local prerequisites and target role
→ committed mitigated-risk coordinates supply non-secret endpoint identity
→ password is entered only through a masked terminal prompt
→ Docker supplies the pinned PostgreSQL 18 client
→ libpq requires TLS and channel binding
→ SQL verifies database role and database identity
→ named SQL action or exact tracked migration is selected
→ mutation requires an explicit human confirmation boundary
→ sanitized evidence returns to the operator
→ Main/Operational reconciliation records meaning and next authority
```

The operational collection separates responsibilities:

- `GRIMOIRE.md` explains architecture, safety boundaries, workflow, failure
  classification, proven checkpoints, and ends with the active minimal-command
  index;
- `GENERAL_SCRIPTS.md` provides expanded operator commands and validation
  sequences;
- `models/NEON_CHECK.ps1` owns masked credentials, Docker `psql`, role/database
  preflight, TLS/channel-binding enforcement, action dispatch, exact migration
  path containment, Git tracking/cleanliness checks, SHA-256 display, and
  explicit mutation confirmation;
- `models/NEON_ACTION.sql` owns delimited, named, predominantly read-only SQL
  evidence blocks;
- root `NEON_ACTION.sql`, `NEON_CHECK.ps1`, and `NEON_CRED.md` preserve the
  user-uploaded operational originals;
- `NEON_CRED.md` is committed under an explicit mitigated-risk decision,
  stores only non-secret target coordinates and role names, and contains
  neither passwords nor complete connection URLs;
- `SECRET_INPUTS.md` remains the sole ignored private input surface.

Executable mechanics, reusable models, and minimal non-secret coordinates are
versioned. Secret inputs are not. Minimal commands are treated as stable
interfaces into reviewed verbose mechanics; when an action or variable name
changes, every reference must be reconciled in the same focused change.

### Failure-to-system learning

The sprint resolved four recurrent operator/tooling defects:

1. recycled download filenames produced stale script revisions, so development
   revisions use unique immutable names before promotion to the canonical
   repository filename;
2. `$PSScriptRoot` was unsafe in parameter defaults, so companion paths are
   resolved after script initialization;
3. server-side `pg_stat_ssl` behind Neon proxying was not authoritative for
   the client transport, so the launcher instead enforces
   `PGSSLMODE=require` and `PGCHANNELBINDING=require` and treats successful
   libpq authentication under those requirements as transport evidence;
4. textual Windows path-prefix comparison was separator-sensitive, so exact
   migration containment uses a parent-directory walk before Git tracked/clean
   checks.

### Gate 02 applied and validated evidence

Migration `007_account_cursor_provisioning.sql` was applied once with:

```text
role: markei_migrator
database: markei_sync_dev
client TLS/channel binding: required
file SHA-256: 89AB11302F8B860C52AA1C74FBFEDF6A4DB3A0EE62FE7CB715B20B74AEF99AC6
confirmation: APPLY-ONCE
transaction terminal: COMMIT
```

Postflight returned:

```text
migration_id: 007_account_cursor_provisioning
checksum: c10-mcg02-account-cursor-provisioning-v1
readiness_v2: true
provisioning function: present
provisioning trigger count: 1
account count: 1
cursor-state count: 1
accounts missing cursor state: 0
orphan cursor-state rows: 0
runtime SELECT: true
runtime INSERT: false
runtime DELETE: false
runtime next_cursor UPDATE: true
runtime readiness-v2 EXECUTE: true
runtime provisioning EXECUTE: false
inspection terminal: ROLLBACK
action terminal: PASS
```

The false privilege values are intended least-privilege boundaries and are not
caused by absent Flutter activity. Migration 007 must not be reapplied.

### Resulting state and next authority

```text
GRIMOIRE_BASELINE_ESTABLISHED
MIGRATION_007_APPLIED_ONCE
GATE_02_POSTFLIGHT_PASS
ACCOUNT_CURSOR_INVARIANT_PASS
RUNTIME_PRIVILEGE_SHAPE_PASS_BY_MIGRATOR_INSPECTION
GATE_02_CLOSED
RUNTIME_ROLE_DIRECT_READINESS_CHECK_NEXT
RENDER_CORRECTED_REVISION_NOT_YET_RECONCILED
REAL_SYNC_RETRY_UNAUTHORIZED
GCM02_OPEN
```

The next bounded operation is a direct runtime-role connection and
`markei_hosted_runtime_ready_v2()` call. After that passes, reconcile GitHub
HEAD and Render deployment revision, deploy only an explicitly authorized
reconciled revision, and require live/ready HTTP 200 evidence before any
controlled Sync attempt.

## 2026-07-23 — Canonical five-file reconciliation and branch remodelling

### Sprint identity

```text
Sequence: FLX-PRN-03 pruning + FLX-PRM-04 reconciliation
Cycle: 10
Phase: post-migration-007 GRIMOIRE consolidation
Source branch: intermid-cycle-recovery
Source HEAD: c76734e32f70702978f5c7a543c1f0ef3c63c521
Target branch: cycle10-intermid-grimoire
Human authority: explicit
Write scope: GRIMOIRE five-file set, obsolete duplicates, and this append
```

### Reconciliation result

The five latest uploaded files were compared with the `c76734e` tree. The
uploads were useful source evidence but were not accepted blindly as the final
tree: the existing repository documentation contained later Gate 02 closure
knowledge, while the former `models/` layer contained the launcher and SQL
corrections that had been operationally proven.

The live repository interface is now one commutatively maintained set:

```text
documentation/GRIMOIRE.md
documentation/GENERAL_SCRIPTS.md
documentation/NEON_CHECK.ps1
documentation/NEON_ACTION.sql
documentation/NEON_CRED.md
```

`NEON_ACTION.sql` is the canonical filename. The occasional plural
`NEON_ACTIONS.sql` and the uploaded numbered filenames are treated as naming
noise, not additional repository interfaces.

### Explicit tuning and pruning

- `GRIMOIRE.md` now defines the root five-file set as canonical, preserves the
  proven Gate 02 closure, keeps `GRIMOIRE_INDEX` as its final subsection, and
  points every launcher command to `documentation/NEON_CHECK.ps1`.
- `GENERAL_SCRIPTS.md` now uses the same root paths, identifies
  `cycle10-intermid-grimoire` as its Git-alignment branch, and retains migration
  007 as historical/do-not-rerun evidence.
- `NEON_CHECK.ps1` is the Windows-proven v8 launcher promoted from the former
  model layer. Its SHA-256 remains
  `c4c050e3c83ba17e3ca509bd97f7d8cb7f6fdc301db02f0a3c72e6f1d98f6818`.
- `NEON_ACTION.sql` is the aligned read-only catalogue promoted from the former
  model layer. Its connection action reports role, database, and read-only
  transaction state; transport assurance remains owned by the launcher's
  enforced libpq TLS and channel-binding settings rather than proxy-sensitive
  server-side TLS columns.
- `NEON_CRED.md` retains the latest uploaded minimal non-secret coordinates and
  role-name interface. Passwords, tokens, private keys, and complete connection
  URLs remain prohibited.
- `documentation/models/NEON_CHECK.ps1`,
  `documentation/models/NEON_ACTION.sql`, and
  `documentation/models/NEON_CRED.md` were removed after promotion because a
  second live layer would duplicate semantic and executable ownership.
- `documentation/legacy/GENERAL_SCRIPTS.md` was removed because Git already
  preserves its history and a stale copy would remain discoverable as a false
  operational route. `documentation/legacy/PT_INTRO.md` was retained because it
  is unrelated to the Neon/GRIMOIRE reconciliation.
- `documentation/SECRET_INPUTS.md` remains ignored and untracked as the sole
  private input surface.

### PRC-01 claims

```text
Claim: c76734e is the exact source coordinate for this remodelling
Prior state: requested / remotely verified
Evidence: GitHub comparison reports intermid-cycle-recovery identical to c76734e
Semantic owner: Git history
Resulting state: accepted

Claim: the models folder is still required for current operation
Prior state: accepted by the earlier 2026-07-23 Legacy_Progress entry
Evidence: latest uploaded v8 launcher equals the proven model launcher; the
          corrected model SQL can be promoted without losing behavior
Contradiction: duplicate root/model paths create two competing live interfaces
Semantic owner: GRIMOIRE operational documentation
Resulting state: superseded; models pruned after promotion
History disposition: earlier entry retained unchanged; this entry corrects it

Claim: migration 007 should be applied during this sprint
Prior state: already applied once and postflight-validated
Evidence boundary: documentation and static reconciliation only
Resulting state: rejected; do not rerun migration 007

Claim: creating cycle10-intermid-grimoire authorizes Render reconfiguration
Prior state: not authorized
Evidence: branch work is documentation/Git reconciliation
Resulting state: still not authorized
```

### Expected next sequence before resuming the former steps 4–14

The earlier eleven-step route is not replayed literally because migration 007
and Gate 02 have since completed. Resume through these seven bounded steps:

1. pull and inspect `cycle10-intermid-grimoire` locally; verify clean `0 0`
   divergence and review this five-file/J reconciliation;
2. run the direct runtime-role connection and
   `markei_hosted_runtime_ready_v2()` read-only proof;
3. reconcile the intended application revision against the current Render
   deployment fingerprint;
4. decide explicitly whether the new branch remains documentation-only or
   becomes the branch Render follows; branch creation alone changes no Render
   setting;
5. deploy exactly one authorized reconciled application revision and capture
   its full Git SHA plus Render deployment fingerprint;
6. require `/health/live = 200`, `/health/ready = 200`, and a fresh provider
   immobility baseline;
7. only then authorize at most one exact-identity Sync resolution attempt and
   reconcile its correlated terminal evidence.

Current terminals:

```text
GRIMOIRE_CANONICAL_FIVE_FILE_SET_RECONCILED
MODELS_LAYER_SUPERSEDED_AND_PRUNED
MIGRATION_007_DO_NOT_RERUN
GATE_02_REMAINS_CLOSED
RUNTIME_ROLE_DIRECT_READINESS_CHECK_NEXT
RENDER_BRANCH_CHANGE_NOT_AUTHORIZED
REAL_SYNC_RETRY_UNAUTHORIZED
GCM02_OPEN
```

## 2026-07-23 — Hosted pre-Sync gate closure and controlled-Sync planning boundary

### Sequence identity

```text
Sequence: post-Gate-02 hosted deployment verification
Cycle: 10
Phase: GCM-02 closure recovery
Active branch: cycle10-intermid-grimoire
Authorized revision: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Previous observed Render revision: 5b36421
Provider database: markei_sync_dev
Evidence date: 2026-07-23
Human authority: explicit
Mutation boundary: one Render deployment; no Sync request
```

### Purpose

This sequence verified that the reconciled Cycle 10 branch could become the active Render branch, that its intended revision could be deployed exactly once, and that the hosted service could satisfy its live and ready contracts without changing the inspected Neon coordination state.

The sequence also completed the direct runtime-role readiness-v2 proof that remained pending after migration 007.

No controlled Sync request was performed. Migration 007 was not reapplied. No Neon schema, role, Auth0, hosted identity, or Render environment-variable change was performed during this gate.

### 1. Local Git alignment — PASS

The Windows checkout was clean and exactly aligned with the remote branch before deployment:

```text
Repository: gus-i-gu/markei
Branch: cycle10-intermid-grimoire
Local HEAD: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Remote HEAD: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Local/remote divergence: 0 / 0
Working tree: clean
```

This established an unambiguous application revision for the hosted gate.

### 2. Direct runtime-role readiness-v2 proof — PASS

A direct read-only connection was opened using the restricted runtime role.

Observed evidence:

```text
Role: markei_runtime
Database: markei_sync_dev
TLS: active
Protocol: TLS 1.3
Cipher: TLS_AES_256_GCM_SHA384
Readiness function: public.markei_hosted_runtime_ready_v2()
Readiness result: true
Transaction: read only
Terminal: ROLLBACK
```

The proof establishes that the runtime identity could reach the intended development database and execute the readiness-v2 contract.

It does not by itself prove application Sync, token validity, device identity resolution, or event convergence.

### 3. Pre-deployment provider baseline — PASS

A sanitized aggregate baseline was captured through the migrator inspection role inside a read-only transaction.

| Measure                               | Before deployment |
| ------------------------------------- | ----------------: |
| Accounts                              |                 1 |
| Devices                               |                 1 |
| Account cursor states                 |                 1 |
| Submissions                           |                 0 |
| Sync events                           |                 0 |
| Device acknowledgements               |                 0 |
| Sum of next cursors                   |                 1 |
| Sum of device next-expected sequences |                 1 |

The transaction ended with `ROLLBACK`.

The evidence contains no account ID, device ID, credential, token, connection string, event payload, or submission content.

The state is consistent with one previously provisioned account/device fixture and no submitted or synchronized application event.

### 4. Render revision comparison — PASS

The previous observed Render deployment was:

```text
Revision: 5b36421
Description: Implement transport observability diagnostics
Started: 2026-07-21 21:15 local dashboard time
Live: 2026-07-21 21:16 local dashboard time
Trigger: manual dashboard deployment
```

The intended revision for the new gate was:

```text
baaa3231c0b8f9b1af2c2aff80255e883309ca74
```

The intended revision differed from the previously hosted revision and belonged to the reconciled `cycle10-intermid-grimoire` branch.

The newest commit primarily reconciled documentation and GRIMOIRE structure while inheriting the hosted application implementation from its ancestry. Deploying the exact revision nevertheless established one reproducible Git fingerprint for subsequent evidence.

### 5. Render branch establishment — PASS

The Render development service was configured to follow:

```text
Repository: gus-i-gu/markei
Branch: cycle10-intermid-grimoire
Service type: Node web service
Instance class: free development instance
Auto-deploy during gate: off
```

No Render environment variable, secret, build command, start command, Neon coordinate, or Auth0 setting was changed during branch establishment.

### 6. Single authorized deployment — PASS

Exactly one deployment of the authorized revision was observed for this gate:

```text
Revision: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Short revision: baaa323
Description: Reconcile Cycle 10 GRIMOIRE interface
Trigger: manual dashboard deployment
Started: 2026-07-23 20:18 local dashboard time
Final state: live
Unexpected second deployment: none observed
```

Build and startup evidence:

```text
Node.js: 24.14.1
Build command: npm ci --include=dev && npm run build
Packages installed: 208
Packages audited by npm install: 209
TypeScript compilation: PASS
Build upload: PASS
Runtime command: npm start
Hosted entry point: node dist/src/hosted.js
Startup marker: MARKEI_HOSTED_SYNC_READY
Render terminal: live
```

The service became publicly available after successful compilation, artifact upload, startup, and readiness probing.

Render’s initial platform probes included undefined-root `HEAD /` and `GET /` requests returning 404. These were unclassified root-route requests and did not contradict the designated health contracts.

### 7. Hosted HTTP health verification — PASS

The deployed service was queried through its public development origin.

| Endpoint        | Status | Sanitized response   |
| --------------- | -----: | -------------------- |
| `/health/live`  |    200 | `{"status":"live"}`  |
| `/health/ready` |    200 | `{"status":"ready"}` |

Render logs independently recorded `/health/ready` requests with:

```text
Route class: /health/ready
Operation: health-ready
Method: GET
Status: 200
Elapsed band: below 250 ms
```

The application logs used short correlation fingerprints and did not expose raw credentials or identity material.

### 8. Post-deployment provider immobility — PASS

After deployment and public health verification, the exact pre-deployment aggregate inspection was repeated through the migrator role in a read-only transaction.

Observed post-deployment state:

| Measure                               | Before | After | Difference |
| ------------------------------------- | -----: | ----: | ---------: |
| Accounts                              |      1 |     1 |          0 |
| Devices                               |      1 |     1 |          0 |
| Account cursor states                 |      1 |     1 |          0 |
| Submissions                           |      0 |     0 |          0 |
| Sync events                           |      0 |     0 |          0 |
| Device acknowledgements               |      0 |     0 |          0 |
| Sum of next cursors                   |      1 |     1 |          0 |
| Sum of device next-expected sequences |      1 |     1 |          0 |

Connection and transaction evidence:

```text
Role: markei_migrator
Database: markei_sync_dev
TLS: active
Protocol: TLS 1.3
Transaction: read only
Terminal: ROLLBACK
```

All eight values exactly matched the pre-deployment baseline.

Within the inspected coordination boundary, branch retargeting, deployment, startup, Render readiness probes, and explicit public health requests produced no observable provider mutation.

This evidence does not claim that no unobserved provider metric changed. It proves immobility only for the eight inspected database aggregates.

### 9. Deployment singularity — PASS

The Render event history showed one deployment of `baaa323` during this gate:

```text
Watched branch: cycle10-intermid-grimoire
Authorized revision: baaa3231c0b8f9b1af2c2aff80255e883309ca74
Deployment count for this gate: 1
Final state: live
Unexpected later deployment: no
```

The earlier `5b36421` deployment belongs to the preceding 2026-07-21 observability round and is not a duplicate deployment of the present revision.

### 10. Hosted pre-Sync gate conclusion — PASS

```text
LOCAL_GIT_ALIGNMENT_PASS
RUNTIME_ROLE_DIRECT_READINESS_V2_PASS
PRE_DEPLOYMENT_PROVIDER_BASELINE_CAPTURED
RENDER_REVISION_COMPARISON_PASS
RENDER_WATCHED_BRANCH_ESTABLISHED
SINGLE_AUTHORIZED_DEPLOYMENT_PASS
HOSTED_LIVENESS_HTTP_200
HOSTED_READINESS_HTTP_200
POST_DEPLOYMENT_PROVIDER_IMMOBILITY_PASS
HOSTED_PRE_SYNC_GATE_CLOSED
```

Preserved constraints:

```text
Migration 007 reapplied: NO
Sync request performed: NO
Application event intentionally submitted: NO
Neon schema edited: NO
Neon roles edited: NO
Auth0 configuration edited: NO
Render environment variables edited: NO
Provider aggregate difference: NONE
Controlled Sync authorization: PENDING SEPARATE REVIEW
```

### 11. Dependency-audit observation — OPEN / NOT YET DIAGNOSED

Render’s dependency installation reported:

```text
One high-severity vulnerability
```

This is an npm install-time advisory observation. It did not prevent compilation or deployment, but it must not be classified as a clean dependency-security result.

The first local follow-up command was executed from the repository root:

```text
npm audit
```

That directory has no npm lockfile. npm therefore returned:

```text
Code: ENOLOCK
Meaning: audit requires an existing lockfile
```

The generated `npm-audit-cycle10.json` contains only the `ENOLOCK` error. It is not a vulnerability report and provides no affected package, installed version, dependency path, exploitability, or remediation range.

Repository inspection locates the actual Node package and lockfile at:

```text
services/markei_sync_api/package.json
services/markei_sync_api/package-lock.json
```

Current classification:

```text
Render npm advisory observation: OPEN
Local vulnerability diagnosis: NOT YET PERFORMED
Local audit failure cause: WRONG WORKING DIRECTORY / LOCKFILE ABSENT THERE
Dependency remediation authorized: NO
npm audit fix authorized: NO
npm audit fix --force authorized: NO
```

The root-level JSON artifact should remain outside the repository. A corrected read-only audit must be run from `services/markei_sync_api` before selecting any dependency change.

The dependency observation is tracked separately from the hosted pre-Sync gate because it did not invalidate Git alignment, runtime readiness, deployment identity, health behavior, or provider immobility. Its actual runtime relevance remains unknown until the corrected audit is interpreted.

### Dependency-audit remediation — PASS

The hosted installation had reported one high-severity advisory affecting `find-my-way <=9.6.0`.

Dependency inspection established:

```text
Dependency: find-my-way
Installed before remediation: 9.6.0
Dependency type: transitive production dependency
Introduced by: fastify 5.10.0
Dependency path: @markei/sync-api → fastify → find-my-way
Advisory: GHSA-c96f-x56v-gq3h
Advisory class: HTTP/2 denial of service
Evidence of rogue installation or repository intrusion: NONE

find-my-way: 9.6.0 → 9.7.0
package.json changed: NO
Force or major-version remediation used: NO

npm ls find-my-way: 9.7.0
npm audit: 0 vulnerabilities
format:check: PASS
lint: PASS
typecheck: PASS
tests: 53 passed, 0 failed
build: PASS
```

### PRC-01 classification

```text
Claim: direct runtime readiness-v2 is available
Source: runtime-role read-only provider inspection
Current state: validated
Evidence: markei_hosted_runtime_ready_v2() returned true
Evidence boundary: markei_runtime against markei_sync_dev
Does not prove: authenticated Sync or event convergence
Semantic owner: Operational
Result: accepted within the named boundary

Claim: baaa323 was successfully hosted
Source: Render deployment event and runtime logs
Current state: validated
Evidence: build pass, startup marker, live terminal
Evidence boundary: Render development/free service
Does not prove: production acceptance
Semantic owner: Operational
Result: accepted within the development-host boundary

Claim: the hosted service was live and ready
Source: explicit HTTP requests and Render readiness logs
Current state: validated
Evidence: /health/live 200 and /health/ready 200
Does not prove: Sync success
Semantic owner: Operational
Result: accepted

Claim: the deployment mutated no inspected coordination state
Source: matched pre/post read-only aggregate inspections
Current state: validated
Evidence: all eight inspected values unchanged
Evidence boundary: named Neon tables and aggregate fields
Does not prove: universal provider immobility outside inspected measures
Semantic owner: Operational
Result: accepted within the inspected boundary

Claim: exactly one baaa323 deployment occurred during this gate
Source: Render event history
Current state: validated
Evidence: one manually triggered baaa323 deployment; earlier 5b36421 event belongs to a different round
Semantic owner: Operational
Result: accepted

Claim: the Node dependency tree contains a confirmed exploitable high-severity vulnerability
Source: Render npm install warning
Current state: candidate / unresolved
Evidence: aggregate advisory count only
Contradiction: local npm audit did not run against a lockfile
Semantic owner: Operational dependency evidence
Result: remain open pending corrected package-root audit

Claim: the ENOLOCK JSON is a dependency vulnerability report
Source: root-level local npm audit attempt
Current state: contradicted
Evidence: JSON contains only the ENOLOCK error
Result: rejected; do not preserve it as audit evidence

Claim: one controlled Sync request is now authorized
Source: hosted pre-Sync gate result
Current state: proposed
Evidence: prerequisite deployment and immobility gate passed
Missing evidence: exact identity, token, sequence, endpoint, expected mutation, and containment plan
Result: not yet authorized
```

Claim: the reported dependency vulnerability was safely remediated
Source: dependency explanation, lockfile resolution, npm audit, and API validation
State: validated
Evidence boundary: services/markei_sync_api dependency tree
Result: accepted

Claim: find-my-way represented an unauthorized or rogue dependency
State: contradicted
Evidence: normal Fastify dependency path recorded by npm
Result: rejected

### 12. Controlled exact-identity Sync attempt — PLANNING STARTED / EXECUTION HELD

The next sequence is a single bounded authenticated Sync experiment. Passing the hosted pre-Sync gate makes planning appropriate but does not automatically authorize execution.

Planning must resolve five evidence groups before a request is sent.

#### 12.1 Identity binding

Establish, without recording raw secrets:

```text
Auth0 issuer expected by the hosted API
Auth0 audience expected by the hosted API
Token subject fingerprint or sanitized comparison method
Token expiry and not-before validity
Fixture account mapped to the authenticated subject
Fixture device enrolled under that same account
Device active/revoked state
```

A raw access token, client secret, password, complete connection string, account UUID, or device UUID must not be copied into J.

#### 12.2 Request contract

Resolve from the committed implementation:

```text
Exact public endpoint
HTTP method
Required authorization header shape
Required request body schema
Operation name/version
Supported event type
Idempotency or submission identifier requirements
Expected success status and response schema
```

The procedure must be derived from the deployed `baaa323` source contract rather than reconstructed from memory.

#### 12.3 Sequence and cursor preconditions

Capture a sanitized read-only baseline immediately before the request:

```text
Account next cursor
Device next expected sequence
Submission count
Sync-event count
Acknowledgement count
Device enrollment state
Account/device relationship valid
```

The current aggregate baseline indicates cursor `1` and device sequence `1`, but exact-identity readiness must be checked at execution time.

#### 12.4 Expected single transition

Before authorization, specify exactly which values may change after one valid request.

The expected transition must identify:

```text
Expected submission count delta
Expected sync-event count delta
Expected acknowledgement behavior
Expected account-cursor delta
Expected device-sequence delta
Expected HTTP response
Expected correlated terminal log events
Expected local application effect, if any
```

Any mutation outside that allowlist is a stop condition.

#### 12.5 Containment and stop rules

The first request is limited to one attempt.

Do not automatically retry on:

```text
401 or 403 identity rejection
409 sequence or replay conflict
unexpected 4xx response
5xx response
timeout with uncertain provider outcome
missing terminal correlation
unexpected provider-state delta
```

A timeout or lost response does not prove that the provider remained unchanged. Inspect correlated logs and provider state before deciding whether the request was accepted.

No cleanup, deletion, sequence correction, fixture recreation, second submission, credential rotation, or migration is authorized merely because the attempt fails.

#### 12.6 Planned evidence order

```text
1. Complete corrected read-only npm audit diagnosis.
2. Inspect the deployed Sync route and authentication contract.
3. Verify sanitized Auth0 issuer/audience and token claim compatibility.
4. Verify exact fixture account/device binding read-only.
5. Capture exact pre-attempt provider baseline.
6. Define the one allowed state transition.
7. Review the assembled evidence and authorize or reject one request.
8. If authorized, send exactly one controlled request.
9. Capture HTTP result and correlated hosted logs.
10. Capture exact post-attempt provider state.
11. Compare expected and observed transitions.
12. Reconcile GCM-02 closure state and determine Cycle 11 readiness.
```

Current terminals:

```text
HOSTED_PRE_SYNC_GATE_PASS
RENDER_ACTIVE_BRANCH_CYCLE10_INTERMID_GRIMOIRE
RENDER_REVISION_BAAA323_LIVE
PROVIDER_IMMOBILITY_PASS
DEPENDENCY_AUDIT_DIAGNOSIS_OPEN
CONTROLLED_SYNC_PLAN_INCOMPLETE
CONTROLLED_SYNC_REQUEST_UNAUTHORIZED
MIGRATION_007_DO_NOT_RERUN
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-23 — Neo-Grimoire indexed coordinate-system redesign

### Sprint identity

```text
Sequence: FLX-ORD-01 direct human-authorized documentation materialization
Cycle: 10
Phase: GCM-02 closure support / Step 12 preparation
Branch: cycle10-intermid-grimoire
Baseline HEAD: 1106dbea6a6d6b309d306d2f5a7911240b84bc2e
Immediate parent: f1851ca
Baseline commit: Neo-Grimoire system for Human Supervised Execution1.3
Human authority: explicit
Materialization scope: canonical GRIMOIRE five-file interface
Evidence boundary: isolated local checkout and static structural validation
Provider mutation authority: none
Persistence status: human replacement, diff review, commit, and push pending
```

The baseline ambiguity is resolved as follows:

```text
1106dbea6a6d6b309d306d2f5a7911240b84bc2e
    current branch HEAD / Execution1.3

f1851ca
    immediate parent / Execution1.2
```

### Objective

The sprint restructures the existing human-supervised execution system without
adding unrelated provider operations.

The intended active interface remains five files:

```text
documentation/GRIMOIRE.md
documentation/GENERAL_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/NEON_CHECK.ps1
documentation/NEON_ACTION.sql
```

The responsibilities are now separated as:

```text
GRIMOIRE.md
    human-facing architecture, safety rules, usage model, and concise index

GENERAL_SCRIPTS.md
    canonical expanded commands, queries, validation procedures, and evidence
    expectations

NS_COORDINATES.md
    repository-safe non-secret coordinates, lifecycle classifications, and
    verification sources

NEON_CHECK.ps1
    Windows launcher, coordinate parser, role/action dispatcher, secure runtime
    input, target guards, and Docker psql execution

NEON_ACTION.sql
    SQL-only indexed read-only action catalogue
```

### Naming reconciliation

Commit `1106dbe` had already renamed:

```text
documentation/NEON_CRED.md
→ documentation/NS_COORDINATES.md
```

The rename-only state left active GRIMOIRE commands and the launcher capable of
referring to the superseded filename. The present materialization reconciles the
live interface:

- `NEON_CHECK.ps1` now defaults to `NS_COORDINATES.md`;
- active GRIMOIRE and GENERAL_SCRIPTS command bodies pass
  `-ConfigPath ".\documentation\NS_COORDINATES.md"`;
- hosted and Git procedures load public values from `NS_COORDINATES.md`;
- no active execution route requires `documentation/NEON_CRED.md`;
- `NEON_ACTION.sql` remains the canonical singular filename.

Historical references to `NEON_CRED.md` remain valid observational evidence in
earlier J entries, Git history, and the migration explanation inside the active
documentation. They are not stale executable paths and must not be erased merely
to make a global text search return zero results.

### Materialized system

#### GRIMOIRE

`GRIMOIRE.md` now defines:

- the canonical five-file architecture;
- the coordinate and secret boundaries;
- the runtime-input model;
- Neon launcher and role behavior;
- SQL action architecture;
- migration and do-not-rerun boundaries;
- Gate 02’s proven checkpoint;
- failure classifications;
- interface-maintenance rules;
- the stable `GRIMOIRE_INDEX` landline.

The final index contains 16 `GRM-*` blocks. Every active block contains:

```text
GRM identifier and functionality name
01 — canonical command/query and hosting path
Copy-paste-ready body
What this does
Variables required
Expected output or result
```

Only the fenced copy-paste body is machine input. Its stable non-secret values
are loaded from `NS_COORDINATES.md`; manually supplied values are restricted to
runtime role selection, masked passwords, locally entered UUIDs, or an explicit
authorization phrase where the canonical procedure requires one.

#### GENERAL_SCRIPTS

`GENERAL_SCRIPTS.md` now contains 18 canonical `GS-*` procedures.

The active GRIMOIRE blocks map to 16 corresponding procedures. Two additional
procedures remain historical or deliberately non-indexed:

```text
GS-NEON-H01
GS-MIG-H01
```

The historical migration procedure preserves auditability but does not restore
migration 007 to the active GRIMOIRE index.

The Git, Render-health, Auth0-metadata, Windows-build, and Android-build
procedures fetch their public coordinates from `NS_COORDINATES.md` and reject
required placeholders instead of silently inventing values.

#### NS_COORDINATES

`NS_COORDINATES.md` is explicitly a coordinate allowlist, not a credential
store.

It now contains 60 unique machine-readable coordinate keys covering:

```text
repository and source
Render development service
Auth0 public development configuration
Neon development target
Markei hosted API contract
provider migration state
```

All 11 keys from the former `NEON_CRED.md` were retained by name and without
semantic loss:

```text
Environment
ProjectAlias
BranchAlias
Region
PostgreSQLVersion
Host
Port
Database
RuntimeUser
MigratorUser
DbOwnerUser
```

The file also records:

- where each coordinate must be verified;
- whether it is stable, mutable, rotatable, or ephemeral;
- which values remain optional until a procedure consumes them;
- which values must never be committed;
- when the coordinate set was last reviewed.

No password, token, client secret, API key, private key, complete connection
string, identity-bound UUID, authorization header, cookie, or raw environment
dump was migrated into the file.

The direct Neon hostname, database name, and role names remain non-secret.
Together they expose development topology, so they are retained under the
existing mitigated-risk decision and should not be redistributed
unnecessarily.

#### NEON_ACTION

`NEON_ACTION.sql` now contains eight indexed `NA-*` action blocks:

```text
NA-01  connection
NA-02  gate02-preflight
NA-03  gate02-postflight
NA-04  migration-ledger
NA-05  runtime-privileges
NA-06  schema-inventory
NA-07  list-devices-sanitized
NA-08  verify-device
```

The file remains SQL-only. Explanations are SQL comments, while extraction
continues to use the exact parser contract:

```sql
-- ACTION: action-name
...
-- END ACTION
```

Routine actions remain read-only and terminate through `ROLLBACK`.

#### NEON_CHECK

`NEON_CHECK.ps1` now:

- resolves `NS_COORDINATES.md` by default;
- loads the required Neon and migration coordinates dynamically;
- rejects unresolved required placeholders;
- remains locked to the development environment;
- requires the direct Neon hostname;
- requires PostgreSQL 18;
- requires TLS and channel binding;
- separates runtime, migrator, and database-owner roles;
- prompts for passwords through masked terminal input;
- requests a device UUID only for the exact action that requires it;
- forwards non-secret action variables through `psql`;
- preserves the tracked, clean, repository-contained migration guard;
- preserves the exact `APPLY-ONCE` mutation confirmation;
- clears PostgreSQL environment variables and temporary plaintext password
  material in `finally`.

Migration 007 remains applied-once historical evidence. This update does not
authorize or perform its reapplication.

### Validation record

Static validation returned:

```text
GRIMOIRE blocks:                         16
Canonical GENERAL_SCRIPTS procedures:   18
NEON_ACTION indexed actions:              8
NS_COORDINATES unique keys:              60
Original coordinate keys retained:     11/11
Active GRM → GS cross-references:        PASS
Executable bodies with placeholders:       0
Active stale executable NEON_CRED paths:   0
Canonical NS_COORDINATES default:        PASS
Secret-pattern scan:                     PASS
SQL action parsing:                    8/8 PASS
git diff --check:                        PASS
```

All eight SQL action bodies parsed as PostgreSQL after substituting the
non-secret `psql` variables supplied by the launcher.

The validation boundary is static and structural. The Linux materialization
environment did not repeat:

- Windows PowerShell execution;
- Docker Desktop execution;
- Neon connections or queries;
- Render requests or configuration;
- Auth0 requests or token acquisition;
- Windows or Android builds;
- a Sync submission.

No provider state, deployment, credential, migration, or application source was
changed by this documentation sprint.

### PRC-01 classification

```text
Claim: the redesigned five-file GRIMOIRE interface exists
Source: local repository diff against 1106dbea
Current state: implemented and statically validated
Evidence: five modified active-interface files, index counts, cross-reference
          checks, parser checks, and git diff --check
Evidence boundary: isolated local checkout
Semantic owner: operational execution documentation
Target role: active human-supervised execution interface
History disposition: prior Execution1.3 state retained in Git and J
Result: accepted as a materialization candidate pending human diff review and
        Git persistence
```

```text
Claim: NEON_CRED.md remains the active coordinate filename
Source: pre-reconciliation live references
Current state: contradicted
Evidence: canonical file is NS_COORDINATES.md; launcher default and active
          command bodies now use NS_COORDINATES.md
Semantic owner: canonical five-file interface
History disposition: historical NEON_CRED.md references preserved as evidence
Result: rejected as a live path; retained only as historical naming
```

```text
Claim: the coordinate file contains authentication secrets
Source: inspected NS_COORDINATES content and scoped secret-pattern scan
Current state: contradicted within the inspected five-file boundary
Evidence: only non-secret coordinates, identifiers, route names, public
          metadata, role names, and migration identifiers were found
Evidence boundary: inspected repository files; no claim about external secret
                   stores
Semantic owner: coordinate safety contract
Result: rejected
```

```text
Claim: every GRIMOIRE procedure is runtime-validated on Windows and providers
Source: static materialization validation
Current state: host-unvalidated for this sprint
Evidence: structural and parser validation passed; Windows/provider execution
          was not repeated
Semantic owner: operational runtime evidence
Result: remain host-unvalidated until the applicable procedures are executed in
        the intended Windows/provider environment
```

```text
Claim: this redesign authorizes migration, deployment, credential changes, or
       one controlled Sync request
Source: documentation materialization
Current state: contradicted
Evidence: no provider action was included in the authorized scope
Result: rejected; existing provider and Step 12 stop boundaries remain active
```

### Continuation boundary

The immediate continuation is:

1. replace the five local files with the reviewed candidate versions;
2. append this record to J;
3. run the naming and diff integrity guard;
4. inspect the complete six-file diff;
5. persist the batch only after human acceptance;
6. collect and independently verify the remaining non-secret coordinates;
7. fill `NS_COORDINATES.md` without adding secrets;
8. resume Cycle 10 GCM-02 closure and Step 12 from the read-only preparation
   boundary.

Step 12’s authenticated Sync mutation remains held. No request is authorized
until identity, token flow, exact device/account binding, canonical request
generation, expected state transition, and stop conditions are fully resolved.

Current terminals:

```text
NEO_GRIMOIRE_FIVE_FILE_REDESIGN_IMPLEMENTED_LOCALLY
ACTIVE_COORDINATE_FILENAME_NS_COORDINATES
STALE_LIVE_NEON_CRED_EXECUTION_PATHS_REMOVED
HISTORICAL_NEON_CRED_REFERENCES_PRESERVED
ORIGINAL_COORDINATE_KEYS_RETAINED_11_OF_11
STATIC_INTERFACE_VALIDATION_PASS
WINDOWS_AND_PROVIDER_RUNTIME_NOT_REEXECUTED
HUMAN_DIFF_REVIEW_AND_GIT_PERSISTENCE_PENDING
NS_COORDINATE_COLLECTION_NEXT
MIGRATION_007_DO_NOT_RERUN
CONTROLLED_SYNC_REQUEST_UNAUTHORIZED
GCM02_OPEN
```