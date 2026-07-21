# F_DSN_STAGE — Windows Recovery Retest Boundary

> Authority marker: C10-MCG02-WINDOWS-RECOVERY-RETEST_20260721T014246Z
> Required ancestor: 82db09dbb56883ec00b309c1444df8197337947c
> Status: **ACTIVE HUMAN VALIDATION AUTHORITY; CODEX MUTATION PAUSED**

## Validated implementation boundary

~~~text
Native Closure Sync
  -> HostedSyncCoordinator
  -> scoped failed/notApplied recovery
  -> canonical immutable upload 1,2
  -> Render API / Neon transaction
  -> download + acknowledgement
  -> durable local accepted state
~~~

The provider retest validates this existing dependency path; it must not redesign it. The local
database remains authoritative for preserved local History and immutable queued events. Neon
evidence confirms only accepted hosted state for the scoped Account/Device.

## Acceptance invariants

1. Local facts and event identities remain unchanged through recovery.
2. The old failed attempt becomes superseded; one retry becomes accepted.
3. The server accepts sequences `1,2` exactly once and expects `3` afterward.
4. Reopen/repeat produces no second submission or duplicated fact.
5. Acknowledgement follows committed upload/download application.
6. Six older local-only Device events remain outside the hosted Device scope.
7. No source/provider/database mutation is authorized by this validation stage.

If any invariant cannot be established with sanitized evidence, record partial and return to Main.
