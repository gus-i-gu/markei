# I_DSN_CODEX — Ordered Outbox Recovery Design

> Unit: C10-MCG02-ORDERED-OUTBOX-RECOVERY_20260721T000323Z
> Result: C10_MCG02_ORDERED_OUTBOX_RECOVERY_PROVED

## Final dependency direction

Immutable local `sync_events` remain the source of upload truth. The dependency direction is:

~~~text
pending_events
  -> sync_events ordered by device_sequence asc, id asc
  -> preflight
  -> sync_submissions + sync_submission_events positions
  -> HTTP transport
  -> persisted result
~~~

No Drift or PostgreSQL migration was added. Drift schema remains v8.

## Ordering and hydration invariant

Pending selection now joins `pending_events` to `sync_events` and applies:

~~~text
ORDER BY sync_events.device_sequence ASC, sync_events.id ASC
~~~

Fresh submissions use those ordered rows directly; they no longer rehydrate pending event IDs through unordered `WHERE id IN (...)`. Unknown-outcome retry still hydrates through membership, then reconstructs rows by ordered `sync_submission_events.position`.

Submission membership positions and transport serialization both follow the same canonical order.

## Batch preflight

Before any fresh lease mutation or unknown retry transport, the repository requires:

- non-empty batch;
- one Account and one Device;
- scoped Account/Device match when repository is scoped;
- unique event IDs;
- unique Device sequences;
- strictly contiguous ascending Device sequence;
- payload identity fields match the immutable row;
- stored content hash matches the canonical payload hash.

Failure throws a local preflight exception that `UploadPendingEvents` converts to `SyncStatusCode.localBatchInvalid`. No submission is created and no transport call is made.

## Failed-attempt recovery representation

The existing `sync_submissions.state` text field represents safe retirement without a migration:

- admitted: `state=failed` and `outcome=notApplied`;
- retired evidence: old submission updated to `state=superseded`;
- members: same immutable events requeued to `pending`;
- retry: next normal lease creates at most one new ordered submission.

Recovery blocks unknown, uploading, accepted, malformed, cross-scope, non-contiguous, accepted-member, or active-equivalent work. Repeated recovery returns a bounded blocker after retirement; if members are already pending before leasing, recovery returns the same available state.

## Idempotency and immutable-event guarantees

Unknown upload outcomes continue to retry the same submission identity/hash. Definitely not-applied failed recovery creates a new submission only through the canonical lease path and never changes EventId, AccountId, DeviceId, Device sequence, payload, payload version, occurrence time, or content hash.

The HTTP proof confirmed reversed `[2,1]` is rejected, production `[1,2]` is accepted atomically, server expectation advances `1 -> 3`, and replay of the same accepted identity/hash leaves server event and submission counts unchanged.

## Deviations and unresolved decisions

No unresolved implementation decisions remain for this unit. Human/provider acceptance is intentionally not claimed; it requires the separate human retest authorized after this disposable proof.
