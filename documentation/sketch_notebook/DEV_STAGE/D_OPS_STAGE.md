# D_OPS_STAGE — Drift v8 Foreign-Key Repair

> Authority marker: C10-MCG02-DRIFT-V8-FK-REPAIR_20260720T221440Z
> Required ancestor: 00c78e85c19f4acdc5554fb695c181af10616bc0
> Status: **ACTIVE CODEX CORRECTION AUTHORITY**

## Evidence accepted

The file-backed v2-to-v7 lifecycle at `00c78e8` reproduced
`purchase-registration-insert-purchase-failed`. SQLite metadata showed that migrated `purchases`
still references dropped `people_old` and `payment_methods_old`, while `purchase_items` references
dropped `products_old`. The attempted transaction was not applied and preserved all prior state.

## Objective

Add a forward-only Drift schema v8 repair that rebuilds the affected tables with current foreign
keys, preserves every valid row and hosted/local synchronization invariant, and makes Purchase
registration succeed after migration and reopen.

## Checkpoints

1. Increase the Drift schema version from 7 to 8. Do not rewrite the meaning of historical schema
   versions or reset an existing database.
2. In the v7-to-v8 upgrade, rebuild `purchases` and `purchase_items` so foreign keys reference the
   current `people`, `payment_methods`, `products` and other authoritative tables declared by the
   v8 Drift schema. Preserve column values, primary keys, Account scope, timestamps and nullability.
3. Order the rebuild so parent/child facts remain valid. Use one migration transaction where Drift
   and SQLite permit it; restore foreign-key enforcement and fail closed on copy/validation error.
4. Recreate every required index, unique constraint and foreign key. Verify SQLite schema metadata
   contains no `_old` reference and `PRAGMA foreign_key_check` returns no row.
5. Preserve Accounts, Devices, Stores, Products, People, Payment Methods, Purchases, Items, sync
   events, outbox/inbox, cursors, acknowledgements, recovery state, migration ledger and hosted
   identity binding. Do not relabel or synthesize user facts.
6. Add deterministic file-backed tests for malformed v7 -> v8, supported historical v2 -> v8 and
   fresh v8. Record pre/post row counts and representative values; close and reopen each fixture.
7. On repaired migrated fixtures, register through the production Purchase command/repository path
   and prove exactly one Purchase, expected Items, one v3 event, one pending outbox entry, monotonic
   Device sequence and unchanged download cursor before synchronization.
8. Inject migration-copy/validation failure and prove rollback leaves the original disposable v7
   database reopenable. Prove repeated reopen does not repeat or corrupt the repair.
9. Preserve the phase diagnostics from `00c78e8`; they remain safe evidence if another transaction
   boundary fails.

## Validation

- Drift generation and generated-diff review;
- focused v7-to-v8, v2-to-v8, fresh-v8, failure/rollback, reopen and registration tests;
- existing local migration, Purchase repository and application tests;
- full Flutter tests, analysis and formatting check;
- supported Android debug and Windows release builds;
- `git diff --check`, changed-path inventory, secret/artifact scan.

## Stop rules

No human database access/copy/reset, Auth0, Render, Neon, deployment, PostgreSQL migration,
protocol/event/API change, Account/Device rebinding, dependency upgrade, UI redesign, permanent
promotion, MCG-03 or MCG-04. Stop if valid v7 data cannot be preserved losslessly or if repair
requires an unapproved semantic/data-policy decision.

Success terminal:

~~~text
C10_MCG02_DRIFT_V8_FK_REPAIR_PROVED
~~~

Otherwise:

~~~text
C10_MCG02_DRIFT_V8_FK_REPAIR_PARTIAL
~~~
