# D_OPS_STAGE — R04C02 Core Authorization Matrix Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C02_20260717T151546Z
> Required ancestry: 40e0a7097fef7f8a7abfe172cc867b670dfec196
> Reconciled R04C01 J: 2d85523952a3606ec80a3769817cb4ad8e647cb9
> R04C01 D/E/F: 2f7272a8cacaa790ccfaad6c0c7523eede336460
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Objective

Reuse the validated R04C01 proof infrastructure to execute authorization cases 2–24. Retain case 1
as executed truth and leave the four R04C04 cases pending.

This unit merges the former identity/actor and target/enrollment phases because they now share a
working controller, observer and scenario topology. Do not implement R04C04.

## 2. Repository and environment gate

Before mutation:

1. confirm branch `intermid-cycle-recovery`, fast-forward only and clean/non-overlapping state;
2. confirm `40e0a70` is an ancestor of HEAD;
3. preserve private/unrelated files without reading them;
4. run Docker client/server, loopback PostgreSQL 18 readiness/query/removal/empty-inventory preflight.

Stop before source mutation if Docker/PostgreSQL fails. Do not install or reconfigure host software.

## 3. Accepted R04C01 baseline

Preserve:

- participant-aware barrier lifecycle and no-op production composition;
- corrected barrier phase placement;
- payload-free canonical Account observer;
- real membership-disabled-before-fence scenario;
- producer schema v1 and exact 28-case inventory.

Do not rewrite this infrastructure unless a retained focused test demonstrates a defect.

## 4. CP-A — identity, membership and actor Device

Execute these cases through real loopback Fastify routes and PostgreSQL transactions:

1. membership-removed-before-fence;
2. external-identity-disabled-before-mutation;
3. actor-device-revoked-before-upload;
4. actor-device-revoked-before-download;
5. actor-device-revoked-before-acknowledgement;
6. actor-device-revoked-before-capabilities;
7. actor-device-revoked-before-rebootstrap-start;
8. actor-device-revoked-before-rebootstrap-status;
9. actor-device-revoked-before-rebootstrap-chunk;
10. actor-device-revoked-before-rebootstrap-complete;
11. actor-device-revoked-before-device-status;
12. actor-device-revoked-before-device-revoke.

Each request must be otherwise valid before the authority transition. Recovery routes require valid
snapshot/session/chunk fixtures so authorization—not recovery availability—determines the response.

Use deterministic barriers, commit the control transition, release, require the existing typed 403,
and compare Account state. No sleeps may establish order.

## 5. CP-B — target authorization and revoke behavior

Execute:

1. owner-target-status;
2. owner-target-revoke;
3. member-self-status;
4. member-self-revoke;
5. foreign-target-denial;
6. cross-account-target-denial;
7. concurrent-target-revoke-one-transition-one-event;
8. independent-repeat-revoke-duplicate-equivalent;
9. self-revoked-actor-denied-later.

Required invariants:

- owner may manage an Account Device;
- ordinary member may manage only their own Device;
- foreign/cross-Account targets fail without disclosure;
- concurrent revoke yields one active-to-revoked transition and one security event;
- later equivalent revoke returns duplicate-equivalent without another event;
- a self-revoked actor is denied subsequent protected work.

## 6. CP-C — enrollment concurrency

Execute:

1. equivalent-concurrent-enrollment;
2. conflicting-enrollment-request-hash.

Equivalent requests must converge on one Device/durable result. Same request identity with a
different canonical hash must fail closed and preserve the first committed truth. Use enrollment
contract v1; do not create a new protocol.

## 7. Case evidence rules

Every true value must come from an executed `ScenarioResult` containing:

- exact case ID;
- route/operation and participant;
- barrier phase when applicable;
- response status/code;
- before/after invariant result;
- transition/event/result counts where applicable;
- safe blocker when false.

Do not inherit truth from an older broad observation, parse test prose, or mark a case true from
command exit alone. Tests and the producer should call the same scenario functions where practical.

## 8. Checkpoint discipline

Implement and validate CP-A, then CP-B, then CP-C. If one checkpoint fails:

- keep its exact false cases and safe blockers;
- do not begin unrelated production redesign;
- do not mark later cases true without execution;
- report R04C02 partial.

One final commit is preferred. Safe intermediate commits are allowed only on the same branch and
must still reconcile into one bounded R04C02 report.

## 9. Production correction rule

Proof first. Production code may change only when a scenario first fails and remains as a regression
test. Corrections must be narrow, version-preserving and listed in I. Do not weaken transaction
fences or authorization to make tests pass.

## 10. Producer contract

After success:

- cases 1–24 are true;
- response-loss-query-replay is false with `pending-r04c04`;
- process-restart-replay is false with `pending-r04c04`;
- serialization-retry-exhaustion-fails-closed is false with `pending-r04c04`;
- denied-no-state-advance is false with `pending-r04c04`;
- `AUTHORIZATION_RACE_PRODUCER=false` remains expected.

Do not change the case inventory or producer schema.

## 11. Validation

Run and record:

- Docker/PostgreSQL preflight and exact final inventory;
- focused CP-A/B/C scenario tests;
- format, lint, typecheck, full server tests and build;
- authorization producer showing exactly 24 true and four pending cases;
- npm audit `--omit=dev`;
- migrations 001–006 hash comparison;
- `git diff --check`;
- tracked/staged secret scan.

Full Flutter/platform/global aggregation is deferred because no mobile contract should change.

## 12. Scope

Allowed: server authorization/scenario/proof/test files and G/H/I.

Forbidden: providers or credentials; migrations/dependencies/lockfiles; Drift/Flutter/UI; public
barrier controls; methodology/permanent memory; A/B/C/J/D/E/F; R04C04/R05/MCG-03/MCG-04.

## 13. Reports and terminal

Replace only G/H/I. Resolve final tree and commit metadata accurately; if the commit SHA cannot be
known while authoring, say it will be resolved by Main without repeating the wrong authority SHA.

Success terminal:

~~~text
R04C02_CP_A=true
R04C02_CP_B=true
R04C02_CP_C=true
AUTHORIZATION_CASES_TRUE=24
AUTHORIZATION_CASES_PENDING=4
AUTHORIZATION_RACE_PRODUCER=false
R04C04_PENDING
C10-MCG02-R04C02_CORE_MATRIX_PROVED
~~~

Otherwise report `C10-MCG02-R04C02_PARTIAL` with exact false cases. Do not begin R04C04.
