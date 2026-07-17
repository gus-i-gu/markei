# E_DDC_STAGE — R04C02 Semantic Materialization Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C02_20260717T151546Z
> Required ancestry: 40e0a7097fef7f8a7abfe172cc867b670dfec196
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Evidence boundary

Use exactly:

~~~text
R04C01 reusable slice validated
+ R04C02 core matrix executed
≠ full authorization producer
≠ R04 local aggregate
≠ provider acceptance
~~~

R04C02 may succeed while `AUTHORIZATION_RACE_PRODUCER=false`.

## 2. Core meanings

- current authority: identity, membership, role and Device state rechecked inside the protected
  transaction;
- valid race denial: an otherwise-valid request denied only after committed authority change;
- target authorization: the actor may act on the named Device under current Account/role rules;
- no disclosure: foreign/cross-Account denial does not reveal target existence or state;
- one transition/one event: concurrency yields one durable state change and one matching audit event;
- duplicate-equivalent: replay returns the already-committed equivalent truth without new mutation;
- enrollment convergence: equivalent concurrent enrollment identities resolve to one result;
- conflicting identity: same request identity plus different hash fails closed and preserves first truth.

## 3. Case truth

A case is true only when its named scenario executed the intended route and invariant. A malformed
request, missing recovery fixture, unavailable route, direct-service substitute, inherited broad
observation or passing command alone is not case evidence.

For denial cases, record the typed response and the observer comparison. For mutation cases, record
the exact transition, security-event and durable-result counts.

## 4. Checkpoint meanings

CP-A proves identity/member and actor-Device rechecks across protected routes.

CP-B proves target role/account boundaries, revoke idempotency and concurrent one-transition truth.

CP-C proves enrollment contract-v1 concurrency and conflicting-hash preservation.

These checkpoints share infrastructure but remain separately reported so one failure does not hide
inside a broad matrix result.

## 5. Pending claims

R04C02 must not claim:

- post-commit response-loss recovery;
- process-restart replay;
- serialization retry exhaustion;
- global denied-no-state-advance across all cases;
- authorization producer completion;
- R04/R05/local-security completion;
- Auth0, Neon, Render or production acceptance;
- Cycle 10 closure.

Those claims remain false or pending under R04C04/R05/provider proof.

## 6. Safe diagnostics and privacy

Reports may contain case IDs, synthetic safe identifiers, routes, phases, response codes, booleans,
counts and safe blocker categories. They must exclude JWTs, claims, keys, passwords, provider URLs,
connection strings and fact payloads.

Allowed wording:

~~~text
R04C02 core authorization matrix passed: 24 cases are executed truth.
Four R04C04 cases and the full authorization producer remain pending.
~~~

## 7. Didactic boundary

Do not change permanent didactic memory, learner maturity, KANBAN, glossary, Concept Map or Lecture
Register. H reports only materialized semantics and named evidence.
