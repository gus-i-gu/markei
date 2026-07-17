# J_MAIN_STAGE — Cycle 10 R04C01 Vertical-Slice Coordination

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C01_20260717T143908Z
> Staged at UTC: 2026-07-17T14:39:08Z
> Staged at America/Sao_Paulo: 2026-07-17T11:39:08-03:00
> Reconciled implementation: fab9357224cd6e4fb532f02e0c1e33f161a4e615
> Prior authority: 22467716ae9ba0fb93ee775781c7177db88320fc
> Status: **R04B PARTIAL ACCEPTED; R04C01 SELECTED**
> Active unit: **R04C01 — Reusable Authorization Proof Vertical Slice**

## 1. Reconciliation

R04B proved Docker/PostgreSQL availability and added an inert barrier interface, phase names, several
reach points and containment tests. Git later published that partial work as fab9357.

R04B did not add:

- an active lab barrier controller;
- participant-aware reach/release coordination;
- an Account state observer;
- case-addressable authorization scenarios;
- producer completion or R04 aggregation.

Source inspection also found:

- enrollment reaches before-protected-mutation after earlier durable writes;
- before-commit is a generic database callback without operation/participant context.

Therefore:

~~~text
C10-MCG02-R04B_PARTIAL
AUTHORIZATION_RACE_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
~~~

## 2. Strategy correction

The previous unit was too broad. R04 is now decomposed into independently successful slices:

~~~text
R04C01  proof infrastructure + one membership-denial slice
R04C02  identity, membership and actor-Device route matrix
R04C03  target Device and enrollment concurrency
R04C04  response loss, restart, retry exhaustion and final R04 aggregate
R05      complete Flutter HTTP/file-backed proof and global local aggregate
MCG-02   human/provider Auth0 + Neon + Render proof
Promotion and Main Cycle 10 closure
~~~

Only R04C01 is active.

## 3. R04C01 objective

Build reusable proof infrastructure and prove one complete scenario:

~~~text
working deterministic barrier controller
+ corrected transaction phase placement
+ canonical Account state observer
+ membership-disabled-before-fence upload denial
~~~

The authorization producer remains false after this unit. That is expected and does not make
R04C01 partial.

## 4. Reusable infrastructure

R04C01 selects:

- a participant-aware lab barrier controller;
- context-aware transaction lifecycle signaling;
- canonical payload-free Account snapshots;
- a reusable arrange/snapshot/pause/intervene/release/compare scenario runner;
- deterministic cleanup and safe ScenarioResult output.

Later R04 and recovery/synchronization assays should add scenarios to these mechanisms rather than
rebuild them.

## 5. Phase corrections

Required meanings:

| Phase | Placement |
| --- | --- |
| before-identity-membership-fence | inside transaction, before current identity/membership resolution |
| after-membership-lock | only after relevant identity/membership rows are actually locked |
| before-actor-device-lock | immediately before actor Device FOR UPDATE |
| before-target-transition | after authorization/locks, immediately before transition |
| before-protected-mutation | immediately before the first durable write |
| before-commit | after writes and before COMMIT, with operation/participant context |

R04C01 must correct enrollment placement and remove or replace context-free before-commit behavior.

## 6. Representative scenario

Use membership-disabled-before-fence on a valid upload:

1. seed an active identity, membership and Device;
2. prepare a valid purchase submission;
3. capture Account state;
4. pause upload before membership resolution;
5. disable membership from a control transaction;
6. commit the control transition;
7. release upload;
8. require typed 403 authorization denial;
9. capture Account state again;
10. prove protected synchronization state did not advance.

The membership status transition itself is expected. Facts, submissions, events, cursors,
acknowledgements, recovery state, Devices and security-event state must otherwise remain unchanged.

## 7. R04C01 terminal

Success:

~~~text
R04C01_BARRIER_CONTROLLER=true
R04C01_ACCOUNT_OBSERVER=true
R04C01_MEMBERSHIP_DENIAL_SLICE=true
AUTHORIZATION_RACE_PRODUCER=false
R04_REMAINING_CASES_PENDING
C10-MCG02-R04C01_PROVED
~~~

Do not mark denied-no-state-advance globally true. It remains pending until the wider matrix covers
all required state families.

## 8. Validation boundary

R04C01 validates:

- Docker/PostgreSQL preflight;
- barrier controller lifecycle and timeout tests;
- phase-placement tests;
- Account snapshot canonicalization;
- real Fastify/PostgreSQL representative scenario;
- complete server format/lint/typecheck/tests/build;
- diff, secret and teardown checks.

Full Flutter builds, all proof producers and global aggregation return in R04C04/R05 unless a shared
contract changed.

## 9. Scope boundary

R04C01 excludes:

- the other 27 authorization cases;
- provider access or credentials;
- migrations, dependencies, lockfiles and Drift changes;
- Flutter R05 work;
- UI, MCG-03, MCG-04, deployment and permanent promotion.

Production correction requires a retained failing vertical-slice test and must remain narrow.

## 10. Forward coordination

After R04C01 reconciliation:

- R04C02 reuses the controller/observer for identity, membership and actor Device cases;
- R04C03 reuses them for target and enrollment concurrency;
- R04C04 adds response-loss/restart/retry evidence and runs the full authorization aggregate;
- R05 proves the complete Flutter transport/file-backed boundary;
- human MCG-02 proves provider configuration;
- functional domains promote accepted evidence;
- Main closes Cycle 10 only after all named gates reconcile.

No later unit is automatically authorized by R04C01 completion.
