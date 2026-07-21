# F_DSN_STAGE — Closure Diagnostic Architecture

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-CLOSURE-DIAGNOSTICS_20260721
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Selected structure

~~~text
NativeClosurePage
  -> NativeAuthClosureRunner (commands)
  -> ClosureDiagnosticsQuery (read-only snapshots)
       -> DriftClosureDiagnosticsRepository
            -> local Device / SyncState / PendingEvent / SyncEvent / SyncAttempt tables

Sync action
  -> HostedSyncCoordinator
  -> bounded attempt recorder
  -> existing guard / outbox / transport / applier
~~~

The widget renders immutable diagnostic view models and owns only loading/expansion state. It must
not depend on Drift rows. The query repository performs Account/environment scoping, ordering,
counting, bounding and identifier redaction before data reaches presentation.

## Durable attempt model

If no equivalent table exists, add a local-only `sync_attempts` table with an opaque local ID,
Account/environment scope, started/completed timestamps, bounded phase, stable result code, outcome
class and sanitized recovery code. Fields containing raw remote data are prohibited.

Attempt persistence must not participate in the Purchase/event/outbox transaction or change its
atomicity. Failure to write diagnostics must not relabel a successful/failed Sync result, but should
produce safe local logging/test evidence. An attempt begins immediately before coordinator work and
is finalized once for every returned or caught terminal path.

## Snapshot model

One snapshot contains:

~~~text
auth/enrollment/readiness summary
current Device summary + next local sequence
queue counts by durable state
last locally recorded successful completion
recentAttempts[0..20]
recentActionableEvents[0..20]
devices[] scoped to active Account/environment
snapshot timestamp
~~~

Ordering is deterministic: newest timestamp first with local ID as tie-breaker. Short fingerprints
are presentation-safe derivatives, not persisted replacement identities.

## UI composition

Keep Closure as its own navigation destination. Use vertically stacked responsive cards:

1. `Sync overview` — auth, enrollment, readiness, last result/success and recovery guidance.
2. `Local queue` — pending/uploading/failed/unknown counts and next Device sequence.
3. `Recent sync attempts` — bounded retrospective timeline/table with explicit empty state.
4. `Devices` — current/enrolled local Device summaries with redacted identity.
5. `Actionable events` — bounded pending/failed/unknown rows.
6. `Closure actions` — existing command buttons plus Refresh and guarded history clearing.

Use a table on wide Windows layouts and stacked rows/cards on narrow layouts. Developer sections may
be collapsed initially, but their summaries must make pending/failed/unknown conditions visible.

## Invariants

- refresh is local and read-only;
- diagnostics never mutate queue state or trigger transport;
- stable codes survive restart; raw exceptions do not;
- attempt history is observational and does not replace queue truth;
- Account/environment boundaries prevent cross-scope diagnostic leakage;
- clearing attempt history cannot alter synchronization state;
- existing authentication, enrollment, Query, Sync and Logout behavior remains unchanged;
- no provider-side status is inferred from absent local evidence.

No server schema, API route, event payload, authentication protocol, remote telemetry, Settings merge
or general navigation redesign is authorized.
