# C_DESIGN — C10-S03 Hosted Development Authentication and Synchronization Proof

> Sequence: FLX-INV-02 investigative/speculative round
> Role: Design/Architecture [D]
> Branch / inspected HEAD: `intermid-cycle-recovery` / `de1319dc05e1f04ba84b6cfd681f5b72a4568f88`
> Authority: investigation and Main handoff only
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX OR PROVIDER MUTATION

## 1. Methodology retained

The full `INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL`
route was read after both AGENTS files. Design may investigate trust, identity, responsibility,
dependency, schema, transaction and hosting boundaries. PRC-01 keeps repository facts, passing
tests, provider guarantees, human observations, inferences and proposals distinct. C is staging,
not canon or implementation authority. Only C may change; source, migrations, permanent memory,
J/A/B/D–I, Main continuity and providers remain protected. Flutter→ports→HTTP/Drift→API→PostgreSQL
dependency direction and the stop rules remain controlling.

## 2. Current architecture and missing hosted invariants

```text
Flutter local-first facts/outbox/recovery
→ injected HttpSyncTransport with bearer token source
→ Fastify AuthVerifier port
→ verified AuthContext(AccountId, DeviceId)
→ serializable transaction + transaction-local RLS context
→ PostgreSQL sync/recovery tables (migrations 001–003)
```

Implemented locally: immutable v3 Purchase synchronization, recovery format 1, Device rows with
active/revoked status and leases, RLS, bounded transaction retries and local convergence/rebootstrap
harnesses. `FixtureAuthVerifier` is lab-only; normal `main.ts` uses `RefusingAuthVerifier`, requires
one database URL and binds `127.0.0.1`. Flutter’s default composition remains local-only and still
uses `local-account`; no Auth0 SDK/composition is present. Android ID is `com.gusigu.markei`;
Windows executable metadata remains prototype-like and supplies no security identity.

Missing invariants: verified external issuer+subject maps to one internal identity; identity has an
active Account membership; requested Device is enrolled to that Account and installation; every
sync/recovery transaction derives Account/Device only after authorization; enrollment/revocation
is auditable and idempotent; hosted startup fails closed; runtime and migration credentials remain
separate; membership removal invalidates active synchronization/recovery without relying on token
expiry alone.

## 3. Alternative A — token subject directly maps to Account and Device

**Model:** `auth_bindings(issuer, subject, account_id, device_id, status)` unique on issuer+subject.
Token selects the only Account and Device; no membership or enrollment resource.

- API/Flutter: Flutter sends only access token; server resolves the fixed binding. Reinstall needs
  administrative rebinding because Device identity cannot vary safely.
- Transaction/RLS: resolver loads binding before `inTransaction`; sets Account/Device context.
- Protection: simple cross-Account scope and no forged Device body, but one human identity cannot
  naturally own multiple Devices/Accounts; Device revocation risks revoking the person binding.
- Replay/recovery: existing submission/recovery identities work, but replacement semantics are
  ambiguous and retention leases become tied to identity rather than installation.
- Migration/operations: one table and narrow repository; lowest cost. Tests cover issuer+subject
  collision, disabled binding, wrong issuer and context. Rollback restores refusing verifier.
- Privacy/security: minimal records, but over-couples authentication subject with Device lifecycle
  and makes future household/account selection expensive. Confidence: low for Markei.

## 4. Alternative B — external identity + membership + client-supplied Device

**Model:** `external_identities`, `account_memberships`, existing `devices`; client includes DeviceId
on enrollment/sync and server checks membership plus `(AccountId, DeviceId)` ownership.

- API/Flutter: token resolves identity; client selects Account and supplies persisted DeviceId.
  Existing Device is accepted only if bound to that Account. Enrollment may insert it once.
- Server: separates authentication from authorization; route preflight resolves membership and
  Device before transaction. Account choice is explicit or omitted when exactly one membership.
- Reinstall/replacement: new client-generated DeviceId requires enrollment; old Device remains
  revocable/expirable. Client-generated UUID is identity, never proof of ownership.
- RLS/replay: verified Account/Device context plus explicit predicates; enrollment uses an
  idempotency key and uniqueness on Account+Device. Forged IDs fail without enumeration detail.
- Cost/tests: moderate migration and API surface; test two identities/two Accounts, forged Device,
  membership disable, replay and races. Rollback disables hosted composition and retains rows.
- Risk: a copied stable DeviceId plus valid member token can attempt to impersonate another
  installation unless enrollment has stronger installation binding. Confidence: medium.

## 5. Alternative C — identity + membership + server-mediated installation enrollment

**Model:** external identity and membership are separate; Flutter installation holds a stable
random `InstallationId`; server idempotently creates or returns a Device binding under an authorized
membership. DeviceId remains server-owned protocol identity, not hardware fingerprint.

- Tables: issuer+subject identity; membership with role/status; installation enrollment keyed by
  Account+InstallationId with Device FK/status/generation; enrollment attempts/idempotency result;
  revocation audit. Existing sync/recovery Device tables remain authoritative.
- API/Flutter: Flutter authenticates, chooses an allowed Account, submits InstallationId plus
  EnrollmentRequestId, persists returned DeviceId, and then sends DeviceId through transport.
  Native app contains public Auth0 domain/client ID/API audience as required configuration, never a
  client secret, management token, database URL or signing key.
- Server: validates JWT first, resolves identity/membership second, enrolls/authorizes Device third,
  then opens Account transaction. Invitation/pairing may be an additional gate but is not selected.
- Reinstall: loss of InstallationId produces a new enrollment/Device; silent replacement of an
  active Device is forbidden. Authorized revocation ends sync/rebootstrap and lease eligibility.
- Replay/RLS: same request hash returns stored Device; different hash conflicts. All existing route
  contexts come from the resolved authorization object, never Account/Device request authority.
- Cost/security: highest migration/state-machine cost but clean multi-Device, retention and
  rebootstrap ownership. Tests and rollback remain bounded. Confidence: high architecturally;
  invitation/replacement policy remains unresolved.

**Recommendation:** C. It preserves the existing installation-held stable identity direction while
keeping Auth0 subject, Account membership, Device and installation as distinct identities.

## 6. Proposed forward-only data model

Prefer `004_hosted_identity_enrollment.sql`; never edit 001–003.

| Structure | Candidate invariants |
| --- | --- |
| `external_identities` | IdentityId PK; issuer+subject unique; status; no email as identity key |
| `account_memberships` | Account+Identity unique; active/disabled/removed; role; timestamps/version |
| `device_enrollments` | Account+Installation unique; Device FK; enrolled/revoked/replaced; generation |
| `enrollment_requests` | Account+Identity+RequestId; request hash; stored result; expiry |
| `device_security_events` | append-only enrollment/revocation actor, target, reason code, correlation/time |

Issuer and subject must be stored exactly as validated strings with bounded lengths; uniqueness is
the pair, preventing cross-issuer subject collision. Membership owns Account access. Enrollment
owns installation→Device association. Existing `devices` continues to own Device sequence, status,
lease and synchronization FK relationships. Do not reuse Account, Person or Device rows as external
identity records. Email/profile claims are optional presentation data and not authorization truth.

Migration 004 should add composite FKs, indexes and checks; revoke defaults; grant hosted runtime
only resolver/enrollment operations; enable RLS on every Account-bearing new table. Identity lookup
requires a narrowly scoped pre-Account repository because Account is not known yet; it returns
candidate internal identity only. Membership selection then yields the Account. The Account-scoped
transaction sets `markei.account_id` and `markei.device_id` locally and retains explicit predicates.
Database owner/migrator must not be the runtime role; RLS remains defense in depth, not the resolver.

## 7. Authentication and authorization boundary

`Auth0JwtVerifier` implements `AuthVerifier` but should initially return `VerifiedExternalIdentity`
rather than the current final `AuthContext`; an `AuthorizationService` produces Account/Device
context after database checks. If changing the port is too disruptive, add an orchestrating
`RequestAuthorizer` and keep JWT verification a narrower dependency.

Verifier requirements: accept bearer access token only; pin configured HTTPS issuer, API audience
and asymmetric algorithm (proposed RS256); validate signature, issuer, audience, expiration and
not-before with small explicit clock skew; reject missing/duplicate/malformed headers and oversized
tokens. Select keys by `kid` from issuer-bound JWKS; cache with bounded lifetime, coalesce refreshes,
refresh once on an unknown key, honor timeouts/response bounds, and fail closed on substitution,
outage without an unexpired cached key, or algorithm mismatch. Never decode-and-trust claims.

Auth0’s official documentation inspected 2026-07-15 guarantees that an API must reject an invalid
access token, validate its intended audience and required scope; Auth0 exposes tenant JWKS and key
rotation can yield multiple keys. Exact cache duration/clock skew are proposals, not guarantees:
https://auth0.com/docs/secure/tokens/access-tokens/validate-access-tokens and
https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-key-sets

## 8. Versioned API contract hypothesis

- `GET /v1/identity`: verified external identity status and memberships as opaque Account choices;
  for a single active membership the response may mark a default, but client cannot invent one.
- `POST /v1/devices/enroll`: `contractVersion`, AccountId, InstallationId, EnrollmentRequestId,
  request hash, platform/app identifier metadata; returns DeviceId, status/generation and replay
  result. Same identity/hash is equivalent; mismatch conflicts.
- `GET /v1/devices/enrollments/{requestId}`: resolves unknown outcome without creating a Device.
- `GET /v1/devices/{deviceId}/status`: active/revoked/replacement-required plus recovery eligibility;
  foreign IDs return the same non-enumerating denial as absent IDs.
- `POST /v1/devices/{deviceId}/revoke`: deferred unless Main selects self-revocation authority;
  must require role/step-up or another explicit authorization and append audit evidence.
- Every sync/recovery route: token→identity→membership→Device authorization. Typed failures:
  `auth-required`, `token-invalid`, `membership-required`, `membership-disabled`,
  `device-not-enrolled`, `device-revoked`, `account-selection-required`, `rate-limited`.
- `/health/live`: process/event-loop only, no auth/provider/database metadata. `/health/ready`:
  generic ready/not-ready after configuration, pool and verifier/JWKS prerequisites; never issuer,
  audience, database host, branch, role, key ID or exception detail.

401 is authentication failure; authorization denial is 403 without Account/Device enumeration.
Enrollment validation is 400/409; dependency outage is bounded 503 with safe retry. Unknown
enrollment outcome queries the same EnrollmentRequestId. Synchronization retains original Event,
Submission and RecoverySession identities across retry.

## 9. Hosted Fastify composition

Add a production entrypoint/composition distinct from lab entrypoints:

```text
validated HostedConfig
→ Auth0JwtVerifier(JWKS client, clock, bounds)
→ Identity/Membership/Enrollment repositories
→ pooled Neon runtime Database
→ existing Sync + Recovery route services
→ Fastify listen(0.0.0.0, PORT)
```

Configuration parsing fails before listening if database URL, issuer, audience, public service
origin, timeouts, pool bounds or PORT are absent/invalid. Secret values never appear in errors.
Issuer/audience/Auth0 domain are not secrets, but server validation values remain authoritative;
Flutter may receive the public domain, native client ID and API audience through build-time public
configuration. No native client secret exists. Auth0 management credentials, if later needed for
administration, remain server-only and are not required for token verification.

Render officially requires a web service to bind `0.0.0.0` and recommends its `PORT`; HTTPS is
terminated by the hosted service boundary. This is a guaranteed platform fact inspected 2026-07-15,
not evidence of a Markei deployment: https://render.com/docs/web-services

Register graceful shutdown: stop accepting requests, bound the drain interval, close Fastify and
`pg.Pool`, then exit; signals and exact timeout require a Render/local lifecycle test. Readiness must
fail during startup/drain and when the database cannot execute a minimal non-secret probe. JWKS
temporary outage may remain ready only while a valid cached key set exists—proposal, not provider fact.

Use Neon’s pooled runtime connection for hosted request traffic and a direct migrator connection for
forward-only migration 004. Neon documents pooling through PgBouncer and recommends pooled
connections for web apps while migrations commonly use direct connections; inspect/tested 2026-07-15:
https://neon.com/docs/connect/connection-pooling. Transaction-local `set_config(..., true)` must be
proved through the selected pooled endpoint. PostgreSQL RLS applies policies per command, while
owners and roles with `BYPASSRLS` can bypass unless forced; runtime must own neither tables nor that
attribute: https://www.postgresql.org/docs/current/ddl-rowsecurity.html

## 10. Threat model and required controls

| Threat | Boundary |
| --- | --- |
| forged/wrong issuer/audience/algorithm/time | strict JWT/JWKS validation; pinned issuer/audience/algorithm/clock |
| JWKS substitution/outage/stale key | HTTPS issuer-bound URL; bounded cache/timeout; unknown-key refresh once; fail closed |
| token/log leakage | never log Authorization, JWT claims, JWKS payload, query tokens or provider URLs |
| subject collision | unique issuer+subject; internal opaque IdentityId |
| Account enumeration | membership-derived choices; uniform foreign/absent denial and bounded responses |
| forged Device/enrollment replay | membership check, Installation binding, request hash and stored idempotent result |
| unauthorized replacement/revoked reuse | no implicit replacement; generation/status/audit; route-wide authorization |
| malicious acknowledgement | existing high-water/Device checks after membership and enrollment authorization |
| runtime escalation | least-privilege runtime, RLS, explicit predicates; no DDL/worker/enrollment-admin powers |
| migrator/env leakage | separate direct credential; secret store only; sanitized startup/errors/build logs |
| partial migration | transactional 004, ledger/checksum and fresh/001→004 probes; no runtime auto-migration |
| branch expiry/provider unknown | hosted proof stops; do not recreate against another branch silently |
| membership removal race | lock/recheck membership+Device inside transaction before mutations; revoke sessions |
| enrollment abuse | per-identity/IP bounded rate limit, request/body bounds and audit without raw identifiers |

Account deletion must first enter a denying state, block enrollment/sync/rebootstrap, invalidate
memberships/sessions and then follow the future deletion/tombstone policy. Authentication success
never overrides deletion, revoked Device or expired recovery state.

## 11. Tests, migration and rollback

Local tests before providers: deterministic RSA key/JWKS fixtures; wrong issuer/audience/algorithm/
expiry/not-before/kid; cache/rotation/outage/timeout; identity collision; membership selection and
disable/remove; enrollment replay/hash mismatch/race/rate limit; reinstall/new installation;
revocation across upload/download/ack/capabilities/rebootstrap; two Accounts and enumeration; RLS
matrix through pooled-compatible connections; graceful startup/shutdown/pool close; fail-fast
configuration; health redaction; 001→004/fresh/failed migration and runtime DDL denial.

Rollback boundary: deploy the prior refusing/local-only composition, disable hosted service, keep
004 data inert, and migrate forward for corrections. Never roll back by editing 001–004, resetting
Drift, deleting identity mappings or force-pushing. Provider proof rollback is Render service
disable, Auth0 test application/API disable and Neon development branch teardown under human control.

## 12. Recommended bounded sequence and authority split

**Codex unit C10-S03A:** closed auth/authorization/enrollment contracts; forward-only 004; local
RSA/JWKS fixtures; Auth0 verifier; identity/membership/enrollment repositories; route-wide
authorization; hosted-safe entrypoint; local pooled-composition tests; secret-safe configuration
documentation. Stop with normal Flutter still local-only and no provider calls.

**Human MCG-02 / evidence unit C10-S03B:** after Main reconciles S03A, configure an isolated Auth0
native application/API, apply 004 to the authorized Neon development branch with direct migrator,
configure Render secret environment, deploy explicit commit, then return sanitized evidence only:
provider aliases, region/version, public non-secret origins/identifiers where approved, commit and
migration hashes, timestamps, request/status matrix and teardown state. Never return tokens,
passwords, connection URLs, management credentials, environment dumps or raw subjects.

Codex implementation and MCG-02 must be separate materialization/evidence units. Local correctness
must precede provider mutation; hosted observations cannot silently rewrite architecture.

## 13. Main decisions and speculative exit

Main must decide: Alternative C; Account selection UX/single-membership default; whether membership
alone permits enrollment or invitation/pairing is required; InstallationId generation/storage and
reinstall rules; who may revoke/replace Devices; external-identity provisioning source; roles/scopes;
public Auth0 configuration delivery; JWKS cache/skew/timeouts; rate limits; Render service plan/
region/health/drain policy; Neon branch lifetime and pooled/direct evidence; membership removal and
Account deletion races; retention lease renewal after authorization; MCG-02 exact manual scope.

Performance improvement: one recommended trust chain, one additive migration boundary and two
separate implementation/provider units are now explicit. Evidence still missing: sanitized MCG-01,
Auth0/Render project observations, pooled Neon RLS probe, native callback configuration, installation
secure-storage behavior and human enrollment/revocation policy. Exit to implementation is not ready
until Main freezes C10-S03A. This document is speculative staging—not accepted architecture,
authentication policy, provider approval, implementation authority or permission to inspect secrets.
