# F_DSN_STAGE — C10-MCG02-R04 Design Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: fd73da6fddf3cc308655c41e0640b045d710d983
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Unit: deterministic authorization transaction and proof architecture

## 1. Selected topology

R04 extends the local proof topology:

~~~text
synthetic identity/Account/Device fixtures
        ↓
loopback Fastify route
        ↓
application authorization service
        ↓
PostgreSQL transaction fence
        ↕
lab-only deterministic barrier
        ↓
protected mutation or denial
        ↓
Account-scoped state observer
        ↓
closed authorization producer record
        ↓
R04 aggregate
~~~

Production modules do not depend on proof modules.

## 2. Dependency direction

Required dependency direction:

~~~text
production contracts and services
    ↑ exercised by
local scenario adapters and lab composition
    ↑ coordinated by
barrier controller and state observer
    ↑ emit
closed proof records
    ↑ consumed by
aggregator/orchestrator
~~~

Barrier and observation interfaces may be injected through application seams only when their
production defaults are inert. Proof modules must never become runtime dependencies of public
composition.

## 3. Transaction fence

The authorization fence must execute inside the same database transaction as protected mutation.
Equivalent ordering:

1. identify external identity;
2. lock/recheck external identity active state;
3. lock/recheck Account membership and role;
4. lock/recheck actor Device Account/identity/active state;
5. validate target permission where applicable;
6. perform protected mutation;
7. write security event when the transition requires it;
8. commit.

Claims verified before transaction entry are input, not authoritative current membership/Device
state.

## 4. Barrier architecture

Use a small test/lab port equivalent to:

~~~text
AuthorizationBarrier.reach(phase, context)
~~~

Production default: immediate no-op.

Lab implementation:

- signals that a named phase was reached;
- waits on an explicit release promise/latch;
- supports one or bounded named participants;
- rejects unknown phases;
- times out safely;
- releases all waiters in finally;
- records no credentials or facts.

Do not use arbitrary sleeps for transaction ordering.

Normal hosted composition must instantiate only the inert implementation. Add a structural or
composition test proving the lab implementation is unreachable there.

## 5. Barrier placement

Authorized phases:

- before identity/membership fence;
- after membership lock;
- before actor Device lock;
- before target transition;
- before protected mutation;
- before commit.

Use the narrowest phase needed for each scenario. Do not add public debugging routes or database
flags to operate barriers.

## 6. State observer

Implement a test-only observer over one Account. Its canonical snapshot should contain hashes,
counts or stable IDs sufficient to compare:

- event/fact identities and stream high-water;
- Device acknowledgements;
- recovery sessions and verified chunks;
- Device state;
- enrollment request identity/hash/result state;
- security event identity/type/subject.

The observer excludes payloads, JWTs, claims and provider data.

Comparison must support:

- exact unchanged assertion;
- expected one-transition assertion;
- expected one-event assertion;
- duplicate-equivalent assertion.

Use a separate committed-view connection when observing concurrent transactions.

## 7. Route scenario architecture

Actor-revocation cases must exercise real loopback HTTP routes, not direct service calls alone.

Build valid fixtures before barrier release:

- valid Account and active membership;
- valid actor Device;
- valid request body/cursor where applicable;
- available compatible snapshot and Device-bound recovery session for recovery status/chunk/complete
  routes.

Then mutate actor authority through the concurrent control connection and require authorization
denial at the fence.

## 8. Target Device transition

Target revoke must be one atomic state transition:

~~~text
lock target Device
→ authorize actor against locked membership/target
→ transition active to revoked if still active
→ insert one security event
→ return transition or duplicate-equivalent truth
~~~

Concurrent attempts may serialize, but cannot emit two transition events. Cross-Account and foreign
targets must not disclose target existence through distinguishable response detail.

## 9. Enrollment concurrency

Use the existing request identity and canonical request hash.

Equivalent concurrency:

- same external identity;
- same Account;
- same installation identity;
- same request identity and canonical hash;
- one accepted durable meaning;
- equivalent results.

Conflict:

- same request identity;
- different canonical request hash;
- safe conflict;
- original result remains authoritative;
- no second Device or enrollment result.

Do not merge arbitrary installations or add a new enrollment protocol.

## 10. Response loss and restart

Response-loss injection belongs at the transport/lab boundary after commit. It must not roll back or
skip the server transaction.

Restart replay topology:

~~~text
first app commits
→ response lost
→ first app closes
→ new Fastify/application composition opens same disposable database
→ same request identity is queried/replayed
→ equivalent persisted result returned
~~~

In-memory caches from the first composition must not be required.

## 11. Serialization exhaustion

Exercise the production retry wrapper with deterministic conflict injection. The proof must observe
the configured bounded number of attempts and the final safe failure.

Do not:

- increase retry limits merely to pass;
- loop without a fixed cap;
- substitute an immediate generic exception;
- leave partial state between attempts.

## 12. Proof-integrity corrections

### Teardown

Capture docker inventory stdout. Pass only on exit zero plus empty trimmed output. Add a focused
test with exit zero/non-empty output.

### JWKS metadata revision

Avoid production introspection. Establish unchanged semantic revision by preserving an existing
unknown-kid negative cooldown across a metadata-only refresh and asserting fetch count does not
advance until cooldown expiry.

### Flutter mapping

Set token-not-persisted-or-logged to not-yet-r05. Do not infer it from the current focused file test.

## 13. Producer architecture

Retain producer schema version 1 and the exact 28 authorization cases.

Prefer:

~~~text
scenario function
→ structured ScenarioResult
→ case map
→ makeProducerResult
→ emitProducer
~~~

Ordinary focused tests and producer execution should call the same scenario functions where
practical. Do not parse test-runner prose.

The authorization producer owns its PostgreSQL/Fastify lab and cleans it in finally. It must emit a
valid false record if a scenario cannot execute, never a fabricated pass.

## 14. R04 aggregation

Add or revise an R04 orchestrator so acceptance requires:

- closed schema integrity;
- migration producer true;
- corrected JWKS producer true;
- route producer true;
- corrected static producer true;
- authorization producer true;
- Flutter producer valid and false only for not-yet-r05 blockers;
- global aggregate false.

Unexpected producer absence, blocker, malformed output or pass-state mismatch fails R04.

R04 must not reuse the historical R3D1 rule that expected authorization to be false.

## 15. Versions retained

Retain exactly:

- PostgreSQL migrations 001–006;
- event payload v3;
- cursor c10b:*;
- recovery snapshot format 1;
- hosted enrollment contract v1;
- Drift schema v7;
- JWT RS256;
- producer schema version 1;
- current dependencies and lockfiles.

No protocol or schema version increment is selected.

## 16. Security boundaries

- loopback and synthetic fixtures only;
- generated local keys only;
- no Auth0/Neon/Render access;
- no provider credentials or private helpers;
- no facts/tokens/secrets in proof records or logs;
- least-privilege migrator/runtime roles in disposable PostgreSQL;
- barriers inaccessible from public routes and normal composition;
- every process, pool, server, waiter, temporary file and container closed in finally.

## 17. Change and rollback boundary

Expected R04 changes are proof/lab modules, focused tests, orchestration and G/H/I.

Narrow production correction is permitted only when:

1. an R04 scenario first fails against the current implementation;
2. the failing test is retained;
3. the correction preserves existing contracts and versions;
4. G/I identify the deviation.

Rollback is one bounded R04 commit. No migration rollback is required because migrations remain
unchanged.

## 18. Stop conditions

Stop if completion requires:

- provider behavior or credentials;
- migration 007 or edits to 001–006;
- a dependency/lockfile change;
- Drift v8;
- public barrier/debug capability;
- enrollment/JWT/route redesign;
- full R05 Flutter work;
- UI, MCG-03, MCG-04 or production deployment.

Report the exact case and architectural reason.

## 19. Required I report

I must record:

- final dependency direction;
- barrier port, phases and composition containment;
- transaction fence ordering;
- state observer scope;
- race/replay/restart/exhaustion mechanics;
- producer and aggregate requirements;
- retained versions;
- resource ownership;
- every production deviation;
- deferred R05/provider decisions.
