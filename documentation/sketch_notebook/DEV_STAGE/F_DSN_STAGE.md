# F_DSN_STAGE — Ordered Outbox Recovery Design

> Authority marker: C10-MCG02-ORDERED-OUTBOX-RECOVERY_20260721T000323Z
> Required ancestor: 7e65d310260deeec7391915e5d3546a35b8dadb2
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Selected boundary

~~~text
immutable SyncEvents
  -> Account/Device-scoped pending lease
  -> ORDER BY device_sequence ASC, stable event tie-breaker
  -> ordered hydration/membership
  -> contiguous-batch preflight
  -> one idempotent Submission
  -> HTTP response code preserved
  -> accepted / duplicate / unknown / typed not-applied
~~~

SQL result order is never an implicit protocol rule. Ordering must be explicit at selection and
preserved after hydration. A batch is valid only when every event has one Account, one Device,
unique identity and strictly contiguous increasing Device sequence.

## Recovery boundary

The existing human attempt was recorded locally as `failed`, `notApplied`, `conflict`; Neon has no
matching submission or event and still expects sequence `1`. Production code cannot assume those
manual observations for every user. Implement a general bounded recovery seam that:

1. admits only stored `failed/notApplied` attempts;
2. revalidates immutable members and canonical order;
3. excludes unknown/uploading/accepted and malformed work;
4. records the old attempt as retired/superseded without deleting evidence;
5. returns members to one recoverable ordered submission path at most once;
6. survives close/reopen without duplicate active work;
7. leaves a new typed not-applied failure terminal if the server rejects again.

Choose the smallest representation supported by current tables. No schema migration is authorized.
If existing fields cannot express safe retirement/recovery, stop for Main rather than overload a
state ambiguously.

## Failure-code boundary

The TypeScript server already returns bounded protocol codes. Flutter must preserve recognized
`sequence-gap`, `wrong-account`, and `hash-mismatch` codes in `SyncStatusCode`, persisted submission
evidence and coordinator outcomes. Unknown codes remain generic conflict; response bodies, hashes
and identifiers remain private.

## Proof architecture

Use a disposable local Drift database plus the real HTTP transport and disposable API/PostgreSQL
composition where available. The decisive positive fixture inserts/hydrates two events in reversed
physical order but transmits `1,2`; server expectation advances `1 -> 3`; replay is equivalent. The
negative matrix covers gaps, duplicates, cross-scope, bad hashes, timeout/unknown, interruption and
legacy failed recovery. Fresh one-event success is insufficient.

No event rewriting, schema migration, provider mutation or manual human-database operation belongs
to this unit.
