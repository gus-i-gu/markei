# F_DSN_STAGE — R05 Flutter HTTP/File-Backed Design Authority

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-R05_20260717T162323Z
> Required ancestry: bddccba29e208ad423d9adfc95b99ed969ade71e
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**

## 1. Selected topology

~~~text
file-backed Drift + pending local outbox
→ HostedEnrollmentCoordinator
→ ephemeral AccessTokenSource
→ real HttpDeviceEnrollmentTransport
→ loopback hosted Fastify + PostgreSQL
→ typed outcome persisted in Drift
→ close/reopen comparison
→ 16-case Flutter producer
→ final six-producer local aggregate
~~~

Application ports remain independent of HTTP, Drift and provider SDKs.

## 2. Transport ownership

`HttpDeviceEnrollmentTransport` owns one absolute attempt deadline across send, headers and complete
bounded body consumption. It rejects redirects, malformed JSON, oversized bodies and unexpected
contract fields. Expected network/timeout/cancellation failures become closed transport outcomes;
programming errors remain visible.

Owned request/client resources are cancelled or closed on every terminal path. A borrowed client is
never closed by the transport and remains usable after timeout. Late completions cannot reach the
coordinator as successful results after the deadline.

Use the pinned `http` API. Do not change dependencies unless Main separately reconciles a proven API
gap.

## 3. Unknown-outcome state machine

~~~text
persist request identity
→ send enrollment
→ server commits
→ response delivery lost
→ persist unknown-outcome, no Device truth
→ obtain fresh ephemeral token
→ query same enrollment request ID
→ persist committed Device/account/generation
~~~

Do not generate a new request ID after an unknown outcome. Query/replay is idempotent and durable;
the same PostgreSQL truth must survive server composition restart where exercised by R04.

## 4. Drift invariants

Hosted identity state is protocol state, not authoritative Purchase facts. Across every R05 case:

- existing Purchases and facts remain unchanged;
- pending outbox events remain present unless normal sync explicitly commits them;
- conflict/unavailable/malformed/timeout do not install a server Device ID;
- unknown outcome retains installation and enrollment request identity;
- successful replay installs one equivalent server identity;
- close/reopen returns the same committed local state;
- no reset or replacement of the Drift file occurs.

## 5. Real and deterministic fixtures

The decisive happy/unknown/replay path uses loopback Fastify, disposable PostgreSQL 18, synthetic
RS256/JWKS and the real Flutter HTTP adapter. Dart loopback servers/clients may deterministically
exercise header stall, trickle, redirect, oversize, cancellation and ownership edges.

Fixture authentication remains local-only and structurally absent from hosted production roots.

## 6. Token design

The token source returns an ephemeral credential for a single request. Neither coordinator state,
Drift tables, transport results nor logs retain it. Tests may compare a credential in transient
memory but must never print it. Token proof scans durable file content/rows and captured redacted
diagnostics.

No production Auth0 SDK, callback handler, client secret or login UI is selected.

## 7. Case producer

Define one closed Dart/proof result per existing producer case. The TypeScript producer consumes a
machine-readable record, validates exact case set/order and calls `makeProducerResult`.

Do not infer multiple case truths from one test process exit. Safe blocker categories are required
for every false case.

## 8. Final aggregation

Preserve the R04 orchestrator as an authorization-era diagnostic. Add or adapt a final local
orchestrator that requires all six producer records true and `aggregateProofResults(...).passed`
true before emitting `R3_LOCAL_SECURITY_PROVED=true`.

No special deferred blocker remains after R05. Missing/malformed/duplicate producer output fails
closed.

## 9. Local-first availability

Hosted enrollment/sync unavailability cannot block `RegisterPurchase`. The local transaction commits
facts and its pending event first; remote work remains retryable. R05 does not add UI or automatic
background policy.

## 10. Resource ownership

One lab owner closes Flutter test processes, Fastify/JWKS, PostgreSQL pools/container, HTTP clients,
temporary Drift files and captured logs in `finally`. Teardown requires successful cleanup and empty
exact filtered inventory.

## 11. Retained versions

Retain migrations 001–006, Drift v7, enrollment contract v1, event v3, cursor `c10b:*`, recovery
format 1, JWT RS256, producer schema v1 and current dependencies/lockfiles.

No schema or protocol increment is selected.

## 12. Rollback and report

R05 is one bounded rollback unit. Production changes require retained failing cases. I reports final
dependency direction, timeout/cancellation design, client ownership, unknown-outcome transitions,
Drift invariants, token boundary, fixture containment, producer/aggregate architecture, versions,
resources and deviations.

Do not claim provider proof, deployment, MCG-02 completion or Cycle 10 closure.
