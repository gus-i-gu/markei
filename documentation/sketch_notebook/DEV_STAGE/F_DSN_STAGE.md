# F_DSN_STAGE — Unknown Recovery Architecture

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-UNKNOWN-RECOVERY_20260721
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Selected boundary

~~~text
Closure confirmation
  -> unknown-recovery preflight/query
  -> HostedSyncCoordinator recovery path
  -> existing outbox leases exact unknown submission
  -> existing authenticated HTTP transport
  -> existing result persistence
  -> attempt ledger + refreshed diagnostic snapshot
~~~

The outbox/submission tables remain authoritative for retry identity. The widget receives a
sanitized eligibility view model and invokes an application command; it does not query or mutate
Drift. Recovery must reuse existing protocol idempotency rather than create a parallel repair model.

## Invariants

- exactly one scoped unknown submission is recoverable at a time;
- submission ID, request hash, member order, event IDs, Device sequences and payload facts are
  immutable across retry;
- unknown-to-unknown is non-destructive and remains retryable;
- accepted/duplicate-equivalent converges the original rows;
- no preflight or confirmation path allocates a sequence or changes queue state;
- ordinary Sync cannot silently bypass an ineligible unknown submission;
- diagnostic recording cannot change the synchronization result;
- no direct database repair is exposed.

Codex must inspect whether the current ordinary Sync path already retries the exact unknown
submission. If so, factor/reuse it and add the guarded Closure command plus evidence; do not rewrite
working synchronization logic merely to create a new abstraction.

## Windows completion

Protocol registration and callback forwarding are two halves of one boundary. Retain the runner's
strict callback-prefix validation and current-user single-instance forwarding. Add repository-owned
registration/installation support without embedding tenant configuration or authorization data.

The desktop navigation container must own vertical overflow. Pages and destination ordering remain
unchanged; the rail becomes scrollable/responsive while retaining selection semantics.

No hosted schema/API change, local schema reset, new event contract, provider telemetry, Settings
merge or general shell redesign is authorized.
