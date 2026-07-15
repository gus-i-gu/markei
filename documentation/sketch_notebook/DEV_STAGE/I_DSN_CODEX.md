# I_DSN_CODEX - C10-S03A-R1 Design Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex design/architecture evidence
Unit: C10-S03A-R1 local security correction
Branch: `intermid-cycle-recovery`
Authority: `F_DSN_STAGE.md` plus J/D/E
Evidence boundary: local architecture only; provider proof deferred

## Transaction ownership

Protected hosted sync/recovery routes now use:

```text
JWT/JWKS verification
-> ExternalPrincipal
-> HostedAuthVerifier.authorizeOperation(...)
-> serializable database transaction
-> identity/membership resolution
-> enrollment/Device recheck
-> protected operation callback using the same PoolClient
```

The route callback no longer receives a trusted authorization context from a previously committed hosted-auth transaction. Fixture auth remains supported only through the non-hosted fallback path used by existing direct tests.

## JWT/JWKS boundary

`Auth0JwtVerifier` still delegates cryptography to `jose`, but now uses an explicit bounded JWKS source:

- RS256 precheck;
- required `kid`;
- issuer and audience pinning;
- token byte ceiling;
- JWKS response byte ceiling;
- request timeout;
- cache maximum age;
- refresh cooldown;
- redirect refusal;
- duplicate/conflicting key ID rejection;
- coalesced parallel refresh.

Provider URLs, tokens, claims and JWKS bodies are not logged by new code.

## Migration, Drift and protocol versions

- PostgreSQL migrations 001-004 unchanged.
- No migration 005 added.
- Drift schema remains v7.
- Event payload v3 preserved.
- `c10b:*` cursor format preserved.
- Recovery snapshot format 1 preserved.
- Hosted identity/enrollment contract remains v1.

## Runtime and migrator boundary

The hosted-local harness now separates:

```text
LAB_MIGRATOR_URL
LAB_RUNTIME_URL
```

The migrator applies migrations and synthetic provisioning, then is closed before the HTTP service starts. Fastify receives only the runtime pool. Runtime HTTP path passed local proof for enrollment, sync, acknowledgement, cross-Account denial and revocation denial.

The disposable migrator role required local `CREATEROLE` because migration 003 creates `markei_recovery_worker`. Runtime was not granted role administration or DDL.

## Account, Device and route inventory

- Synthetic Account count: 2.
- Synthetic external identity count: 2.
- Installation count: 3.
- Device count: 3.
- Protected route policy count: 8.
- Cross-Account denial cases exercised by harness: 1.
- Revoked Device denial cases exercised by harness: 1.
- Enrollment conflict cases exercised by harness/tests: 1.

## Flutter lab containment

Added provider-neutral lab composition pieces only:

- `LabAuthenticationSession`
- `LabAccessTokenSource`
- `HttpDeviceEnrollmentTransport`
- `HostedEnrollmentCoordinator`
- `DriftHostedIdentityRepository`
- `DriftHostedSyncGuard`

No provider SDK, callback registration, provider identifier, native secret, production token storage, Account-selection UI or Device-management UI was added.

## Deviations and deferrals

R1 remains partial because the complete CP4 race matrix is not represented by named barrier/hook tests. Current design relies on serializable transactions plus enrollment/Device row locks; membership read/write race proof still needs explicit barrier-level validation before Main can accept full local-security proof.

Deferred:

- Auth0, Neon and Render proof;
- production Account creation/invitations;
- provider JWKS tuning;
- Account-selection and Device-management UI;
- MCG-03/04;
- Cycle 10 closure.

Terminal design result:

```text
C10-S03A_R1_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```
