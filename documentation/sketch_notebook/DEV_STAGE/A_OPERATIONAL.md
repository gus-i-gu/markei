<!-- TEMPORAL_MARKER:C10-RETENTION-RECOVERY-INVESTIGATION-2026-07-15 -->
# A_OPERATIONAL — Cycle 10 Retention and Recovery Policy Investigation
Sequence: FLX-INV-02
Role: Operational [O]
Branch: `intermid-cycle-recovery`
Inspected HEAD: `36b7b22b20e3b308b7b800514f6828a91ea49fcd`
Required ancestor: `36b7b22b20e3b308b7b800514f6828a91ea49fcd`
Evidence date: 2026-07-15
Authority: candidate/proposed/provisional Operational staging only; no policy acceptance, source materialization, provider mutation or secret inspection.
## 1. Methodology retained
Loaded root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md` and `CHAT_PROTOCOL.md` in the complete canonical route.
Retained:
- Operational owns execution boundaries, jobs, validation, failure handling, rollback, cost drivers and stop gates.
- `A_OPERATIONAL.md` is functional staging for Main reconciliation, not canon or Codex authority.
- PRC-01 keeps candidate, proposed, provisional, accepted, implemented and validated distinct.
- Provider connectivity does not prove authorization, retention, recovery, backup or production readiness.
- G/H/I are observational evidence; J is Main synthesis; promotion requires later reconciliation.
- Only this A stage may change; secrets, connection strings and provider-bearing files are excluded.
GitHub comparison reported the required commit and branch as identical before investigation. Connector evidence cannot inspect a local worktree or execute local commands; branch/blob concurrency is the available publication guard.
## 2. Evidence inspected
Notebook and Operational memory:
- `[M]_STAGE/J_MAIN_STAGE.md`.
- `DEV_STAGE/D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`.
- `DEV_STAGE/G_OPS_CODEX.md`, `H_DDC_CODEX.md`, `I_DSN_CODEX.md`.
- `operational/10_OPERATIONAL_STATE.md`.
- relevant `04_TODO.md`, `11_OPERATIONAL_RECORD.md`, `12_OPERATIONAL_MODEL.md`.
Implementation boundary:
- server migrations `001_init.sql` and `002_coordination_hardening.sql`;
- API upload, ordered download, acknowledgement and serializable transactions;
- Account/Device RLS and runtime grants;
- Drift outbox, inbox, cursor and remote Purchase application;
- HTTP transport, real convergence harness and focused tests.
Official documentation consulted 2026-07-15:
- Neon Branching, last updated 2026-02-15;
- Neon Plans, restore-window and `pg_cron` documentation as displayed 2026-07-15;
- PostgreSQL 18 transaction isolation, explicit locking, partitioning and PITR documentation.
Provider guarantees are limited to documented branch, restore-window, plan and extension behavior. Current MCG-01 project facts remain human-supplied and unreconciled.
## 3. Present implementation versus missing behavior
Accepted local evidence establishes:
- HTTP→API→PostgreSQL→API→Drift convergence for one append-only Purchase event;
- ordered Account cursor allocation and bounded download;
- per-Device monotonic acknowledgement;
- duplicate Submission/Event handling;
- atomic remote fact/inbox/cursor apply;
- bounded serializable/deadlock retry;
- migration 002 constraints, indexes, grants and RLS.
Not implemented or accepted:
- retention duration or cleanup watermark;
- Device lease, dormancy, expiry, replacement or deletion lifecycle;
- Account snapshot format, creation, validation or storage;
- snapshot-cut/event-retention relationship;
- initial bootstrap or expired-cursor rebootstrap;
- typed `cursor-expired` behavior;
- cleanup scheduler, locking, retries or metrics;
- account deletion/erasure workflow;
- tombstones for future mutable facts;
- provider-backed retention or restore exercise.
Acknowledgement proves only one Device’s applied prefix. It does not prove every Device is current, that an unresponsive Device remains eligible forever, or that old events may be deleted.
## 4. Challenged starting hypothesis
Append-only stream + per-Device acknowledgement + consistent snapshots is credible but incomplete without a bounded Device-eligibility lease and explicit rebootstrap.
Required corrections:
- acknowledgement alone lets a lost Device pin storage forever;
- TTL alone can strand an offline eligible Device;
- snapshot deletion safety requires a transactionally consistent cut plus retention of every later event;
- an expired cursor must return typed rebootstrap instructions, never an empty page;
- provider PITR restores database history but not Device-local apply state;
- revoked/deleted Devices must not block cleanup; dormant Devices need bounded eligibility.
## 5. Policy alternatives
### A — acknowledgement-gated retention with maximum Device lease
Policy:
- retain events until all eligible Devices acknowledge them;
- eligibility expires after a renewable maximum lease;
- cleanup watermark is the minimum acknowledgement of active and dormant-eligible Devices.
Operations: lease sweeper, watermark calculator, cleanup worker and lifecycle audit.
Storage/offline behavior: efficient for healthy Devices; one eligible inactive Device pins history until lease expiry. Incremental recovery works through the lease, but safe post-expiry rebootstrap is not inherently supplied.
Risks: lease misclassification can strand a legitimate Device; no snapshot means deleted history may be unrecoverable at application level.
Privacy/testability: lifecycle timestamps only; deterministic clocks make it testable.
Rollback/cost: disable cleanup, extend leases and preserve events. Cost follows event bytes, indexes, retained history, scans and compute wakeups.
Confidence: medium-low as a complete policy.
### B — fixed TTL plus periodic snapshots
Policy:
- retain events for a fixed interval independent of acknowledgement;
- create periodic Account snapshots;
- older Devices rebootstrap from snapshot plus later events.
Operations: snapshot builder/validator, replacement/expiry worker, TTL cleanup and bootstrap endpoint.
Storage/offline behavior: predictable bound from event rate × TTL plus snapshots. Incremental sync ends at TTL; older Devices rebootstrap.
Risks: cleanup can strand Devices if no validated snapshot covers the deletion boundary; TTL ignores Device state.
Privacy/testability: snapshots duplicate Account facts and enlarge exposure, but deterministic cut/clock fixtures are strong.
Rollback/cost: pause deletion and preserve the prior snapshot. Cost follows snapshot size/frequency, TTL, validation reads, transfer and compute.
Confidence: medium.
### C — hybrid minimum TTL, Device lease and snapshot coverage
Policy:
- retain every event for at least a minimum TTL;
- eligible acknowledgements may delay cleanup beyond the minimum;
- Device eligibility expires under a renewable lease;
- deletion requires a validated Account snapshot covering the boundary;
- retain snapshot cut and every event after it;
- expired Device cursors require rebootstrap.
Operations: lifecycle sweeper, snapshot builder/validator, cleanup planner/executor, bootstrap endpoint and audit metrics.
Storage/offline behavior: bounded by minimum TTL, event rate, maximum lease delay and snapshot generations. Incremental recovery works inside the retained range; older Devices rebootstrap.
Risks: incorrect eligibility, invalid snapshot activation, cleanup races or premature snapshot replacement.
Privacy/testability: highest complexity and strongest explicit safety predicates; payload-free operational metrics remain possible.
Rollback/cost: disable cleanup, extend leases, retain two validated snapshot generations and restore the prior migration checkpoint. Cost follows events, snapshot amplification, indexes, periodic compute, transfer and restore-history storage.
Confidence: medium-high; preferred hypothesis, with durations and provider scheduling unresolved.
## 6. Preferred provisional policy and state machine
Recommend Alternative C for Main consideration.
Device states:
- `active`: recently authenticated and lease-valid; acknowledgement participates in cleanup.
- `dormant`: lease-valid but outside recent-contact threshold; still blocks cleanup.
- `expired`: lease ended; no longer blocks cleanup and must rebootstrap.
- `revoked`: authorization denied immediately; never blocks cleanup.
- `deleted`: metadata erased/minimized after audit boundary; never blocks cleanup.
Cleanup safety predicate:
```text
delete an event only when
age >= minimum TTL
and every eligible Device acknowledged it
and an active validated snapshot covers its cursor
```
If no Devices are eligible, minimum TTL and snapshot coverage still apply. No exact duration is proposed: offline guarantees must be chosen from user expectations, event growth, snapshot transfer size and provider limits.
Snapshot states:
```text
building → validating → active → superseded → expired
              ↓
            failed
```
Snapshot creation must:
- claim one Account with a bounded Account-scoped lock;
- choose a cut cursor under one consistent transaction snapshot;
- materialize complete immutable facts through the cut;
- store protocol/schema versions, cut cursor, content hash, counts and time;
- validate reconstruction before activation;
- retain the previous active snapshot until replacement validates.
Events committed after the cut remain in the event stream.
Bootstrap states:
```text
no-local-state | cursor-expired
→ bootstrap manifest
→ resumable snapshot download
→ hash/version/count validation
→ isolated atomic local apply
→ persist cut cursor
→ download events after cut
→ acknowledge contiguous cursor
→ reopen and compare
```
Interrupted download restarts/resumes without changing facts. Interrupted apply leaves the prior local database usable; activation occurs only after full validation.
## 7. Cleanup and recovery runbooks
Cleanup:
1. Claim one Account using `FOR UPDATE SKIP LOCKED` or equivalent.
2. Acquire Account-scoped advisory/row lock; never a global cleanup lock.
3. Recompute eligibility and acknowledgement floor in-transaction.
4. Verify an active validated snapshot and cut/version/hash.
5. Compute the boundary from minimum age, eligible acknowledgements and snapshot coverage.
6. Delete bounded cursor batches; record alias/hash, range, counts, duration and outcome only.
7. Commit; retry serialization/deadlock failures with bounded attempts.
8. Re-read high-water and snapshot metadata; alert on drift.
9. Retain active and previous validated snapshot generations through a later checkpoint.
Scheduling remains unresolved. `pg_cron` may be available, but an external worker is preferred for explicit ownership, retries, observability and portability unless MCG-01 proves scheduler support and Main accepts database-owned jobs.
Device loss/reinstall:
- revoke old Device separately from creating replacement;
- replacement receives new Device identity and sequence epoch;
- never reuse old credentials or infer continuity from installation name;
- bootstrap replacement from snapshot plus later events.
Account deletion:
- stop authorization and new events;
- mark deletion with idempotent operation identity;
- revoke Devices;
- delete snapshots, events, submissions, acknowledgements and Account facts in verified order;
- verify zero live Account rows;
- disclose provider backup/PITR residual lifetime separately.
Future edits/deletes require tombstone events. Snapshot compaction must preserve deletion outcomes, and tombstone retention cannot be selected before Device lease and snapshot coverage are accepted.
## 8. Failure-injection matrix
| Case | Injection | Required evidence |
| --- | --- | --- |
| stale Device | freeze contact/ack clocks | blocks cleanup until lease expiry |
| expired Device | advance clock | stops blocking; incremental call returns `cursor-expired` |
| snapshot race | append during build | cut consistent; later events retained |
| invalid snapshot | corrupt hash/count/version | never activates; cleanup unchanged |
| interrupted build | kill worker | partial snapshot remains non-active |
| interrupted download | drop chunks/restart | resumable; local facts unchanged |
| interrupted apply | throw pre-activation | prior local database remains usable |
| cleanup race | concurrent append/ack/revoke | lock/retry preserves invariants |
| duplicate job | two workers claim Account | one effective cleanup |
| old protocol | unsupported snapshot/event | typed upgrade/rebootstrap stop |
| lost Device | revoke then reconnect | denied; no cleanup pin |
| account erase | fail each phase | idempotent resume; no cross-Account deletion |
| PITR exercise | restore disposable branch/time | database recovered; Device state not claimed |
## 9. MCG-01 sanitized dependencies
Before choosing durations or provider jobs, Main needs only:
- development branch alias/availability and explicit expiry behavior;
- region and PostgreSQL major version;
- branch, storage, compute and monitoring limits;
- restore-window/PITR and manual snapshot availability;
- migration/runtime role capabilities and extension limits;
- scheduler support and ownership;
- scale-to-zero implications for jobs;
- teardown owner and expected deletion date.
Official Neon documentation states branches are isolated copy-on-write clones, may expire, and have plan-dependent restore windows and limits. Those capabilities do not prove the current MCG-01 environment possesses or correctly configures them.
## 10. Proposed C10-S02/C10-S03 slice
### C10-S02 — disposable local retention/snapshot proof
- forward-only local PostgreSQL migration for lifecycle, snapshots and cleanup claims;
- bootstrap manifest, snapshot transfer and typed cursor expiry;
- synthetic Accounts with 0, 1, 2 and many Devices and high event volume;
- deterministic clocks and event-size fixtures;
- snapshot build/validate/replace proof;
- expired-cursor rebootstrap into fresh Drift;
- cleanup safety across active, dormant, expired and revoked Devices;
- concurrent append and interrupted-job failure matrix;
- no Neon, production auth, deployment or ordinary user data.
Rollback: cleanup disabled by default; migration additive; events preserved; previous snapshot retained; local-only application remains available.
### C10-S03 — provider probe after Main accepts MCG-01
- apply accepted migration to the disposable development branch;
- seed synthetic payload-free data;
- run role, scheduler, snapshot, cleanup, quota/latency and teardown probes;
- perform one disposable restore/PITR exercise if supported;
- return sanitized aliases, versions, hashes, counts, timings and pass/fail only.
Exact Codex stop:
```text
local retention/snapshot/rebootstrap matrix green
→ G/H/I written
→ cleanup remains disabled by default
→ no provider mutation without new D/E/F
→ stop for Main reconciliation
```
## 11. Metrics, costs and stop gates
Payload-free metrics:
- event rows/bytes and oldest/newest retained cursor age;
- Device counts by lifecycle state and acknowledgement lag;
- snapshot bytes, build/validation duration and cut lag;
- cleanup candidate/deleted rows and duration;
- bootstrap bytes/duration/retries;
- transaction/job retries and cursor-expired outcomes.
Cost drivers only: event/snapshot bytes, index amplification, restore-history storage, compute wakeups, scans, branch count, transfer and monitoring retention. Exact prices must be rechecked at acceptance, not encoded into policy.
Stop before provider-backed implementation on:
- incomplete or contradictory MCG-01 evidence;
- credential, URL or payload exposure;
- no validated snapshot covering deletion;
- cleanup able to delete newer-than-cut or eligible-unacknowledged history;
- cursor expiry represented as empty success;
- non-atomic/non-restartable rebootstrap;
- lifecycle durations presented as accepted without Main;
- undefined scheduler ownership, retries or teardown;
- protocol/schema incompatibility;
- erasure claims that ignore provider backup retention;
- ordinary user data in fixtures.
Main must decide:
- minimum TTL, Device lease and maximum incremental-offline duration;
- dormancy renewal and user-visible lifecycle;
- snapshot representation, generations, compression and size ceiling;
- database versus external object storage;
- bootstrap replacement versus merge;
- scheduler ownership/frequency and cleanup batch/lock strategy;
- provider restore exercise requirement;
- erasure evidence and backup-residual disclosure;
- protocol compatibility window;
- whether C10-S02 and C10-S03 remain separate.
## 12. Explicit speculative status
Everything beyond the accepted C10-S01B boundary is investigative and speculative. Alternative C is the preferred Operational hypothesis with medium-high confidence, not an accepted policy, implementation instruction, provider configuration or production-readiness claim. Main reconciliation is required before D/E/F or Codex authority exists.
