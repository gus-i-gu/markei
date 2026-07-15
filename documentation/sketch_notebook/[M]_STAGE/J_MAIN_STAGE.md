# J_MAIN_STAGE — Cycle 10 MCG-02 R3D1 Reconciliation and R04 Selection

> Sequence: FLX-ORD-01
> Reconciled implementation: 7ed037db586d4e257eaa88783bec2c146a409230
> Prior materialization authority: b254b722014dd85871c03926789e6064d3635c88
> Status: **R3D1 CONDITIONALLY ACCEPTED; R04 SELECTED**
> Active next unit: **C10-MCG02-R04 — Authorization Barrier Matrix Completion**
> Evidence boundary: local repository, loopback HTTP, synthetic identities, disposable PostgreSQL 18

## 1. Methodology retained

Main retains:

- J owns cross-domain reconciliation and next-unit selection.
- D/E/F jointly own Codex materialization authority.
- G/H/I are observational implementation evidence, not semantic promotion.
- implementation, validation, provider acceptance and production readiness remain distinct;
- evidence is accepted only within its named environment and scope;
- private provider files and credentials remain outside Codex authority;
- unresolved provider evidence cannot be converted into local proof.

No permanent memory is promoted by this reconciliation.

## 2. Evidence reconciled

R3D1 changed 15 bounded paths:

- G/H/I;
- ten proof producer, scenario and orchestration modules;
- the local hosted harness;
- the proof aggregate test.

It did not change:

- dependencies or lockfiles;
- migrations 001–006;
- Drift schema v7;
- production enrollment, JWT, authorization or route contracts;
- A/B/C, J/D/E/F, methodology or permanent memory;
- Auth0, Neon or Render resources.

Reported validation included:

- TypeScript formatting, lint, typecheck, tests and build;
- 34 server tests;
- production dependency audit with zero reported vulnerabilities;
- Flutter formatting, analysis, tests, Android debug build and Windows release build;
- protected Python regressions;
- disposable PostgreSQL 18 migration and authorization labs;
- changed-path secret scan and final resource inventory.

## 3. R3D1 accepted results

The following claims are accepted as local validation at
7ed037db586d4e257eaa88783bec2c146a409230:

~~~text
PROOF_PIPELINE_INTEGRITY=true
MIGRATION_006_LIFECYCLE_ACL=true
ROUTE_INVENTORY_PRODUCER=true
~~~

The proof record is now closed and versioned. It validates:

- exact top-level and case fields;
- exact producer and case inventories;
- canonical derived blockers;
- consistency between cases, blockers and producer pass state;
- safe failure categories;
- malformed, missing, duplicate and unknown-record rejection;
- fail-closed aggregation.

The orchestrator executes producers and validates their records. Synthetic all-pass records remain
confined to aggregate unit tests.

Migration 006 is accepted as locally validated for the reported fresh, upgrade, duplicate,
failure-copy, ledger, catalog, ACL and readiness scenarios. The tracked migration files were not
changed. Route inventory evidence is accepted as execution of real Fastify readiness scenarios.

Most JWKS state-machine scenarios and the fixed static command results are accepted, subject to the
three corrections below.

## 4. Evidence corrections required before R04 acceptance

Repository inspection found three narrow mismatches between case names and what their producers
actually observe.

### 4.1 Resource teardown

The static producer runs a filtered docker inventory command but marks the case true from exit code
alone. A successful command with non-empty output would still pass.

R04 must require:

~~~text
command exits zero
AND trimmed stdout is empty
~~~

G separately reports an empty final inventory, so R3D1 cleanup is not rejected. Only the producer
case itself remains insufficient.

### 4.2 JWKS irrelevant metadata

The named case verifies that a known token still succeeds after metadata-only JWKS change. That does
not directly demonstrate that the semantic key-set revision was preserved.

R04 must measure the invariant through externally observable state-machine behavior, preferably:

~~~text
install unknown-kid negative cooldown
→ refresh with metadata-only change
→ repeat the same unknown kid
→ prove no extra fetch occurred during the preserved cooldown
~~~

No production introspection API is authorized.

### 4.3 Flutter token logging

The Flutter producer maps one focused three-test command to
token-not-persisted-or-logged=true. Those tests do not inspect logs and therefore do not establish
the complete case.

R04 must return that case to false with blocker not-yet-r05. The full proof belongs to R05.

These corrections do not authorize the full Flutter gate.

## 5. R3D1 completion classification

Accepted:

~~~text
C10-S03A_R3D1_PROVED
R3_LOCAL_SECURITY_PROVED=false
R3D2_AUTHORIZATION_PENDING
R3D3_FLUTTER_PENDING
MCG-02_PROVIDER_PROOF_PENDING
~~~

The historical R3D2 authorization unit is renamed for the active Main sequence as R04. The
historical R3D3 Flutter unit becomes R05. This is a staging label change, not a protocol or source
version change.

## 6. R04 objective

R04 must produce deterministic, case-addressable evidence for all 28 authorization cases already
declared by producer schema version 1.

It must use:

- real local Fastify routes where the case is route-observable;
- disposable PostgreSQL 18;
- synthetic Accounts, identities and Devices;
- deterministic transaction barriers rather than timing sleeps;
- explicit before/after state snapshots for every denial;
- the existing closed producer record and aggregate pipeline.

R04 is proof-first. Production changes are allowed only when a preserved failing R04 scenario
demonstrates a direct defect in an existing contract.

## 7. Required authorization matrix

R04 owns:

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
13. actor-device-revoked-before-device-revoke;
14. owner-target-status;
15. owner-target-revoke;
16. member-self-status;
17. member-self-revoke;
18. foreign-target-denial;
19. cross-account-target-denial;
20. concurrent-target-revoke-one-transition-one-event;
21. independent-repeat-revoke-duplicate-equivalent;
22. self-revoked-actor-denied-later;
23. equivalent-concurrent-enrollment;
24. conflicting-enrollment-request-hash;
25. response-loss-query-replay;
26. process-restart-replay;
27. serialization-retry-exhaustion-fails-closed;
28. denied-no-state-advance.

No case may pass merely because a test file or aggregate command passed. Each case must be tied to an
executed scenario result.

## 8. Authorization invariants

The decisive invariants are:

~~~text
identity active
AND Account membership active
AND actor Device active
AND requested Account matches membership
AND target operation is permitted
~~~

They must be fenced inside the transaction that performs the protected mutation.

A denied or exhausted request must not advance:

- authoritative facts or events;
- cursors or acknowledgements;
- recovery sessions or chunk progress;
- Device or enrollment state;
- security-event state.

Target Device rules remain:

- owner may inspect or revoke an Account Device;
- ordinary member may inspect or revoke only their own Device;
- foreign and cross-Account targets are denied;
- one state transition emits one security event;
- equivalent replay is duplicate-equivalent;
- conflicting request identity/hash fails closed.

## 9. Deterministic barrier hypothesis

R04 may add lab-only barrier hooks equivalent to:

~~~text
before identity/membership fence
after membership lock
before actor Device lock
before target transition
before protected mutation
before commit
~~~

Hooks must:

- be absent from hosted/public composition;
- carry no provider or credential data;
- use explicit release signals, not sleeps;
- close and release in finally;
- not weaken production transaction boundaries.

## 10. Scenario requirements

For every actor-revocation route, construct a valid request and any required recovery fixture before
revoking the actor. The resulting 403 must be attributable to authorization, not malformed input or
unavailable recovery state.

Concurrency and unknown-outcome scenarios must prove:

- concurrent revoke yields one transition and one event;
- equivalent concurrent enrollment converges on one meaning;
- response loss occurs after server commit but before client receipt;
- replay with the same identity returns equivalent truth;
- process-restart replay uses a new app/composition against persisted database state;
- serialization retry exhaustion returns a bounded failure with no state advance.

## 11. R04 checkpoints

### CP0 — Correct proof meanings

- teardown producer checks empty stdout;
- metadata-only JWKS scenario measures revision/cooldown preservation;
- Flutter token logging case returns to false and not-yet-r05;
- regression tests prevent the three overclaims.

### CP1 — Barrier and observer infrastructure

- add deterministic lab-only barriers;
- add Account-scoped before/after state observer;
- prove hooks are absent from normal hosted composition.

### CP2 — Identity, membership and actor fencing

- complete cases 1–13;
- assert exact denial and no state advance.

### CP3 — Target authorization

- complete cases 14–22;
- prove self/owner/foreign/cross-Account behavior and one-event transition.

### CP4 — Enrollment, replay and exhaustion

- complete cases 23–28;
- prove equivalent/conflicting concurrency, unknown outcomes, restart and retry exhaustion.

### CP5 — Producer and aggregate

- authorization-race is true for all exact cases;
- migration, corrected JWKS, route and static producers remain true;
- Flutter remains a valid false producer only for R05 cases;
- global aggregate remains false.

## 12. Exclusions and stop rules

R04 does not authorize:

- Auth0, Neon, Render or public hosted access;
- provider credentials or private helper files;
- migration 007 or edits to migrations 001–006;
- dependency or lockfile changes;
- Drift v8;
- production enrollment/auth redesign;
- full Flutter hosted proof;
- UI or Cycle 11 work;
- MCG-03, MCG-04, production deployment or Cycle 10 closure;
- permanent-memory promotion.

Stop on a need for any excluded expansion and report the exact failing case.

## 13. R04 terminal contract

On complete R04 proof:

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

If any decisive authorization case remains unproved:

~~~text
C10-MCG02-R04_PARTIAL
AUTHORIZATION_RACE_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
~~~

## 14. Forward boundary

R05 will own the complete Flutter HTTP/file-backed matrix and the final local aggregate. Manual
Auth0/Neon/Render proof remains a separate human/provider gate after local proof. Neither is active
inside R04.
