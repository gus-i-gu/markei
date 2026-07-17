# D_OPS_STAGE — R05 Flutter HTTP/File-Backed Proof Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R05_20260717T162323Z
> Required ancestry: bddccba29e208ad423d9adfc95b99ed969ade71e
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Objective

Complete all 16 `flutter-http-file-backed` cases with case-addressable evidence, then run a final
local aggregate in which all six producers pass.

R05 proves the local Flutter HTTP/file-backed boundary. It does not contact or accept Auth0, Neon,
Render or production deployment.

## 2. Safety and preflight

Confirm branch, fast-forward-only state, required ancestry and clean/non-overlapping worktree.
Preserve unrelated/private files without reading them.

Before mutation verify:

- Flutter/Dart toolchain and package resolution;
- Docker/PostgreSQL 18 loopback start, readiness, query, removal and empty inventory;
- supported host build targets without installing/reconfiguring host software.

Stop before mutation when the decisive Flutter or Docker/PostgreSQL environment is unavailable.

## 3. Decisive topology

Use real `HttpDeviceEnrollmentTransport`, `HostedEnrollmentCoordinator`, file-backed `LocalDatabase`,
pending local Purchase/outbox state and a loopback hosted Fastify/PostgreSQL fixture with synthetic
RS256 identity. Deterministic Dart HTTP fixtures may supplement edge cases, but cannot replace the
real hosted path for enrollment, unknown outcome and replay.

No provider credentials, public endpoint or fixture authentication may escape this local proof.

## 4. Closed producer evidence

Replace the current broad focused-test mapping with one executed result per exact case ID. Dart/test
or lab code must emit closed machine-readable results that the TypeScript producer validates and
maps directly. Do not mark several cases true from one command exit.

Each result includes case ID, pass/fail, safe blocker and only the counts/state needed by that case.

## 5. Persistence and outcome cases

Execute:

- device-enrolled-applied;
- duplicate-equivalent-distinct;
- conflict-persists-facts-outbox;
- unavailable-persists-facts-outbox;
- close-reopen-preserves-state;
- local-registration-while-api-unavailable.

For every case, preserve existing Purchases and pending outbox events. Conflict and unavailable must
not install a server Device identity. Close/reopen uses the same Drift file and proves hosted state,
facts and outbox truth survive.

Local Purchase registration must remain successful while the hosted API is unavailable.

## 6. Response and deadline cases

Execute:

- malformed-oversized-redirect-fail-closed;
- normal-response-before-deadline;
- stalled-headers-timeout;
- slow-trickle-total-deadline;
- owned-client-closed-on-timeout;
- borrowed-client-preserved;
- late-response-no-durable-mutation.

One absolute deadline covers connection/send, headers and the complete bounded body. A slow trickle
must not renew the deadline. Redirects are not followed. Malformed or oversized responses fail
closed. Expected transport failures become application-owned outcomes; programming errors remain
visible.

An internally owned client/request must be cancelled or closed after timeout. A borrowed client must
remain usable. A late result after the deadline cannot mutate Drift identity, facts or outbox state.

## 7. Unknown-outcome recovery

Execute:

- response-loss-unknown-outcome;
- query-replay-same-request-id.

Suppress delivery only after the hosted enrollment transaction commits. Flutter must persist
`unknown-outcome` with the original enrollment request ID and no invented Device truth. Query/replay
uses the same request ID and an ephemeral fresh token, recovers the committed result and converges
without duplicate Device/enrollment/security-event state.

## 8. Token boundary

Execute `token-not-persisted-or-logged`.

Bearer credentials may exist only in transient request construction. Prove the exact token is absent
from the Drift file/database values, application logs/diagnostics, failure text and retained result
objects. Do not print the token to prove equality; use safe in-memory comparison/redaction evidence.

No Auth0 SDK or production login UI is authorized in R05.

## 9. Producer and final aggregate

`flutter-http-file-backed` must contain all 16 true results and no blockers.

Add or update a final local orchestrator without weakening the accepted R04 gate. It must consume
closed records for migration, JWKS, route inventory, authorization, Flutter and static regression.
All six producers and the aggregate must be true before `R3_LOCAL_SECURITY_PROVED=true`.

Missing, malformed, duplicate or stale output fails closed.

## 10. Production correction rule

Proof first. Change Flutter application/transport code only after a named case fails; retain that
test, keep the correction narrow and version-preserving, and report it in I. No UI redesign.

## 11. Validation

Run and record:

- focused case-addressable Flutter proof;
- complete Flutter format, analysis and tests;
- Android debug and Windows release builds when host-supported;
- all six producers and final aggregate;
- complete server format/lint/typecheck/tests/build and audit;
- protected Python regressions;
- Drift close/reopen and no-reset evidence;
- migrations 001–006 hashes;
- `git diff --check`, tracked/staged secret scan and exact teardown inventory.

Build success is not runtime/platform acceptance. Record unsupported host checks as exclusions.

## 12. Scope

Allowed: Flutter hosted ports/coordinator/HTTP transport, focused file-backed proof, local lab fixture,
Flutter producer/final aggregator, narrow tests and G/H/I.

Forbidden: providers/credentials; migrations/dependency/lockfile changes unless an existing pinned API
is demonstrably insufficient and Main stops/reconciles first; production deployment; UI; permanent
memory/methodology; A/B/C/J/D/E/F; scenario pruning; MCG-03/04.

## 13. Reports and terminal

Replace only G/H/I. Report all 16 cases, Drift/fact/outbox invariants, deadline/client behavior,
token scan, producer/aggregate results, builds/exclusions, paths, deviations and teardown.

Success terminal:

~~~text
FLUTTER_HTTP_FILE_BACKED_CASES_TRUE=16
FLUTTER_HTTP_FILE_BACKED_PRODUCER=true
AUTHORIZATION_RACE_PRODUCER=true
PROOF_PIPELINE_INTEGRITY=true
R3_LOCAL_SECURITY_PROVED=true
C10-MCG02-R05_FLUTTER_PROVED
MCG-02_PROVIDER_PROOF_PENDING
CYCLE_10_PRUNING_AND_PROMOTION_PENDING
~~~

Otherwise report `C10-MCG02-R05_PARTIAL` with exact false cases. Do not access providers.
