# E_DDC_STAGE — Drift v8 Repair Semantics

> Authority marker: C10-MCG02-DRIFT-V8-FK-REPAIR_20260720T221440Z
> Status: **ACTIVE CODEX DIDACTIC AUTHORITY**

## Truthful states

- `local-database-upgrade-required`: an older supported database must upgrade before use.
- `local-database-upgrade-completed`: schema v8 committed and passed integrity validation.
- `local-database-upgrade-failed`: upgrade did not commit; do not claim facts were repaired.
- `purchase-registration-insert-purchase-failed`: retained bounded diagnostic for a transaction that
  did not apply.
- `registered-locally`: allowed only after Purchase, Items, event and outbox commit atomically.

Migration success is not synchronization, backup, hosted convergence or MCG-02 closure. A repaired
database retains the same Account, Device binding, facts, cursor and queued work; it does not create
a new identity or silently discard local data.

Production diagnostics must not expose SQL, exceptions, paths, identifiers, payloads, credentials
or provider configuration. Tests may inspect disposable schema metadata and in-memory causes.

Required semantic evidence names the migrated version, preservation assertions, foreign-key check,
reopen result and atomic registration result. No wording may claim the human database is corrected
until a separate human build/retest opens and upgrades it successfully.
