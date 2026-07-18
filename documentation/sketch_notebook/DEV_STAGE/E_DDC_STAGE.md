# E_DDC_STAGE — MCG-02 Executable Closure Semantics

> Authority marker: C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z
> Status: **ACTIVE SEMANTIC AUTHORITY**

## Truth boundary

Device enrollment is authorization readiness, not synchronization. `hosted-sync-available` must not
be returned from enrollment replay. A sync-success state requires executed event transfer, committed
local application and acknowledgement under the existing contract.

## Required states

~~~text
closure-disabled
configuration-missing
signed-out
authenticated
authentication-required
device-enrollment-required
device-enrolled
sync-running
sync-no-new-events
sync-completed
sync-interrupted
sync-unavailable
device-revoked
signed-out-cleared
~~~

`sync-completed` means the bounded action committed and acknowledged its accepted range. It does not
mean permanent history, backup, production readiness or universal convergence. Cancellation and
provider unavailability preserve local facts and pending work.

## Human-operable evidence

The development surface must allow a human to initiate the sequence without copying a token and
must expose only semantic states. Provider aliases, tokens, claims, subjects, emails, Account/Device
identifiers, connection data and facts remain absent.

## Completion boundary

Codex may claim `NATIVE_PROVIDER_PROOF_READY` after the real local sync path and supported builds
pass. Full MCG-02 still requires human Android and Windows login, two Device enrollments, hosted
convergence and denial evidence through Auth0, Render and Neon. MCG-03 remains inactive until Main
reconciles that evidence.
