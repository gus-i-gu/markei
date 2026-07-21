# I_DSN_CODEX - Recovery Orchestration Design

> Unit: C10-MCG02-RECOVERY-ORCHESTRATION_20260721T003303Z
> Result: C10_MCG02_RECOVERY_ORCHESTRATION_PROVED

## Final Dependency Direction

Recovery orchestration follows the existing application dependency direction:

```text
HostedSyncCoordinator
  -> RecoverFailedNotApplied use case
  -> SyncOutboxRepository port
  -> DriftSyncOutboxRepository adapter
  -> existing UploadPendingEvents use case
  -> HttpSyncTransport
```

The coordinator depends on a closed application use case, not on Drift queries or submission IDs. Presentation still depends only on the existing Sync action.

## Port And Use-Case Responsibilities

`SyncOutboxRepository.recoverOneFailedNotApplied()` is the scoped storage operation. It requires the repository to be bound to one Account and one Device, deterministically inspects failed/notApplied candidates, revalidates structure transactionally, and returns only closed `SyncResult` values.

`RecoverFailedNotApplied` is the focused application use case. It delegates all storage mechanics to the outbox repository and gives the coordinator a single orchestration step with no infrastructure identifiers.

## Coordinator Ordering

`HostedSyncCoordinator.run` now orders work as:

1. authentication/session confirmation;
2. Account/Device binding confirmation through the existing guard;
3. Device enrollment/allowed check through the existing guard;
4. scoped failed/notApplied discovery and recovery;
5. existing upload path once;
6. existing download path;
7. existing acknowledgement path.

Recovery does not run before authentication, binding, or Device checks. Recovery does not bypass `UploadPendingEvents` or `HttpSyncTransport`.

## Transactional Discovery And Recovery Boundary

The Drift adapter performs candidate discovery and state transition in one transaction. It admits only submissions with `state=failed` and `outcome=notApplied` for the scoped Account/Device.

For each candidate it validates:

- non-empty membership;
- exactly one Account and one Device matching scope;
- immutable event rows exist;
- pending rows exist and are not accepted;
- event IDs are unique;
- Device sequences are unique and strictly contiguous;
- payload identity fields match stored event identity;
- canonical payload hash matches stored content hash;
- no active equivalent retry already exists.

Exactly one valid candidate is recovered. Multiple valid candidates are ambiguous and fail closed. Invalid candidate structure fails closed without upload.

## Recovery Representation And Idempotency

No schema migration was required. Existing state fields express the durable recovery boundary:

- old failed attempt: retained as `state=superseded`;
- member pending rows: returned to `state=pending`;
- retry submission: created only by the existing ordered lease path;
- unknown retry: retains the same retry submission identity/hash.

Concurrent recovery calls are serialized by the transaction and conditional update. Repeated Sync after recovery finds no second eligible failed attempt. Close/reopen after recovery leaves either one pending retry path before upload or one accepted result after upload. An accepted upload cannot return to failed recovery because accepted member rows are rejected by candidate validation.

## Immutable-Event Guarantees

Recovery never modifies:

- EventId;
- AccountId;
- DeviceId;
- Device sequence;
- payload;
- payload version;
- occurrence time;
- content hash.

The recovered events are reused through the ordered lease invariant from `bbb5922`: ascending Device sequence with stable event identity tie-breaker, then membership position and transport serialization in that same order.

## Deviations And Blockers

No deviations or unresolved blockers remain for this unit. Provider/runtime acceptance against the human database is intentionally outside this commit and requires a separate authorized retest.
