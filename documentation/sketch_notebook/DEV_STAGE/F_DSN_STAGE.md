# F_DSN_STAGE — R04C04 Authorization Completion Design Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C04_20260717T154951Z
> Required ancestry: 4f8c1567521ffb7deb93541a3af7f4a713986058
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Selected topology

~~~text
modular scenario facade
├─ authority/actor scenarios
├─ target/enrollment scenarios
└─ replay/restart/retry scenarios
        ↓
real Fastify + PostgreSQL compositions
        ↓
ScenarioResult[28]
        ↓
authorization producer true
        ↓
R04 orchestrator accepts server producers
        ↓
Flutter remains explicitly deferred
~~~

Production modules must not depend on proof modules.

## 2. Scenario decomposition

Split the 1,669-line module into cohesive modules with a compact compatibility facade. Keep shared
types/case sets free of infrastructure ownership. Put environment lifecycle and fixture builders in
dedicated helpers. Keep scenario-family modules near the ordinary handwritten limit where practical.

The refactor must preserve exported behavior used by tests, harness and producer. First rerun the
existing 24 cases unchanged; only then add R04C04 behavior.

## 3. Response-loss seam

Inject loss at the lab HTTP delivery boundary after the application transaction commits. The seam
may suppress or replace delivery to the caller, but must not alter database commit behavior, stored
result or production route contracts. It remains test-only and unreachable from hosted composition.

Recovery uses the existing authenticated enrollment-status/replay contract and durable request ID,
hash and stored result.

## 4. Restart topology

~~~text
composition A commits request
→ response delivery suppressed
→ close A and its app/pools/JWKS/in-memory state
→ composition B opens same PostgreSQL database
→ same identity/request query or replay
→ equivalent durable result, no duplicate state
~~~

Composition B must not receive any cache or object from A other than database coordinates and safe
fixture configuration.

## 5. Retry-exhaustion seam

Use a lab-injected transaction lifecycle hook carrying operation, scenario, participant and attempt.
It must be absent/inert in normal composition. At the before-commit boundary, execute a PostgreSQL
operation that returns retryable SQLSTATE `40001` or `40P01` for each allowed attempt.

The existing wrapper remains bounded. Each failed attempt rolls back its writes. After exhaustion,
the observer must match the pre-request protected state. Do not add public controls or global
cross-talk between concurrent operations.

## 6. No-state derivation

Maintain a closed denial-case set separate from positive cases. Derive
`denied-no-state-advance=true` only when every denial ScenarioResult is present, passed, has the
expected typed denial and reports `stateInvariant=true`. Include retry exhaustion as fail-closed
state evidence without calling it an authorization 403.

The derived case itself must be inserted into the exact 28-case map; it cannot be hard-coded true.

## 7. Producer and aggregate

Authorization flow:

~~~text
28 executed results
→ exact ordered case map
→ makeProducerResult
→ passed=true, blockers=[]
~~~

R04 orchestration retains six closed producers. It succeeds only when migration, JWKS, route,
static and authorization producers are true; Flutter is valid and false only for `not-yet-r05`;
aggregate false is explained only by that deferral; pipeline integrity is true.

Do not relax parser, blocker, case-set or aggregation checks.

## 8. Durable invariants

Response-loss/restart cases require:

- one Device and active enrollment;
- one enrollment request identity/hash/stored result;
- one corresponding security event;
- equivalent recovered response;
- no extra state after replay/restart.

Retry exhaustion requires exact bounded attempts and zero durable protected mutations.

## 9. Resource ownership

The top-level proof owner closes in `finally`:

- both application compositions;
- JWKS servers and generated keys;
- runtime/migrator/control pools;
- barriers and transaction hooks;
- disposable files;
- PostgreSQL containers.

Teardown success means command exit zero and empty exact filtered inventory.

## 10. Retained versions and scope

Retain migrations 001–006, event v3, cursor `c10b:*`, recovery format 1, enrollment contract v1,
Drift v7, JWT RS256, producer schema v1, current dependencies and lockfile.

No migration, protocol, dependency, Flutter, provider or UI change is selected.

## 11. Rollback and report

R04C04 is one bounded rollback unit. Mechanical module splitting must remain reviewable separately
from behavioral additions within the diff. Narrow production deviations require retained failing
tests and explicit I reporting.

I must record module boundaries, dependency direction, response-loss seam, restart ownership,
retry hook/SQLSTATE/attempt count, denial derivation, producer/aggregate truth, retained versions,
resources and every deviation.

Do not claim R05, provider proof, MCG-02 completion or Cycle 10 closure.
