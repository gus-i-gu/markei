# F_DSN_STAGE — MCG-02 Executable Closure Design

> Authority marker: C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z
> Status: **ACTIVE DESIGN AUTHORITY**

## Corrected dependency direction

~~~text
development-only closure surface
  -> native authentication application ports
  -> Device enrollment application service
  -> hosted synchronization application port
       -> existing HTTP sync transport
       -> Drift event applier/cursor/outbox/ack repositories

Auth0 adapter -> auth0_flutter SDK
HTTP adapters -> Render HTTPS -> pooled Neon runtime
~~~

The surface coordinates existing application services; it does not call SDK, HTTP or Drift details
directly. Auth0 SDK types remain infrastructure-only. Synchronization remains distinct from Device
enrollment and provider authentication.

## Real sync boundary

Replace the enrollment-replay implementation of `hostedSyncProbe`. The corrected port must invoke
the same production-capable synchronization path proved by R05: preserve pending uploads, resolve
unknown outcomes safely, download after the committed cursor, apply atomically and acknowledge only
after commit. Reuse existing services; do not create a parallel sync algorithm.

## Identity boundary

Use durable local installation/Device identity and durable enrollment request progress. Random
identity generation at each invocation is forbidden. External identity, Account membership and
server Device authorization remain PostgreSQL-controlled; no automatic provisioning is added.

## Surface boundary

The closure surface exists only when a compile-time development flag is true and typed provider
configuration is valid. It defaults absent. It may expose actions and semantic results but no
credentials, raw identifiers or payloads. Product navigation and ordinary local registration remain
unchanged when disabled.

## Change boundary

Allowed: closure runner/port, composition, minimal flagged surface, stable local identity reuse,
focused tests and G/H/I. Platform files may change only if required to keep the accepted Auth0
callback composition buildable.

Forbidden: migrations, server authorization redesign, Drift schema/reset, provider operation,
credential files, automatic membership, production UX, telemetry, permanent documentation and
MCG-03/04.

## Validation and rollback

Validation must distinguish enrollment success from executed synchronization, include the real
loopback HTTP/file-backed path, and prove no local loss or credential persistence. Android and
Windows builds are separate evidence; source presence does not substitute for a binary build.

Rollback removes only the flagged surface and corrected closure adapter while retaining the accepted
Auth0 adapter, local R05 proof, provider foundation, local facts and outbox.
