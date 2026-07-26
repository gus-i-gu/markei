# J_MAIN_STAGE — Cycle 10 active reconciliation

> Sequence: FLX-PRN-03 recovery-economy pruning after FLX-PRM-04 reconciliation
> Role: Main Chat
> Branch: `cycle10-intermid-grimoire`
> Pruning baseline: `7a59bc8b2db4016bd42ca89df0cf2286cd64b755`
> Authority: human-directed J pruning and current-state rearrangement
> Writable surface: this file only
> Evidence boundary: repository and accepted human-operated evidence through
> the Gate 12.6 copied-database classification
> Status: **CYCLE 10 OPEN; GCM-02 GATE 12.6 CORRELATION PENDING**

## 1. Recovery entrypoint

This mutable prefix is the current Main recovery surface. Read it before the
append-only `Legacy_Progress` history. Expand into the legacy entries, G/H/I,
permanent domains, GRIMOIRE, or source only when the current task requires
deeper evidence.

Mandatory methodology boot remains:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Retain these ownership boundaries:

- Main synthesizes and stages authority.
- A/B/C are functional investigation and reconciliation inputs.
- D/E/F are synchronized Codex materialization authority.
- G/H/I are observational materialization reports.
- J is Main staging and continuity, not permanent domain canon.
- `Legacy_Progress` is append-only and must not be compacted or rewritten.
- Semantic promotion and physical materialization remain distinct.
- Human/provider actions require explicit, narrow authorization.

## 2. Current repository frame

```text
Repository: gus-i-gu/markei
Active branch: cycle10-intermid-grimoire
Current pruning baseline: 7a59bc8b2db4016bd42ca89df0cf2286cd64b755
Cycle: 10
Active closure unit: MCG-02 / user-facing GCM-02
Active gate: 12.6 copied-database transition correlation
```

The branch contains the GRIMOIRE execution interface, hosted Sync
implementation and diagnostics, account-cursor provisioning repair,
human-operated provider evidence, and the latest Gate 12.6 staging.

The old `intermid-cycle-recovery` branch carried earlier J reconciliations.
Their accepted meaning has already been reconciled into this branch. Do not
merge that historical branch merely to recover J content.

Parallel-work rule:

- the J pruning commit and the current Codex G/H/I materialization may be
  developed from the same baseline;
- integrate them by rebasing or merging one complete commit onto the other;
- never copy individual files across histories or force-push over either
  commit;
- stop if both commits unexpectedly change J or the same G/H/I/GRIMOIRE
  lines.

## 3. Cycle 10 consolidated panorama

Cycle 10 moved Markei from local synchronization groundwork toward bounded,
authenticated, hosted inter-device convergence. It is not yet closed.

### 3.1 Accepted implementation track

The source and reconciled reports establish:

- offline-first local data remains primary;
- immutable append-only Sync events and deterministic request content exist;
- Account/Device-scoped local queues, download/apply, acknowledgements and
  idempotent application paths exist;
- two-Device disposable convergence and recovery harnesses exist;
- hosted Auth0/OIDC verification, membership resolution, Device enrollment,
  query/replay/status/revocation and transaction-scoped authorization exist;
- RLS context and runtime/migrator privilege separation exist;
- Native Closure exposes guarded sign-in, enrollment, query, hosted
  connection, Sync and diagnostic/recovery actions;
- durable Sync-attempt and unknown-outcome observability exists;
- retention, snapshot and rebootstrap contracts and local harness groundwork
  exist.

These are implementation and bounded validation claims. They do not by
themselves establish production readiness, real multi-device convergence,
hosted retention execution, backup/PITR acceptance, or release acceptance.

### 3.2 Account cursor-state correction

The protected hosted submission failure was traced locally to an Account that
existed without `account_cursor_state`.

The accepted correction lineage includes:

- fail-closed handling for a missing cursor row;
- explicit `service-unavailable / not-applied` classification;
- migration 007 provisioning exactly one cursor-state row for new Accounts;
- backfill only for missing historical rows;
- preservation of existing cursor rows;
- hosted high-water-derived initialization;
- revocation of runtime cursor INSERT/DELETE;
- retained scoped runtime SELECT/UPDATE;
- readiness-v2 migration capability.

Migration 007 was applied once to the development Neon target and
postflight-validated. It must not be reapplied.

### 3.3 Hosted preparation accepted

Within development-provider boundaries, accepted human-operated evidence
includes:

- the intended corrected Render revision was deployed;
- live and ready endpoints returned their expected ready results;
- readiness-v2 was true;
- Auth0 issuer, audience and RS256 metadata matched;
- an authenticated fixture principal resolved to active membership;
- exact enrolled Device binding was confirmed;
- provider state remained unchanged across the inspected pre-Sync checkpoint;
- secrets and complete identifiers were kept out of notebook evidence.

This does not authorize production deployment, provider mutation, credential
rotation, ordinary Sync, or a recovery operation.

### 3.4 Validation record retained

The latest complete materialization record before the current evidence-only
round retained:

```text
API format/lint/typecheck/build: PASS
API tests: 53 / 53
production dependency audit: 0 vulnerabilities
migration-007 disposable PostgreSQL probe: 29 / 29
hosted local authorization cases: 28 true / 0 pending
Flutter format/analyze: PASS
Flutter tests: 178 passed / 4 lab-gated skips
real convergence harness: 3 / 3
real recovery harness: 1 / 1
Windows release build: PASS
Android debug build: PASS
protected Python unittest suite: 5 / 5
```

One older aggregate orchestrator observation retained a
`query-replay-same-request-id` Flutter-producer failure while the direct suite
and opt-in harnesses passed. Do not mark that aggregate observation resolved
without a correlated rerun.

## 4. Current source and operational map

Use this map for targeted recovery rather than scanning the repository
indiscriminately.

### 4.1 Human execution interface

```text
documentation/GRIMOIRE.md
documentation/G_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/NEON_CHECK.ps1
documentation/DB_MGMT.sql
```

`GRIMOIRE.md` is the concise indexed human entry surface. Every active `GRM-*`
block dispatches exactly one `GS-*` procedure through `NEON_CHECK.ps1`.
`G_SCRIPTS.md` owns procedure logic and runtime requests,
`NS_COORDINATES.md` owns reviewed non-secret values, and `DB_MGMT.sql` owns
manual SQL plus indexed automation-query blocks. Coordinates are mutable and
must be freshly verified before provider action.

Current SQLite route:

```text
GRM-SQLITE-01 -> SQLite CLI availability
GRM-SQLITE-02 -> closed-app discovery and verified temporary copy
GRM-SQLITE-03 -> read-only sanitized copied-database classification
GRM-SQLITE-04 -> materialized read-only sanitized device-scope correlation
```

All four procedures are materialized. The first three have human-observed
results; `GRM-SQLITE-04` remains unexecuted against the preserved copy. The
copy is `markei-gate-12-6-current`; it must remain unchanged until the
scope-correlation evidence is interpreted.

### 4.2 Flutter synchronization authorities

```text
clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart
clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart
clients/markei_flutter/lib/domain/sync/sync_event.dart
```

The coordinator owns the recovery-to-upload-to-download-to-acknowledgement
transition. Local repositories own durable queue/submission/event state.
Transport owns protocol mapping. Domain Sync models own event and state
semantics.

### 4.3 Hosted API authorities

```text
services/markei_sync_api/src/
services/markei_sync_api/migrations/
packages/markei_sync_contract/
```

Inspect exact files through G/H/I or targeted search when the active question
requires server behavior. Do not infer hosted state from source capability.

## 5. GCM-02 current state

GCM-02 owns the controlled exact-identity hosted Sync resolution. Gates
12.1–12.5 established hosted readiness, metadata, alignment, exact binding
and an immutable pre-operation baseline. Gate 12.6 now determines the exact
eligible transition and evidence packet before any human authorization.

### 5.1 Accepted Gate 12.6 copied-database evidence

The human-operated procedure:

- confirmed Markei and relevant Flutter execution were closed;
- found exactly one local database candidate;
- found no WAL/SHM sidecars;
- created a fixed-name copy;
- verified copy size and hash equality without printing hashes;
- queried only the copy with SQLite read-only and
  `PRAGMA query_only=ON`;
- returned `SQLiteQuickCheck: ok`;
- performed no Retry, ordinary Sync or provider action.

Sanitized classification:

```text
submissions:
  superseded / notApplied / conflict / null                  = 1
  superseded / notApplied / conflict / enrollment-required   = 1
  failed     / notApplied / conflict / service-unavailable   = 1

each submission:
  two member events
  event sequences 1–2
  event state failed
  positions 0–1

pending-event summary:
  failed  = 2, sequences 1–2
  pending = 6, sequences 1–5

latest attempt:
  sync-unavailable
  provider-evidence-unavailable
  no HTTP status
  no response headers
```

### 5.2 Reconciled conclusions

Accepted:

- copied-database procedure: PASS;
- database copy: healthy and internally coherent;
- exactly one active failed/notApplied two-event lineage: confirmed;
- two earlier two-event submissions: superseded;
- unknown-submission Retry path: inapplicable;
- earlier insufficient-evidence queue classification: superseded;
- no trustworthy provider result exists for the latest ordinary Sync;
- the six other pending events make ordinary Sync an unsafe substitute for
  the bounded recovery question.

The observed active legacy row stores:

```text
response_code = conflict
error_code = service-unavailable
```

Current source maps `service-unavailable` to `serviceUnavailable`. Git history
shows that explicit mapping was added in
`75dc7bed0789d693af93abb3ed15e107fd77433a`; the observed database timestamp
predates that correction. The pairing is historically coherent with the
older fallback, but this is not executable row-level provenance and must not
be silently rewritten.

### 5.3 Exact remaining Gate 12.6 question

Gate 12.6 no longer waits on queue-classification evidence. It remains open
only for device-scoped transition correlation:

- which anonymized Device scope owns the active failed submission;
- that Device scope's `next_sequence`;
- how the six other pending events divide across anonymized Device scopes;
- which events the next coordinator upload would include;
- whether immutable request identity/hash reuse is safely verifiable;
- the exact transition from failed recovery through supersession, pending
  upload, download and acknowledgement.

Codex concluded that the aggregate evidence cannot resolve these facts safely
and materialized `GS-SQLITE-04` plus `GRM-SQLITE-04`. Disposable zero-, one-,
and multi-device fixture validation passed. The procedure has not been run
against the preserved human copy; that read-only human step remains the next
evidence action. Codex did not query or copy the human database.

### 5.4 Gate terminals

```text
GCM02_12_1_RENDER_READY_PASS
GCM02_12_2_AUTH0_METADATA_PASS
GCM02_12_3_ALIGNMENT_PASS_AT_INSPECTED_CHECKPOINT
GCM02_12_4_EXACT_BINDING_PASS
GCM02_12_5_PROVIDER_BASELINE_PASS
GCM02_12_6_COPIED_DATABASE_PROBE_PASS
GCM02_12_6_DEVICE_SCOPED_CORRELATION_PENDING
GCM02_12_7_HUMAN_AUTHORIZATION_PENDING
GCM02_12_8_CONTROLLED_OPERATION_HELD
GCM02_12_9_POST_OPERATION_COMPARISON_HELD
GCM02_12_10_RECONCILIATION_HELD
GCM02_OPEN
```

### 5.5 Active prohibitions

Until a new Main reconciliation explicitly changes them:

```text
Retry: NOT AUTHORIZED
ordinary Sync: NOT AUTHORIZED
Enroll/re-enroll: NOT AUTHORIZED
provider query or mutation: NOT AUTHORIZED
database repair, cleanup or deletion: NOT AUTHORIZED
credential inspection or rotation: NOT AUTHORIZED
Gate 12.7 authorization: NOT GRANTED
GCM-02 closure: NOT GRANTED
```

Keep Markei closed and preserve the copied database unchanged. Do not execute
ad hoc SQL.

## 6. Immediate continuation

The active Codex round is evidence-only:

1. reconcile the copied-database observation into G/H/I;
2. prove the legacy response mapping boundary from source and Git history;
3. trace the exact coordinator transition;
4. determine whether current evidence resolves device-scoped correlation;
5. conditionally materialize and validate SQLite-04 if required;
6. prepare a Gate 12.7 packet skeleton with every unresolved field `PENDING`.

Codex must not modify J. After its commit is integrated with this pruning
commit, Main must reconcile the new G/H/I result into this mutable prefix.

If SQLite-04 is produced, the next human action is limited to:

- pull and verify the integrated branch;
- keep Markei closed;
- run the indexed, sanitized, read-only procedure against the preserved copy;
- return only its intended output;
- perform no Retry, Sync or provider action.

If SQLite-04 is unnecessary, Main should use G/H/I to decide whether Gate 12.6
can close and whether a complete Gate 12.7 authorization packet can be
presented for explicit human review.

## 7. GCM-03 provisional boundary

GCM-03 is undefined and inactive until GCM-02 closes. Its scope must be
derived from the actual GCM-02 terminal, not from the optimistic expectation
of success.

Current provisional candidate:

```text
bounded second-Device hosted convergence and acknowledgement proof
```

Main must first inspect GCM-02 closure evidence, inventory remaining accepted
gaps, select one narrow objective, stage fresh A/B/C investigation if needed,
then create new D/E/F authority.

GCM-03 must not silently absorb:

- production deployment;
- broad retention/rebootstrap acceptance;
- backup/PITR acceptance;
- credential-lifecycle acceptance;
- Cycle 11 UI/UX work.

## 8. GCM-04 provisional boundary

GCM-04 is undefined and inactive until earlier closure evidence establishes
what remains. It should contain the final bounded external/operational
acceptance needed for Cycle 10, potentially partitioned by Main if one unit
would otherwise become non-terminal.

Current candidate families:

```text
authorization, revocation and credential lifecycle
outage, recovery and retention acceptance
deployment/release operational boundary
```

These are planning candidates, not authority. Main must reconcile GCM-03
evidence before selecting GCM-04.

## 9. Cycle 10 closure route

Cycle 10 closes only after:

1. GCM-02 reaches a trustworthy correlated terminal or an explicitly accepted
   bounded blocker;
2. GCM-03 is defined, materialized, validated and reconciled;
3. GCM-04 is defined, materialized, validated and reconciled;
4. remaining host/provider/release gaps are classified;
5. source, G/H/I, domain memory and human evidence are reconciled;
6. Operational, Didactic and Design permanent files are promoted through
   their authorized FLX-PRM-04 sequences;
7. `00_PROJECT_STATE.md`, `05_SESSION_LOG.md` and
   `06_SESSION_SCHEME.md` are refreshed under Main authority;
8. Cycle 11 receives a clean entry baseline with Cycle 10 residuals explicit.

Cycle 11 remains separate. Its UI/UX and basic Analytics work must not be used
to bypass Cycle 10 closure.

## 10. PRC-01 current claims

| Claim                                        | Result and evidence boundary                                          |
| -------------------------------------------- | --------------------------------------------------------------------- |
| Cycle 10 implementation foundation exists    | Implemented and locally validated within named reports                |
| Migration 007 repaired cursor provisioning   | Implemented; development-provider application and postflight accepted |
| Hosted readiness and exact binding passed    | Human-operated accepted development evidence                          |
| Gate 12.6 copied-database probe passed       | Human-operated accepted, read-only copied-database evidence           |
| Failed/notApplied lineage is known           | Accepted from sanitized copied-database output                        |
| Legacy response pairing is explained         | Source/history-consistent, not row-proven                             |
| Exact device-scoped next transition is known | Pending Codex correlation                                             |
| Retry is eligible                            | Rejected; unknown-retry path is inapplicable                          |
| Ordinary Sync is a safe substitute           | Rejected; six other pending events exist                              |
| Gate 12.7 is authorized                      | Rejected                                                              |
| GCM-02 is closed                             | Rejected                                                              |
| GCM-03 or GCM-04 is active                   | Rejected                                                              |
| Cycle 10 is closed                           | Rejected                                                              |

## 11. Pruning disposition

This refresh replaces the former mutable prefix, which had accumulated:

- superseded cursor-state implementation instructions;
- pre-probe Gate 12.6 Cancel/Retry decision trees;
- repeated repository, methodology and validation panoramas;
- cleared provider-preflight and deployment steps;
- stale one-line continuation terminals;
- duplicated future GCM-03/04 and Cycle 10 closure descriptions.

Their continuing meaning is consolidated above. Historical progression remains
available under `Legacy_Progress`, which was preserved unchanged.

Current recovery pointer:

```text
read this mutable prefix
-> read current D/E/F for active Codex authority
-> read newest G/H/I after Codex materialization
-> expand into Legacy_Progress only for provenance/history
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

## Append-only reconciliation entry — 2026-07-25 — Gate 12.6 copied-database classification

### Sequence identity

```text
Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Main Chat
Round: C10-GCM02-GATE-12.6-COPIED-DATABASE-RECONCILIATION
Branch: cycle10-intermid-grimoire
Inspected remote baseline: 49534b2029ecc56441cc00a5ad8b5a1a29ddbb38
Authority: human-requested Main reconciliation and next-Codex staging
Evidence boundary: sanitized user-transcribed Windows/SQLite output,
                   repository source, and Git history
```

### Accepted copied-database observation

The human operator first aligned the Windows checkout to
`49534b2029ecc56441cc00a5ad8b5a1a29ddbb38`. Markei was closed. The canonical
`GS-SQLITE-02` procedure then:

- found exactly one local `markei_shared_beta.sqlite` candidate;
- observed no WAL/SHM sidecars;
- created the fixed-name Gate 12.6 working copy;
- verified equal source/copy sizes and hashes without printing hash values;
- did not query the live database;
- returned the terminal to repository root.

The canonical `GS-SQLITE-03` procedure queried only that copy in read-only
mode. It observed:

```text
Expected Sync tables:                    6/6 present
SQLite quick_check:                      ok
Active failed submissions:               1
Active failed outcome:                   notApplied
Active response/error representation:    conflict / service-unavailable
Active submission members:               2
Active member sequence range:            1–2
Active member positions:                 0–1
Active member event state:               failed
Superseded submissions:                  2
Each superseded member count/range:       2 / 1–2
Device next_sequence distribution:        2, 3, 6
Failed pending-event rows:                2 / sequences 1–2
Pending pending-event rows:               6 / sequences 1–5
Latest ordinary Sync result:              sync-unavailable
Latest recovery classification:           provider-evidence-unavailable
Latest HTTP status/headers:                absent / absent
Live database queried:                    false
Retry selected:                           false
Sync selected:                            false
Provider action performed:                false
```

This evidence contains no database path, account/device/submission/event ID,
payload, purchase content, token, URL, complete hash, or provider secret.

### Repository and history reconciliation

Current source proves:

1. `HttpSyncTransport._failure` now maps protocol
   `service-unavailable` to `SyncStatusCode.serviceUnavailable`;
2. `LocalSyncRepository.persistUploadResult` stores `result.code.name` in
   `response_code` and the protocol body code in `error_code`;
3. the fallback branch maps unrecognized protocol codes to
   `SyncStatusCode.conflict`;
4. commit `75dc7bed0789d693af93abb3ed15e107fd77433a`, authored
   2026-07-22 11:54:56 -0300, introduced the explicit
   `service-unavailable -> serviceUnavailable` mapping;
5. the copied database reports a last-modified time of
   2026-07-22 10:08:29 in the human's Windows locale, earlier than that commit.

The observed `conflict / service-unavailable` pair is therefore historically
coherent with the pre-fix fallback mapper: the client retained the precise
protocol code in `error_code` while persisting the fallback client enum name in
`response_code`. This is strong source-history evidence for a legacy
representation. It is not proof that every row was written by a uniquely
identified executable, because filesystem timestamps and Git author time do
not provide row-level provenance.

### Gate conclusion

PRC-01 classification:

```text
Claim: the copied database is structurally readable and internally healthy
Prior state: unavailable
Evidence: verified copy procedure, six-table presence, PRAGMA quick_check=ok
Evidence boundary: sanitized human-observed output; no Codex/user live-DB read
Contradiction: none
Semantic owner: GCM-02 operational evidence
Target role: Gate 12.6 copied-database subprocedure
Resulting state: accepted PASS
History disposition: diagnostic uncertainty superseded
```

```text
Claim: the current queue contains an unknown submission eligible for unknown Retry
Prior state: provisional possibility
Evidence: one active submission is failed/notApplied; no unknown class emitted
Evidence boundary: copied database at the preserved snapshot
Contradiction: earlier screenshot/procedure language implied unresolved unknown
Semantic owner: local Sync recovery classification
Target role: Gate 12.6 eligibility
Resulting state: rejected; unknown-retry path is inapplicable
History disposition: earlier provisional Conclusion C superseded
```

```text
Claim: exactly one failed/notApplied recovery candidate exists
Prior state: provisional
Evidence: active class and two-member failed lineage at sequences 1–2
Evidence boundary: sanitized grouping; exact device/account correlation omitted
Contradiction: none
Semantic owner: failed-recovery eligibility
Target role: Gate 12.6 transition definition
Resulting state: accepted as queue classification; exact scoped transition pending
History disposition: retain pre-probe diagnosis as observational history
```

```text
Claim: conflict/service-unavailable contradicts current mapping
Prior state: unresolved semantic anomaly
Evidence: source mapping, persistence fields, Git introduction commit, file time
Evidence boundary: source/history and file-level time; no row-level provenance
Contradiction: apparent current-source mismatch
Semantic owner: client protocol persistence history
Target role: Gate 12.6 evidence interpretation
Resulting state: explained as historically coherent legacy representation
History disposition: preserve boundary; do not rewrite the database
```

```text
Claim: the successful copied-database probe authorizes ordinary Sync
Prior state: unauthorized
Evidence: coordinator performs failed recovery before upload, download and ack;
          six other pending rows are present
Evidence boundary: current source plus copied grouping
Contradiction: none
Semantic owner: Gate 12.7 human authorization
Target role: mutation boundary
Resulting state: rejected; ordinary Sync remains unauthorized
History disposition: stop boundary retained
```

Gate 12.6 no longer waits on queue-classification evidence. It remains open
only because the sanitized output does not yet correlate the failed submission
to an anonymized device scope, that scope's `next_sequence`, or the distribution
of the six other pending events. Those facts determine whether the coordinator's
recovery-then-upload path can be described as one exact bounded transition.

### Next materialization round

D/E/F are replaced with one bounded evidence-reconciliation round:

```text
D: classify copied evidence; prove legacy mapping history; decide whether one
   additional sanitized copied-database correlation procedure is necessary
E: stabilize evidence vocabulary and prevent PASS/authorization conflation
F: trace failed recovery -> upload -> download -> acknowledgement and prepare
   a Gate 12.7 packet skeleton with every unproven field marked PENDING
```

The round may update G/H/I. It may add only `GS/GRM-SQLITE-04` if exact
device-scoped correlation cannot be established from current evidence. It may
not modify application source, query a user database, perform provider action,
authorize Gate 12.7, or close GCM-02.

### Current terminals

```text
GATE_12_6_COPIED_DATABASE_PROBE_PASS
FAILED_NOT_APPLIED_CLASS_CONFIRMED
UNKNOWN_RETRY_INAPPLICABLE
LEGACY_CONFLICT_SERVICE_UNAVAILABLE_EXPLAINED_WITH_BOUNDARY
EXACT_DEVICE_SCOPED_TRANSITION_CORRELATION_PENDING
GATE_12_6_OPEN
GATE_12_7_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-25 — DB management cascade refactor

### Sequence identity

```text
Sequence: FLX-PRN-03 with active-state reconciliation
Scope: live GRIMOIRE operational interface
Baseline: 41c94be245ed093b2e92e3f8403ef72cfb42984b
Provider action: none
Database access: none
Gate authority change: none
```

The parallel Codex round materialized and fixture-validated
`GS/GRM-SQLITE-04`; no human database was queried. The preceding entry's
conditional materialization instruction is therefore superseded for current
use. The remaining Gate 12.6 action is the human-run, read-only
`GRM-SQLITE-04` procedure against the preserved verified copy.

The live five-file interface was reorganized without changing provider state:

```text
GRIMOIRE.md       -> concise GRM invocation index
NEON_CHECK.ps1    -> exact GS dispatcher and guarded Neon launcher
G_SCRIPTS.md      -> complete procedures, prompts, expectations and stops
NS_COORDINATES.md -> reviewed non-secret values
DB_MGMT.sql       -> manual SQL plus indexed automation queries
```

`DB_MGMT.sql` supersedes `NEON_ACTION.sql` as the live catalogue. Earlier
`NEON_ACTION.sql`/`NA-*` references remain valid historical evidence only.
Every active `GRM-*` block now invokes one exact `GS-*` procedure; operational
variables and query logic no longer live in GRM bodies. The nine existing
automation SQL bodies were preserved byte-for-byte, and one read-only
`runtime-readiness` automation block was added so `GRM-NEON-10` also follows
the uniform cascade.

Current terminals remain:

```text
EXACT_DEVICE_SCOPED_TRANSITION_CORRELATION_PENDING
GATE_12_6_OPEN
GATE_12_7_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```
