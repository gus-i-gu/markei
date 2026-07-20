# D_OPS_STAGE — Decisive Two-Device Provider Proof

> Authority marker: C10-MCG02-PROVIDER-CONVERGENCE_20260720T175006Z
> Required ancestor: e762b64be2a00b43735c3bcb40b8d349afcb0dd3
> Status: **ACTIVE HUMAN-OPERATED PROVIDER EVIDENCE AUTHORITY**

## Accepted evidence

- Hosted binding/scoped sync at `e762b64` passed 93 Flutter tests, 46 API tests, Android and
  Windows builds, file-backed proof and disposable Docker/PostgreSQL two-Device convergence.
- Windows native authentication, callback, authenticated status, logout and re-sign-in passed.
- Android build, install, Auth0 callback and authenticated status passed after supplying the same
  sanitized Auth0 domain to Dart and Gradle. The earlier browser `Not found` and debug-service
  tunnel failure are resolved diagnostics, not provider convergence evidence.

## Objective

Prove one synthetic hosted Account converges through Auth0, Render and Neon across Windows Device A
and Android Device B, while authorization, revocation, outage continuity, token ephemerality and
local-only preservation fail closed.

## Ordered gates

1. Confirm the tested branch contains `e762b64`; Render is live/ready and unauthenticated identity
   returns 401; scan logs for secret/payload leakage.
2. Authenticate the synthetic identity and query its hosted identity state.
3. Using only the controlled migrator procedure, create/activate exactly one external identity and
   one Account membership when absent. Do not improvise SQL or derive Account/Device IDs from Auth0.
4. Enroll Windows as Device A. Require `hosted-restart-required`; do not sync in that process.
5. Fully restart Windows, re-authenticate if required, and require an active hosted binding.
6. Register synthetic purchase A on Windows; sync twice and prove acceptance then idempotence.
7. Enroll Android as distinct Device B. Require restart before sync, then active hosted binding.
8. Sync Android to receive A; register/sync purchase B; sync Windows to receive B.
9. Close/reopen both applications and compare authoritative hosted facts. Local-only facts and
   pending work must remain local and unchanged.
10. Revoke Device B through the controlled development procedure; require typed denial with no
    Device-B cursor, acknowledgement, event or fact advance; Device A remains operational.
11. Make only the development API temporarily unavailable using the least destructive approved
    method; register purchase C locally, prove pending continuity, restore service and converge once.
12. Logout on both clients; protected actions require authentication and no usable access token is
    recovered after close/reopen.
13. Collect only sanitized counts, state names, HTTP statuses, deployment SHA, pass/fail outcomes and
    redacted errors; scan Render logs and inventory remaining synthetic resources.

## Stop rules

Stop before further mutation on ambiguous/duplicate membership, cross-Account data, unexpected
provider activity, wrong deployment ancestry, migration/checksum drift, secret exposure, missing
restart boundary, local-only event selection or any untyped state advance after denial. Preserve
local databases and provider evidence without committing them.

## Boundaries

This is development-provider acceptance only. No source, migration, dependency, schema, production
branch, permanent documentation, MCG-03 or MCG-04 change is authorized. Codex may perform read-only
redacted diagnosis but must not receive credentials/tokens or operate Auth0, Render or Neon. G/H/I
remain the `e762b64` implementation evidence and are not replaced by this human procedure.

Success terminal after every gate passes:

~~~text
MCG-02_NATIVE_CLIENT_AUTH=true
MCG-02_WINDOWS_DEVICE_ENROLLED=true
MCG-02_ANDROID_DEVICE_ENROLLED=true
MCG-02_TWO_DEVICE_PROVIDER_CONVERGENCE=true
MCG-02_REVOCATION_DENIAL=true
MCG-02_PROVIDER_OUTAGE_CONTINUITY=true
MCG-02_EPHEMERAL_TOKEN_CLEARING=true
MCG-02_PROVIDER_PROOF_COMPLETE
~~~

Otherwise report `MCG-02_PROVIDER_PROOF_PARTIAL` with the exact failed gate and evidence boundary.
