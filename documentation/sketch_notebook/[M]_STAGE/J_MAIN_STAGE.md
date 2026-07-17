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

---

## 11. Append-only reconciliation — R04C01 result

> Reconciliation marker: C10-MCG02-R04C02_20260717T151546Z
> Reconciled at UTC: 2026-07-17T15:15:46Z
> Reconciled at America/Sao_Paulo: 2026-07-17T12:15:46-03:00
> Reconciled implementation: 40e0a7097fef7f8a7abfe172cc867b670dfec196
> Implementation tree: 0740d1038f3b3e3b783dc8d9f1cebeff83571bc4
> Controlling R04C01 J: 2d85523952a3606ec80a3769817cb4ad8e647cb9
> Controlling R04C01 D/E/F: 2f7272a8cacaa790ccfaad6c0c7523eede336460
> Current status: **R04C01 VALIDATED; R04C02 SELECTED**

R04C01 is accepted as validated local evidence within its declared boundary.

Evidence reconciled:

- the remote implementation is a direct child of the controlling D/E/F commit;
- the participant-aware controller, Account observer and reusable scenario runner exist;
- enrollment protected-mutation and target-transition placement were corrected;
- the real upload scenario records a typed 403 after a committed membership disable;
- protected Account synchronization state remains unchanged except for the expected membership
  transition;
- Codex recorded 8 focused tests and 45 total server tests passing;
- Main independently reran format, lint, typecheck, all 45 server tests, build and production audit;
- `git diff --check` passed and the commit changed only the authorized server/proof/report paths.

Main could not independently rerun Docker because Docker is unavailable in the reconciliation
environment. The committed scenario and the recorded Windows/Docker PostgreSQL 18.4 run remain the
environment-scoped evidence for the real database case.

R04C01 terminal accepted:

~~~text
R04C01_BARRIER_CONTROLLER=true
R04C01_ACCOUNT_OBSERVER=true
R04C01_MEMBERSHIP_DENIAL_SLICE=true
AUTHORIZATION_RACE_PRODUCER=false
R04_REMAINING_CASES_PENDING
C10-MCG02-R04C01_PROVED
~~~

## 12. Evidence corrections retained

G/H/I contain two report-header defects:

1. their controlling D/E/F SHA repeats the J SHA; the correct D/E/F SHA is `2f7272a8...`;
2. their implementation tree and final commit fields remained `pending`; Git resolves them to tree
   `0740d103...` and commit `40e0a70...`.

These are observational metadata corrections. They do not invalidate the executed tests or source
evidence. Codex must resolve commit/tree fields accurately in the next G/H/I reports.

## 13. Phase-scheme revision

The earlier forward scheme is preserved above as history. Current coordination merges the former
R04C02 and R04C03 because R04C01 proved their shared controller, observer, fixture and scenario
foundation. R04C04 remains separate because transport loss, process restart and deterministic retry
exhaustion require materially different mechanisms.

Current scheme:

~~~text
R04C01  reusable proof infrastructure + membership-disabled slice       VALIDATED
R04C02  core authorization matrix: identity/member/actor/target/enroll  ACTIVE
R04C04  response loss + restart + retry exhaustion + final R04 aggregate PENDING
R05      Flutter HTTP/file-backed proof + global local aggregate          PENDING
MCG-02   human Auth0 + Neon + Render proof                                PENDING
Promotion and Main Cycle 10 closure                                       PENDING
~~~

R04C02 uses three internal checkpoints:

~~~text
CP-A  identity, membership and actor-Device race cases
CP-B  target authorization, revoke concurrency and later actor denial
CP-C  equivalent/conflicting enrollment concurrency
~~~

The unit may be one commit, but each checkpoint must produce case-addressable results before the
next begins. A failed checkpoint remains diagnosable and cannot be converted into inherited truth.

## 14. R04C02 acceptance boundary

R04C02 must execute cases 2–24 of the existing authorization producer while retaining the validated
case 1. It may then report 24 true cases and exactly four pending cases:

- response-loss-query-replay;
- process-restart-replay;
- serialization-retry-exhaustion-fails-closed;
- denied-no-state-advance.

`AUTHORIZATION_RACE_PRODUCER` remains false until R04C04. R04C02 success is therefore a bounded
matrix checkpoint, not local-security or provider completion.

## 15. Forward authority

D/E/F carrying marker `C10-MCG02-R04C02_20260717T151546Z` are the only active Codex authority.
R04C04, R05, provider mutation, permanent promotion and Cycle 10 closure remain unauthorized.
