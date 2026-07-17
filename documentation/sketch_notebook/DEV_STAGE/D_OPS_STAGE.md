# D_OPS_STAGE — R04C04 Authorization Completion Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R04C04_20260717T154951Z
> Required ancestry: 4f8c1567521ffb7deb93541a3af7f4a713986058
> Controlling R04C02 authority: f1fe19135ba47c652cd2575d7256a74f871f78bb
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Objective

Complete server-side R04 authorization proof:

~~~text
split oversized scenario module
→ response-loss replay
→ process-restart replay
→ serialization retry exhaustion
→ global denial no-state-advance
→ authorization producer true
→ R04 aggregate accepted with Flutter deferred
~~~

R05 and provider proof remain excluded.

## 2. Safety and environment gate

Confirm branch, fast-forward-only state, required ancestry and clean/non-overlapping worktree.
Preserve private/unrelated files without reading them.

Before mutation prove Docker/PostgreSQL 18 start, readiness, query, removal and empty exact filtered
inventory on loopback. Stop without mutation if unavailable; do not configure host software.

## 3. CP-0 — structural recovery correction

`authorization_slice_scenarios.ts` is 1,669 lines. Split it by responsibility before new behavior:

- result/case types and case sets;
- shared fixture/environment/HTTP/database helpers;
- membership and actor-Device scenarios;
- target/revoke/enrollment scenarios;
- replay/restart/retry scenarios;
- a compact public facade/orchestrator.

Keep ordinary handwritten modules near 250 lines where practical. Avoid a replacement monolith.

CP-0 must be behavior-preserving:

- no case IDs or producer schema change;
- existing 24 cases rerun and remain true;
- format/lint/typecheck/tests pass before CP-1;
- imports remain one-way from scenario modules to production, never production to proof.

## 4. CP-1 — response loss and process restart

Execute `response-loss-query-replay`:

1. arrange valid identity, membership and enrollment request;
2. allow the real enrollment transaction to commit;
3. suppress only delivery of the successful response at a lab transport seam;
4. query the existing enrollment-status route with the same authenticated identity/request ID;
5. require the committed equivalent result and one durable Device/enrollment/security event truth.

Execute `process-restart-replay`:

1. commit through composition A and suppress delivery after commit;
2. close composition A, its pools/JWKS/app and all in-memory state;
3. open composition B over the same PostgreSQL database;
4. replay/query the same request identity and hash;
5. require the same durable result with no duplicate Device, enrollment or security event.

Loss must occur after commit. Do not simulate this by throwing inside the transaction or by keeping
an in-memory result cache.

## 5. CP-2 — serialization retry exhaustion

Execute `serialization-retry-exhaustion-fails-closed` through the real bounded transaction wrapper.

Use deterministic lab-only conflict injection that produces PostgreSQL retryable SQLSTATE `40001`
or `40P01` after protected writes but before commit for every allowed attempt. Record exact attempt
count, bounded completion and final typed failure. All attempts must roll back; Account observation
must show no submission, event, cursor, acknowledgement, recovery, Device, enrollment or security
event advance.

Do not use sleeps, an unbounded loop, raised retry limits, or a generic pre-transaction exception.
Any transaction hook must be context-aware, injected, inert by default and inaccessible publicly.

## 6. CP-3 — global denial invariant and producer

Derive `denied-no-state-advance` from executed ScenarioResults, not a hard-coded boolean.

Maintain an explicit closed list of authorization-denial scenarios. Every listed denial must have:

- expected typed authorization response;
- `stateInvariant=true` for prohibited protected state;
- no missing/duplicate case result.

Include serialization exhaustion in the fail-closed/no-state proof. Positive target/enrollment/replay
cases are not denial cases and must not be mislabeled.

Then rerun all 28 authorization cases. All must be true and the authorization producer must pass.

## 7. R04 aggregate

Run the existing R04 orchestrator and require:

- migration-006-lifecycle-acl true;
- jwks-state-machine true;
- route-inventory true;
- static-regression true;
- authorization-race true;
- Flutter producer valid and false only for `not-yet-r05`;
- aggregate false only because Flutter is deferred;
- proof-pipeline integrity true.

Do not change aggregation rules merely to obtain success.

## 8. Evidence rules

Each remaining case returns a structured ScenarioResult with exact case ID, operation, response,
state invariant, attempt/result/event counts and safe blocker. Producer truth consumes scenario
results directly. No test prose parsing, inherited truth or broad command-exit substitution.

## 9. Production correction rule

Proof first. Production code changes require a retained failing scenario, must be narrow and
version-preserving, and must be identified in I. Do not weaken authorization, locking, retries,
Account scoping or idempotency.

## 10. Validation

Record exact commands/results:

- environment preflight;
- CP-0 24-case regression before new cases;
- focused replay/restart/retry/denial tests;
- all 28 authorization scenarios and producer;
- all six proof producers and R04 orchestrator;
- server format, lint, typecheck, full tests and build;
- npm audit `--omit=dev`;
- migrations 001–006 hashes;
- git diff check and tracked/staged secret scan;
- empty final exact Docker inventory.

Flutter producer execution is required by the R04 orchestrator, but no Flutter implementation change
is authorized. Record host build exclusions truthfully.

## 11. Scope

Allowed: proof scenario decomposition, lab-only injected seams, narrowly required transaction code,
producer/orchestrator tests, and G/H/I.

Forbidden: providers/credentials; migration/dependency/lockfile changes; Drift/Flutter/UI work;
public debug controls; methodology/permanent memory; A/B/C/J/D/E/F; R05/MCG-03/04.

## 12. Reports and terminal

Replace only G/H/I. Record module split, all four cases, attempt/count evidence, producer/aggregate
outputs, exact paths, deviations, validation, teardown, and final metadata resolution boundary.

Success terminal:

~~~text
R04C04_RESPONSE_LOSS_REPLAY=true
R04C04_PROCESS_RESTART_REPLAY=true
R04C04_RETRY_EXHAUSTION=true
R04C04_DENIED_NO_STATE_ADVANCE=true
AUTHORIZATION_CASES_TRUE=28
AUTHORIZATION_RACE_PRODUCER=true
PROOF_PIPELINE_INTEGRITY=true
C10-MCG02-R04_AUTHORIZATION_PROVED
R05_FLUTTER_PENDING
MCG-02_PROVIDER_PROOF_PENDING
~~~

Otherwise report `C10-MCG02-R04C04_PARTIAL` with exact false cases. Do not begin R05.
