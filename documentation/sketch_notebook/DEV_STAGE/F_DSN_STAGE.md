# F_DSN_STAGE — Hosted Device Header Design Boundary

> Authority marker: C10-MCG02-HOSTED-DEVICE-HEADER-CORRECTION_20260721T124452Z
> Required ancestor: cee414ffd4501e86d2d221f8fe02876716510692
> Status: **ACTIVE CODEX MATERIALIZATION AUTHORITY**

## Selected dependency path

~~~text
active HostedIdentityBinding.serverDeviceId
  -> production composition
  -> HttpSyncTransport required Device identity
  -> x-markei-device-id on every protected request
  -> Render transaction-scoped authorization
  -> enrolled Neon Device
~~~

The body `submission.deviceId` remains immutable event/submission content. The header is the
request authorization context. They must agree semantically, but one must not be substituted for
the other implicitly inside upload because download, acknowledgement and recovery have no upload
submission body.

## Invariants

1. One transport instance is scoped to one active hosted Device binding.
2. All protected methods use the same scoped header injection path.
3. Authorization, correlation, content negotiation and timeout behavior remain unchanged.
4. The header is not persisted as a new fact and is never logged or displayed.
5. Missing binding fails during composition or before transport, not as an anonymous protected
   request.
6. Existing event identity, sequence, hashing, outbox recovery and server transaction semantics
   remain unchanged.
7. Test fixtures enforce the production authorization contract instead of accepting a weaker one.

## Exclusions

No migration, enrollment redesign, provider mutation, Device B work, local database repair,
sequence renumbering, broad transport abstraction, UI redesign, deployment, permanent promotion,
MCG-03 or MCG-04 is authorized.

The later provider retest must reuse the preserved Windows binding and failed sequences `1,2` after
building the corrected release. It is not part of Codex materialization.
