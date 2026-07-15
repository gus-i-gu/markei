# E_DDC_STAGE — C10-MCG02-R04 Semantic Materialization Authority

> Sequence: FLX-ORD-01
> Controlling reconciliation: fd73da6fddf3cc308655c41e0640b045d710d983
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Unit: truthful authorization and race vocabulary

## 1. Governing distinction

Use this semantic chain exactly:

~~~text
case declared
≠ case executed
≠ case passed
≠ producer passed
≠ R04 passed
≠ local security proved
≠ provider accepted
≠ production ready
~~~

R04 may prove the authorization producer. It must not claim the full local-security, provider or
Cycle 10 gate.

## 2. Corrected evidence meanings

The following meanings are mandatory:

- resource-teardown means the inventory command succeeded and found zero matching resources;
- irrelevant-metadata-preserves-revision means externally observed state-machine behavior proves
  metadata-only change did not reset the semantic negative-key revision/cooldown;
- token-not-persisted-or-logged remains unproved until R05 explicitly checks persistence and logs;
- a producer command exit does not replace case-addressable scenario evidence;
- one focused test command cannot silently prove unrelated cases;
- one successful token verification does not expose internal revision identity.

## 3. Authorization vocabulary

- external identity: verified issuer/subject identity mapped to Markei state;
- membership: explicit Account relationship and role;
- actor Device: Device making the protected request;
- target Device: Device inspected or revoked;
- fence: transactional recheck and lock before protected mutation;
- barrier: test-only deterministic pause used to order concurrent actions;
- protected mutation: facts, events, cursor, acknowledgement, recovery, Device, enrollment or
  security-event state change;
- denied-no-state-advance: exact protected state is unchanged after denial;
- one transition: active to revoked happens at most once;
- duplicate-equivalent: repeated same meaning returns an equivalent existing result;
- conflicting request: same idempotency identity with different canonical request hash;
- unknown outcome: server result may have committed while the client did not receive it;
- restart replay: replay through a new app/composition over persisted server state;
- retry exhaustion: bounded serialization/deadlock retries are consumed and the request fails closed.

## 4. Identity and membership semantics

Protected work requires all of:

~~~text
external identity active
membership exists and active
membership Account matches request
actor Device exists, belongs to the Account and is active
operation permitted for the membership role
~~~

These are transaction-time invariants. Pre-transaction authentication or previously loaded claims
do not substitute for the fence.

When identity or membership changes before the fence:

- protected work is denied;
- no protected state advances;
- the result must be attributable to authorization rather than malformed input.

## 5. Actor Device semantics

When the actor Device is revoked before a protected operation reaches its fence:

- upload is denied;
- download is denied;
- acknowledgement is denied;
- capabilities is denied;
- rebootstrap start/status/chunk/complete are denied;
- Device status and revoke operations are denied.

Each case must call the real applicable route with otherwise-valid state. Missing recovery fixtures
or invalid bodies cannot stand in for Device denial.

## 6. Target Device semantics

For an active membership:

- an owner may inspect and revoke an Account Device;
- an ordinary member may inspect and revoke only their own Device;
- another member's Device is foreign to the actor and denied;
- a Device belonging to another Account is denied without disclosure;
- self-revocation immediately prevents later protected actions.

Use the existing closed API errors. Do not add detailed error text that reveals whether a foreign
target exists.

## 7. Concurrency and idempotency semantics

Concurrent target revocation must mean:

~~~text
two authorized attempts
→ one active-to-revoked transition
→ one security event
→ equivalent final Device truth
~~~

Independent later replay of the same semantic revocation is duplicate-equivalent, not a second
transition.

Equivalent concurrent enrollment means both requests carry the same canonical installation and
request meaning. It does not mean two unrelated Device identities are merged.

Conflicting enrollment means the same request identity carries a different canonical hash. It must
fail closed and preserve the first accepted truth.

## 8. Unknown outcome semantics

Response-loss evidence requires:

1. server transaction commits;
2. response delivery is intentionally suppressed;
3. client classifies the result as unknown, not failed-before-submit;
4. query or same-identity replay returns the committed result;
5. no duplicate Device, enrollment or security event appears.

Restart replay requires a new app/composition. Reusing the same in-memory service instance is not a
restart.

## 9. Retry exhaustion semantics

Serialization/deadlock exhaustion must use controlled conflict injection and the real bounded retry
policy.

Passing means:

- every allowed retry is observed;
- no unbounded loop occurs;
- final result is a safe failure;
- no protected state advances.

A mock that simply throws before transaction entry does not prove retry exhaustion.

## 10. Case-level evidence rule

Every case result must be tied to:

- scenario name;
- setup state;
- deterministic interleaving or direct action;
- observed response/result;
- exact state comparison;
- safe blocker on failure.

The producer may summarize those booleans, but G must retain enough named evidence to audit their
meaning.

## 11. Required semantic tests

Name or preserve focused tests covering:

- teardown rejects non-empty successful inventory;
- metadata-only refresh preserves unknown-kid cooldown/fetch count;
- Flutter token logging case stays deferred;
- each identity/membership fence denial;
- each actor Device route denial;
- owner and member target rules;
- foreign and cross-Account nondisclosure;
- concurrent revoke one-transition/one-event;
- equivalent and conflicting enrollment concurrency;
- response-loss query/replay;
- process-restart replay;
- retry exhaustion;
- denial no-state-advance across every protected state family;
- barrier hooks absent from normal hosted composition.

## 12. Allowed completion wording

On complete R04:

~~~text
Authorization barrier matrix proved locally.
Authorization producer passed all 28 declared cases.
Flutter and provider proof remain pending.
R3 local security is not yet proved.
~~~

Do not write:

~~~text
HOSTED_AUTH_READY=true
Auth0 verified
Neon accepted
Render deployed
MCG-02 complete
production ready
Cycle 10 closed
~~~

## 13. Privacy and diagnostics

Proof output may include:

- safe case IDs;
- boolean outcomes;
- safe blocker categories;
- aggregate counts;
- synthetic opaque aliases.

It must not include:

- JWTs, claims or JWK bodies;
- passwords, URLs or provider identifiers;
- Account facts or payloads;
- connection strings;
- private paths.

No new telemetry is authorized.

## 14. Didactic boundary

Do not change:

- permanent didactic memory;
- KANBAN, glossary, Concept Map or Lecture Register;
- learner maturity;
- Cycle 11 UI semantics.

H reports only meanings materialized and meanings deliberately deferred.
