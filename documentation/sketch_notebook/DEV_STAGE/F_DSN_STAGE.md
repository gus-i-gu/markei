# F_DSN_STAGE — R04C02 Core Authorization Matrix Design Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C02_20260717T151546Z
> Required ancestry: 40e0a7097fef7f8a7abfe172cc867b670dfec196
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Selected topology

~~~text
case fixture
→ real loopback Fastify route
→ production authorization transaction
↔ R04C01 participant-aware barrier
→ committed authority/target/enrollment intervention
→ typed result
→ R04C01 Account observer
→ ScenarioResult
→ exact case map
~~~

Production depends only on the inert barrier interface. Proof modules depend on production modules.
No public route or environment variable may expose the barrier.

## 2. Reuse boundary

Extend, do not replace:

- `AuthorizationBarrierController`;
- canonical Account observer;
- synthetic JWKS/identity/Account/Device arrangement;
- safe scenario result and producer mapping;
- finally-owned app/pool/server/container cleanup.

Extract shared fixture helpers where needed. Avoid a single oversized scenario function and avoid
duplicating whole database setup per case when safe reset/isolated Account fixtures suffice.

## 3. Transaction race design

Use the narrowest existing phase:

- membership removed: before identity/membership fence;
- external identity disabled: after membership lock or before first protected mutation, with a
  subsequent in-transaction authority recheck sufficient to observe the committed disable;
- actor Device revoked: before actor Device lock;
- target revoke concurrency: before target transition;
- enrollment concurrency: before protected mutation/commit as appropriate.

If current code cannot observe a required committed transition, first retain the failing scenario,
then make the narrowest transaction-fence correction. Do not add sleeps or weaken locks.

## 4. Valid route fixtures

Every actor-revocation case begins with valid JWT, active identity/member/actor Device and valid
route-specific input.

For recovery routes, seed a compatible available snapshot and Device-bound rebootstrap session with
valid requested chunk/state. The expected response after release must be an authorization denial,
not cursor expiry, recovery unavailable, validation failure or not-found caused by bad setup.

## 5. Target authorization model

Use the existing role model:

- owner: may inspect/revoke Account Devices;
- member: may inspect/revoke self only;
- foreign identity/Device: denied;
- other Account: denied without target disclosure.

Target queries and transitions remain Account-scoped and locked. Cross-Account truth must not leak
through different status, body or mutation behavior.

## 6. Revoke concurrency model

Equivalent required sequence:

~~~text
authorize and lock actor/target
→ if active, one active-to-revoked transition
→ one device-revoked security event
→ commit
→ concurrent/later equivalent request returns duplicate-equivalent
~~~

Assert exact durable counts through the committed-view observer. A second transition or security
event fails the case. After self-revoke, the same actor must fail a later protected route.

## 7. Enrollment concurrency model

Retain enrollment contract v1, enrollment request identity, installation identity and canonical
request hash.

- equivalent concurrent requests converge on one Device, one active enrollment and equivalent
  stored result;
- same enrollment request ID plus different hash returns conflict and preserves the first result;
- no extra Device, enrollment or security event may be created.

Do not solve races with an in-memory cache; PostgreSQL remains the durable authority.

## 8. Observer assertions

Extend comparison helpers only as needed for:

- exact unchanged protected state;
- expected authority transition plus otherwise unchanged state;
- one Device transition and one event;
- duplicate-equivalent no-new-state;
- one enrollment/result convergence;
- conflicting-hash preservation.

Snapshots remain payload-free, canonical, sorted and taken from a separate committed-view
connection. Do not log entire before/after snapshots in ordinary output.

## 9. Scenario and producer architecture

Each scenario returns a closed result with case ID, pass/fail, safe blocker, response class and
invariant counts. The authorization producer consumes these results directly.

At R04C02 success:

~~~text
cases 1–24 = true
cases 25–28 = false / pending-r04c04
producer passed = false
~~~

The validated case 1 may be rerun as part of the producer; do not hard-code it true without executed
scenario output in the current producer run.

## 10. Resource and retry boundaries

Use deterministic barrier timeouts and bounded test deadlines. Every server, pool, waiter and
container is owned by one harness and closed in `finally`. Exact filtered Docker inventory must be
empty after success or failure.

Serialization retry exhaustion and post-commit response loss are R04C04 and must not be added here.

## 11. Retained versions

Retain migrations 001–006, event v3, cursor `c10b:*`, recovery format 1, enrollment contract v1,
Drift v7, JWT RS256, producer schema v1 and current dependencies/lockfile.

No migration, protocol or dependency change is selected.

## 12. Validation and rollback

Validate focused scenarios, full server suite/build, authorization producer shape, migration hashes,
audit, diff, secret scan and teardown. R04C02 is one rollback boundary; narrow production fixes must
remain individually visible in I with their retained failing tests.

## 13. Required design report

I must record:

- final dependency direction;
- shared fixture/scenario decomposition;
- phase used by every race family;
- valid recovery-route fixture strategy;
- target/role rules;
- exact transition/event/enrollment invariants;
- producer truth and four deferrals;
- resource ownership;
- retained versions;
- every production deviation and unresolved issue.

Do not claim R04C04, R05, provider or Cycle 10 completion.
