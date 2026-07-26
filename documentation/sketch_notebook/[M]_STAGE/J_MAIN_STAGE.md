# J_MAIN_STAGE — Cycle 10 active reconciliation

> Sequence: FLX-PRN-03 recovery-economy pruning after FLX-PRM-04 reconciliation
> Role: Main Chat
> Branch: `cycle10-intermid-grimoire`
> Reconciliation baseline: `a63367763716e2769ac58d5adc19de0c41774b35`
> Authority: human-directed Main reconciliation after REC-01 materialization
> Writable surface: J only for this reconciliation
> Evidence boundary: repository and local/disposable validation through the
> REC-01 G/H/I reports; fresh Windows and provider evidence remain absent
> Status: **CYCLE 10 OPEN; GCM-02 GATE 12.7 PREFLIGHT PASS; REC-01 SOURCE
> ACCEPTED; HOST VALIDATION AND EXECUTION AUTHORIZATION HELD**

## 1. Recovery entrypoint

This mutable prefix is the current Main recovery surface. Read it before the
append-only `Legacy_Progress` history. Expand into the legacy entries, G/H/I,
permanent domains, GRM, or source only when the current task requires
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
Current reconciliation baseline: a63367763716e2769ac58d5adc19de0c41774b35
Cycle: 10
Active closure unit: MCG-02 / user-facing GCM-02
Latest completed sprint: C10-GCM02-S12-REC-01 bounded execution surface
Active gate: 12.7 Windows validation, repeated preflight and freshness refresh
before one-action authorization
```

The branch contains the GRM execution interface, hosted Sync
implementation and diagnostics, account-cursor provisioning repair,
human-operated provider evidence, and the latest Gate 12.6 staging.

The old `intermid-cycle-recovery` branch carried earlier J reconciliations.
Their accepted meaning has already been reconciled into this branch. Do not
merge that historical branch merely to recover J content.

The earlier parallel J/Codex and GRM-refactor rounds are integrated in the
current branch baseline. Do not replay their local-equivalent commits onto this
branch.

REC-01 was materialized at `a63367763716e2769ac58d5adc19de0c41774b35`.
Codex explicitly preserved the unrelated local deletion of
`documentation/NEON_CHECK.ps1` and untracked
`documentation/I_SCRIPTS.ps1`; that rename is not part of the remote REC-01
commit and is not accepted by this reconciliation.

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
- a separate, explicitly confirmed failed/notApplied recovery surface now
  exists, preserving read-only inspection, unknown Retry and ordinary Sync as
  distinct actions;
- the bounded REC-01 coordinator revalidates exact internal candidate identity,
  atomically recovers and leases only its members, performs at most one upload,
  persists that result, and contains no download or acknowledgement path;
- retention, snapshot and rebootstrap contracts and local harness groundwork
  exist.

These are implementation and bounded validation claims. REC-01 specifically
remains host-unvalidated and unexecuted against the user environment. They do
not by themselves establish production readiness, real multi-device
convergence, hosted retention execution, backup/PITR acceptance, or release
acceptance.

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
documentation/GRM.md
documentation/G_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/NEON_CHECK.ps1
documentation/DB_MGMT.sql
```

`GRM.md` is the concise indexed human entry surface. Every active `GRM-*`
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

All four procedures are materialized and have human-observed results.
`GRM-SQLITE-04` queried only the preserved verified copy and completed the
device-scope correlation without Retry, Sync, provider action, mutation or
cleanup. Preserve `markei-gate-12-6-current` unchanged through the controlled
operation and post-operation reconciliation.

### 4.2 Flutter synchronization authorities

```text
clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart
clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart
clients/markei_flutter/lib/domain/sync/sync_event.dart
```

`hosted_sync_coordinator.dart` owns ordinary Sync's broad
recovery-to-upload-to-download-to-acknowledgement transition.
`failed_not_applied_recovery_coordinator.dart` owns REC-01's narrower exact
candidate recovery-to-one-upload terminal and intentionally has no download or
acknowledgement dependency. Local repositories own durable
queue/submission/event state. Transport owns protocol mapping. Domain Sync
models own event and state semantics.

### 4.3 Hosted API authorities

```text
services/markei_sync_api/src/
services/markei_sync_api/migrations/
packages/markei_sync_contract/
```

Inspect exact files through G/H/I or targeted search when the active question
requires server behavior. Do not infer hosted state from source capability.

## 5. GCM-02 current state

GCM-02 owns the controlled exact-identity hosted recovery resolution. Gates
12.1–12.5 established hosted readiness, metadata, alignment, exact binding
and an immutable pre-operation baseline. Gate 12.6 has now determined the
exact eligible transition and recovery boundary. The read-only Gate 12.7
inspection passes, and REC-01 now provides a dedicated bounded
failed/notApplied executor validated only through local/disposable boundaries.
Main may not prepare the exact one-action authorization packet until the new
source passes fresh Windows validation, exposes the expected repeated preflight
and confirmation surface, and the Git/Render/Auth0/Device/provider evidence is
refreshed.

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

### 5.3 Gate 12.6 device-scoped correlation

Human execution of `GRM-SQLITE-04` against the preserved verified copy
returned:

```text
SQLite quick check: ok
observed Device scopes: 3
hosted/enrolled scope rank: 3
hosted scope next_sequence: 3
failed candidate submission: failed / notApplied
legacy response/error: conflict / service-unavailable
candidate members: 2
candidate positions: 0–1, contiguous
candidate sequences: 1–2, contiguous
candidate member state: failed
same-hash superseded submissions: 0
same-hash active submissions: 0
simulated first upload count: 2
candidate events in first upload: 2
other pending events in hosted scope: 0
first upload contains only candidate events: true
other non-hosted pending work: rank 1 = 1; rank 2 = 5
latest Sync: sync-unavailable / provider-evidence-unavailable
```

The output proves:

- the hosted/enrolled Device scope is anonymized rank 3;
- it owns exactly the failed two-event lineage at sequences 1–2;
- its next local Device sequence is 3;
- the six other pending events belong only to non-hosted ranks 1 and 2;
- failed recovery would make exactly the two candidate events the first
  bounded upload;
- no active or superseded submission shares the candidate request hash;
- no latest provider result exists because the latest Sync stopped without
  HTTP status or response headers.

The procedure queried no live database and selected no Retry or Sync. Gate
12.6 evidence collection and correlation are complete. The local SQLite
snapshot and the earlier Neon checkpoint are not contradictory: they describe
different sides and times of a failed/notApplied boundary, while the latest
Sync obtained no fresh provider evidence.

### 5.4 Gate terminals

```text
GCM02_12_1_RENDER_READY_PASS
GCM02_12_2_AUTH0_METADATA_PASS
GCM02_12_3_ALIGNMENT_PASS_AT_INSPECTED_CHECKPOINT
GCM02_12_4_EXACT_BINDING_PASS
GCM02_12_5_PROVIDER_BASELINE_PASS
GCM02_12_6_COPIED_DATABASE_PROBE_PASS
GCM02_12_6_DEVICE_SCOPED_CORRELATION_PASS
GCM02_12_6_PASS
GCM02_12_7_READ_ONLY_PREFLIGHT_PASS
GCM02_S12_REC_01_SOURCE_ACCEPTED
GCM02_S12_REC_01_HOST_VALIDATION_PENDING
GCM02_12_7_HUMAN_AUTHORIZATION_HELD
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

Keep Markei closed and preserve the copied database unchanged until the Gate
12.7 packet is reviewed. Do not execute ad hoc SQL.

## 6. Immediate continuation — Phase 12.7

The Windows read-only failed/notApplied preflight is reconciled as PASS. REC-01
is now source-accepted from G/H/I at
`a63367763716e2769ac58d5adc19de0c41774b35`: the dedicated execution surface,
precise `MKS-REC-001` preflight code, exact recovered batch, one-upload maximum,
and absence of download/acknowledgement were locally validated. No provider or
user-database action occurred.

Proceed in this order:

1. settle the separate `NEON_CHECK.ps1` to `I_SCRIPTS.ps1` rename and every
   dispatcher/documentation reference in one isolated, validated commit, or
   restore the tracked dispatcher name before host validation;
2. pull the reconciled branch into the clean Windows checkout and require a
   clean understood worktree;
3. run the canonical Windows analysis, full tests, release build and Closure
   launch through the dispatcher name actually tracked by that commit;
4. select only `Inspect failed/notApplied recovery` and require
   `MKS-REC-001`, one eligible candidate, member count `2`, sequence range
   `1-2`, next sequence `3`, and no mutation/contact/persistence;
5. confirm that `Recover failed/notApplied candidate` is separately visible
   and separately confirmed, then cancel without executing it;
6. refresh Git revision, Render readiness/revision, Auth0 metadata/principal,
   exact Device binding and the allowlisted provider baseline;
7. return the sanitized host/freshness evidence for Main reconciliation;
8. Main prepares one exact Gate 12.7 packet only if every invariant matches;
9. only a later explicit human authorization may permit exactly one
   `Recover failed/notApplied candidate` action;
10. no second action is permitted; Gates 12.8–12.10 then capture and reconcile
    the correlated terminal.

Ordinary Sync, unknown-outcome Retry, Repair, Enroll, provider-console
mutation, database editing and cleanup remain prohibited. The complete
evidence, hierarchy and continuation sequence are preserved in the newest
`Legacy_Progress` entry.

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
| Exact device-scoped next transition is known | Accepted from human-operated read-only `GRM-SQLITE-04` evidence       |
| Retry is eligible                            | Rejected; unknown-retry path is inapplicable                          |
| Ordinary Sync is a safe substitute           | Rejected; six other pending events exist                              |
| REC-01 bounded execution surface exists      | Implemented and locally validated at `a633677`; host-unvalidated       |
| Eligible preflight diagnostic is corrected   | `MKS-REC-001` generated and locally validated; Windows rerun pending   |
| Exact batch and one-upload boundary hold      | Locally test-validated; no live execution performed                    |
| Gate 12.7 packet is ready                    | Rejected; Windows and freshness evidence still required                |
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
-> read REC-01 G/H/I for accepted materialization evidence
-> inspect the separately published dispatcher rename before Windows commands
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

## Append-only reconciliation entry — 2026-07-25 — GRM rename and full catalogue audit

### Sequence identity

```text
Sequence: FLX-PRN-03 with PRC-01 evidence qualification
Scope: live GRM/GS procedural interface and Gate 12.6 recovery pointer
Baseline: 05265cfb91f92504e1ac5e627f0af62e351c4b8f
Provider action: none
Database access: none
Retry or ordinary Sync: none
Gate authority change: none
```

The concise human entrypoint was renamed:

```text
documentation/GRIMOIRE.md -> documentation/GRM.md
GRIMOIRE_INDEX             -> GRM_INDEX
```

The live file header now explains the complete procedural cascade and contains
one ordered code/name glossary for every active command. The canonical route
remains:

```text
human copies GRM
-> NEON_CHECK dispatches one GS
-> GS owns guards, coordinates and requested inputs
-> GS invokes PowerShell and/or one DB_MGMT automation query
-> sanitized evidence returns for human interpretation
```

Qualified static audit:

```text
ordered GRM glossary entries: 25 / 25
active GRM invocation blocks: 25 / 25
active GS procedure headings: 25 / 25
one exact GRM-to-GS mapping per active command: PASS
one PowerShell fence per active GS procedure: PASS
active GRM/GS order equality: PASS
DB_MGMT automation blocks and end markers: 10 / 10
launcher action-name coverage: PASS
historical GS procedures outside active GRM index: 2
live five-file references to old GRIMOIRE filename/index: 0
```

This audit proves catalogue structure, mapping, ordering and documentation
coherence at the inspected repository state. It is not a Windows PowerShell,
provider, database, Flutter, Retry or Sync execution. No GS procedure body was
changed by the rename round. Existing fixture and human evidence retain their
previous boundaries.

The mutable J recovery prefix now records that the evidence-only Codex round
is complete. The sole next Gate 12.6 evidence action is to run the indexed,
sanitized and read-only `GRM-SQLITE-04` procedure against the preserved
verified copy after the integrated branch is published and pulled.

Current terminals remain:

```text
GCM02_12_6_COPIED_DATABASE_PROBE_PASS
GCM02_12_6_DEVICE_SCOPED_CORRELATION_PENDING
GCM02_12_7_HUMAN_AUTHORIZATION_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```

## Append-only reconciliation entry — 2026-07-25 — Gate 12.6 device-scope closure

### Sequence identity

```text
Sequence: FLX-PRM-04 Main reconciliation
Round: C10-GCM02-GATE-12.6-DEVICE-SCOPE-CLOSURE
Branch baseline: 52ea09c9e08380fb7c2a85b58ae9909385bd3bdc
Human evidence: sanitized GS-SQLITE-04 output
Provider action: none
Live database access: none
Retry or ordinary Sync: none
Gate authority change: Gate 12.6 PASS; Gate 12.7 remains unauthorized
```

Claim: the remaining failed lineage is correlated to one Device scope.

Prior state: Gate 12.6 was open for exact anonymized scope ownership,
`next_sequence`, other-pending-work partition and simulated first-upload
membership.

Evidence: the human-operated read-only copied-database procedure found three
Device scopes. Rank 3 is the hosted/enrolled scope, has `next_sequence=3`, and
owns the failed/notApplied two-event candidate at contiguous sequences 1–2 and
positions 0–1.

Evidence boundary: the procedure queried only the preserved verified SQLite
copy with quick-check already OK. It did not query the live database, select
Retry or Sync, contact a provider, mutate data or clean anything.

Contradiction: none. The six other pending events divide across non-hosted
rank 1 (one event) and rank 2 (five events). The hosted scope has no other
pending work.

Semantic owner: Main GCM-02 gate reconciliation.

Target role: Gate 12.6 device-scoped transition correlation.

Resulting state: accepted PASS. Simulated recovery places exactly the two
candidate events in the first upload; no active or superseded submission has
the same request hash.

History disposition: the earlier Gate 12.6 pending terminals remain historical
and are superseded for current recovery by this entry and the mutable prefix.

Claim: the latest local Sync proves a fresh provider contradiction.

Prior state: unresolved because the copied database stores
`sync-unavailable / provider-evidence-unavailable`.

Evidence: the latest attempt has no HTTP status and no response headers.

Evidence boundary: local observational classification only.

Contradiction: rejected. No fresh provider comparison occurred, so the local
failed/notApplied lineage and earlier Neon checkpoint describe different
sides/times of the boundary rather than proven conflicting state.

Semantic owner: Gate 12.7 pre-operation freshness packet.

Target role: provider-baseline interpretation.

Resulting state: fresh provider readiness and baseline must be rechecked before
authorization; no database repair is justified by the present evidence.

History disposition: preserved as the reason 12.7 requires freshness checks.

Current terminals:

```text
GCM02_12_6_COPIED_DATABASE_PROBE_PASS
GCM02_12_6_DEVICE_SCOPED_CORRELATION_PASS
GCM02_12_6_PASS
GCM02_12_7_PACKET_PREPARATION_ACTIVE
GCM02_12_7_HUMAN_AUTHORIZATION_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
REPAIR_UNAUTHORIZED
PROVIDER_MUTATION_UNAUTHORIZED
GCM02_OPEN
```

## System Diagnosis

Date: 2026-07-25

Record class: append-only Step 12.1–12.6 diagnostic synthesis.

Change authority: documentation and Gate interpretation only. This entry does
not authorize Retry, ordinary Sync, Repair, Enroll, provider mutation, or direct
database mutation.

### Reconciliation correction

The prior Gate 12.7 preparation named `Retry unresolved submission` as the
candidate one-action recovery. Source inspection and the captured UI state
invalidate that action selection for the current lineage:

- the visible Retry control is an **unknown-outcome Retry**;
- the current hosted Device scope has `pending=0`, `uploading=0`, `failed=2`,
  and `unknown=0`;
- its preflight therefore returns the existing native code
  `unknown-retry-queue-not-isolated`;
- the blocked branch performs no local mutation and no provider request;
- the page refreshes Diagnostics and changes only its compact status text; it
  does not show a blocking dialog or an in-view banner;
- the correct current lineage is the already-proved `failed/notApplied`
  candidate containing Device sequences `1–2`, with `next_sequence=3`.

The latest Retry button press is therefore explained. It is not evidence of a
new SQLite/Neon contradiction, provider rejection, failed database repair, or
HTTP 500.

The displayed `sync-unavailable / provider-evidence-unavailable` result belongs
to an earlier ordinary Sync attempt. Its exact internal failure phase remains
unproved. Null HTTP status/header fields in the current attempt record must not
be interpreted as proof that the earlier Sync never contacted the API, because
the ordinary Sync path does not currently populate those fields. The supplied
Render window proves only that the latest blocked Retry click produced health
requests and no protected Sync request in that window.

Current corrected terminal:

```text
GCM02_12_6_PASS
GCM02_12_7_ACTION_INTERFACE_ALIGNMENT_BLOCKED
CURRENT_UNKNOWN_RETRY_INAPPLICABLE
BOUNDED_FAILED_NOT_APPLIED_RECOVERY_NOT_IMPLEMENTED
PRIOR_SYNC_FAILURE_PHASE_UNRESOLVED
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
REPAIR_UNAUTHORIZED
PROVIDER_MUTATION_UNAUTHORIZED
GCM02_OPEN
```

### Error Protocol purpose

This protocol catalogues only events that are reachable from the inspected
Flutter, API, PostgreSQL, and SQLite composition or are directly required to
explain the accepted Step 12 evidence. It deliberately excludes speculative
external systems and failure modes not represented by the current source.

The protocol has four objectives:

1. prevent an expected, classifiable failure from collapsing into a generic
   `500/service-unavailable`;
2. distinguish a local preflight stop from a request that may have reached the
   provider;
3. preserve whether an operation was blocked, not applied, applied,
   duplicate-equivalent, or left with unknown outcome;
4. make every UI action traceable through one sanitized operation fingerprint
   without exposing tokens, raw account/device IDs, payloads, SQL, or full
   request hashes.

### Code and classification contract

Protocol codes use:

```text
MKS-<LAYER>-<NNN>
```

The protocol code wraps rather than replaces an existing runtime
`resultCode`, `protocolCode`, `errorCode`, or Auth0 state. For example:

```text
protocolCode: MKS-UI-001
nativeCode: unknown-retry-queue-not-isolated
```

Layers:

| Layer | Meaning                                                          |
| ----- | ---------------------------------------------------------------- |
| `UI`  | action selection, preflight presentation, and visible result     |
| `CFG` | compiled configuration, composition, revision, and endpoint      |
| `AUT` | authentication and token acquisition                             |
| `BND` | account, installation, Device, enrollment, and hosted binding    |
| `LDB` | local SQLite access, schema, transaction, and attempt ledger     |
| `REC` | failed/notApplied recovery candidate and requeue                 |
| `QUE` | pending/uploading/unknown queue lease and persistence            |
| `TRN` | HTTP construction, connection, timeout, and response decoding    |
| `API` | API ingress, route, authorization, and request validation        |
| `PDB` | PostgreSQL connection, transaction, privileges, and constraints  |
| `UPL` | submission validation and provider upload application            |
| `DNL` | provider download and local remote-event application             |
| `ACK` | provider acknowledgement                                         |
| `OBS` | observability, correlation, redaction, and diagnostic projection |
| `INV` | invariant violations and partial-application hazards             |

Severity is independent of outcome:

| Severity   | Meaning                                                   |
| ---------- | --------------------------------------------------------- |
| `INFO`     | expected no-op or completed state                         |
| `WARNING`  | safe blocked state requiring review or a different action |
| `ERROR`    | known failure with a proved application boundary          |
| `UNKNOWN`  | provider or persistence outcome cannot be proved          |
| `CRITICAL` | invariant or atomicity violation; freeze mutation         |

Allowed outcomes:

```text
blocked
not-applied
applied
duplicate-equivalent
unknown
completed
```

Evidence relevance:

| Value         | Meaning                                                     |
| ------------- | ----------------------------------------------------------- |
| `CONFIRMED`   | observed and sufficient to explain the named event          |
| `REACHABLE`   | explicit current source branch; not yet observed here       |
| `LATENT`      | source-level ambiguity or defect requiring tightening       |
| `LOW-CURRENT` | reachable, but contradicted or reduced by accepted evidence |
| `FRESHNESS`   | previously accepted; must be rechecked before mutation      |

### Required diagnostic envelope

Every top-level UI action must create one `operationId`; every child HTTP
request must inherit it and add a request ordinal. The persisted and logged
envelope must contain:

| Field                                                           | Rule                                                                                                                        |
| --------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `diagnosticVersion`                                             | schema version, initially `1`                                                                                               |
| `protocolCode`                                                  | stable `MKS-*` code                                                                                                         |
| `nativeCode`                                                    | existing sanitized runtime code, if one exists                                                                              |
| `severity` / `outcome`                                          | values from the contracts above                                                                                             |
| `operationKind`                                                 | `diagnostics`, `unknown-retry`, `failed-recovery`, `sync`, `upload`, `download`, or `acknowledge`                           |
| `phase`                                                         | exact last completed or failed pipeline phase                                                                               |
| `operationFingerprint`                                          | first 12 hex characters of SHA-256 over a random per-action operation ID                                                    |
| `correlationFingerprint`                                        | first 12 hex characters of SHA-256 over the full request correlation ID                                                     |
| `requestOrdinal`                                                | `0` for local preflight; `1..n` for child requests                                                                          |
| `submissionFingerprint`                                         | first 12 hex characters of SHA-256 over submission identity; never the raw ID                                               |
| `requestHashShape`                                              | only `sha256-64-hex-valid` or `invalid`; never the full request hash                                                        |
| `accountScopeFingerprint`                                       | first 12 hex characters of SHA-256 over the normalized account UUID                                                         |
| `deviceScopeFingerprint`                                        | first 12 hex characters of SHA-256 over the normalized Device UUID                                                          |
| `sourceRevision`                                                | deployed/client short Git revision                                                                                          |
| `clientBuild` / `apiBuild`                                      | sanitized build identifiers                                                                                                 |
| `routeClass`                                                    | route template, never a URL containing identifiers                                                                          |
| `queueScope`                                                    | explicitly `account` or `device`                                                                                            |
| `pendingCount`, `uploadingCount`, `failedCount`, `unknownCount` | target scope counts captured at action start                                                                                |
| `memberCount`, `firstSequence`, `lastSequence`, `nextSequence`  | numeric boundary only                                                                                                       |
| `localMutation`                                                 | `none`, `started`, `committed`, `rolled-back`, or `unknown`                                                                 |
| `providerContact`                                               | `not-started`, `request-started`, `headers-received`, `trusted-response`, or `unknown`                                      |
| `providerTransaction`                                           | `not-started`, `committed`, `rolled-back`, or `unknown`                                                                     |
| `httpStatus`                                                    | numeric status when received                                                                                                |
| `headersReceived`                                               | boolean                                                                                                                     |
| `responseTrusted`                                               | boolean after origin, size, JSON, and contract validation                                                                   |
| `elapsedBand`                                                   | bounded band, not precise timing                                                                                            |
| `retryable`                                                     | typed protocol value, never inferred solely from HTTP 500                                                                   |
| `safeAction`                                                    | bounded guidance such as `preserve-local-state`, `sign-in`, `recheck-enrollment`, `inspect-candidate`, or `operator-review` |
| `exceptionClass`                                                | closed sanitized allow-list; no message or stack in UI                                                                      |
| `sqlStateClass`                                                 | allow-listed SQLSTATE class in server logs only                                                                             |

Never persist or display bearer/refresh/ID tokens, authorization codes, raw
account/device/event/submission IDs, payload bodies, personal purchase data,
connection strings, SQL text, complete hashes, raw exception messages, or stack
traces.

### Event parsing and precedence

Events must be reduced in this order:

1. Verify the `diagnosticVersion` and stable protocol code.
2. Join by `operationFingerprint`, then `requestOrdinal`.
3. Prefer a trusted typed provider response over an HTTP status label.
4. Prefer a proved transaction outcome over a transport outcome.
5. If request transmission started but no trusted provider outcome exists,
   classify `unknown`; never automatically requeue as `not-applied`.
6. If local preflight stopped before mutation and request start, classify
   `blocked`.
7. If the provider proves `not-applied`, preserve the failed lineage until a
   separately authorized failed-recovery action.
8. If local result persistence fails after a trusted provider response,
   preserve the provider outcome and emit a separate local-persistence event.
9. A later event may refine an earlier `unknown`, but must not erase it.
10. UI projection must show the current action result separately from the last
    ordinary Sync result.

### A. Present incident and UI selection

| Code         | Event / native signal                                                            | Detection fingerprint                                                                                          | Relevance   | Required disposition                                          |
| ------------ | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | ----------- | ------------------------------------------------------------- |
| `MKS-UI-001` | Unknown Retry blocked by non-isolated queue / `unknown-retry-queue-not-isolated` | Device queue `failed=2`, `unknown=0`; preflight stops before mutation/request                                  | `CONFIRMED` | Visible warning; select no provider action                    |
| `MKS-UI-002` | Blocked preflight is not visibly presented                                       | state changes only in compact page status; no dialog/banner                                                    | `CONFIRMED` | Add persistent in-view warning with code and safe action      |
| `MKS-UI-003` | Wrong recovery action label                                                      | label says unresolved submission although implementation accepts only unknown outcome                          | `CONFIRMED` | Rename to `Retry unknown-outcome submission`                  |
| `MKS-UI-004` | Failed/notApplied action absent                                                  | failed candidate exists but no bounded failed-recovery control exists                                          | `CONFIRMED` | Implement separate preflight and separately authorized action |
| `MKS-UI-005` | Current action result conflated with prior Sync result                           | button preflight result and `Last result: sync-unavailable` occupy different UI state without clear chronology | `CONFIRMED` | Show action name, timestamp/order, and operation fingerprint  |
| `MKS-UI-006` | Action handler exception escapes visible reporting                               | page `_run` and diagnostic refresh/preflight lack a page-level presentation boundary                           | `LATENT`    | Catch, persist, and display sanitized typed failure           |
| `MKS-UI-007` | Account-scoped queue summary interpreted as Device-scoped                        | snapshot totals use Account scope while recovery preflight uses Device scope                                   | `LATENT`    | Label both scopes and fingerprint the target Device           |
| `MKS-UI-008` | Enrolled badge overstates full binding validity                                  | snapshot projects hosted row state; full binding validation happens later in Sync guard                        | `LATENT`    | Display binding-validation state separately                   |

### B. Configuration and composition

| Code          | Event / native signal                                             | Detection fingerprint                                                                | Relevance     | Required disposition                           |
| ------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ------------- | ---------------------------------------------- |
| `MKS-CFG-001` | Unsupported native platform / `platform-unsupported`              | client platform not supported by native Auth surface                                 | `LOW-CURRENT` | Block before sign-in or Sync                   |
| `MKS-CFG-002` | Missing/invalid Auth0 configuration / `configuration-invalid`     | domain, client ID, audience, or callback invalid/missing                             | `LOW-CURRENT` | Block and identify missing configuration class |
| `MKS-CFG-003` | Hosted surface disabled / `configuration-missing`                 | required hosted endpoint/define absent                                               | `LOW-CURRENT` | Block composition; no network attempt          |
| `MKS-CFG-004` | Invalid API origin                                                | endpoint parse, scheme, or allowed-origin validation fails                           | `REACHABLE`   | Emit origin/config code; do not call provider  |
| `MKS-CFG-005` | Binding created after app composition / `hosted-restart-required` | no active hosted binding loaded at startup although enrollment later succeeds        | `REACHABLE`   | Require controlled app restart before Sync     |
| `MKS-CFG-006` | Client/API/repository revision drift                              | client build, API build, and expected branch revision differ                         | `FRESHNESS`   | Stop Gate 12.7 and reconcile revisions         |
| `MKS-CFG-007` | Deployment healthy but wrong source revision                      | `/health/ready` succeeds but advertised API build differs from authorization packet  | `FRESHNESS`   | Treat readiness as insufficient; stop          |
| `MKS-CFG-008` | Constant request correlation source                               | all native closure requests derive from `native-closure` rather than a per-action ID | `LATENT`      | Generate unique correlation per action/request |

### C. Authentication and token acquisition

| Code          | Event / native signal                                                     | Detection fingerprint                                                     | Relevance     | Required disposition                                            |
| ------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------- | --------------------------------------------------------------- |
| `MKS-AUT-001` | Signed out / `signed-out` or `auth-required`                              | no current authenticated state/token                                      | `LOW-CURRENT` | Sign in; no queue mutation                                      |
| `MKS-AUT-002` | Sign-in already running / `signing-in`                                    | concurrent sign-in state                                                  | `REACHABLE`   | Block duplicate action                                          |
| `MKS-AUT-003` | User cancelled sign-in / `sign-in-cancelled`                              | provider flow returns cancellation                                        | `REACHABLE`   | Preserve queue; present informational result                    |
| `MKS-AUT-004` | Provider unavailable / `provider-unavailable`                             | provider launch/discovery unavailable                                     | `REACHABLE`   | Preserve queue; operator/network review                         |
| `MKS-AUT-005` | Callback absent / `callback-not-received`                                 | authorization flow ends without callback                                  | `REACHABLE`   | Preserve queue; no Sync                                         |
| `MKS-AUT-006` | Callback state rejected / `callback-state-rejected`                       | returned state does not match local state                                 | `REACHABLE`   | Security stop; discard callback                                 |
| `MKS-AUT-007` | Code exchange rejected / `authorization-code-exchange-rejected`           | token endpoint rejects code exchange                                      | `REACHABLE`   | Preserve queue; new sign-in required                            |
| `MKS-AUT-008` | Access token missing / `access-token-missing`                             | exchange succeeds without usable access token                             | `REACHABLE`   | Reject credentials; no provider request                         |
| `MKS-AUT-009` | ID token missing / `id-token-missing`                                     | exchange lacks required ID token                                          | `REACHABLE`   | Reject credentials                                              |
| `MKS-AUT-010` | Token confusion rejected / `token-confusion-rejected`                     | token identity/type binding inconsistent                                  | `REACHABLE`   | Security stop                                                   |
| `MKS-AUT-011` | Local token expired / `token-expired`                                     | expiry within configured safety margin                                    | `REACHABLE`   | Sign in again; preserve queue                                   |
| `MKS-AUT-012` | Server token rejected / `token-rejected`                                  | JWT malformed, oversized, wrong issuer/audience/algorithm/key, or expired | `REACHABLE`   | Public code remains sanitized; server log records safe subphase |
| `MKS-AUT-013` | Membership missing / `membership-required`                                | verified principal has no active hosted membership                        | `LOW-CURRENT` | Stop; recheck Auth0/Neon identity                               |
| `MKS-AUT-014` | Account selection ambiguous / `account-selection-required`                | principal maps to multiple/ambiguous account choices                      | `LOW-CURRENT` | Stop; explicit account selection required                       |
| `MKS-AUT-015` | Authentication rejected, unclassified / `authentication-rejected-unknown` | provider error outside known local mapping                                | `REACHABLE`   | Preserve sanitized provider class and operation fingerprint     |

### D. Binding, enrollment, and Device authorization

| Code          | Event / native signal                              | Detection fingerprint                                                          | Relevance     | Required disposition                                |
| ------------- | -------------------------------------------------- | ------------------------------------------------------------------------------ | ------------- | --------------------------------------------------- |
| `MKS-BND-001` | Enrollment required / `device-enrollment-required` | no active enrolled Device for account/installation                             | `LOW-CURRENT` | Stop and query/enroll only under separate authority |
| `MKS-BND-002` | Local hosted binding invalid / `binding-invalid`   | environment alias, UUID, installation, generation, or active-state check fails | `LOW-CURRENT` | Stop; never silently substitute Device              |
| `MKS-BND-003` | Device header missing/malformed                    | protected request lacks valid `x-markei-device-id`                             | `REACHABLE`   | Reject before service execution                     |
| `MKS-BND-004` | Device revoked / `device-revoked`                  | local or hosted enrollment/device is revoked                                   | `LOW-CURRENT` | Stop; preserve local events                         |
| `MKS-BND-005` | Device expired / `device-expired`                  | enrollment/device expiry check fails                                           | `LOW-CURRENT` | Stop; explicit re-enrollment decision               |
| `MKS-BND-006` | Device/account binding mismatch / `wrong-account`  | event, token account, binding account, or Device account differs               | `LOW-CURRENT` | Critical identity stop; no repair mutation          |
| `MKS-BND-007` | Hosted authorization forbidden / `forbidden`       | authenticated principal lacks required operation permission                    | `REACHABLE`   | Stop; inspect policy/membership                     |
| `MKS-BND-008` | Local Device scope differs from authorized target  | queue target fingerprint/rank differs from Gate packet                         | `LOW-CURRENT` | Cancel action and rebuild evidence                  |

### E. Local SQLite and attempt ledger

| Code          | Event / native signal                   | Detection fingerprint                                                              | Relevance     | Required disposition                                               |
| ------------- | --------------------------------------- | ---------------------------------------------------------------------------------- | ------------- | ------------------------------------------------------------------ |
| `MKS-LDB-001` | SQLite open failure                     | database cannot be opened/read                                                     | `LOW-CURRENT` | Stop; preserve file and OS error class                             |
| `MKS-LDB-002` | Integrity/schema failure                | quick check fails or expected table count/schema differs                           | `LOW-CURRENT` | Freeze mutation; copied DB showed healthy expected schema          |
| `MKS-LDB-003` | Local migration/version mismatch        | client expects fields/tables absent from current DB                                | `LOW-CURRENT` | Stop; no ad hoc SQL                                                |
| `MKS-LDB-004` | Diagnostics query failure               | snapshot/preflight query throws or returns invalid shape                           | `REACHABLE`   | Emit typed local-read failure                                      |
| `MKS-LDB-005` | Attempt-begin persistence failure       | attempt row cannot be inserted before action                                       | `REACHABLE`   | Do not start provider contact                                      |
| `MKS-LDB-006` | Attempt-completion persistence failure  | operation finishes but result row cannot be finalized                              | `LATENT`      | Preserve external outcome separately; emit local-persistence error |
| `MKS-LDB-007` | Unknown stored enum/state               | text state cannot be decoded into current enum                                     | `REACHABLE`   | Invariant stop; never collapse to generic unavailable              |
| `MKS-LDB-008` | Local JSON/type/date decode failure     | persisted payload cannot be decoded/cast                                           | `REACHABLE`   | Quarantine candidate by identity fingerprint; no mutation          |
| `MKS-LDB-009` | Local transaction constraint failure    | recovery/lease/apply violates SQLite constraint                                    | `REACHABLE`   | Roll back and report transaction outcome                           |
| `MKS-LDB-010` | Attempt evidence field absent by design | Sync attempt has null correlation/status/header because writer never supplied them | `CONFIRMED`   | Treat as instrumentation gap, not proof of no provider contact     |

### F. Failed/notApplied recovery

| Code          | Event / native signal                                              | Detection fingerprint                                            | Relevance     | Required disposition                                  |
| ------------- | ------------------------------------------------------------------ | ---------------------------------------------------------------- | ------------- | ----------------------------------------------------- |
| `MKS-REC-001` | Recoverable failed lineage available / `failed-recovery-available` | exactly one valid scoped failed/notApplied candidate             | `CONFIRMED`   | Preflight only until Gate 12.7 authorization          |
| `MKS-REC-002` | No recoverable failed lineage / `no-recoverable-failure`           | zero valid failed/notApplied candidates                          | `REACHABLE`   | Informational stop                                    |
| `MKS-REC-003` | Ambiguous failed lineage / `failed-recovery-blocked`               | multiple candidate submissions                                   | `REACHABLE`   | Stop; operator reconciliation                         |
| `MKS-REC-004` | Candidate membership malformed                                     | count, position, contiguity, or event lookup invalid             | `REACHABLE`   | Critical local invariant stop                         |
| `MKS-REC-005` | Candidate state mismatch                                           | member/event not uniformly failed as expected                    | `REACHABLE`   | Stop; capture state-kind set                          |
| `MKS-REC-006` | Candidate contains accepted member                                 | candidate overlaps an accepted event                             | `REACHABLE`   | Stop; never requeue                                   |
| `MKS-REC-007` | Candidate overlaps active submission                               | uploading/unknown submission shares candidate members            | `REACHABLE`   | Stop; resolve active outcome first                    |
| `MKS-REC-008` | Candidate request hash/payload invalid                             | canonical payload or request-hash validation fails               | `LOW-CURRENT` | Stop; SQLite-04 observed valid hash shape/contiguity  |
| `MKS-REC-009` | Candidate Device/account mismatch                                  | candidate scope differs from authorized binding                  | `LOW-CURRENT` | Stop; no cross-scope recovery                         |
| `MKS-REC-010` | Recovery transaction rolled back                                   | supersede/requeue transaction fails before commit                | `REACHABLE`   | Preserve candidate and record rollback                |
| `MKS-REC-011` | Recovery commit result unknown                                     | local process/storage interruption around commit                 | `REACHABLE`   | Reopen diagnostics; do not repeat automatically       |
| `MKS-REC-012` | Mixed pending/failed candidate partial-requeue ambiguity           | recovery sees `alreadyPending` while other members remain failed | `LATENT`      | Tighten to all-or-none candidate state before release |

### G. Queue isolation, lease, and result persistence

| Code          | Event / native signal                                 | Detection fingerprint                                                    | Relevance     | Required disposition                                                 |
| ------------- | ----------------------------------------------------- | ------------------------------------------------------------------------ | ------------- | -------------------------------------------------------------------- |
| `MKS-QUE-001` | Pending and unknown collision / `local-batch-invalid` | target Device has pending and unknown work together                      | `REACHABLE`   | Stop; resolve unknown first                                          |
| `MKS-QUE-002` | Multiple unknown submissions                          | more than one scoped unknown candidate                                   | `REACHABLE`   | Stop; ambiguous provider outcome                                     |
| `MKS-QUE-003` | Unknown candidate malformed                           | membership/hash/state/sequence validation fails                          | `REACHABLE`   | Stop; preserve unknown                                               |
| `MKS-QUE-004` | Unknown Retry eligible / `unknown-retry-eligible`     | exactly one valid unknown candidate and no pending/uploading/failed work | `LOW-CURRENT` | Separate authorization path; current `unknown=0`                     |
| `MKS-QUE-005` | Empty upload lease                                    | no pending events after recovery/preflight                               | `REACHABLE`   | Continue to download only for ordinary Sync; bounded recovery stops  |
| `MKS-QUE-006` | Local event hash/identity invalid                     | canonical event validation fails before lease                            | `LOW-CURRENT` | Stop; current candidate passed SQLite-04 structural checks           |
| `MKS-QUE-007` | Local sequence gap/noncanonical order                 | leased events are not contiguous/canonical                               | `LOW-CURRENT` | Stop before request                                                  |
| `MKS-QUE-008` | Lease transaction failure                             | submission/members/event uploading states not committed atomically       | `REACHABLE`   | Roll back; no network request                                        |
| `MKS-QUE-009` | Uploading state stranded after transport throw        | lease committed, then transport throws before typed result persistence   | `LATENT`      | Persist outcome in `finally`; diagnostics must expose stranded lease |
| `MKS-QUE-010` | Upload result persistence target missing              | scoped submission lookup fails and current writer silently returns       | `LATENT`      | Convert silent return to invariant error                             |
| `MKS-QUE-011` | Provider result persisted as failed                   | trusted `not-applied` response maps events/members to failed             | `REACHABLE`   | Preserve exact provider code and candidate                           |
| `MKS-QUE-012` | Provider result persisted as unknown                  | no trusted response after request start                                  | `REACHABLE`   | Preserve unknown; do not failed-recover                              |

### H. HTTP transport and response contract

| Code          | Event / native signal                                 | Detection fingerprint                                                  | Relevance   | Required disposition                                         |
| ------------- | ----------------------------------------------------- | ---------------------------------------------------------------------- | ----------- | ------------------------------------------------------------ |
| `MKS-TRN-001` | Token source fails during request construction        | authenticated UI state cannot supply a current token                   | `REACHABLE` | No request; return exact token phase                         |
| `MKS-TRN-002` | DNS resolution failure / `dns-failed`                 | connection fails before socket establishment                           | `REACHABLE` | Unknown only if transmission cannot be disproved             |
| `MKS-TRN-003` | TCP/connect failure / `connection-failed`             | client exception before trusted response                               | `REACHABLE` | Preserve request-start boundary                              |
| `MKS-TRN-004` | TLS failure / `tls-failed`                            | certificate/handshake failure                                          | `REACHABLE` | Security/transport stop                                      |
| `MKS-TRN-005` | Timeout before response / `timeout-before-response`   | timeout with no response headers                                       | `REACHABLE` | Upload outcome is `unknown` after request start              |
| `MKS-TRN-006` | Timeout during response / `timeout-during-response`   | headers or partial response observed before timeout                    | `REACHABLE` | Record status/header evidence; outcome may remain unknown    |
| `MKS-TRN-007` | HTTP client exception collapsed to null upload result | `_sendJson` catches `ClientException` without phase detail             | `LATENT`    | Replace null with typed transport result                     |
| `MKS-TRN-008` | Response is not JSON                                  | body parse throws                                                      | `REACHABLE` | Record status/size/content class; do not generic-collapse    |
| `MKS-TRN-009` | JSON contract invalid / `response-contract-invalid`   | decoded body has wrong top-level or field types                        | `REACHABLE` | Treat response untrusted; preserve provider-contact evidence |
| `MKS-TRN-010` | Response exceeds size limit                           | body exceeds 262144-byte bound                                         | `REACHABLE` | Reject safely; record size band                              |
| `MKS-TRN-011` | HTTP status lacks trusted protocol body               | non-success status cannot be mapped from sanitized body                | `REACHABLE` | Preserve status and untrusted-response code                  |
| `MKS-TRN-012` | Redirect/unexpected effective origin                  | request does not terminate at authorized API origin                    | `REACHABLE` | Security stop; do not forward bearer across untrusted origin |
| `MKS-TRN-013` | Download `ClientException` escapes transport mapper   | download path does not use the upload `_sendJson` exception mapping    | `LATENT`    | Use one typed transport boundary for all routes              |
| `MKS-TRN-014` | Different timeout semantics by route                  | upload null-maps timeout while download lets timeout reach coordinator | `LATENT`    | Normalize with route and phase retained                      |

### I. API ingress and authorization

| Code          | Event / native signal                            | Detection fingerprint                                                                                                | Relevance     | Required disposition                                             |
| ------------- | ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------- | ------------- | ---------------------------------------------------------------- |
| `MKS-API-001` | Route absent or revision mismatch / HTTP 404     | protected route not present at deployed revision                                                                     | `FRESHNESS`   | Verify exact revision and route inventory                        |
| `MKS-API-002` | Method/content type rejected                     | wrong method or media type                                                                                           | `REACHABLE`   | Typed 4xx; never generic 500                                     |
| `MKS-API-003` | Request body missing/malformed                   | unvalidated body cast causes type/runtime error                                                                      | `LATENT`      | Add schema validation before transaction                         |
| `MKS-API-004` | Authentication required                          | bearer absent                                                                                                        | `REACHABLE`   | Typed 401 with no service execution                              |
| `MKS-API-005` | JWT rejected                                     | verifier rejects token                                                                                               | `REACHABLE`   | Typed auth failure; sanitized verifier subphase in server log    |
| `MKS-API-006` | Membership/account selection rejected            | principal cannot resolve one active account                                                                          | `LOW-CURRENT` | Typed authorization result                                       |
| `MKS-API-007` | Device header/enrollment rejected                | header or active enrollment invalid                                                                                  | `LOW-CURRENT` | Typed device result                                              |
| `MKS-API-008` | Forbidden operation                              | policy denies authenticated request                                                                                  | `REACHABLE`   | Typed 403                                                        |
| `MKS-API-009` | API database composition absent                  | service starts without usable database composition                                                                   | `LOW-CURRENT` | Existing typed 503; readiness is presently healthy               |
| `MKS-API-010` | Rate limited / `rate-limited`                    | provider or authorization layer rejects request rate                                                                 | `REACHABLE`   | Preserve retry-after class; no immediate automatic Retry         |
| `MKS-API-011` | Request lifecycle stops after `request-received` | no later validation/auth/transaction stage for same correlation                                                      | `REACHABLE`   | Server alert identifies last stage                               |
| `MKS-API-012` | Unexpected exception genericized                 | current error handler emits `500/service-unavailable`, operation `server`, outcome `unknown` for all non-auth errors | `LATENT`      | Retain safe phase-specific internal code and transaction outcome |
| `MKS-API-013` | Health-ready incorrectly treated as Sync proof   | `/health/ready` 200 exists without protected route execution                                                         | `CONFIRMED`   | Treat readiness only as startup/DB readiness evidence            |
| `MKS-API-014` | Correlation ID missing/reused                    | request lacks unique per-action correlation                                                                          | `LATENT`      | Generate/reject according to correlation contract                |

### J. PostgreSQL connection and transaction

| Code          | Event / native signal                      | Detection fingerprint                                            | Relevance     | Required disposition                                             |
| ------------- | ------------------------------------------ | ---------------------------------------------------------------- | ------------- | ---------------------------------------------------------------- |
| `MKS-PDB-001` | Pool connection unavailable                | `pool.connect()` fails before transaction                        | `REACHABLE`   | Typed `db-connect-unavailable`; provider transaction not started |
| `MKS-PDB-002` | Transaction begin/context failure          | `BEGIN`, transaction-local context, or authorization setup fails | `REACHABLE`   | Record rolled-back/not-started exactly                           |
| `MKS-PDB-003` | Serialization retry / SQLSTATE `40001`     | serializable conflict before retry budget expires                | `REACHABLE`   | Internal warning; retry only within bounded DB helper            |
| `MKS-PDB-004` | Deadlock retry / SQLSTATE `40P01`          | deadlock before retry budget expires                             | `REACHABLE`   | Same bounded internal retry                                      |
| `MKS-PDB-005` | Serialization/deadlock retries exhausted   | three attempts or five-second budget exhausted                   | `REACHABLE`   | Typed transient DB failure; outcome/rollback required            |
| `MKS-PDB-006` | Permission/RLS failure                     | runtime role lacks allowed operation or context                  | `LOW-CURRENT` | Typed server configuration failure                               |
| `MKS-PDB-007` | Schema/migration mismatch                  | relation/function/column/readiness contract absent               | `LOW-CURRENT` | Stop deployment; migration 007/readiness previously passed       |
| `MKS-PDB-008` | Constraint/type failure                    | insert/update violates DB constraint or type                     | `REACHABLE`   | Typed invariant/validation class; rollback                       |
| `MKS-PDB-009` | Transaction commit failure                 | commit returns error or connection loss                          | `REACHABLE`   | Provider outcome `unknown` unless DB proves rollback             |
| `MKS-PDB-010` | Rollback failure suppressed                | rollback attempt also fails and current helper suppresses it     | `LATENT`      | Log rollback outcome separately; public response sanitized       |
| `MKS-PDB-011` | Cursor state row missing                   | active account has no `account_sync_state` row                   | `LOW-CURRENT` | Stop; prior Neon baseline proved row and `next_cursor=1`         |
| `MKS-PDB-012` | Readiness passes but request-time DB fails | pool/transaction changes after last readiness check              | `FRESHNESS`   | Fresh baseline required immediately before authorization         |

### K. Upload validation and provider application

| Code          | Event / native signal                                               | Detection fingerprint                                                                                                 | Relevance     | Required disposition                                           |
| ------------- | ------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | ------------- | -------------------------------------------------------------- |
| `MKS-UPL-001` | Submission Device differs from authorized Device / `device-revoked` | request Device and authorized Device mismatch                                                                         | `LOW-CURRENT` | Reject before event writes                                     |
| `MKS-UPL-002` | Submission shape invalid                                            | missing/invalid submission ID, hash, events, sequence, or payload fields                                              | `LATENT`      | Validate complete request before transaction mutation          |
| `MKS-UPL-003` | Existing submission hash differs / `hash-mismatch`                  | same submission ID, different request hash                                                                            | `REACHABLE`   | Reject; preserve original submission                           |
| `MKS-UPL-004` | Event scope differs / `wrong-account`                               | event account/device differs from submission context                                                                  | `LOW-CURRENT` | Reject entire batch atomically                                 |
| `MKS-UPL-005` | Event content hash differs / `hash-mismatch`                        | canonical provider hash check fails                                                                                   | `LOW-CURRENT` | Reject entire batch atomically                                 |
| `MKS-UPL-006` | Provider sequence gap / `sequence-gap`                              | event sequence differs from next expected Device sequence                                                             | `LOW-CURRENT` | Reject not-applied and report expected/observed safely         |
| `MKS-UPL-007` | Provider cursor state unavailable / `service-unavailable`           | cursor row absent while assigning event cursor                                                                        | `LOW-CURRENT` | Roll back; classify DB invariant, not generic service outage   |
| `MKS-UPL-008` | Duplicate event is equivalent                                       | existing event identity/hash/content matches                                                                          | `REACHABLE`   | Return `duplicate-equivalent`; do not duplicate write          |
| `MKS-UPL-009` | Submission applied                                                  | all events and submission committed                                                                                   | `REACHABLE`   | Return trusted `server-accepted` with committed outcome        |
| `MKS-UPL-010` | Stored submission replay                                            | same submission ID/hash already has stored result                                                                     | `REACHABLE`   | Return explicit replay/duplicate semantic                      |
| `MKS-UPL-011` | Request hash not independently recomputed server-side               | server trusts request-level hash except identity collision comparison                                                 | `LATENT`      | Recompute canonical request hash before writes                 |
| `MKS-UPL-012` | Partial-batch commit hazard                                         | service may return a normal `ProtocolFailure` after earlier loop iterations wrote events, allowing transaction commit | `LATENT`      | Validate full batch first or throw rollback-only typed failure |
| `MKS-UPL-013` | Failure lacks event/field/submission context                        | failure contract supports context but service often omits it                                                          | `LATENT`      | Populate sanitized member position/field and fingerprints      |
| `MKS-UPL-014` | Failure retryability/safe action inconsistent                       | cursor-missing/service failure may carry unsafe retry meaning                                                         | `LATENT`      | Derive safe action from outcome and transaction proof          |

### L. Download and local remote-event application

| Code          | Event / native signal                                 | Detection fingerprint                                      | Relevance   | Required disposition                                       |
| ------------- | ----------------------------------------------------- | ---------------------------------------------------------- | ----------- | ---------------------------------------------------------- |
| `MKS-DNL-001` | Provider cursor expired / `cursor-expired`            | requested cursor is outside retained/provider boundary     | `REACHABLE` | Stop; determine recovery snapshot path                     |
| `MKS-DNL-002` | Recovery unavailable / `recovery-unavailable`         | cursor expired and no provider snapshot exists             | `REACHABLE` | Stop; explicit recovery decision                           |
| `MKS-DNL-003` | Full rebootstrap required                             | provider requires full local rebuild                       | `REACHABLE` | Separate destructive authorization                         |
| `MKS-DNL-004` | Local changes block rebootstrap                       | unuploaded local work prevents safe rebuild                | `REACHABLE` | Preserve local work; operator reconciliation               |
| `MKS-DNL-005` | Protocol upgrade required                             | response/event version unsupported                         | `REACHABLE` | Stop and update client                                     |
| `MKS-DNL-006` | Download response shape invalid                       | response/event/cursor fields fail type/contract checks     | `REACHABLE` | Reject page before apply                                   |
| `MKS-DNL-007` | Remote event wrong account/type/version/hash          | remote applier validation fails                            | `REACHABLE` | Local transaction rollback; typed conflict subcode         |
| `MKS-DNL-008` | Remote cursor not contiguous                          | returned cursor sequence skips expected local cursor       | `REACHABLE` | Roll back; preserve page fingerprint                       |
| `MKS-DNL-009` | Duplicate event identity with different hash          | inbox already has identity but different content           | `REACHABLE` | Critical conflict; no overwrite                            |
| `MKS-DNL-010` | Required fact reference absent                        | person/payment reference snapshot unavailable              | `REACHABLE` | Roll back local page                                       |
| `MKS-DNL-011` | Store/product/purchase identity conflict              | remote fact collides with incompatible local identity      | `REACHABLE` | Roll back and name entity class only                       |
| `MKS-DNL-012` | Local fact type/date/constraint failure               | decoded payload cannot be written under schema constraints | `REACHABLE` | Roll back and classify local apply                         |
| `MKS-DNL-013` | Duplicate-only page does not advance local cursor     | duplicate outcome returns without updating sync state      | `LATENT`    | Prove/update cursor advancement for equivalent pages       |
| `MKS-DNL-014` | Local apply committed but later acknowledgement fails | download transaction succeeds before ack failure           | `REACHABLE` | Preserve applied cursor; Retry acknowledgement, not upload |

### M. Acknowledgement

| Code          | Event / native signal                                     | Detection fingerprint                             | Relevance   | Required disposition                                    |
| ------------- | --------------------------------------------------------- | ------------------------------------------------- | ----------- | ------------------------------------------------------- |
| `MKS-ACK-001` | No local cursor to acknowledge                            | local sync state absent after download/apply      | `REACHABLE` | Stop; local invariant                                   |
| `MKS-ACK-002` | Ack cursor exceeds provider high-water / `cursor-expired` | provider rejects impossible/out-of-range cursor   | `REACHABLE` | Stop and reconcile cursors                              |
| `MKS-ACK-003` | Ack transport outcome unknown                             | request started without trusted ack response      | `REACHABLE` | Query/retry same idempotent ack only under typed policy |
| `MKS-ACK-004` | Ack protocol failure                                      | trusted provider failure body returned            | `REACHABLE` | Preserve code/status/correlation                        |
| `MKS-ACK-005` | Ack observability absent from local ledger                | top-level Sync result hides independent ack phase | `LATENT`    | Persist child request/phase record                      |

### N. Cross-cutting observability and invariant controls

| Code          | Event / native signal                                      | Detection fingerprint                                                             | Relevance   | Required disposition                                       |
| ------------- | ---------------------------------------------------------- | --------------------------------------------------------------------------------- | ----------- | ---------------------------------------------------------- |
| `MKS-OBS-001` | Client catch-all / `local-exception-redacted`              | uncaught `Object` becomes `sync-unavailable`, phase `unexpected-terminal`         | `LATENT`    | Retain sanitized exception class and last completed phase  |
| `MKS-OBS-002` | Coordinator state loses native cause                       | many guard/protocol codes map only to `unavailable`                               | `LATENT`    | Keep projected state and diagnostic code separately        |
| `MKS-OBS-003` | API generic 500 collapse                                   | non-auth exception maps to `service-unavailable/server/unknown`                   | `LATENT`    | Typed internal taxonomy; public envelope remains sanitized |
| `MKS-OBS-004` | Sync attempt lacks child request evidence                  | no correlation, status, header, or route fields persisted for upload/download/ack | `LATENT`    | Persist one parent plus child phase events                 |
| `MKS-OBS-005` | Same correlation reused across operations                  | constant `native-closure` correlation source                                      | `LATENT`    | Unique correlation per top-level action                    |
| `MKS-OBS-006` | Render health noise mistaken for operation evidence        | only `/health/ready` entries appear                                               | `CONFIRMED` | Filter logs by operation/correlation and protected route   |
| `MKS-OBS-007` | Provider contact inferred from missing fields              | absent fields are treated as negative evidence although not instrumented          | `CONFIRMED` | Add explicit `providerContact` state                       |
| `MKS-OBS-008` | Sensitive raw exception/log data risk                      | unbounded error messages or payloads could enter UI/logs                          | `REACHABLE` | Closed allow-list and fingerprint-only identifiers         |
| `MKS-INV-001` | Automatic retry after generic 500                          | HTTP status alone drives Retry despite unknown commit outcome                     | `LATENT`    | Prohibit; reconcile same submission identity first         |
| `MKS-INV-002` | Failed recovery before provider proves not-applied         | unknown outcome is requeued as failed                                             | `REACHABLE` | Prohibit state transition                                  |
| `MKS-INV-003` | Second action before first outcome captured                | repeated Retry/Sync changes evidence                                              | `REACHABLE` | One-operation lock and explicit terminal                   |
| `MKS-INV-004` | Provider and local mutations cannot be joined              | missing operation/correlation/submission fingerprints                             | `LATENT`    | Require diagnostic envelope before Gate action             |
| `MKS-INV-005` | Partial local/provider state hidden by final `unavailable` | compound Sync collapses recovery, upload, download, and ack                       | `LATENT`    | Record phase transitions and transaction outcomes          |

### Conditions reduced by accepted Step 12 evidence

These events remain in the catalogue because they are reachable, but they are
not leading explanations for the latest blocked Retry:

| Reduced hypothesis                                      | Accepted evidence                                                                                             |
| ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Corrupt or structurally wrong SQLite database           | copied DB quick check passed and expected table count matched                                                 |
| Wrong hosted Device candidate                           | rank 3 was the enrolled hosted scope and owned exactly the two failed events                                  |
| Unrelated local pending events joining recovery         | simulated hosted-scope first upload contained only sequences `1–2`; six pending events belong to other scopes |
| Unknown-outcome Retry candidate exists                  | hosted scope has `unknown=0`; candidate is failed/notApplied                                                  |
| Same-hash active/superseded submission collision        | SQLite-04 found neither                                                                                       |
| Provider/API wholly offline at captured time            | Render readiness repeatedly returned 200                                                                      |
| Missing migration 007 cursor state at accepted baseline | Neon readiness and cursor baseline previously passed                                                          |
| Authentication absent at the displayed checkpoint       | UI reported authenticated after recent login                                                                  |
| Enrollment absent at the displayed checkpoint           | UI reported Device enrolled and earlier exact binding checks passed                                           |
| Latest button caused a provider 500                     | no protected request followed the locally blocked preflight                                                   |

These are freshness-sensitive rather than permanently excluded:

- deployed revision and route inventory;
- current Auth0 principal/membership;
- current exact account/Device binding;
- current Neon cursor/submission/event baseline;
- request-time PostgreSQL connectivity and transaction behavior;
- token validity at the instant of the authorized operation.

### Ranked diagnosis for the present state

1. **Proved present event:** `MKS-UI-001`. The pressed button selected the
   unknown-outcome Retry path, which correctly blocked on two failed events and
   zero unknown events.
2. **Proved presentation defect:** `MKS-UI-002` and `MKS-UI-005`. The blocked
   result was not made visible enough and the earlier Sync result remained the
   prominent explanation.
3. **Proved action gap:** `MKS-UI-004`. No bounded failed/notApplied recovery
   surface exists; ordinary Sync is the only current code path that invokes
   failed recovery, but it also uploads, downloads, and acknowledges.
4. **Unresolved historical event:** the earlier `sync-unavailable` cannot yet be
   assigned to transport, provider, database, local persistence, or response
   parsing because `MKS-LDB-010`, `MKS-OBS-001`, `MKS-OBS-002`, and
   `MKS-OBS-004` erase the necessary distinctions.
5. **Pre-release source hazards:** `MKS-QUE-009`, `MKS-QUE-010`,
   `MKS-UPL-012`, `MKS-DNL-013`, and `MKS-OBS-003` require explicit tests or
   correction before the controlled Gate 12.7 mutation.

### Required tightening before Gate 12.7 can reopen

The next Codex unit should remain source-only and non-provider:

1. implement the diagnostic envelope and stable code registry as one
   language-neutral source of truth consumed by Dart UI and TypeScript/API
   logging;
2. retain existing native codes and map each to one `MKS-*` protocol code;
3. rename the existing action to `Retry unknown-outcome submission`;
4. display all blocked preflights as persistent in-view banners/dialogs;
5. implement a separate **non-mutating** failed/notApplied preflight showing
   Device-scoped count, sequence range, next sequence, and sanitized candidate
   fingerprint;
6. do not initially attach that preflight to an executing provider action;
7. instrument ordinary Sync and future bounded recovery with parent/child
   phases, unique correlations, provider-contact state, trusted-response state,
   and local/provider transaction outcomes;
8. validate the complete upload batch before any provider write and make every
   later protocol failure roll back the transaction;
9. convert silent local persistence misses and generic catch-alls into typed
   invariant/phase events;
10. add tests proving that blocked actions make no local/provider mutation,
    ambiguous upload outcomes are never automatically requeued, and every
    unexpected server path produces a sanitized phase-specific diagnostic
    rather than an undifferentiated generic 500;
11. render a readable `SYNC_DIAGNOSTICS.md` from the same registry rather than
    maintaining a second hand-written catalogue;
12. return to J with validation evidence before any build/deployment or Gate
    12.7 authorization packet is activated.

No current evidence justifies direct SQLite editing, Neon editing, another
Repair, ordinary Sync, unknown Retry, or provider-side cleanup.

---

## Step 12 Diagnostic Tightening Materialization Reconciliation

Date: 2026-07-26
Round: C10-GCM02-S12-ERR-01
Sequence: FLX-ORD-01 — Ordinary Sequence
Materialization commit:
`ecb0c500f43dd6fd8b614dcec92d06a3c2a79f26`
Parent staging commit:
`02aa7a0a57219faba856a22c73f1cac0ff2d1988`
Branch: `cycle10-intermid-grimoire`
Authority: Main reconciliation under explicit human direction
Evidence classes: repository-proven, source-inspected, Codex-reported
test-validated, independently projection-checked, unavailable in the present
Work host
Disposition: **PARTIAL ACCEPTANCE WITH BOUNDED FOLLOW-UP; NO GATE 12.7
AUTHORIZATION**

### 1. Reconciliation purpose

This entry reconciles the C10-GCM02-S12-ERR-01 source materialization against:

- the active D/E/F packet at `02aa7a0`;
- the append-only `System Diagnosis` catalogue in this J file;
- the materialized source and tests at `ecb0c50`;
- the replacement G/H/I Codex reports;
- the accepted Gate 12.6 state;
- the prohibition against provider mutation before an exact Gate 12.7
  authorization packet and explicit human approval.

This reconciliation does not semantically promote G/H/I into permanent domain
memory. It records the Main conclusion and preserves the materialization
history needed for later functional promotion and Gate 12.7 preparation.

### 2. Repository and publication evidence

The selected GitHub branch was inspected through the connected repository and
then fetched into a detached clean reconciliation worktree.

Confirmed:

```text
REMOTE_BRANCH=cycle10-intermid-grimoire
REMOTE_TIP=ecb0c500f43dd6fd8b614dcec92d06a3c2a79f26
PARENT=02aa7a0a57219faba856a22c73f1cac0ff2d1988
COMMIT_MESSAGE=Tighten Step 12 sync diagnostics
REMOTE_RELATION=ONE_FAST_FORWARD_COMMIT_OVER_D_E_F
```

The commit changes 33 task-relevant files only:

- Flutter Closure, diagnostics, local Sync and migration source;
- focused Flutter Closure, diagnostics, migration and Sync tests;
- the machine registry, schema and README;
- the deterministic generator;
- generated Dart, TypeScript and Markdown projections;
- API Sync/protocol/error source and tests;
- G/H/I Codex evidence reports.

No hosted migration, methodology file, permanent domain-memory file, Main-root
continuity file, D/E/F file or pre-existing J entry was modified by Codex.

### 3. Accepted implementation results

#### 3.1 Single diagnostic catalogue owner

Repository inspection accepts:

```text
MACHINE_OWNER=contracts/shared_beta/diagnostics_v1/diagnostics.registry.json
REGISTRY_VERSION=1
REGISTRY_CODES=159
REGISTRY_UNIQUE_CODES=159
DART_PROJECTION_CODES=159
TYPESCRIPT_PROJECTION_CODES=159
MARKDOWN_PROJECTION_CODES=159
PROJECTION_CODE_SET_DIFFERENCE=0
```

The registry is the only intended hand-maintained list. The Dart, TypeScript
and `documentation/SYNC_DIAGNOSTICS.md` views are generated dependencies.

The present Work host independently parsed all four artifacts and confirmed
identical 159-code sets. `git diff --check 02aa7a0..ecb0c50` also passed.

The generator's own `--check` mode could not be independently rerun in this
Work host because Dart is unavailable here and the generator correctly stops
when it cannot locate Dart. Codex reports successful generation, check mode
and deterministic validation in its implementation environment. Therefore:

```text
CODE_SET_EQUALITY=INDEPENDENTLY_CHECKED_PASS
GENERATOR_DART_DEPENDENT_CHECK=CODEX_REPORTED_PASS
CURRENT_WORK_HOST_RERUN=UNAVAILABLE_NO_DART
```

This is an evidence distinction, not a contradiction.

#### 3.2 Local diagnostic persistence and UI

Source inspection accepts:

- additive Drift schema version 11;
- `sync_attempts` retained as the operation parent;
- additive `sync_diagnostic_events` child-event storage;
- migration-ledger identifier
  `v10-to-v11-sync-diagnostic-events`;
- the visible action label `Retry unknown-outcome submission`;
- the separate `Inspect failed/notApplied recovery` action;
- current-action diagnostic projection with MKS code, meaning, outcome,
  phase, mutation/contact state, safe action and fingerprint;
- visible blocked/error/unknown results;
- a read-only current-Device failed/notApplied candidate inspection;
- no execution callback attached to that inspection.

The read-only inspection explicitly records:

```text
LOCAL_MUTATION=none
PROVIDER_CONTACT=not-started
PROVIDER_TRANSACTION=not-started
RETRYABLE=false
SAFE_ACTION=hold for Gate 12.7 reconciliation
```

This materially corrects the earlier action/interface ambiguity without
executing or authorizing the failed lineage.

#### 3.3 Five named source hazards

Source and test evidence support accepting the five bounded corrections:

| Code | Reconciled implementation result |
| --- | --- |
| `MKS-QUE-009` | A post-lease transport exception is converted to an unknown outcome so the submission identity is preserved instead of remaining an unexplained upload lease. |
| `MKS-QUE-010` | A scoped upload-result persistence miss throws `SyncPersistenceInvariantException` instead of returning silently. |
| `MKS-REC-012` | Candidate inspection/recovery distinguishes all-pending, all-failed and mixed states; mixed states block rather than partially requeue. |
| `MKS-UPL-012` | The complete provider submission is validated before the first write; the later-member failure fixture proves no partial submission/event/cursor/Device-sequence mutation. |
| `MKS-DNL-013` | Equivalent duplicate-only downloads transactionally advance the contiguous local cursor; conflicting duplicates remain failures. |

These corrections are source-implemented and test-validated in the Codex
environment. They are not live-provider validated.

#### 3.4 Validation accepted with evidence limits

G reports the following successful commands:

```text
node scripts/generate_sync_diagnostics.mjs
node scripts/generate_sync_diagnostics.mjs --check
npm run diagnostics:check
flutter pub run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed lib test
flutter analyze
focused Flutter diagnostic/sync/migration/UI tests
flutter test: 183 passed, 4 existing lab-gated skips
npm run format:check
npm run lint
npm run typecheck
npm run build
npm test: 58 passed
git diff --check
credential-pattern scan: no reported assignment match
```

Main accepts these as Codex-reported test evidence. Main independently checked:

- commit ancestry and remote branch position;
- changed-file scope;
- 159 unique registry codes;
- identical registry/Dart/TypeScript/Markdown code sets;
- relevant source ownership and action labels;
- additive v11 table and migration-ledger source;
- absence of an executing failed/notApplied UI callback;
- `git diff --check`.

Main did not repeat Flutter, Dart or complete npm validation in this Work host.
No Windows, Android, Render, Auth0, Neon or end-to-end provider validation
belongs to this materialization claim.

### 4. D/E/F conformance limits

The materialization is not a complete realization of every D/E/F requirement.
The following differences remain material and must not be hidden by the broad
`ERROR_PROTOCOL_SOURCE_IMPLEMENTED` terminal in G:

#### 4.1 Ordinary Sync remains coarsely terminalized

`NativeAuthClosureRunner.hostedSyncProbe()` still catches an unclassified
`Object` and records:

```text
resultCode=sync-unavailable
phase=unexpected-terminal
recoveryCode=local-exception-redacted
```

The new MKS child-event envelope is not yet emitted across every ordinary Sync
phase required by D:

```text
authentication
binding
failed-recovery
upload-lease
upload-transport
upload-provider
upload-result-persistence
download-transport
download-provider
download-local-apply
acknowledgement
terminal
```

The new child-event ledger is materially used for the local failed/notApplied
inspection, but source inspection does not prove complete end-to-end
instrumentation of the existing ordinary Sync coordinator.

#### 4.2 Parent/child correlation remains incomplete

For the local failed/notApplied inspection, the operation fingerprint is also
used as the correlation fingerprint. This is sufficient to group that
network-free local preflight, but it does not implement the staged rule for
distinct full child correlation identities, sanitized child fingerprints and
deterministic request ordinals across every future HTTP child request.

The persisted envelope also does not yet carry every field listed in the full
D/F target, including a persisted diagnostic version and all source/build,
route, submission and request-hash projections.

#### 4.3 Public/internal API diagnostic separation needs one more tightening

The API catch-all now avoids generic retry permission and returns
`retryable=false`, which is accepted.

However, it presently returns `correlationId` and
`sanitizedExceptionClass` in the public 500 body. D/F requested a safe
correlation fingerprint publicly while retaining exception class and richer
failure detail internally. The current implementation therefore improves the
500 result but does not fully satisfy the public/internal projection boundary.

The helper used for ordinary protocol failures also assigns
`MKS-UPL-012` broadly. Future tightening must map the actual operation/boundary
instead of treating the partial-upload hazard code as a generic failure code.

#### 4.4 Registry presence is broader than runtime emission coverage

The 159-code registry and generated explanation surfaces exist, but source
inspection does not prove that every reachable detector currently emits its
corresponding MKS code at its pathogenic boundary. The catalogue is callable
from Dart and TypeScript; full source-adjacent emission remains incremental
work.

### 5. PRC-01 classification

| Claim | Classification | Main disposition |
| --- | --- | --- |
| Remote tip and ancestry | repository-proven | accepted |
| 159-code registry and equal projections | repository-proven and independently checked | accepted |
| Deterministic generator/check | Codex-reported test-validated; present host unavailable | accepted with evidence qualifier |
| Drift v11 additive diagnostic ledger | repository-proven; Codex test-validated | accepted locally |
| Visible renamed Retry and read-only failed inspection | repository-proven and test-validated | accepted |
| Failed/notApplied execution absent | repository-proven | accepted |
| Five named source-hazard corrections | source-inspected and Codex test-validated | accepted locally |
| Complete ordinary Sync phase instrumentation | not proved by source | deferred corrective follow-up |
| Complete parent/child correlation design | partially implemented | deferred corrective follow-up |
| Public/internal API diagnostic separation | partially implemented | deferred corrective follow-up |
| Live provider behavior | unavailable and intentionally unperformed | not accepted |
| Gate 12.7 readiness | not yet established | held |
| GCM02 closure | not established | open |

### 6. Main reconciliation conclusion

The round achieved the decisive structural objective:

```text
ERROR_CATALOGUE_SINGLE_OWNER_IMPLEMENTED
ERROR_CATALOGUE_PROJECTIONS_ALIGNED
ERROR_DOCUMENTATION_GENERATED
DIAGNOSTIC_LEDGER_V11_IMPLEMENTED
CURRENT_ACTION_DIAGNOSTICS_VISIBLE
UNKNOWN_RETRY_SEMANTICS_VISIBLE
FAILED_NOT_APPLIED_INSPECTION_READ_ONLY
FIVE_NAMED_SOURCE_HAZARDS_LOCALLY_CORRECTED
GENERIC_500_AUTORETRY_REJECTED
```

It did not complete:

```text
ORDINARY_SYNC_ALL_PHASE_MKS_EMISSION
FULL_CHILD_REQUEST_CORRELATION
FULL_DIAGNOSTIC_ENVELOPE_PROJECTION
PUBLIC_FINGERPRINT_INTERNAL_EXCEPTION_SPLIT
EVERY_REGISTRY_CODE_SOURCE_BOUNDARY_EMISSION
WINDOWS_CORRECTED_CLIENT_BUILD
FRESH_USER_DATABASE_READ_ONLY_INSPECTION
GATE_12_7_AUTHORIZATION_PACKET
CONTROLLED_PROVIDER_OPERATION
POST_OPERATION_CONVERGENCE
```

The correct materialization classification is:

```text
C10_GCM02_S12_ERR_01=PARTIAL_ACCEPT_WITH_FOLLOW_UP
SOURCE_STRUCTURE=IMPLEMENTED
NAMED_HAZARD_FIXES=LOCALLY_TEST_VALIDATED
DIAGNOSTIC_RUNTIME_COVERAGE=PARTIAL
HOST_PROVIDER_VALIDATION=NOT_PERFORMED
```

### 7. Legacy and forward disposition

This reconciliation belongs in `Legacy_Progress` because it records:

- the exact published materialization commit and its parent;
- the transformation of the J error catalogue into runtime-owned artifacts;
- the evidence boundary between Codex validation and Main independent checks;
- the accepted five-hazard correction;
- the residual D/E/F conformance gap;
- the reason Gate 12.7 remains held.

The 159-row `System Diagnosis` catalogue remains historical provenance. It
must not be manually maintained as a second runtime registry after this point.
Future code/meaning changes begin in
`contracts/shared_beta/diagnostics_v1/diagnostics.registry.json`, regenerate
Dart/TypeScript/Markdown, and then return to J as reconciliation evidence.

The next source unit should be bounded to the four conformance gaps above,
followed by:

1. a corrected Windows client build;
2. the read-only failed/notApplied inspection only;
3. cancellation without local mutation or provider contact;
4. fresh sanitized Gate 12.7 baselines;
5. an exact authorization packet;
6. one controlled action only after explicit human approval;
7. correlated post-operation client, server and provider comparison.

The pre-existing Gate 12.7 rule remains authoritative:

```text
ANYTHING_OTHER_THAN_EXPLICIT_APPROVAL=NO_AUTHORIZATION
NO_SECOND_ACTION_AFTER_AN_AMBIGUOUS_RESULT
```

### 8. Terminal state

```text
GATE_12_6=PASS
C10_GCM02_S12_ERR_01=PARTIAL_ACCEPT_WITH_FOLLOW_UP
DIAGNOSTIC_REGISTRY_SINGLE_OWNER=PASS
DIAGNOSTIC_PROJECTION_CODE_SET=PASS
FAILED_NOT_APPLIED_PREFLIGHT=IMPLEMENTED_READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
FIVE_NAMED_SOURCE_HAZARDS=LOCALLY_TEST_VALIDATED
ORDINARY_SYNC_PHASE_DIAGNOSTICS=PARTIAL
PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD_FOR_CORRECTIVE_RECONCILIATION
GCM02=OPEN
```

---

## C10-GCM02-S12-ERR-02 — post-Codex source and host reconciliation

Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Main Chat [M]
Round or unit: C10-GCM02-S12-ERR-02-HOST-HANDOFF
Branch: `cycle10-intermid-grimoire`
Baseline / inspected HEAD: `17e37eb8b83eb77e56c6421e09cb5ad768dbbfd4`
Authority: human-directed G/H/I reconciliation and next-step preparation
Writable surfaces: `[M]_STAGE/J_MAIN_STAGE.md` only
Evidence boundary: repository inspection at `17e37eb`; Codex G/H/I evidence at
`512f690`; human-reported Windows/Android observations; no provider mutation,
failed/notApplied execution, Render deployment, live Sync, Retry, Repair, or
Enroll

### 1. Repository sequence recovered

The remote branch contains the complete corrective sequence:

```text
0636c54  Main reconciliation and six-gap decision
d56c3a6  active D/E/F implementation packet
512f690  Codex source materialization and replacement G/H/I
baaccfa  Android AVD startup automation
17e37eb  local Android AVD coordinate alignment
```

The C10-GCM02-S12-ERR-02 D/E/F packet was active and bounded. Codex
materialized the six requested conformance corrections and replaced G/H/I.
No further source-conformance unit is required before the Windows host
validation and read-only failed/notApplied inspection.

### 2. PRC-01 claim reconciliation

Claim: ordinary Sync now records the complete required phase evidence.

Prior state: partial; authentication and terminal summaries existed, but the
ordinary Sync path lacked full child-phase evidence.

Evidence: `G_OPS_CODEX.md` records the tested order authentication, binding,
failed-recovery, upload lease/transport/provider/result-persistence, download
transport/provider/local-apply, acknowledgement, and terminal.

Evidence boundary: repository-proven and locally test-validated by Codex;
Windows/provider end-to-end execution was not part of that validation.

Contradiction: none remaining at source-conformance level.

Semantic owner: Operational domain.

Target role: accepted implemented and locally validated source behavior.

Resulting state: `ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED`.

History disposition: the earlier partial state remains historical provenance.

Claim: one ordinary Sync owns a top-level operation identity with deterministic
child correlation identities and ordinals.

Prior state: parent/child semantics were requested but incomplete.

Evidence: G/H/I and the source at `512f690` record one random top-level
operation identity, deterministic child ordinals, scoped child correlation IDs,
and persisted terminal causal summaries.

Evidence boundary: repository-proven and locally test-validated.

Contradiction: none remaining.

Semantic owner: Design domain.

Target role: accepted implemented relationship boundary.

Resulting state: `PARENT_CHILD_CORRELATION=IMPLEMENTED`.

History disposition: prior incomplete correlation is superseded, not erased.

Claim: diagnostic persistence, public projection, and UI causal meaning now
conform to the approved v1 diagnostic model.

Prior state: the runtime registry existed, but schema envelope, API
public/internal separation, reachable-code attribution, and causal UI meaning
remained incomplete.

Evidence: Drift schema v12 and migration ledger
`v11-to-v12-diagnostic-envelope-v1`; shared typed diagnostic projections;
fingerprinted public failures without internal exception/SQL/raw-identifier
material; narrower reachable MKS attribution; trusted-response and
result-persistence UI state; recent child timeline.

Evidence boundary: repository-proven and locally test-validated. Migration 007
was already applied in the earlier provider sequence and is not to be rerun;
this reconciliation authorizes no migration.

Contradiction: none remaining at source-conformance level.

Semantic owner: Operational, Didactic, and Design domains by their respective
perspectives.

Target role: accepted implementation evidence pending later permanent-domain
promotion.

Resulting state:

```text
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED
REACHABLE_MKS_ATTRIBUTION=VALIDATED
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
```

History disposition: G/H/I remain observational evidence; this J entry is the
Main reconciliation cache.

Claim: the failed/notApplied interface is now sufficient for the next
investigative inner-step.

Prior state: the UI exposed unknown-outcome Retry but lacked a bounded
failed/notApplied preflight.

Evidence: the Closure UI exposes `Inspect failed/notApplied recovery`; its
query is local, read-only, network-free, and distinct from unknown-outcome
Retry. No failed/notApplied execution callback exists.

Evidence boundary: repository-proven and locally test-validated; the human
Windows inspection has not yet been returned at this baseline.

Contradiction: none at source level.

Semantic owner: Gate 12.7 authorization preparation.

Target role: accepted read-only preflight; mutation remains absent and
unauthorized.

Resulting state:

```text
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
```

History disposition: the earlier action-interface block is superseded by the
implemented preflight, while the no-execution boundary remains active.

### 3. Validation reconciliation

Codex validation at `512f690`:

```text
FLUTTER_ANALYZE=PASS
FLUTTER_TEST=184_PASS_4_LAB_GATED_SKIP
API_FORMAT_LINT_TYPECHECK_BUILD=PASS
API_TEST=58_PASS
DIAGNOSTIC_GENERATION_CHECK=PASS
```

The user subsequently proved the Android development environment, AVD boot,
Markei installation, and visible application launcher on the Android virtual
device. This is accepted as human-observed Android build/install/run
conformance for the present Cycle 10 platform boundary.

The same trial exposed a narrow PowerShell 5.1 post-boot selection defect in
`GS-FLUTTER-AND`: after the correct AVD became available, the parsed Flutter
device inventory could yield `windows` as `$AndroidDeviceId`, causing
`adb -s windows`. This does not retract the human-observed Android
build/install/run result and does not block Gate 12.7, whose controlled client
is Windows. It remains a bounded operational follow-up for later correction.

No new application refactor or D/E/F implementation packet is activated by
this reconciliation. If the generic launcher must later provide an entirely
clean automated Android result, Main should stage a separate narrow
PowerShell-procedure correction with its own Windows PowerShell 5.1 regression
evidence. It must not be mixed into Gate 12.7 preparation.

Fresh Windows Closure validation from the current remote source remains
required. Earlier Windows success proves the host/toolchain baseline but does
not replace a build/run of the C10-GCM02-S12-ERR-02 materialization.

### 4. Exact next investigative inner-steps

#### Inner-step 4 — align and prove the Windows checkout

From the Windows repository:

```powershell
git switch cycle10-intermid-grimoire
git pull --ff-only origin cycle10-intermid-grimoire
git status --short
git rev-parse HEAD
git merge-base --is-ancestor 512f6903535ce53f325660850709ac4bb254a0dc HEAD
```

Required:

```text
HEAD=17e37eb8b83eb77e56c6421e09cb5ad768dbbfd4_OR_DESCENDANT
WORKTREE=CLEAN
512f690=ANCESTOR
```

Stop on divergence, merge conflict, dirty overlap, or failed ancestry.

#### Inner-step 5 — build and open the current Windows Closure client

Run the canonical command:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
    -File ".\documentation\NEON_CHECK.ps1" `
    -Procedure "GS-FLUTTER-WIN"
```

Required evidence:

```text
FLUTTER_ANALYZE=PASS
FLUTTER_TEST=PASS
WINDOWS_RELEASE_BUILD=PASS
AUTH0FLUTTER_PROTOCOL_REGISTRATION=PASS
FRESH_WINDOWS_CLOSURE_CLIENT=OPEN
CLOSURE_DESTINATION=VISIBLE
```

Do not select Enroll, Query, Sync, Retry, Repair, or Clear diagnostic history.

#### Inner-step 6 — perform only the read-only candidate inspection

Inside the freshly built Windows Closure client:

1. Open `Closure`.
2. Select only `Inspect failed/notApplied recovery`.
3. Record only the sanitized fields displayed by the preflight:
   eligibility/result state, diagnostic code and native code, operation and
   correlation fingerprints, failed/notApplied candidate count, pending-event
   count, sequence range, event count, retryability, and safe action.
4. Do not select `Retry unknown-outcome submission`.
5. Do not select Sync, Enroll, Query, Repair, or Clear diagnostic history.
6. If any confirmation or execution control appears, choose Cancel/close and
   stop.

This inner-step must perform no provider contact and no local mutation beyond
the diagnostic observation written by the read-only inspection path itself.
It is not Gate 12.7 authorization and is not the controlled recovery.

#### Inner-step 7 — return the sanitized preflight evidence

Return:

```text
INSPECTION_ACTION=Inspect failed/notApplied recovery
ELIGIBLE=<sanitized displayed value>
DIAGNOSTIC_CODE=<sanitized displayed value>
NATIVE_CODE=<sanitized displayed value>
OPERATION_FINGERPRINT=<bounded fingerprint only>
CORRELATION_FINGERPRINT=<bounded fingerprint only>
FAILED_NOT_APPLIED_CANDIDATE_COUNT=<count>
PENDING_EVENT_COUNT=<count>
SEQUENCE_RANGE=<bounded range>
EVENT_COUNT=<count>
RETRYABLE=<boolean>
SAFE_ACTION=<sanitized displayed value>
PROVIDER_CONTACT=NO
FAILED_NOT_APPLIED_EXECUTION=NO
CANCELLED_WITHOUT_MUTATION=YES
```

Do not return tokens, connection strings, complete UUIDs, complete hashes,
payloads, purchase content, private paths, or provider secrets.

#### Inner-step 8 — prepare, but do not execute, Gate 12.7

Main reconciles the returned preflight with fresh Git/Windows, Render health,
Auth0 metadata, and Neon/provider baseline evidence. Only then may Main present
one exact Gate 12.7 authorization packet containing the eligible transition,
expected HTTP operations, evidence-capture order, stop classifications, and
the no-second-action rule.

Anything other than explicit human approval of that exact packet is no
authorization. Steps 12.8–12.10 remain held. No recovery execution or provider
contact is authorized by this J entry.

### 5. Terminal state

```text
C10_GCM02_S12_ERR_02=SOURCE_ACCEPTED
SIX_CORRECTIVE_GAPS=PASS
ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED
PARENT_CHILD_CORRELATION=IMPLEMENTED
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED
REACHABLE_MKS_ATTRIBUTION=VALIDATED
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
ANDROID_BUILD_INSTALL_RUN=HUMAN_OBSERVED_PASS
GS_FLUTTER_AND_POST_BOOT_SELECTION=DEFERRED_NARROW_FOLLOW_UP
WINDOWS_CURRENT_SOURCE_BUILD_RUN=PENDING
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD
GCM02=OPEN
```

---

## cycle 10 - guideline

> Date: 2026-07-26
> Sequence: FLX-PRM-04 — Promotion/Reconciliation
> Role: Main Chat [M]
> Branch: `cycle10-intermid-grimoire`
> Reconciled remote baseline: `71bb73f88e88f3b94dd78fb5131bd6262ae7321f`
> Authority: human-requested navigation reconciliation
> Scope: Cycle 10 remaining work, GCM-02 conclusion, provisional GCM-03/GCM-04
> organisation, and closure route
> Materialization effect: J append only; no D/E/F activation, source change,
> provider action, Sync, Retry, Repair, Enroll, recovery execution, or semantic
> promotion

### 1. Navigation grammar

The following hierarchy is a provisional Cycle 10 navigation grammar. It
organises existing work; it does not amend canonical methodology or silently
activate an implementation unit.

```text
Cycle
└─ GCM / MCG phase
   ├─ Sprint — bounded implementation or investigation package
   └─ Gate — mandatory evidence, decision, or authorization boundary
      └─ Gate/Sprint subphase — investigate, stage, materialize, validate,
         authorize, execute, or reconcile
         └─ Step — one concrete human or agent action
```

`GCM` is retained as the current conversation/J spelling. Older operational
artifacts may use `MCG` for the same phase level. A Gate controls mandatory
ordering and authority. A Sprint packages major work. Neither is automatically
inside the other; their order is declared by the active GCM plan.

### 2. Documentary state-of-union

The most current recovery surfaces are:

1. the mutable Cycle 10 prefix and newest append-only entries in
   `[M]_STAGE/J_MAIN_STAGE.md`;
2. current D/E/F when an implementation unit is explicitly active;
3. the newest G/H/I materialization evidence;
4. targeted source or provider evidence only for unresolved claims.

Current remote G/H/I at the Step 12 diagnostic materialization establish:

```text
ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED
PARENT_CHILD_CORRELATION=IMPLEMENTED
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED
REACHABLE_MKS_ATTRIBUTION=VALIDATED
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
PROVIDER_ACTION=NOT_PERFORMED
GCM02=OPEN
```

The repository also contains older state-of-union surfaces that have not kept
pace with this sequence:

- `00_PROJECT_STATE.md` remains a Cycle 09 closure checkpoint;
- `06_SESSION_SCHEME.md` remains the pre-activation Cycle 10 plan;
- permanent domain checkpoints and `operational/04_TODO.md` retain earlier
  C10-S03A corrective-stop language;
- `CYCLE_10_GCMS_STEP_SEQUENCE.md` preserves the earlier broad MCG-02 Gates
  0–11 provider-proof scaffold and older branch/baseline references.

These files remain useful provenance and closure debt. They must not rewind the
active Step 12 state. Their reconciliation and refresh are mandatory before
Cycle 10 closure.

```text
DOCUMENTARY_DRIFT=CONFIRMED
ACTIVE_RECOVERY_SURFACE=J_PLUS_NEWEST_GHI
PERMANENT_PROMOTION=PENDING
MAIN_ROOT_REFRESH=PENDING
```

### 3. Cycle 10 expectations

Cycle 10 is now a hosted synchronization, recovery, and operational acceptance
cycle built on the earlier local reliability work. Its successful terminal
requires all of the following:

1. preserve the offline-first/local-authoritative application boundary;
2. obtain a trustworthy GCM-02 hosted recovery/synchronization terminal with
   correlated client, server, and provider evidence;
3. define and complete one bounded GCM-03 from the actual GCM-02 residuals;
4. define and complete one bounded GCM-04 from the actual GCM-03 residuals;
5. reconcile source, G/H/I, human evidence, domain memory, and Main continuity;
6. promote accepted Operational, Didactic, and Design claims through
   FLX-PRM-04;
7. refresh the stale Main-root and domain checkpoint surfaces;
8. inventory migrations, schema/protocol versions, provider resources,
   development/production distinctions, rollback boundaries, and deferrals;
9. pass repository, secret, generated-artifact, and final platform hygiene;
10. establish a clean, explicit Cycle 11 baseline.

Cycle 11 UI/UX convergence and basic Analytics remain separate and cannot be
used to bypass Cycle 10 closure.

### 4. Phase organisation

#### GCM-01 — development provider foundation

State: accepted within its sanitized development boundary.

Its accepted meaning includes the isolated Neon development foundation,
separate migrator/runtime roles, TLS/channel binding, least-privilege checks,
provider metadata/readiness preparation, and related development evidence.
It does not prove production acceptance.

```text
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
PRODUCTION_ACCEPTANCE=ABSENT
```

#### GCM-02 — hosted synchronization and exact recovery proof

State: active and open.

Completed Sprint/evidence packages include the local convergence foundation,
retention/rebootstrap foundation, hosted-auth/device foundation and corrections,
GRIMOIRE human-operation procedures, Gate 12.6 copied-database/device-scoped
classification, and the Step 12 diagnostic-runtime completion represented by
the current G/H/I.

The active mandatory Gate sequence is:

| Gate | Purpose | Current state |
| --- | --- | --- |
| 12.1 | Render/API readiness | pass at inspected evidence |
| 12.2 | Auth0 metadata/contract | pass at inspected evidence |
| 12.3 | client/deployment alignment | pass at inspected checkpoint; refresh before action |
| 12.4 | exact Account/Device binding | pass at inspected evidence; refresh before action |
| 12.5 | provider pre-operation baseline | pass at inspected evidence; refresh before action |
| 12.6 | copied-database and Device-scoped candidate correlation | pass |
| pre-12.7 | fresh Windows build plus read-only failed/notApplied preflight | active next boundary |
| 12.7 | exact one-action authorization and controlled action | held |
| 12.8 | correlated post-action client/server evidence capture | held |
| 12.9 | fresh provider baseline and allowlisted comparison | held |
| 12.10 | terminal classification and Main reconciliation | held |

The accepted Gate 12.6 candidate is a failed/notApplied hosted-scope lineage
containing exactly two contiguous events at Device sequences 1–2, with no other
pending event in that hosted scope. The six other pending events belong to
non-hosted scopes. Ordinary Sync is therefore not an acceptable substitute.

### 5. Current restart point — pre-12.7

The human has reported the Windows checkout pulled, established, and clean.
Treat repository alignment as human-observed and require the build output to
carry the tested HEAD before accepting it as host evidence.

Proceed in this order:

#### Subphase A — fresh Windows host proof

1. Run the current canonical `GS-FLUTTER-WIN` procedure through the dispatcher
   named by the checked-out GRM documentation.
2. Require Flutter analysis, the full Flutter tests, Windows Release build,
   Auth0Flutter protocol registration, application launch, and visible Closure
   destination.
3. Do not select Enroll, Query, Sync, Retry, Repair, or Clear diagnostics.
4. Stop on build, launch, configuration, authentication-surface, or Closure
   initialization failure.

#### Subphase B — read-only candidate inspection

1. Open `Closure`.
2. Select only `Inspect failed/notApplied recovery`.
3. Capture only the sanitized displayed classification, MKS/native codes,
   bounded operation/correlation fingerprints, candidate count, pending count,
   sequence range, event count, retryability, and safe action.
4. Cancel/close if any mutation or confirmation control appears.
5. Do not select `Retry unknown-outcome submission`, ordinary Sync, Enroll,
   Query, Repair, or Clear diagnostics.

Required terminal:

```text
PROVIDER_CONTACT=NO
FAILED_NOT_APPLIED_EXECUTION=NO
ORDINARY_SYNC=NO
CANCELLED_WITHOUT_MUTATION=YES
```

#### Subphase C — Main reconciliation and implementation decision

Reconcile the read-only preflight against Gate 12.6 and the fresh Windows/Git
evidence.

- If the candidate is absent, ambiguous, differently classified, differently
  scoped, or has different counts/ranges/fingerprints, stop. Keep GCM-02 open
  and stage only the narrow diagnosis/correction justified by the evidence.
- If the candidate matches and is eligible, do not execute it yet. Current
  source evidence states `FAILED_NOT_APPLIED_EXECUTION=ABSENT`.
- If execution remains absent, Main must prepare one narrow synchronized D/E/F
  packet for the failed/notApplied controlled-action surface and its safety
  guards. Codex then materializes and validates it and returns new G/H/I.
- Main reconciles that new evidence before Gate 12.7 can be presented.

Therefore:

```text
NEW_DEF_BEFORE_WINDOWS_PREFLIGHT=NO
NEW_DEF_BEFORE_CONTROLLED_FAILED_NOT_APPLIED_EXECUTION=CONDITIONAL_YES
CONDITION=ELIGIBLE_PREFLIGHT_AND_EXECUTION_STILL_ABSENT
```

This resolves the earlier J ambiguity: a prepared authorization concept is not
an executable recovery capability.

#### Subphase D — Gate 12.7 exact authorization

Only after current-source conformance, fresh Git/Windows/Render/Auth0/Device/
provider-baseline evidence, and a matching candidate may Main present one exact
authorization packet.

The packet must name:

- the accepted 12.1–12.6 state and tested revisions;
- the sanitized candidate fingerprint;
- target Device scope, sequence range 1–2, and event count 2;
- the exact coordinator/action boundary;
- expected HTTP operations;
- the one accepted provider transition;
- duplicate-equivalent, rejected/notApplied, unknown, and unexpected rules;
- evidence-capture order;
- immediate stop conditions;
- the no-second-action rule.

Only explicit human approval of that complete packet authorizes exactly one
controlled action. It does not authorize ordinary Sync, a second action,
Enroll, Repair, provider-console mutation, database editing, or cleanup.

#### Subphase E — Gates 12.8–12.10

After an explicitly authorized one-action Gate 12.7 trial:

1. Gate 12.8 captures the sanitized client terminal, server lifecycle
   correlation, timestamps, and local post-state without issuing a second
   action.
2. Gate 12.9 runs the fresh approved provider/Neon comparison and compares only
   allowlisted counts, sequence/cursor/acknowledgement measures, and lifecycle
   state.
3. Gate 12.10 classifies the result as exactly one of:
   expected success, duplicate-equivalent, rejected/notApplied, unknown, or
   unexpected mutation.

GCM-02 closes only when the terminal is trustworthy across client
classification, server lifecycle logs, and provider state. Unknown,
out-of-allowlist, or contradictory evidence keeps GCM-02 open and activates
only a narrow diagnostic correction. Do not issue another Sync or retry.

### 6. GCM-03 provisional organisation

GCM-03 is undefined and inactive until GCM-02 reconciles.

Current planning candidate:

```text
bounded second-Device hosted convergence and acknowledgement proof
```

After GCM-02 closure, Main must:

1. inventory the actual remaining gaps;
2. choose one narrow GCM-03 objective and explicit non-goals;
3. request A/B/C investigation when alternatives remain;
4. reconcile J and issue synchronized D/E/F;
5. run bounded implementation and/or human proof;
6. receive and reconcile G/H/I;
7. promote accepted evidence or retain a named blocker.

Production deployment, broad retention/rebootstrap acceptance, backup/PITR,
credential lifecycle, and Cycle 11 UI/UX are not silently absorbed.

### 7. GCM-04 provisional organisation

GCM-04 is undefined and inactive until GCM-03 reconciles.

Candidate families, not authority:

- authorization, revocation, and credential lifecycle;
- outage, recovery, and retention acceptance;
- reproducible deployment/release operational boundary;
- provider cleanup, rollback, and final cross-platform acceptance.

Main repeats the GCM-03 definition/staging/materialization/reconciliation route
and must split the work if one terminal unit would otherwise become too broad.

### 8. Cycle 10 closure work after GCM-04

The closure sequence is:

1. reconcile the final GCM terminal in J;
2. run Operational, Didactic, and Design FLX-PRM-04 promotion;
3. refresh each permanent domain checkpoint and derived TODO surface;
4. refresh `00_PROJECT_STATE.md`, append `05_SESSION_LOG.md`, and refresh
   `06_SESSION_SCHEME.md`;
5. reconcile or retire stale planning surfaces without deleting provenance,
   including the older `CYCLE_10_GCMS_STEP_SEQUENCE.md` scaffold;
6. preserve J `Legacy_Progress` while keeping one compact current recovery
   pointer;
7. inventory migrations, Drift/PostgreSQL schemas, protocol and diagnostic
   versions, provider resources, credentials/rotation boundaries, and deferred
   production work;
8. run final Flutter/API tests, Windows validation, the accepted Android
   boundary, generated-document checks, `git diff --check`, and a secret/
   artifact hygiene scan;
9. resolve branch/local/remote continuity and require a clean terminal
   worktree;
10. declare the Cycle 10 terminal and establish the Cycle 11 entry baseline.

### 9. Immediate terminal

```text
CYCLE10=OPEN
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
GCM02=OPEN_ACTIVE
GCM02_12_6=PASS
WINDOWS_CURRENT_SOURCE_BUILD_RUN=PENDING
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY_PENDING_HUMAN_RUN
FAILED_NOT_APPLIED_EXECUTION=ABSENT
GATE_12_7=HELD
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
PERMANENT_DOMAIN_PROMOTION=PENDING
MAIN_ROOT_REFRESH=PENDING
PROVIDER_ACTION=NOT_PERFORMED
ORDINARY_SYNC=NOT_AUTHORIZED
CONTROLLED_RECOVERY=NOT_AUTHORIZED
```

---

## 2026-07-26 — Gate 12.7 read-only inspection reconciliation and REC-01 staging

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Main Chat [M]
Branch: `cycle10-intermid-grimoire`
Reconciled repository baseline:
`76540c45702b027d56b52fea05a8025f14496cdf`
Evidence: five sanitized human-supplied Windows Closure screenshots plus
targeted inspection of the current J, G/H/I, diagnostic registry, Closure
runner/page, local diagnostic query, local recovery repository and ordinary
Sync coordinator
Disposition: **READ-ONLY PREFLIGHT PASS; NARROW D/E/F ACTIVATED; GATE 12.7
EXECUTION STILL HELD**

### 1. Scope and authority

This entry is appended under `Legacy_Progress` and does not rewrite any prior
entry. It reconciles only the human execution of:

```text
Inspect failed/notApplied recovery
```

No screenshot or source evidence establishes that the new controlled
failed/notApplied recovery-and-upload action exists. No recovery, provider
request, ordinary Sync, enrollment, repair, cleanup, database edit, or second
action is accepted as performed.

The human reported that the prescribed sequence was followed. The screenshots
prove a fresh Windows Closure application was running and that the inspection
completed. They do not contain the terminal output needed to independently
accept every analysis/test/build subcommand. Retain that distinction:

```text
WINDOWS_CLOSURE_RUN=HUMAN_OBSERVED_PASS
WINDOWS_FULL_BUILD_LOG=NOT_PRESENT_IN_SCREENSHOT_EVIDENCE
```

### 2. Before-inspection observations

The first three screenshots preserve the pre-inspection state.

Current-action surface:

```text
MKS_CODE=MKS-UI-003
TITLE=Current action collapsed into historical result
OUTCOME=blocked
LAST_PROVED_PHASE=presentation
LOCAL_MUTATION=none
PROVIDER_CONTACT=not-started
TRUSTED_RESPONSE=not-received
OPERATION=not-recorded
```

This is a prior presentation-state observation. It must not be mistaken for
the later failed/notApplied inspection terminal.

Sync overview and local queue:

```text
AUTHENTICATION=authenticated
ENROLLMENT=device-enrolled
READINESS=failed-work-needs-review
LAST_RESULT=sync-unavailable
RECOVERY_GUIDANCE=review-local-sync-state-before-retry
PENDING=0
UPLOADING=0
FAILED=2
```

Recent-attempt evidence retained:

- the latest ordinary Sync remained `sync-unavailable /
  provider-evidence-unavailable`;
- it carried no observed HTTP status or response headers;
- prior hosted-connection checks included ready responses;
- no local diagnostic child events were shown before the inspection;
- the current Device fingerprint was `#a43532d0`, enrolled, with next
  sequence `3`;
- two actionable `purchase.registered` events were failed at sequences `1`
  and `2`.

This confirms that the read-only action started from the expected Gate 12.6
shape. It does not refresh the live provider baseline.

### 3. After-inspection result

The final screenshot shows one new current diagnostic child:

```text
DIAGNOSTIC_CODE=MKS-UI-004
PHASE=failed-recovery-preflight
OUTCOME=not-applied
LAST_PROVED_PHASE=failed-recovery-preflight
LOCAL_MUTATION=none
PROVIDER_CONTACT=not-started
TRUSTED_RESPONSE=not-received
RESULT_PERSISTENCE=not-started
OPERATION_FINGERPRINT=#4af181b3d7e7
CORRELATION_FINGERPRINT=#0ebea2b44ec7
SAFE_ACTION=hold for Gate 12.7 reconciliation; do not execute recovery
```

The Device remained enrolled with next sequence `3`, and the same two
actionable events remained failed at sequences `1` and `2`.

Targeted source inspection confirms that an eligible `MKS-UI-004` inspection
requires exactly one current Account/Device failed/notApplied submission,
complete contiguous membership, valid scoped events and hashes, all member
states failed, no accepted member, no active overlap, no current-scope
pending/uploading/unknown work, and a matching next sequence.

The inspection runner records `mutation none`, `contact not-started`,
`trusted not-received`, and `persist not-started`; it has no execution
callback. Therefore:

```text
FAILED_NOT_APPLIED_CANDIDATE=ONE_ELIGIBLE
CANDIDATE_MEMBER_COUNT=2
CANDIDATE_SEQUENCE_RANGE=1-2
CURRENT_DEVICE_NEXT_SEQUENCE=3
READ_ONLY_INSPECTION=PASS
LOCAL_MUTATION=ABSENT
PROVIDER_CONTACT=ABSENT
FAILED_NOT_APPLIED_EXECUTION=ABSENT
ORDINARY_SYNC=ABSENT_DURING_INSPECTION
```

One source/meaning drift is confirmed. The eligible inspection emits
`MKS-UI-004`, while the registry title and meaning still describe the older
condition in which the failed/notApplied inspection action is missing. The
action now exists. The state axes and safe action remain sufficient to accept
the read-only preflight behavior, but the code cannot continue to mean both
“action missing” and “eligible preflight.” REC-01 must preserve the historical
UI code and emit a precise REC preflight code for the current condition.

The bounded fingerprints are useful for reconciliation and later confirmation
display. They are not authoritative database identities and must never be
used alone to select the candidate.

### 4. PRC-01 classification

```text
Claim: the Gate 12.7 failed/notApplied preflight is human-observed eligible
Source: Windows Closure screenshots and current source
Current state: validated within the read-only Windows inspection boundary
Evidence: MKS-UI-004 event plus unchanged two-event failed lineage
Evidence boundary: local UI/database observation; no live provider refresh
Contradictions: none within the supplied evidence
Semantic owner: Main GCM-02 Gate 12.7 reconciliation
Target role: J continuity and synchronized D/E/F materialization authority
History disposition: append; preserve earlier pending/blocked states
Confidence: high within the named boundary
Human/Main authority: reconciliation and staging requested
Required regeneration: Codex replacement G/H/I after REC-01 materialization
Result: preflight PASS; execution capability still absent
```

```text
Claim: MKS-UI-004 correctly names the eligible preflight
Source: current registry and Closure diagnostic query
Current state: contradicted
Evidence: runtime emits the code for eligibility; registry defines missing action
Evidence boundary: repository/source semantic consistency
Contradictions: direct code-to-registry mismatch
Semantic owner: diagnostic registry plus detector boundary
Target role: C10-GCM02-S12-REC-01 D/E/F
History disposition: preserve historical code; stop current mis-emission
Confidence: high
Human/Main authority: correction staged, not yet materialized
Required regeneration: registry projections, tests and replacement G/H/I
Result: bounded REC-01 correction required
```

```text
Claim: Gate 12.7 may now authorize a controlled recovery
Source: preflight evidence
Current state: blocked
Evidence: source contains inspection only; no dedicated bounded executor
Evidence boundary: repository/source and UI inspection
Contradictions: older J wording assumed an executable action
Semantic owner: Main Gate 12.7 authority
Target role: D/E/F corrective materialization first
History disposition: preserve and correct by this later entry
Confidence: high
Human/Main authority: no execution authorization granted
Required regeneration: source implementation, tests, G/H/I, Main reconciliation
Result: authorization remains held
```

### 5. Resolved Cycle 10 hierarchy

The navigation grammar is now instantiated as follows:

```text
Cycle 10 — hosted synchronization and operational acceptance
├─ GCM-01 — development-provider foundation
│  └─ Terminal: accepted within the sanitized development boundary
├─ GCM-02 — exact hosted recovery/synchronization proof [ACTIVE]
│  ├─ Gate 12.1 — Render/API readiness [PASS AT INSPECTED EVIDENCE]
│  ├─ Gate 12.2 — Auth0 metadata contract [PASS AT INSPECTED EVIDENCE]
│  ├─ Gate 12.3 — client/deployment alignment [PASS; REFRESH BEFORE ACTION]
│  ├─ Gate 12.4 — exact Account/Device binding [PASS; REFRESH BEFORE ACTION]
│  ├─ Gate 12.5 — provider baseline [PASS; REFRESH BEFORE ACTION]
│  ├─ Gate 12.6 — copied DB and Device-scope correlation [PASS]
│  ├─ Sprint S12-ERR-01/02 — diagnostic runtime tightening [SOURCE ACCEPTED]
│  ├─ Gate 12.7 — one controlled failed/notApplied recovery
│  │  ├─ Phase A — current-source Windows Closure run [HUMAN OBSERVED PASS]
│  │  ├─ Phase B — read-only candidate inspection [PASS]
│  │  ├─ Phase C — Main reconciliation [THIS ENTRY: PASS]
│  │  ├─ Sprint S12-REC-01 — bounded execution surface [D/E/F ACTIVE]
│  │  ├─ Phase D — Codex materialization and local validation [PENDING]
│  │  ├─ Phase E — G/H/I reconciliation [PENDING]
│  │  ├─ Phase F — fresh Windows build and repeated preflight [PENDING]
│  │  ├─ Phase G — Git/Render/Auth0/Device/provider freshness [PENDING]
│  │  ├─ Phase H — exact authorization packet [PENDING]
│  │  └─ Phase I — explicit approval plus one action [HELD]
│  ├─ Gate 12.8 — correlated client/server evidence [HELD]
│  ├─ Gate 12.9 — provider comparison [HELD]
│  └─ Gate 12.10 — terminal classification and GCM-02 reconciliation [HELD]
├─ GCM-03 — bounded second-Device convergence candidate [UNDEFINED/INACTIVE]
├─ GCM-04 — final operational acceptance families [UNDEFINED/INACTIVE]
└─ Cycle closure — promotion, continuity refresh, hygiene and Cycle 11 handoff
   [HELD]
```

### 6. Activated D/E/F unit

This reconciliation activates synchronized materialization unit:

```text
UNIT=C10-GCM02-S12-REC-01
OBJECTIVE=separate bounded failed/notApplied recovery-and-upload surface
SOURCE_ONLY=YES
LIVE_PROVIDER_ACTION=NO
GATE_12_7_AUTHORIZATION=NO
```

The unit must preserve inspection as read-only and introduce a distinct,
confirmed coordinator that:

1. revalidates exact Account/Device/candidate state immediately before
   mutation;
2. uses authoritative internal identity rather than a fingerprint selector;
3. atomically recovers exactly the candidate member set;
4. leases and uploads exactly that recovered set;
5. stops after one upload terminal;
6. never invokes download, acknowledgement or ordinary Sync;
7. records the complete diagnostic evidence axes;
8. prevents automatic or second execution;
9. replaces the eligible-preflight `MKS-UI-004` emission with a precise REC
   code without erasing the historical missing-action definition.

The synchronized controlling files are:

```text
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
```

### 7. Resolved continuation sequence

Proceed only in this order:

1. publish this J plus synchronized D/E/F staging;
2. send the exact seeding prompt below to Codex;
3. Codex verifies the required ancestry and materializes only
   C10-GCM02-S12-REC-01;
4. Codex runs local/disposable validation and replaces G/H/I;
5. Main reconciles source and G/H/I into a new append-only J entry;
6. pull the accepted commit into the clean Windows checkout;
7. run the canonical Windows validation/build/launch procedure;
8. repeat `Inspect failed/notApplied recovery`;
9. require the candidate fingerprint/count/range/next-sequence and all safety
   booleans to match the accepted packet;
10. refresh Git revision, Render readiness/revision, Auth0 metadata/principal,
    exact Device binding and the allowlisted provider baseline;
11. Main prepares one exact Gate 12.7 authorization packet;
12. obtain explicit human authorization for exactly one named action;
13. execute exactly one `Recover failed/notApplied candidate`;
14. issue no second action and freeze the post-action local state;
15. Gate 12.8 captures client terminal and correlated server lifecycle;
16. Gate 12.9 captures and compares the fresh allowlisted provider state;
17. Gate 12.10 classifies exactly one terminal and decides GCM-02 closure.

Any mismatch, unknown result, out-of-allowlist mutation, ambiguous response,
partial local transition, revision drift, or absent correlation stops the
sequence. It does not authorize another attempt.

### 8. Gate 12.8–12.10 expected terminal

The controlled action may be classified only as:

```text
expected success
duplicate-equivalent
rejected/notApplied
unknown
unexpected mutation/failure
```

GCM-02 may close only when client state, server lifecycle evidence and
provider state agree on a trustworthy terminal. An unknown or contradictory
terminal keeps GCM-02 open with a narrow diagnostic follow-up and no second
action.

### 9. Current terminal

```text
CYCLE10=OPEN
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
GCM02=OPEN_ACTIVE
GCM02_12_6=PASS
WINDOWS_CLOSURE_RUN=HUMAN_OBSERVED_PASS
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY_PASS
FAILED_NOT_APPLIED_CANDIDATE=ONE_ELIGIBLE
CANDIDATE_MEMBER_COUNT=2
CANDIDATE_SEQUENCE_RANGE=1-2
CURRENT_DEVICE_NEXT_SEQUENCE=3
LOCAL_MUTATION=ABSENT
PROVIDER_CONTACT=ABSENT
FAILED_NOT_APPLIED_EXECUTION=ABSENT
ELIGIBLE_PREFLIGHT_CODE_SEMANTICS=DRIFT_CONFIRMED
C10_GCM02_S12_REC_01=STAGED_ACTIVE
GATE_12_7=HELD_PENDING_CODEX_AND_RECONCILIATION
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
ORDINARY_SYNC=NOT_AUTHORIZED
CONTROLLED_RECOVERY=NOT_AUTHORIZED
```

## 2026-07-26 — REC-01 source reconciliation and Gate 12.7 host handoff

### Sequence envelope

```text
Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Main Chat [M]
Branch: cycle10-intermid-grimoire
Reconciled implementation commit: a63367763716e2769ac58d5adc19de0c41774b35
Evidence: replacement G/H/I, changed-path inventory and reported validation
Writable surface: J only
Disposition: REC-01 SOURCE ACCEPTED; HOST VALIDATION PENDING; GATE 12.7 HELD
```

### Materialization reconciliation

REC-01 is accepted within its repository and local/disposable test boundary.
The implementation now separates four surfaces:

```text
Retry unknown-outcome submission
Inspect failed/notApplied recovery
Recover failed/notApplied candidate
ordinary Sync
```

The new recovery action revalidates authentication, exact Account/Device
binding and the complete authoritative candidate immediately before mutation.
It retains full internal identity rather than selecting by a truncated
fingerprint, atomically recovers and leases exactly the candidate members,
sends at most one upload, persists the result and stops. Its dependency graph
contains no download or acknowledgement path.

The eligible read-only inspection now emits `MKS-REC-001`.
`MKS-UI-004` remains reserved for its historical missing-action meaning.
Generated Dart, TypeScript and Markdown projections were regenerated from the
single registry owner.

### PRC-01 claims

```text
Claim: REC-01 bounded failed/notApplied execution surface exists
Prior state: staged; execution surface absent
Evidence: a633677 source plus G/H/I and local/disposable tests
Evidence boundary: repository-proven and locally test-validated; host-unvalidated
Contradiction: none in replacement G/H/I
Semantic owner: GCM-02 Gate 12.7 Main reconciliation
Target role: J current state and continuation
Resulting state: SOURCE ACCEPTED; WINDOWS/LIVE EXECUTION NOT ACCEPTED
History disposition: append; supersede D/E/F-active wording
```

```text
Claim: exact candidate, one upload and no download/ack boundaries hold
Prior state: implementation requirement
Evidence: focused Flutter tests, full 189-pass/4-skip suite, analysis, API 58-pass suite
Evidence boundary: mocked/local/disposable transport and persistence boundaries
Contradiction: none reported
Semantic owner: REC-01 operational/design contract
Target role: J accepted source capability
Resulting state: LOCALLY VALIDATED; LIVE RESULT UNKNOWN
History disposition: append; retain future host/provider proof requirement
```

```text
Claim: Gate 12.7 may now execute
Prior state: held
Evidence: no fresh Windows build, repeated UI preflight or provider-freshness packet
Evidence boundary: source materialization only
Contradiction: capability exists, but authorization evidence is incomplete
Semantic owner: human/Main Gate 12.7 authority
Target role: prohibition and next-step boundary
Resulting state: REJECTED; AUTHORIZATION HELD
History disposition: append; no provider/user-database action accepted
```

### Validation absorbed

```text
generator update/check: PASS, including deterministic second check
Dart format: PASS
focused Flutter: 17 + 29 + 10 + 26 reported passing cases
Flutter analyze: PASS
full Flutter test: 189 passed, 4 skipped
API diagnostics/format/lint/typecheck/build: PASS
API tests: 58 passed
git diff --check: PASS
staged sensitive-pattern scan: no matches
provider/live action: NOT PERFORMED
user database inspection or mutation: NOT PERFORMED
Drift migration: NOT ADDED
```

The reports preserve one command-location correction: an initial diagnostics
check invoked from the repository root failed because no root
`package.json` exists; the same command run from
`services/markei_sync_api` passed. This is an invocation correction, not a
product-test failure.

### Separate dispatcher-rename boundary

Codex preserved unrelated machine-local work:

```text
deleted: documentation/NEON_CHECK.ps1
untracked: documentation/I_SCRIPTS.ps1
```

Therefore commit `a633677` does not publish or validate that rename. J must
continue to regard the tracked dispatcher and its references as authoritative
until the rename, all GRM/G_SCRIPTS references and dispatcher validation are
published together in a separate isolated commit. This boundary must be
resolved before relying on canonical Windows commands.

### Hierarchical progress update

```text
Cycle 10 — hosted synchronization and operational acceptance [OPEN]
└─ GCM-02 — exact hosted recovery/synchronization proof [ACTIVE]
   └─ Gate 12.7 — one controlled failed/notApplied recovery [ACTIVE/HELD]
      ├─ Phase A — Windows Closure and read-only inspection [PASS]
      ├─ Phase B — Main candidate reconciliation [PASS]
      ├─ Sprint S12-REC-01 — bounded execution surface [SOURCE ACCEPTED]
      ├─ Phase C — G/H/I reconciliation [PASS: THIS ENTRY]
      ├─ Phase D — dispatcher-name coherence [PENDING, SEPARATE]
      ├─ Phase E — fresh Windows validation/build/launch [PENDING]
      ├─ Phase F — repeated read-only MKS-REC-001 preflight [PENDING]
      ├─ Phase G — recovery confirmation-surface cancel test [PENDING]
      ├─ Phase H — Git/Render/Auth0/Device/provider freshness [PENDING]
      ├─ Phase I — exact authorization packet [PENDING]
      └─ Phase J — explicit approval plus exactly one action [HELD]
```

Gates 12.8–12.10 remain held. GCM-03 and GCM-04 remain undefined and
inactive. No new D/E/F packet is justified by REC-01 evidence alone; any new
packet must be triggered by a concrete Windows/freshness defect or by a later
Main-defined post-terminal unit.

### Current terminal

```text
CYCLE10=OPEN
GCM02=OPEN_ACTIVE
GCM02_12_6=PASS
GCM02_12_7_READ_ONLY_PREFLIGHT=PASS
C10_GCM02_S12_REC_01_SOURCE=ACCEPTED
ELIGIBLE_PREFLIGHT_DIAGNOSTIC_CODE=CORRECTED
EXACT_RECOVERED_BATCH=LOCALLY_VALIDATED
ONE_UPLOAD_ONLY=LOCALLY_VALIDATED
DOWNLOAD_ACK_ABSENT=LOCALLY_VALIDATED
WINDOWS_POST_REC01_VALIDATION=PENDING
DISPATCHER_RENAME=PENDING_SEPARATE_RECONCILIATION
GATE_12_7=HELD
CONTROLLED_RECOVERY=NOT_AUTHORIZED
ORDINARY_SYNC=NOT_AUTHORIZED
PROVIDER_ACTION=NOT_AUTHORIZED
GATES_12_8_TO_12_10=HELD
GCM03=UNDEFINED_INACTIVE
GCM04=UNDEFINED_INACTIVE
```

