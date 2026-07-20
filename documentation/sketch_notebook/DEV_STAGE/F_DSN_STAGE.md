# F_DSN_STAGE — Hosted Purchase Correction Design

> Authority marker: C10-MCG02-HOSTED-PURCHASE-CORRECTION_20260720T193745Z
> Status: **ACTIVE CODEX DESIGN AUTHORITY**

## Selected boundary

~~~text
Catalogue Store UI
  -> Store application/repository port
  -> existing Account-scoped Drift stores table

Purchase UI -> existing Store reference -> LocalPurchaseRepository transaction
  -> Purchase + Items + purchase.registered v3 + pending outbox
~~~

No new server table, API route, event version or Drift migration is expected. A migration requires
new Main reconciliation if concrete evidence proves it unavoidable.

## Invariants

- Store creation and listing use the active Account only;
- Purchase references an existing same-Account Store;
- hosted Account/server Device selected after restart remain the event envelope identities;
- registration is atomic and advances Device sequence exactly once on success, never on rollback;
- success creates exactly one immutable event and one pending outbox row;
- local-only facts, hosted binding and enrollment state remain unchanged;
- UI depends on application ports; Drift stays in infrastructure;
- diagnostics are closed, typed and non-secret.

## Rollback and deferrals

Failure preserves the prior database and in-memory draft. Source rollback is the bounded correction
commit; no provider rollback is involved. Durable draft storage, full Store editing/archive UX,
provider mutation, deployment, permanent promotion and MCG-03/04 remain deferred.
