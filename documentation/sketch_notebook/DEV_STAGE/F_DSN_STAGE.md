# F_DSN_STAGE — C10-S03A-R1 Corrective Design Authority

> Unit: transaction-safe local hosted-authentication correction
> Baseline: `d411e4ee92d5977984913b9bba21cc9aa1c37bbf`
> Joint authority: D/E/F
> Provider authority: none

## 1. Corrected architecture

Preserve the port/adaptor direction but correct authorization ownership:

```text
Flutter local-first application
  ├─ local facts/outbox/recovery
  └─ opt-in hosted-auth coordinator
       ├─ ExternalAuthenticationSession
       ├─ AccessTokenSource
       ├─ DeviceEnrollmentTransport
       ├─ HostedIdentityRepository
       └─ HostedSyncGuard
                ↓ bearer candidate + explicit selectors
Fastify HTTP boundary
  → bounded JWT/JWKS verifier
  → ExternalPrincipal only
  → protected-operation transaction coordinator
       → resolve identity/membership
       → resolve enrollment/Device
       → authorize named operation
       → invoke sync/recovery repository using same tx
                ↓
PostgreSQL runtime connection + explicit predicates + RLS
```

The previous design allowed an `AuthContext` created by one committed transaction to authorize a
later transaction. That context is no longer authority.

## 2. Version and migration boundaries

- Event: `purchase.registered` payload v3, unchanged.
- Cursor: opaque `c10b:*`, unchanged.
- Recovery snapshot format: 1, unchanged.
- Hosted identity/enrollment contract: v1 unless a closed additive field is required.
- Drift schema: v7 unless durable lab orchestration requires an additive v8.
- PostgreSQL migrations 001–004 are immutable.
- If database shape must change, add migration 005 and prove forward-only migration/rollback.
- JWT algorithm: `RS256` only for this unit.
- No production retention defaults or cleanup activation.

Prefer source-only correction without migration 005 or Drift v8. Add schema only when an invariant
cannot be represented safely by the existing model, and record the reason in I.

## 3. Identity ownership

Keep these identities distinct:

```text
ExternalPrincipal = verified issuer + subject
ExternalIdentity  = opaque server identity mapped from principal
AccountMembership = authorization relation and role
AccountId         = Markei data boundary
InstallationId    = stable local installation UUID
DeviceId          = server synchronization actor
DatabaseRole      = PostgreSQL migrator/runtime login
```

Invariants:

- Provider claims never directly grant AccountId or DeviceId.
- Account selection is validated against active membership in the current transaction.
- InstallationId is not secret and is not authorization proof.
- DeviceId is server-owned and bound through enrollment.
- Markei Accounts are rows and do not have PostgreSQL login passwords.
- Runtime/migrator credentials never enter Flutter, fixtures, reports or version control.
- Email/profile claims do not become Person facts or authorization keys.

## 4. Two-stage authentication/authorization boundary

Stage A verifies cryptographic evidence without holding a database transaction:

```text
BearerParser.parse(request headers)
JwtVerifier.verify(candidate)
  -> ExternalPrincipal(issuer, subject)
```

Stage B authorizes and executes exactly one operation:

```text
ProtectedOperationExecutor.execute(principal, selectors, operation, callback)
  -> database.inTransaction(tx =>
       authorizationRepository.authorizeForOperation(tx, ...)
       callback(tx, TransactionAuthorizedContext)
     )
```

`TransactionAuthorizedContext`:

- contains only opaque IDs/role/operation needed by the callback;
- is created inside the active transaction;
- is not serializable or cacheable;
- cannot be reused after callback completion;
- does not expose the raw token or provider claims;
- cannot open or authorize a second transaction.

Application repositories used by the callback must accept the existing transaction/session. They
must not commit independently or obtain an unrelated pool connection.

## 5. Concurrency and lock policy

For protected mutation, transactionally inspect and control:

```text
external identity
selected Account membership
Installation/Device enrollment
Device authorization status
target Account resource
```

Use deterministic row-lock ordering or an equally explicit serializable strategy. Recommended
ordering:

```text
Account membership
→ enrollment
→ Device
→ operation-specific rows
```

Revocation/removal uses the same ordering. A race must serialize as:

```text
operation first, then revocation/removal
OR
revocation/removal first, then operation denied
```

Do not solve races with sleeps, process-local mutexes or cached authorization.

Deadlock/serialization retry must be bounded and only repeat idempotent transaction attempts.
Unknown outcomes retain existing request/session identities.

## 6. Protected route inventory

Centralize route policy so each route declares:

```text
authentication requirement
membership requirement
Device requirement
allowed membership role
named operation
transaction callback
```

Inventory at minimum:

| Route family | Membership | Device | Transaction-scoped check |
| --- | --- | --- | --- |
| identity discovery | verified principal | no | membership resolution transaction |
| Device enrollment | active membership | no existing Device required | yes |
| enrollment status | active membership | request ownership | yes |
| Device status | active membership | owned target | yes |
| Device revocation | authorized actor membership | actor + target ownership | yes |
| event upload | active membership | active bound Device | same event transaction |
| event download | active membership | active bound Device | same read/cursor transaction |
| acknowledgement | active membership | active bound Device | same acknowledgement transaction |
| sync capabilities | active membership | active Device when Account scoped | same transaction |
| rebootstrap routes | active membership | active bound Device | same recovery transaction |

Public health is the only ordinary unauthenticated route and must expose generic status only.

Add a test that compares registered protected routes with policy declarations.

## 7. JWT/JWKS components

Split responsibilities:

```text
BearerParser
  singular bounded Authorization value

JwtVerifier
  JOSE verification, issuer, audience, algorithm, time and subject

BoundedJwksSource
  issuer-bound URI, byte ceiling, timeout, redirect policy
  parse/shape validation, cache and refresh coalescing

Clock
  deterministic token/cache tests
```

`BoundedJwksSource` requirements:

- accept only configured/issuer-derived HTTPS URI outside explicit loopback lab;
- reject credentials, fragments and unexpected origins;
- read no more than the configured response ceiling;
- reject excess bytes even when transport metadata understates length;
- use a bounded timeout and abort request/stream;
- reject redirects unless an explicitly safe same-origin rule is proved; zero is preferred;
- accept only a bounded JSON object/keys array and bounded key fields/count;
- cache valid keys under deterministic maximum age;
- coalesce concurrent refresh for the same issuer/key request;
- apply bounded cooldown after failure;
- permit cached-key outage behavior only under the frozen policy;
- never return raw provider errors or bodies to clients/logs.

Continue using `jose`; do not implement cryptographic primitives.

## 8. PostgreSQL authority split

### 8.1 Migrator

May:

- apply forward migrations and ledger entries;
- perform controlled synthetic lab provisioning;
- grant/revoke repository-defined runtime privileges during migration.

Must not be present in hosted runtime configuration.

### 8.2 Runtime

May:

- resolve external identity and membership through bounded repositories;
- create/replay Device enrollment through authorized routes;
- perform authorized sync/recovery transactions;
- update runtime-owned recovery/session/acknowledgement state.

Must not:

- perform DDL or role administration;
- apply or mutate migration ledger entries;
- provision arbitrary identities/memberships;
- build/publish snapshots or execute worker cleanup;
- bypass RLS or cross Account boundaries.

The decisive HTTP process receives only the runtime URL. Test fixture setup receives only the
migrator URL. Their credentials are generated by the disposable harness and are never printed.

## 9. Data model reuse and constraints

Reuse migration 004 structures where they already express:

- provider-scoped external identity uniqueness;
- Account membership status and role;
- Account/identity/Installation enrollment idempotency;
- request-hash conflict detection;
- Account-owned Device binding;
- append-only enrollment/revocation security events;
- RLS and runtime grants.

Do not edit migration 004 merely because provider migration has not yet occurred. Git history and
forward-only discipline treat it as immutable.

If migration 005 becomes necessary, it must be additive, Account scoped, RLS enabled, indexed,
least privilege and safely rollback on failure. It must not store tokens, passwords, authorization
codes, emails, profiles or provider management credentials.

## 10. Enrollment and revocation

Enrollment identity remains equivalent to:

```text
AccountId
ExternalIdentityId
InstallationId
EnrollmentRequestId
canonical request hash
```

Equivalent replay returns the same committed result. Same request identity with a different hash
returns conflict. Concurrency creates at most one active binding for the frozen uniqueness rule.

Enrollment creates a Device only after current membership is transactionally confirmed. It does
not rewrite local event identities or silently attach old pending events to the server Device.

Revocation:

- verifies actor membership/role and target ownership in its transaction;
- changes enrollment and Device authorization atomically;
- appends the security event in the same transaction;
- becomes visible to later operations through transaction-scoped recheck;
- does not delete local facts or imply remote event deletion.

Production enrollment approval, Device replacement, reactivation and user-facing management remain
deferred.

## 11. Two-Account isolation

The lab contains Account A and Account B. Each table/query/route must prove:

- explicit Account predicate;
- RLS context derived from transaction authorization, not request claims;
- composite ownership where schema supports it;
- foreign identifiers produce generic denial without existence disclosure;
- cursors, acknowledgements, snapshots and recovery sessions cannot cross Account boundaries.

Two Accounts do not require two Auth0 tenants. Local tests use generated principals; later hosted
proof may use ordinary development users inside one tenant.

## 12. Flutter provider-neutral lab

Keep provider SDKs behind application ports. Add only infrastructure/application pieces needed to
exercise the state machine against loopback HTTP:

```text
LabAuthenticationSession
LabAccessTokenSource
HttpDeviceEnrollmentTransport
HostedEnrollmentCoordinator
DriftHostedIdentityRepository
HostedSyncGuard
```

Requirements:

- opt-in lab composition cannot replace ordinary local composition;
- no Auth0 dependency or callback registration in R1;
- public provider identifiers and real credentials are absent;
- request identity/hash and progress survive database reopen;
- response-loss replay is idempotent;
- cancellation/outage preserves local facts and outbox;
- successful enrollment does not reassign existing local events;
- token bytes are memory-bounded and never persisted/logged by new code;
- tests use synthetic tokens and loopback endpoints only.

Actual `auth0_flutter`, Android/Windows callbacks, PKCE, logout and production token handling belong
to the later MCG-02 provider unit after Main reconciliation.

## 13. Threat model floor

Prove defenses for:

- stale authorization across transactions;
- membership removal during operation;
- Device/enrollment revocation during operation;
- forged AccountId/DeviceId/InstallationId;
- cross-Account resource and recovery identifiers;
- duplicate/conflicting enrollment replay;
- token substitution, wrong issuer/audience/algorithm and signature failure;
- expired/not-yet-valid token;
- unknown/rotated key;
- malformed/oversized/slow JWKS;
- JWKS refresh stampede and outage;
- runtime authority escalation;
- migration credential exposure to runtime;
- token/claim/URL/payload leakage in errors or logs;
- API outage while local registration continues;
- account deletion/revocation race where current contracts apply.

## 14. Rollback and reversibility

- Source correction is reversible as one bounded commit.
- Existing migration 004 remains forward history.
- If migration 005 is added, rollback means application rollback with compatible schema retained;
  do not write destructive down migrations.
- Existing Drift v7 databases reopen without reset.
- If v8 is unavoidable, prove v7→v8 migrate/reopen/failure/no-reset.
- Provider-neutral Flutter adapters remain removable independently of local domain behavior.
- No provider resource mutation means provider rollback is outside this unit.

## 15. Deferred decisions

Do not decide or implement:

- production Account creation, invitations or membership administration;
- Auth0 tenant/user lifecycle or social providers;
- Auth0 Android/Windows callback integration;
- Render deployment and secret injection;
- Neon migration/application or backup/PITR acceptance;
- production JWKS cache tuning from provider observations;
- Account-selection and Device-management UI;
- Device replacement/reactivation policy;
- MCG-03/04;
- Cycle 10 closure.

## 16. Design terminal boundary

R1 success establishes only that the local architecture enforces the frozen security invariants
under the decisive disposable harness. It does not prove Auth0, Render, Neon, Android callback,
Windows callback or hosted synchronization behavior.

Required successful report:

```text
C10-S03A_R1_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

Provider work remains stopped until Main reconciles the new G/H/I.
