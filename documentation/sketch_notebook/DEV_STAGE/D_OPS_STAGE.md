# D_OPS_STAGE — Hosted Purchase Registration Correction

> Authority marker: C10-MCG02-HOSTED-PURCHASE-CORRECTION_20260720T193745Z
> Required ancestor: a3d2c782584054fdd53a71a90aab0d8ead78e12f
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Objective

Reproduce and correct failed local Purchase registration after a valid hosted Account/Device
restart, expose sanitized typed failure evidence, and add explicit Account-scoped Store creation to
Catalogue. Resume provider proof only after deterministic local validation.

## Checkpoints

1. Reproduce the failure with file-backed Drift using a hosted binding, existing Product and Store.
2. Capture the exact failure in tests; production diagnostics expose only stable code and recovery.
3. Add a separate Catalogue Stores section: list, create, trim/validate and deterministic duplicate
   handling through an application port and repository implementation.
4. Make Purchase select an existing Store; when none exists, direct the user truthfully to
   Catalogue. Remove ambiguous inline Store creation.
5. Fix the proven hosted-binding registration cause without weakening Account/Device scope.
6. Prove success creates exactly one Purchase, Item set, `purchase.registered` v3 event and pending
   outbox row; failure rolls back all mutations including Store and sequence advance.
7. Reopen file-backed Drift and prove Store, Purchase, event, outbox, binding and sequence persist.
8. Run formatting, analysis, full Flutter tests, focused tests, supported Windows/Android builds,
   `git diff --check` and tracked/staged secret scan.

## Required tests

- empty Store rejected; same-Account duplicate deterministic; cross-Account visibility denied;
- Purchase requires existing Store and retains the staged in-memory draft on failure;
- typed `AppFailure` and unexpected error produce bounded, non-secret diagnostics;
- local-only and hosted-bound registration both succeed;
- atomic rollback and exact event/outbox counts;
- close/reopen persistence and existing enrollment/binding preservation.

## Stop and scope rules

Stop on evidence requiring migration, provider access, data reset, payload-version change, weakened
authorization or unrelated UI redesign. Do not access Auth0, Render or Neon; deploy; read secrets;
delete user databases; alter permanent documentation; or begin MCG-03/04. Replace only G/H/I after
implementation. Commit and push one bounded correction without force.

Success terminal:

~~~text
C10_MCG02_HOSTED_PURCHASE_REGISTRATION_CORRECTED
~~~

Otherwise report `C10_MCG02_HOSTED_PURCHASE_REGISTRATION_PARTIAL` and the exact blocker.
