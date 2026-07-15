# D_OPS_STAGE — C10-MCG02-R04 Operational Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: fd73da6fddf3cc308655c41e0640b045d710d983
> Required implementation ancestry: 7ed037db586d4e257eaa88783bec2c146a409230
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Unit: authorization barrier matrix completion
> Boundary: local repository, loopback HTTP, synthetic identities, disposable PostgreSQL 18

## 1. Objective

Complete the exact 28-case authorization-race producer without starting the full Flutter gate or
provider proof.

The required operational flow is:

~~~text
deterministic local scenario
→ exact authorization outcome
→ Account-scoped before/after state comparison
→ case-addressable producer result
→ closed record validation
→ fail-closed aggregate
~~~

R04 is complete only when every authorization case is produced by its executed scenario.

## 2. Repository safety

Before editing:

1. confirm branch intermid-cycle-recovery;
2. fetch and fast-forward only;
3. confirm both controlling commits are ancestors of HEAD;
4. inspect staged, unstaged and untracked state;
5. preserve unrelated local files;
6. stop on divergence, conflicts or overlapping edits.

Do not stash, clean, reset, discard or force-push. Do not read private Neon/provider helpers.

## 3. CP0 — Correct inherited evidence

Repair three proof meanings before accepting R04:

1. resource-teardown passes only when docker inventory exits zero and trimmed stdout is empty;
2. irrelevant-metadata-preserves-revision measures externally observable negative-cooldown/fetch
   preservation across metadata-only refresh;
3. Flutter token-not-persisted-or-logged is false with blocker not-yet-r05 until R05 measures it.

Add focused regression tests for each correction. Do not start the remaining Flutter cases.

## 4. CP1 — Deterministic authorization lab

Refactor or extend the hosted local lab so one scenario can:

- provision disposable PostgreSQL 18 and migrations 001–006;
- create synthetic external identity, Account memberships and Devices;
- start real loopback Fastify routes;
- pause a named transaction phase through an explicit lab-only barrier;
- perform a concurrent identity, membership or Device transition;
- release the transaction deterministically;
- capture safe response/result and before/after state;
- close server, pools, barriers and container in finally.

Allowed barrier phases:

- before identity/membership fence;
- after membership lock;
- before actor Device lock;
- before target transition;
- before protected mutation;
- before commit.

No timing sleeps may determine ordering. Polling is allowed only for disposable service readiness.

## 5. CP2 — State observer

Add one test-only Account-scoped observer that records canonical safe state for:

- authoritative facts and events;
- stream cursor/high-water and acknowledgements;
- recovery sessions and verified chunk progress;
- Devices and enrollment requests;
- security events.

The observer must:

- sort stable identifiers;
- omit tokens, claims, passwords, facts payloads and connection strings;
- compare exact before/after state;
- distinguish the intended transition from unrelated mutation;
- work from a separate observation connection where transaction visibility matters.

Every denied or retry-exhausted case must prove no protected state advance.

## 6. CP3 — Identity, membership and actor cases

Execute and produce:

1. membership-disabled-before-fence;
2. membership-removed-before-fence;
3. external-identity-disabled-before-mutation;
4. actor-device-revoked-before-upload;
5. actor-device-revoked-before-download;
6. actor-device-revoked-before-acknowledgement;
7. actor-device-revoked-before-capabilities;
8. actor-device-revoked-before-rebootstrap-start;
9. actor-device-revoked-before-rebootstrap-status;
10. actor-device-revoked-before-rebootstrap-chunk;
11. actor-device-revoked-before-rebootstrap-complete;
12. actor-device-revoked-before-device-status;
13. actor-device-revoked-before-device-revoke.

For each route:

- construct a valid authenticated request first;
- create any required valid recovery session/snapshot/chunk state;
- revoke/disable through the barrier;
- require the existing typed 403 authorization outcome;
- compare Account state before and after.

A 400/404/409/503 caused by invalid setup does not satisfy an authorization case.

## 7. CP4 — Target authorization cases

Execute and produce:

14. owner-target-status;
15. owner-target-revoke;
16. member-self-status;
17. member-self-revoke;
18. foreign-target-denial;
19. cross-account-target-denial;
20. concurrent-target-revoke-one-transition-one-event;
21. independent-repeat-revoke-duplicate-equivalent;
22. self-revoked-actor-denied-later.

Prove:

- owner may inspect/revoke an Account Device;
- ordinary member may inspect/revoke only their own Device;
- foreign and cross-Account targets fail closed;
- concurrent revoke causes one transition and one security event;
- later equivalent revoke is duplicate-equivalent;
- a self-revoked actor cannot perform later protected work.

## 8. CP5 — Enrollment, replay and exhaustion cases

Execute and produce:

23. equivalent-concurrent-enrollment;
24. conflicting-enrollment-request-hash;
25. response-loss-query-replay;
26. process-restart-replay;
27. serialization-retry-exhaustion-fails-closed;
28. denied-no-state-advance.

Requirements:

- equivalent concurrent enrollment uses the same installation/request meaning and converges;
- conflicting hash under the same request identity fails closed;
- response-loss commits server state but suppresses delivery before same-identity query/replay;
- restart replay creates a new app/composition against persisted PostgreSQL state;
- retry exhaustion is injected deterministically and stays within the bounded retry budget;
- denial/exhaustion produces exact no-state-advance evidence.

## 9. Producer and aggregation

The authorization producer must use the existing schema-version-1 case inventory. It may not:

- invent replacement case names;
- collapse several meanings into one command exit;
- set unexecuted cases true;
- accept partial/skipped/unavailable evidence;
- supply independent blockers inconsistent with case results.

After R04:

- authorization-race must be true;
- migration, corrected JWKS, route and static producers must be true;
- Flutter must be structurally valid and false only for not-yet-r05 cases;
- global local-security aggregate must remain false.

Update the orchestration acceptance from historical R3D1 to R04 without weakening the later R05
global gate.

## 10. Allowed implementation surface

Expected changes are limited to:

- hosted-local lab/test support;
- proof producers, scenarios, aggregate and orchestration;
- focused server tests;
- the one focused Flutter producer mapping correction;
- G/H/I reports.

Production source may change only when a preserved failing R04 integration scenario proves a direct
contract defect. Record every such deviation.

## 11. Prohibited expansion

Do not:

- contact Auth0, Neon, Render or public services;
- read provider credentials or private helper files;
- add dependencies or edit lockfiles;
- add migration 007 or edit migrations 001–006;
- add Drift v8;
- redesign enrollment, JWT, authorization, routes or UI;
- implement the full R05 Flutter gate;
- modify A/B/C, J/D/E/F, methodology or permanent memory;
- begin MCG-03, MCG-04, deployment or Cycle 10 closure.

Stop and report if a decisive case requires any prohibited expansion.

## 12. Validation

Run and record exact commands/results for:

- server format, lint, typecheck, complete tests and build;
- focused authorization/barrier tests;
- authorization producer;
- corrected JWKS, route, migration, static and Flutter producers;
- R04 orchestrator/aggregate;
- production dependency audit;
- Flutter format, analysis, complete tests and supported builds;
- protected Python regressions;
- migration hash comparison;
- git diff --check;
- changed/staged secret scan;
- final disposable-resource inventory.

Expected partial producer exit codes must be explicitly distinguished from command failure.

## 13. Reports and publication

Replace only:

- DEV_STAGE/G_OPS_CODEX.md;
- DEV_STAGE/H_DDC_CODEX.md;
- DEV_STAGE/I_DSN_CODEX.md.

G records ancestry, exact changed paths, scenario counts, authorization outcomes, no-state snapshots,
commands, test counts, resource teardown and exclusions.

Commit one bounded R04 unit and push only intermid-cycle-recovery without force.

## 14. Terminal result

On complete proof report:

~~~text
PROOF_PIPELINE_INTEGRITY=true
MIGRATION_006_LIFECYCLE_ACL=true
JWKS_STATE_MACHINE_PRODUCER=true
ROUTE_INVENTORY_PRODUCER=true
STATIC_REGRESSION_PRODUCER=true
AUTHORIZATION_RACE_PRODUCER=true
FLUTTER_HTTP_FILE_BACKED_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
C10-MCG02-R04_AUTHORIZATION_PROVED
R05_FLUTTER_PENDING
MCG-02_PROVIDER_PROOF_PENDING
~~~

Otherwise report C10-MCG02-R04_PARTIAL with exact false cases and blockers.
