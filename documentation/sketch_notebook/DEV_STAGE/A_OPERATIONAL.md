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

Loaded root `AGENTS.md`, `INDEX.md`, notebook `AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md` and `CHAT_PROTOCOL.md` in the complete canonical route. Retained:

- Operational owns execution boundaries, jobs, validation, failure handling, rollback, cost drivers and stop gates.
- `A_OPERATIONAL.md` is a functional stage for Main reconciliation, not canon or Codex authority.
- PRC-01 keeps candidate, proposed, provisional, accepted, implemented and validated distinct.
- Provider connectivity does not prove authorization, retention, recovery, backup or production readiness.
- G/H/I are observational evidence; J is Main synthesis; permanent-domain promotion requires a later reconciliation.
- Only this A stage may change. Secrets, connection strings and provider-bearing files are excluded.

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
- API upload, ordered download, acknowledgement and serializable transaction code;
- Account/Device RLS and runtime grants;
- Drift outbox, inbox, cursor and remote Purchase application;
- HTTP transport, real convergence harness and focused tests.

Official platform documentation consulted 2026-07-15:

- Neon Branching, last updated 2026-02-15;
- Neon Plans and restore-window documentation as displayed 2026-07-15;
- Neon `pg_cron` extension documentation as displayed 2026-07-15;
- PostgreSQL 18 transaction isolation, explicit locking, partitioning and PITR documentation.

Provider guarantees are limited to documented branch, restore-window, plan and extension behavior. Current MCG-01 project facts remain human-supplied and unreconciled.

## 3. Present implementation versus missing behavior

Accepted local evidence establishes:

- complete HTTP→API→PostgreSQL→API→Drift convergence for one append-only Purchase event;
- ordered Account cursor allocation and bounded download;
- per-Device monotonic acknowledgement;
- durable duplicate Submission/Event handling;
- atomic remote fact/inbox/cursor apply;
- bounded serializable/deadlock retry;
- migration 002 Account/Device constraints, indexes, grants and RLS.

Not implemented or accepted:

- retention duration or cleanup watermark;
- Device lease, dormancy, expiry, replacement or deletion lifecycle;
- Account snapshot format, creation, validation or storage;
- snapshot cut and event-retention relationship;
- initial bootstrap or expired-cursor rebootstrap;
- cursor-expired protocol response;
- cleanup scheduler, locking, retries or metrics;
- account deletion/erasure workflow;
- tombstones for future mutable facts;
- provider-backed retention or restore exercise.

Current acknowledgements are evidence of one Device’s applied prefix only. They do not establish that every Device is current, that an unresponsive Device should retain eligibility indefinitely, or that old events may be deleted.

## 4. Challenged starting hypothesis

The proposed append-only stream + per-Device acknowledgement + consistent snapshots is operationally credible, but incomplete without a Device eligibility lease and explicit rebootstrap contract.

Required corrections:

- acknowledgement cannot be the sole cleanup gate because a lost Device can pin storage forever;
- TTL cannot be the sole gate because an offline eligible Device can be stranded;
- a snapshot is useful only if its cut cursor is transactionally consistent and all events after the cut remain available;
- expired cursors must receive a typed `cursor-expired` response containing safe bootstrap metadata, never an empty page;
- provider PITR restores database history but does not reconstruct a Device’s local apply state or replace application snapshots;
- revoked/deleted Devices must not block cleanup; dormant Devices require bounded eligibility.

## 5. Operational alternatives

### Alternative A — acknowledgement-gated retention with maximum Device lease

Policy:

- retain events until every eligible Device acknowledges them;
- Device eligibility expires after a bounded renewable lease;
- cleanup watermark is the minimum acknowledgement across active/dormant-but-eligible Devices.

Jobs/infrastructure: Device lease sweeper, acknowledgement watermark calculator, cleanup worker, lifecycle audit.

Storage behavior: efficient for healthy Devices; one eligible inactive Device pins all newer history until lease expiry.

Offline behavior: supported through lease duration; expiry forces rebootstrap but no snapshot mechanism is inherently provided.

Failure modes: lease misclassification can strand a legitimate Device; absent snapshots make rebootstrap expensive or impossible after deletion.

Complexity/privacy: moderate; lifecycle metadata reveals last-contact timing but no payload is required.

Testability: good locally with synthetic clocks and acknowledgements.

Rollback: stop cleanup, extend leases, preserve events. Deleted history cannot be recovered from this policy alone.

Cost drivers: event bytes, indexes, retained history, cleanup scans and compute wakeups.

Confidence: medium-low as a complete policy; missing safe rebootstrap.

### Alternative B — fixed TTL plus periodic snapshots

Policy:

- retain events for a fixed interval regardless of Device acknowledgement;
- periodically create Account snapshots;
- expired Devices rebootstrap from the latest valid snapshot plus later events.

Jobs/infrastructure: snapshot builder, validator, replacement/expiry worker, TTL cleanup, bootstrap endpoint.

Storage behavior: predictable upper bound proportional to event rate × TTL plus snapshot generations.

Offline behavior: incremental sync only within TTL; older Devices rebootstrap.

Failure modes: cleanup can strand Devices if no validated snapshot covers the deletion boundary; fixed TTL ignores Device state and low-activity Accounts.

Complexity/privacy: moderate-high; snapshots duplicate Account facts and increase exposure surface.

Testability: strong with deterministic cut and clock fixtures.

Rollback: pause deletion and retain previous validated snapshot generation. Already-deleted events require snapshot or database restore.

Cost drivers: snapshot size/frequency, event TTL, validation reads, transfer and compute.

Confidence: medium; predictable but insufficiently eligibility-aware.

### Alternative C — hybrid minimum TTL, Device lease and snapshot coverage

Policy:

- retain every event for at least a minimum TTL;
- eligible Device acknowledgements may delay cleanup beyond that minimum;
- Device eligibility is bounded by a renewable lease;
- deletion requires a validated Account snapshot with cut cursor at or beyond the proposed cleanup boundary;
- retain snapshot cut and every event after that cut;
- expired Device cursors require rebootstrap.

Jobs/infrastructure: lifecycle sweeper, snapshot builder/validator, cleanup planner, cleanup executor, bootstrap endpoint and audit metrics.

Storage behavior: bounded by minimum TTL, event rate, maximum lease delay and snapshot generations; safer than pure TTL and less permanently pinned than pure acknowledgement gating.

Offline behavior: incremental within retained range; rebootstrap after lease/cursor expiry.

Failure modes: snapshot validation bug, incorrect eligible-Device set, cleanup racing new events, or premature snapshot replacement.

Complexity/privacy: highest, but metadata can remain payload-free and snapshots can stay inside Account-scoped database storage.

Testability: highest because every safety predicate is explicit.

Rollback: disable cleanup, extend leases, retain two validated snapshot generations and restore prior migration checkpoint.

Cost drivers: event volume, snapshot amplification, indexes, periodic compute, transfer and restore-window storage.

Confidence: medium-high as the preferred hypothesis; durations and provider scheduling remain unresolved.

## 6. Preferred provisional policy

Recommend Alternative C for Main consideration.

Proposed invariants:

1. `active`: recently authenticated and lease-valid; acknowledgement participates in cleanup.
2. `dormant`: lease-valid but outside recent-contact threshold; still blocks cleanup until lease expiry.
3. `expired`: lease ended; no longer blocks cleanup and must rebootstrap.
4. `revoked`: authorization denied immediately; never blocks cleanup.
5. `deleted`: server Device metadata erased or minimized after audit boundary; never blocks cleanup.

Account cleanup boundary:

```text
eligible_ack_floor = minimum ack of active + dormant eligible Devices
snapshot_cut = cursor of newest fully validated snapshot
minimum_ttl_floor = oldest cursor still protected by minimum age
safe_delete_through = minimum(eligible_ack_floor, snapshot_cut, minimum_ttl_floor)
```

The formula is conceptual: implementation must represent “delete only events old enough, acknowledged by every eligible Device, and covered by a validated snapshot.” Empty eligible sets still require snapshot coverage and minimum TTL.

No exact duration is proposed yet. Minimum and maximum offline support are policy decisions constrained by user expectations, event growth, snapshot transfer size and provider limits. An initial local fixture should test multiple synthetic periods rather than encode a production promise.

## 7. Snapshot and rebootstrap state machine

Snapshot states:

```text
building → validating → active → superseded → expired
              ↓
            failed
```

Creation requirements:

- acquire one Account-scoped coordination lock;
- select a cut cursor under a consistent transaction snapshot;
- materialize complete immutable Account facts through that cut;
- store protocol/schema versions, cut cursor, content hash, counts and creation time;
- validate reconstruction against source counts/hashes before activation;
- keep the prior active snapshot until the replacement is validated.

Catch-up rule: events committed after the cut remain in the event stream and are downloaded after snapshot application.

Bootstrap states:

```text
no-local-state | cursor-expired
→ request bootstrap manifest
→ download snapshot resumably
→ verify hash/version/counts
→ apply into isolated local transaction or replacement database
→ persist snapshot cut cursor
→ download events after cut
→ acknowledge contiguous cursor
→ reopen and compare
```

Interrupted download resumes or restarts without mutating authoritative local facts. Interrupted apply leaves the prior local database usable; activation occurs only after complete validation.

## 8. Cleanup runbook

1. Select one Account with `FOR UPDATE SKIP LOCKED` or an equivalent bounded job claim.
2. Acquire Account advisory/row lock; never hold a global cleanup lock.
3. Recompute Device eligibility and acknowledgement floor inside the transaction.
4. Verify one active validated snapshot and its cut/version/hash.
5. Compute candidate deletion boundary from age, eligible acknowledgements and snapshot coverage.
6. Delete in bounded cursor batches; record only Account alias/hash, cursor range, counts, duration and outcome.
7. Commit; retry serialization/deadlock failures with bounded attempts.
8. Re-read high-water and snapshot metadata; alert on invariant drift.
9. Preserve at least the active and immediately previous validated snapshot generation until a later safe replacement checkpoint.

Scheduling is unresolved. `pg_cron` may be available, but an external worker is preferable for explicit deployment ownership, retries, observability and portability unless MCG-01 proves a supported scheduler and Main accepts database-owned jobs.

## 9. Recovery and erasure runbooks

Device loss/reinstall:

- revoke old Device separately from creating replacement Device;
- replacement receives new Device identity and sequence epoch;
- never reuse old Device credentials or infer continuity from installation name;
- bootstrap replacement from snapshot plus later events.

Account deletion:

- stop new authorization and event acceptance;
- mark deletion requested with idempotent operation identity;
- revoke Devices;
- delete snapshots, events, submissions, acknowledgements and Account facts in a verified order;
- record only non-payload deletion evidence permitted by policy;
- verify zero Account rows through runtime and administrative probes;
- provider backup/PITR residual lifetime must be disclosed separately because logical deletion does not instantly rewrite historical backups.

Future edits/deletes:

- tombstone/deletion event semantics are required before mutable synchronization;
- snapshot compaction must preserve deletion outcomes so removed facts do not reappear after rebootstrap;
- no tombstone TTL should be chosen before Device lease and snapshot coverage are accepted.

## 10. Failure-injection matrix

| Case | Injection | Required evidence |
| --- | --- | --- |
| stale active Device | freeze contact and ack clocks | blocks cleanup until lease expiry |
| expired Device | advance synthetic clock | stops blocking; incremental request returns `cursor-expired` |
| snapshot race | append events during build | cut remains consistent; later events retained |
| invalid snapshot | corrupt hash/count/version | never activates; no cleanup boundary advances |
| interrupted build | kill worker mid-write | partial snapshot remains non-active and reclaimable |
| interrupted download | drop chunks/restart client | resumable/restartable; local facts unchanged |
| interrupted apply | throw before activation | prior local database remains usable |
| cleanup race | concurrent append/ack/revoke | bounded lock/serializable retry preserves invariants |
| duplicate job | two workers claim Account | one effective cleanup; idempotent audit result |
| old protocol | snapshot/event version unsupported | typed upgrade/rebootstrap stop, no silent skip |
| lost Device | revoke then reconnect | authorization denied; no cleanup pin |
| account erase | fail each deletion phase | idempotent resume; no cross-Account deletion |
| PITR exercise | restore disposable branch/time | database state recoverable; local Device state not claimed recovered |

## 11. MCG-01 sanitized dependencies

Before Main chooses durations or provider-backed jobs, receive only:

- development branch alias/availability and whether it has explicit expiry;
- region and PostgreSQL major version;
- plan branch, storage, compute and monitoring limits;
- restore-window/PITR and manual snapshot availability;
- migration-role and runtime-role capabilities, including extension creation limits;
- whether `pg_cron` or another scheduler is supported and who owns it;
- scale-to-zero/compute wake implications for scheduled work;
- teardown owner and expected deletion date.

Official Neon documentation currently states branches are isolated copy-on-write clones, may have expiration dates, and have plan-dependent restore windows and storage/compute limits. These are platform capabilities, not evidence that the current MCG-01 environment possesses or correctly configures them.

## 12. Proposed C10-S02/C10-S03 implementation slice

### C10-S02 — disposable retention/snapshot proof

- forward-only local PostgreSQL migration for Device lifecycle, snapshot metadata/data and cleanup-job claims;
- protocol additions for bootstrap manifest, snapshot transfer and typed cursor expiry;
- synthetic Accounts with 0, 1, 2 and many Devices and high event volume;
- deterministic clock and event-size fixtures;
- snapshot build/validate/replace proof;
- expired-cursor rebootstrap into a fresh Drift file;
- cleanup safety proof across active, dormant, expired and revoked Devices;
- failure matrix above, including concurrent append and interrupted jobs;
- no Neon, production auth, deployment or ordinary user data.

Rollback checkpoint: cleanup disabled by default; migration additive; events preserved; previous snapshot retained; local-only app remains available.

### C10-S03 — bounded provider probe after Main reconciliation

Only after MCG-01 is accepted:

- apply accepted migration to disposable development branch;
- seed synthetic payload-free test data;
- run role, scheduler, snapshot, cleanup, quota/latency and teardown probes;
- perform one disposable restore/PITR exercise if plan permits;
- return sanitized aliases, versions, hashes, counts, timings and pass/fail only.

Exact Codex stop point:

```text
local retention/snapshot/rebootstrap matrix green
→ G/H/I written
→ cleanup remains disabled by default
→ no provider mutation unless new D/E/F explicitly authorizes accepted MCG-01 probe
→ stop for Main reconciliation
```

## 13. Metrics, cost and observability

Payload-free metrics:

- event rows/bytes by Account bucket;
- oldest/newest retained cursor age;
- eligible Device counts by lifecycle state;
- acknowledgement lag in cursor count/time;
- snapshot bytes, build/validation duration and cut lag;
- cleanup candidate/deleted row counts and duration;
- bootstrap bytes/duration/retry count;
- serialization/deadlock/job retry counts;
- cursor-expired responses and rebootstrap outcomes.

Approximate cost drivers only: retained event and snapshot bytes, index amplification, restore-history storage, compute wakeups, snapshot/cleanup scans, branch count, network transfer and monitoring retention. No exact price should be copied into policy; recheck the active plan at acceptance.

## 14. Stop conditions and unresolved Main decisions

Stop before provider-backed implementation on:

- incomplete or contradictory MCG-01 evidence;
- any credential, URL or payload exposure;
- no validated snapshot covering proposed deletion;
- cleanup capable of deleting newer-than-cut or unacknowledged eligible history;
- cursor expiry represented as empty success;
- rebootstrap not atomic/restartable;
- unknown Device lifecycle or lease durations presented as accepted;
- scheduler ownership, retries or teardown undefined;
- migration incompatible with current protocol/schema;
- account erasure unable to distinguish live rows from provider backup retention;
- ordinary user data entering fixtures.

Main must decide:

- minimum TTL, Device lease and maximum supported incremental-offline duration;
- dormancy renewal and user-visible Device lifecycle semantics;
- snapshot representation, generation count, compression and size ceiling;
- internal database versus external object storage;
- bootstrap replacement versus merge behavior;
- scheduler ownership and frequency;
- cleanup batch and lock strategy;
- provider restore exercise requirement;
- account deletion evidence and backup-residual disclosure;
- protocol-version compatibility window;
- whether C10-S02 and C10-S03 remain separate units.

## 15. Explicit status

Everything in this stage beyond the accepted C10-S01B implementation boundary is investigative and speculative. Alternative C is the preferred Operational hypothesis with medium-high confidence, not an accepted retention policy, implementation instruction, provider configuration or production-readiness claim. Main reconciliation is required before D/E/F or Codex authority exists.
