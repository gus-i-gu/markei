# I_DSN_CODEX - Drift v8 Repair Design Evidence

- Sequence: FLX-ORD-01
- Role: Codex design evidence report
- Unit: C10-MCG02-DRIFT-V8-FK-REPAIR_20260720T221440Z
- Baseline HEAD: e9f355c61b76975e99f511e3201e6e815c25f7f1
- Final commit SHA: reported in the terminal response after commit creation.

## Migration Direction

The final migration direction is forward-only:

~~~text
supported v1/v2/v3/v4/v5/v6/v7 local Drift database -> schema v8
fresh database -> schema v8
already migrated v8 -> no rewrite
~~~

Historical migration meanings are preserved. Existing databases are not reset.

## Rebuilt Tables

Schema v8 rebuilds only:

- `purchases`
- `purchase_items`

The rebuilt constraints are:

- `purchases.id` primary key
- `purchases.account_id -> local_accounts.id ON DELETE RESTRICT`
- `purchases.store_id -> stores.id ON DELETE RESTRICT`
- `purchases.person_id -> people.id ON DELETE RESTRICT`
- `purchases.payment_method_id -> payment_methods.id ON DELETE RESTRICT`
- `purchase_items.id` primary key
- `purchase_items.purchase_id -> purchases.id ON DELETE CASCADE`
- `purchase_items.product_id -> products.id ON DELETE RESTRICT`
- `currency_code` length check on both rebuilt tables
- current column nullability and timestamp/value columns preserved exactly by copy.

No PostgreSQL schema, wire contract, provider composition, authorization rule, UI surface or event version changed.

## Transaction and Rollback Boundary

The v8 repair:

1. captures purchase/item counts;
2. disables SQLite FK enforcement for table rebuild mechanics;
3. opens one Drift transaction;
4. renames `purchase_items` and `purchases` to v8 temporary tables;
5. creates current tables;
6. copies all columns exactly once;
7. drops temporary tables;
8. validates row counts, `_old` metadata absence, FK targets and `PRAGMA foreign_key_check`;
9. restores FK enforcement in `finally`;
10. validates again after restoration.

Injected validation failure rolls back the transaction. The disposable source can reopen and then repair successfully.

## Preservation Invariants

The migration preserves:

- Accounts and Devices;
- Stores, Products, People and Payment Methods;
- Purchases and Purchase Items;
- sync events and pending outbox rows;
- cursor and acknowledgement state;
- Device sequence;
- recovery progress;
- migration ledger;
- hosted identity and Account/Device binding.

No valid user fact is relabeled, discarded, merged, guessed or synthesized.

## Production Purchase Boundary

The post-repair production path remains:

~~~text
PurchasePage -> RegisterPurchaseCommand -> LocalPurchaseRepository
             -> one Drift transaction
             -> Purchase + Items + v3 event + pending outbox
~~~

The migrated hosted test proves that after v8 repair and reopen, this boundary creates one new Purchase, one Item, one v3 event and one pending outbox row, advances Device sequence from 2 to 3, leaves the cursor unchanged and remains visible in History after close/reopen.

## Deviations and Unresolved Decisions

- Drift generation produced no semantic generated-file diff; line-ending-only churn was restored.
- Platform builds are build evidence only, not runtime/provider acceptance.
- Human database correction remains unproven until a separate human retest opens and upgrades the installed database.
