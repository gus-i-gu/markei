# F_DSN_STAGE — Drift v8 Foreign-Key Repair Design

> Authority marker: C10-MCG02-DRIFT-V8-FK-REPAIR_20260720T221440Z
> Required ancestor: 00c78e85c19f4acdc5554fb695c181af10616bc0
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Selected design

Schema v8 is an additive repair boundary for already-installed v7 databases. It rebuilds malformed
tables from their valid rows into tables generated from the current Drift declarations; it does not
edit an installed database manually or reinterpret user facts.

Target relationship boundary:

~~~text
purchases.person_id          -> people.id
purchases.payment_method_id  -> payment_methods.id
purchase_items.purchase_id   -> purchases.id
purchase_items.product_id    -> products.id
~~~

All other declared Account-scoped and deletion constraints remain those of the authoritative Drift
schema. The implementation must derive the complete table/index shape from repository evidence,
not treat the four lines above as an exhaustive SQL definition.

## Migration invariants

1. Every valid source row is copied exactly once; counts and representative values match.
2. No resulting table/index/foreign key names an `_old` table.
3. `PRAGMA foreign_key_check` is empty before the v8 commit is accepted.
4. Migration failure produces no half-rebuilt schema and the disposable source remains reopenable.
5. Existing hosted identity, Account/Device mapping, cursor, sequence, events and outbox survive.
6. Opening v8 again is idempotent and performs no further data rewrite.
7. A post-repair Purchase uses the unchanged atomic application boundary:

~~~text
PurchasePage -> RegisterPurchaseCommand -> LocalPurchaseRepository
             -> one Drift transaction -> Purchase + Items + v3 event + outbox
~~~

Generated Drift output may change only as required by schema v8 regeneration. No PostgreSQL schema,
wire contract, provider composition or UI surface is part of this unit.

## Test architecture

Use disposable file-backed fixtures, including a deliberately reproduced malformed v7 schema from
the supported historical migration path. Test v7 -> v8 directly, v2 -> v8 transitively, fresh v8,
injected failure/rollback, close/reopen and production-path Purchase registration. Fresh in-memory
success alone is insufficient.

If the repair would require dropping invalid user rows, guessing missing parents or changing
deletion semantics, stop and report the exact policy decision to Main.
