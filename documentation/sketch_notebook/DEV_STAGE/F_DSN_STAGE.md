# F_DSN_STAGE — Database-Enforced Account Cursor Boundary

> Unit: C10-MCG02-ACCOUNT-CURSOR-PROVISIONING-REPAIR_20260722
> Sequence: FLX-ORD-01
> Authority: Main Chat
> Status: READY FOR LOCAL MATERIALIZATION

## 1. Architecture decision

Main selects a trigger-backed database invariant because the repository has no canonical production
Account-provisioning service that can be made exclusive. The selected dependency and lifecycle are:

```text
trusted Account creation
  -> accounts INSERT
  -> database AFTER INSERT trigger
  -> account_cursor_state(account_id, next_cursor = 1)
  -> same transaction commit or rollback

enrollment
  -> resolves pre-existing identity/membership/Account
  -> creates Device and enrollment state
  -> never initializes Account cursor state

Sync
  -> advances existing cursor state
  -> returns service-unavailable/not-applied when invariant is absent
  -> never repairs the invariant lazily
```

The database is the enforcement owner; a future provisioning application service may orchestrate
Account creation but must not duplicate or bypass the invariant.

## 2. Migration 007 design

Add exactly `007_account_cursor_provisioning.sql` after 006. Within one transaction it must:

1. establish/verify the 006 prerequisite and insert the exact 007 ledger identity;
2. backfill missing cursor rows using a set-based, qualified query:
   `coalesce(max(sync_events.server_cursor), 0) + 1` per Account;
3. never update an existing cursor row;
4. create a narrowly named trigger function and `AFTER INSERT ON public.accounts` trigger;
5. create a new exact no-argument `public.markei_hosted_runtime_ready_v2()` capability covering the
   required 006+007 ledger identities/checksums;
6. revoke `PUBLIC` access and grant runtime only execution of readiness-v2;
7. revoke runtime `INSERT` on cursor state while retaining required scoped select/update;
8. commit only after every catalog, backfill and privilege change succeeds.

The trigger function may be `SECURITY DEFINER` only to allow future narrowly granted Account insertion
without also granting cursor-table insertion. If used, it must be owned by the migrator, fix
`search_path` to `pg_catalog, public`, fully qualify all objects, contain no dynamic SQL, expose no
result data, and be non-callable by `PUBLIC` or runtime outside trigger execution.

Use `AFTER INSERT`, not `BEFORE INSERT`, because the child foreign key requires the Account parent to
exist. Trigger work remains in the inserting transaction, preserving atomicity.

## 3. Backfill and locking semantics

The backfill is additive and idempotent:

```text
for each Account without cursor state:
  next_cursor = max(existing Sync event server_cursor) + 1
  or 1 when no events exist
```

It must use primary-key conflict safety without overwriting a row concurrently established by trusted
work. Existing cursor values remain authoritative even if they differ from recomputed high-water.
Codex must prove the chosen statement/lock order cannot decrease, duplicate or expose cursor state
partially.

Migration execution is the only historical repair boundary. Runtime enrollment and Sync adapters do
not receive cursor insertion authority.

## 4. Readiness compatibility

Do not replace or mutate migration 006. Keep `markei_hosted_runtime_ready()` for an old-binary rollback
window. New application code calls only `markei_hosted_runtime_ready_v2()`:

- new binary + database through 006 → not-ready because the function is absent;
- new binary + database through 007 → ready only when exact 006+007 identities match;
- old binary + database through 007 → old readiness remains available for bounded rollback.

Document the later deployment order in G/I but do not deploy:

```text
apply migration 007
-> verify catalog/backfill/readiness-v2
-> deploy new API
-> harmless health correlation
-> provider count/invariant verification
-> separately authorize one exact retry
```

## 5. Preserved invariants

Preserve:

- Account, Device, Submission, Event and acknowledgement identities;
- existing `next_cursor` values and cursor monotonicity;
- events 1–2 and next Device sequence 3;
- exact retry identity, request hash and ordered event membership;
- RLS Account context and runtime/migrator separation;
- JWT/JWKS, enrollment authorization, route inventory and recovery contracts;
- migrations 001–006 as immutable forward history;
- the missing-state 503 path as defense in depth;
- sanitized logs and no provider/private evidence in tests.

No Flutter schema, Drift migration, UI architecture or protocol payload version change is expected.

## 6. Architectural evidence required in I

I must report:

- every Account-creation path found and how it now receives the invariant;
- migration 007 object names, ownership, security mode, search path, grants and trigger timing;
- backfill query semantics, lock/conflict behavior and preservation evidence;
- readiness-v2 compatibility and application call-site change;
- fixture/proof changes that stop manually masking provisioning;
- first-submission and defense-in-depth behavior;
- fresh/upgrade/rollback/concurrency results;
- unchanged dependencies, or the exact evidence for any deviation;
- later deployment order and residual risks without claiming provider completion.

Stop rather than materialize an exclusive procedure, enrollment repair, first-Sync repair, existing-row
reset or privilege broadening.
