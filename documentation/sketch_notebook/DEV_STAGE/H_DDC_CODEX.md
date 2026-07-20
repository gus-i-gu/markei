# H_DDC_CODEX - Drift v8 Repair Semantics

- Sequence: FLX-ORD-01
- Role: Codex didactic evidence report
- Unit: C10-MCG02-DRIFT-V8-FK-REPAIR_20260720T221440Z
- Baseline HEAD: e9f355c61b76975e99f511e3201e6e815c25f7f1
- Final commit SHA: reported in the terminal response after commit creation.

## Materialized Semantics

- `local-database-upgrade-required`: retained for supported older local databases before open completes.
- `local-database-upgrade-completed`: now means schema v8 committed and passed row-count, schema-reference, FK-target and `PRAGMA foreign_key_check` validation.
- `local-database-upgrade-failed`: if v8 copy or validation fails, the upgrade does not commit and the database is not accepted as repaired.
- `registered-locally`: still means Purchase, Items, event and outbox committed atomically in the production repository transaction.
- `purchase-registration-insert-purchase-failed`: retained as bounded diagnostic wording for the earlier v7 defect and future unrelated insert failures.

## Local Registration Semantics

After repair, the migrated hosted fixture registers through `LocalPurchaseRepository` rather than direct event injection. The successful local registration creates exactly one new Purchase, one new Purchase Item, one `purchase.registered` v3 event and one pending outbox row. Device sequence advances monotonically and the download cursor remains unchanged before synchronization.

Migration success is not synchronization, provider convergence, backup, production acceptance, MCG-02 closure, MCG-03 activation or MCG-04 activation.

## Named Semantic Tests

- `repairs malformed v7 purchase foreign keys and reopens`
- `migrates file-backed v2 database to v8 and reopens`
- `fresh v8 database creates local, recovery and hosted auth tables`
- `v8 repair failure rolls back and source remains reopenable`
- `reopening an already migrated v8 database does not rewrite rows`
- `migrated hosted lifecycle repairs v8 foreign keys and registers purchase`
- Retained tests for local-only registration, hosted-bound registration, exactly one event/outbox, transaction rollback, close/reopen preservation, Store selection, draft preservation and phase diagnostics.

## Wording Boundaries

Unsupported synchronization or closure wording is intentionally absent. No wording claims that the human database is corrected. Human correction still requires a separate human build/retest that opens and upgrades the real installed database successfully.

No production diagnostic exposes SQL, exception text, stack traces, local paths, Account/Device identifiers, payload facts, credentials or provider configuration.
