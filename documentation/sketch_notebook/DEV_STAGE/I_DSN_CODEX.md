# I_DSN_CODEX - C10-MCG02-R04B Partial Design Evidence

Authority marker: C10-MCG02-R04B_20260717T133814Z
Controlling J SHA: 0765255c07e3381f74cd9b4e90bc2f9ddd3b13dc
Controlling D/E/F commit SHA: 22467716ae9ba0fb93ee775781c7177db88320fc
Baseline remote SHA: 22467716ae9ba0fb93ee775781c7177db88320fc
Actual implementation start UTC/local: 2026-07-17T14:07:03.8882432Z / 2026-07-17T11:07:03.9099962-03:00
Actual implementation end UTC/local: 2026-07-17T14:18:14.3066132Z / 2026-07-17T11:18:15.8255067-03:00
Implementation tree SHA: not created; worktree remains uncommitted
Final commit status: not committed or pushed
Evidence environment: Windows PowerShell; Docker Desktop desktop-linux; PostgreSQL 18.4 disposable preflight; Node server workspace
Result classification: C10-MCG02-R04B_PARTIAL

## Dependency Direction

Implemented partial direction:

```text
production authorization services
    accept inert-by-default barrier seam
lab/proof code
    may inject barrier later
normal hosted composition
    remains no-op and has no public barrier route
```

No proof module dependency was added to production composition.

## Barrier Interface And Containment

Added phases:

- `before-identity-membership-fence`
- `after-membership-lock`
- `before-actor-device-lock`
- `before-target-transition`
- `before-protected-mutation`
- `before-commit`

Containment evidence: normal hosted production entrypoint has no `AuthorizationBarrier` import, and the default exported barrier is immediate no-op.

## Transaction Fence Ordering

The seam observes the intended order without changing schema or contracts:

1. verified external principal input;
2. transaction;
3. identity/membership fence;
4. actor Device fence;
5. target authorization where applicable;
6. protected mutation.

An optional before-commit transaction hook was added but final before-commit scenario evidence was not produced.

## Not Completed

- Lab barrier controller with reach/release/waiter cleanup was not completed.
- Account-scoped observer was not completed.
- Route fixture architecture for all protected operations was not completed.
- Concurrency, replay, restart and retry mechanisms were not completed.
- Authorization producer remains partial.
- R04B aggregate was not run.

## Resource Ownership And Versions

Preflight resource ownership was proven: one disposable PostgreSQL 18.4 container was started, queried, removed and absent from final inventory.

Retained unchanged: migrations 001-006, event payload v3, cursor `c10b:*`, recovery format 1, hosted enrollment contract v1, Drift v7, JWT RS256, producer schema v1, dependencies and lockfiles.

No narrow production defect correction was made. R05 Flutter and provider proof remain deferred.
