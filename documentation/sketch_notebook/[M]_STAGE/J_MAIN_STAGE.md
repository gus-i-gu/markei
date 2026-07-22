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
