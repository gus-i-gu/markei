# F_DSN_STAGE — Recovery Orchestration Design

> Authority marker: C10-MCG02-RECOVERY-ORCHESTRATION_20260721T003303Z
> Required ancestor: bbb5922b8afa5ab85646c34b9cd08e0c24fcf48a
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Selected dependency direction

~~~text
HostedSyncCoordinator
  -> RecoverFailedNotApplied use case
  -> SyncOutboxRepository scoped candidate discovery + recovery
  -> UploadPendingEvents
  -> existing HTTP transport
~~~

The application layer owns orchestration; Drift owns selection and atomic state transition; the UI
only requests Sync and receives a bounded outcome. Infrastructure details and submission IDs must
not cross into presentation.

## Invariants

1. Candidate discovery is restricted to the active Account and Device.
2. Zero candidates is ordinary progress; exactly one eligible candidate may recover; ambiguity
   fails closed.
3. Discovery plus recovery is transactionally revalidated so concurrent calls cannot both recover.
4. Recovery retains the old submission as superseded and reuses immutable events through the
   canonical ordered lease from `bbb5922`.
5. Unknown/uploading/accepted or structurally invalid attempts never enter this path.
6. Coordinator ordering is authentication/binding check, recovery check, upload, download,
   acknowledgement. Existing offline/local-first behavior remains independent.
7. No schema change is authorized. If current state cannot satisfy concurrency and ambiguity rules,
   report partial rather than weakening them.

## Decisive proof

A file-backed database is seeded with the human-equivalent state: one failed/notApplied submission,
two immutable events whose stored membership order is reversed, local next sequence `3`, and a
server expecting `1`. After close/reopen, one production coordinator call recovers and sends `1,2`;
the server stores two events, one accepted submission and expects `3`. Repeated calls do not
duplicate state. Negative fixtures prove blocked and ambiguous states remain unchanged.
