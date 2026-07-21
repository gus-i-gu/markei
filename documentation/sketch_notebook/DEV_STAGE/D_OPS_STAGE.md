# D_OPS_STAGE — Failed Submission Recovery Orchestration

> Authority marker: C10-MCG02-RECOVERY-ORCHESTRATION_20260721T003303Z
> Required ancestor: bbb5922b8afa5ab85646c34b9cd08e0c24fcf48a
> Status: **ACTIVE CODEX CORRECTION AUTHORITY**

## Accepted evidence

`bbb5922` proves canonical Device-sequence ordering, contiguous preflight, typed server failures and
safe repository-level recovery. The real HTTP/PostgreSQL harness accepts `1,2`, advances expectation
to `3`, and replays idempotently. All Flutter/API tests and supported builds pass.

One production integration gap remains: `recoverFailedNotApplied(submissionId)` is called only by
tests. No application use case or hosted coordinator discovers and invokes the recoverable failed
attempt, so the existing human `failed/notApplied` submission remains stranded.

## Objective

Wire repository recovery through a bounded application use case and production hosted-sync
orchestration, then prove a reopened file-backed database with one legacy failed attempt recovers,
uploads canonically, and completes without manual IDs or database edits.

## Checkpoints

1. Add a port operation that identifies recoverable failed/notApplied attempts within the active
   Account/Device scope. Selection must be deterministic and must not expose IDs to UI or humans.
2. Add an application use case that recovers at most one eligible attempt per synchronization run.
3. Before a fresh upload, the hosted coordinator invokes recovery only after authentication,
   binding and Device checks pass. Continue to upload only on `failed-recovery-available` or when no
   recoverable attempt exists; return bounded unavailable/interrupted results otherwise.
4. Keep repository admission rules from `bbb5922`. Never recover unknown, uploading, accepted,
   malformed, cross-scope, non-contiguous or ambiguous multiple attempts.
5. Prove close/reopen, repeated Sync, concurrent invocation and interruption do not create duplicate
   active submissions or mutate immutable events.
6. Extend the real disposable HTTP/PostgreSQL harness: seed one failed/notApplied reversed legacy
   submission, reopen, call the production coordinator, transmit `1,2`, advance server expectation
   `1 -> 3`, and finish accepted exactly once.
7. Preserve local-only events, facts, cursor, hosted binding, v8 schema and offline registration.

## Stop rules

No provider access, deployment, schema migration, sequence/event rewrite, manual database repair,
Device reenrollment, broad UI work, MCG-03 or MCG-04. If multiple eligible failed attempts require
new policy or safe orchestration needs a schema change, stop for Main.

Success:

~~~text
C10_MCG02_RECOVERY_ORCHESTRATION_PROVED
~~~

Otherwise:

~~~text
C10_MCG02_RECOVERY_ORCHESTRATION_PARTIAL
~~~
