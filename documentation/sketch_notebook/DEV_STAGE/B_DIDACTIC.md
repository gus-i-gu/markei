<!-- TEMPORAL_MARKER:C10-S03-DIDACTIC-INVESTIGATION-2026-07-15 -->

# B_DIDACTIC — C10-S03 Hosted Authentication and Synchronization Semantics

> Sequence: FLX-INV-02
> Role: Didactic/UX Chat [A]
> Unit: C10-S03 — Hosted Development Authentication and Synchronization Proof
> Branch: `intermid-cycle-recovery`
> Baseline / inspected HEAD: `de1319dc05e1f04ba84b6cfd681f5b72a4568f88`
> Authority: Didactic/UX investigation only
> Writable surface: this file only
> Knowledge state: candidate / proposed / provisional
> Materialization authority: none
> Learner maturity: unchanged

## 1. Methodology retained

The complete route `INDEX → METHOD_FOUNDATIONS → FLUX → PROMOTION_RULES → CHAT_PROTOCOL` remains controlling after both Agent Contracts.

Retained constraints:

- Didactic authority owns semantic truth, learner-facing distinctions and misconception prevention;
- this functional stage may propose vocabulary and evidence requirements but cannot select architecture, provider policy or UI composition;
- PRC-01 keeps candidate, proposed, provisional, accepted, implemented, validated, blocked and deferred distinct;
- repository, test and provider evidence prove only their named project boundary;
- successful configuration, login or synchronization cannot manufacture learner explanation, prediction, transfer or mastery;
- no KANBAN maturity transition or lecture-history entry is authorized;
- only `DEV_STAGE/B_DIDACTIC.md` may be replaced;
- source, tests, permanent Didactic memory, Main stages and every other stage remain untouched;
- Cycle 11 owns polished authentication, Device-management and synchronization presentation.

This report is explicitly speculative. It defines semantic obligations for later Main reconciliation and Codex materialization; it does not describe implemented hosted authentication or accepted production UX.

## 2. Current semantic evidence

Accepted project evidence establishes:

- local Purchase registration remains usable without a hosted service;
- synthetic lab authentication can exercise local convergence and recovery mechanisms;
- complete local convergence and one bounded local rebootstrap story have been proved through Drift, HTTP, Fastify and disposable PostgreSQL;
- server acceptance, peer application, Device acknowledgement, convergence and recovery remain distinct states;
- typed `auth-required`, `device-revoked`, `cursor-expired`, `unknown-outcome` and recovery vocabulary already exist in the protocol boundary;
- local pending, uploading or unknown work is protected from destructive rebootstrap;
- no production AuthVerifier, Account-membership service, Device-enrollment flow or hosted synchronization composition is accepted;
- Auth0 and Render preparation alone proves neither login success nor API authorization nor hosted convergence;
- MCG-01 manual configuration remains active but unreconciled as complete.

Provider-dependent terminology retained from official Auth0 documentation:

- Universal Login is an authorization-server-hosted login flow used to authenticate an external identity;
- an access token is intended for a named API and must be validated by that API;
- failed JWT, issuer, audience or required-permission validation makes the token invalid and the request must be rejected;
- tokens should carry minimal non-sensitive claims, use expiration and travel only over HTTPS.

Markei domain language begins only after provider authentication. An Auth0 `sub` claim identifies the external provider subject under its issuer; it is not itself a Markei AccountId, membership record, installation identity or DeviceId.

## 3. Authentication and authorization vocabulary

| Term | Provisional truthful meaning | Must not imply |
| --- | --- | --- |
| Signed in | external provider login completed and credentials were returned to the client | Markei API accepted the token |
| Token obtained | client possesses an access token intended for a configured audience | token is valid, current or sufficient |
| Token accepted | API validated signature, issuer, audience, expiry and required token contract | Account membership exists |
| External subject | provider-scoped identity claim such as issuer + subject | Markei AccountId, Person or Device |
| Membership confirmed | server resolved the accepted subject to an active Markei Account membership | Device is enrolled or authorized |
| Enrollment required | membership exists but this installation has no accepted Device registration | synchronization is permitted |
| Device enrolled | server created or replayed an equivalent Device enrollment for this installation | Device is permanently authorized |
| Device authorized | accepted token, membership and active Device jointly permit this operation | request or facts were accepted |
| Request accepted | named API operation committed or replayed equivalent result | facts reached another Device |
| Facts synchronized | named facts were accepted, downloaded and applied through the stated scope | backup, restore or all-Device equality |
| Acknowledged | this Device reported a contiguous committed cursor | universal convergence or permanence |
| Converged | named eligible fixtures match under the accepted terminal checks | production readiness or future recovery |
| Authentication unavailable | no usable external credential can currently be acquired or renewed | local database is unavailable |
| Device expired | lifecycle/retention eligibility ended under policy | authorization was explicitly revoked |
| Device revoked | server withdrew Device authorization | local facts were remotely erased |
| Unknown outcome | request may have committed but response is absent | creating a new identity is safe |

## 4. State/evidence matrix

| State | Observable evidence | May claim | Must not claim | Safe next action | Privacy constraint |
| --- | --- | --- | --- | --- | --- |
| Locally available | local database opens and Purchase transaction succeeds | local work is saved on this installation | signed in, uploaded or synchronized | continue locally; queue transfer when configured | no token required for local save |
| Authentication unavailable | login cannot start/finish or usable credential cannot be acquired | hosted access is unavailable; local work remains | Account deleted or data lost | retry login later or continue locally | log provider code/correlation only |
| Authenticating | system browser/provider flow began and no terminal callback exists | authentication is in progress | signed in or token obtained | wait, cancel safely or restart a fresh provider flow | never log authorization URL query secrets/code |
| Authenticated externally | provider flow returned credentials | external identity authentication completed | Markei membership or Device authorization | submit access token to the Markei API | do not expose token or full claims |
| Membership confirmed | API validated token and resolved active subject→Account membership | this external identity belongs to the named Markei Account boundary | Device enrolled or sync permitted | check/enroll installation Device | log Account alias, not raw subject/email |
| Enrollment required | active membership exists; Device record absent | this installation needs enrollment | authentication failed | perform idempotent enrollment | do not reveal other Device existence |
| Device enrolled | enrollment request committed or replayed equivalent Device result | installation has a stable Markei Device identity | every operation is authorized forever | re-check active status per request | DeviceId is identifier, not credential |
| Device revoked | accepted identity/membership but Device status denies access | hosted mutation is denied for this Device | local copies were erased | preserve local facts; follow replacement/re-enrollment policy | avoid exposing revocation reason to unrelated subjects |
| Synchronization permitted | token, membership, active Device and operation scope all pass | this request may enter sync processing | request was accepted or facts converged | execute idempotent operation | authorization header never logged |
| Synchronization denied | API rejects authentication/authorization/domain gate | hosted operation was not permitted | local facts are invalid or deleted | act on typed safeAction; keep local work | return minimum denial detail |
| Hosted proof completed | real development Auth0 token, hosted API/database and two isolated clients pass terminal assertions | named hosted development fixture completed | production ready, universally synchronized or backed up | preserve sanitized evidence and teardown | aliases/counts/timings only |
| Unknown outcome | timeout/interruption after possible commit | final server result is unknown | failed or safe to create replacement request | query/replay same idempotency identity | correlation and redacted identity only |

## 5. Typed failure and safe-action hypothesis

| Situation | HTTP hypothesis | Typed meaning | Safe action |
| --- | --- | --- | --- |
| missing, malformed, expired or unverifiable token | 401 | `auth-required` / `invalid-token` | reacquire credential; preserve local queue |
| wrong issuer or audience | 401 | `token-not-for-api` | stop; correct environment/configuration, not user facts |
| accepted token lacks required API permission | 403 | `insufficient-permission` | obtain authorized grant or contact Account owner |
| subject has no active Markei membership | 403 or privacy-preserving 404 by Main policy | `membership-required` | request/join membership through an authorized route |
| Device unknown on protected sync endpoint | 403/404 without existence oracle | `enrollment-required` | use the explicit enrollment route |
| Device revoked or expired | 403 | `device-revoked` / `device-expired` | stop mutation; preserve local data; use accepted replacement policy |
| verified Account differs from requested resource scope | 404 for resource lookup; 403 for explicit cross-Account operation | `not-found-or-not-authorized` | do not retry with guessed identifiers |
| equivalent enrollment replay | 200/201 equivalent stored result | `duplicate-equivalent` | reuse returned Device identity |
| same enrollment idempotency key with different installation proof/content | 409 | `enrollment-conflict` | stop; do not overwrite or create competing Device silently |
| request domain identity/hash collision | 409 | `conflict` | preserve both evidence sets; require typed resolution |
| hosted API unavailable before acceptance | 503 | `service-unavailable`, not applied | retain local pending work and retry later |
| timeout after possible commit | transport/504 with unknown local classification | `unknown-outcome` | replay/query same Submission or enrollment identity |

HTTP codes are transport semantics, not complete user language. Main must select one consistent anti-enumeration policy. Responses must not reveal whether an unrelated Account, Device, membership or snapshot exists.

## 6. Login cancellation and session expiry

Login cancellation or browser interruption means no completed provider callback was accepted by Markei. It must not create Account membership, Device enrollment or a failed synchronization fact. Local registration continues unchanged.

A cancelled flow may be described diagnostically as `authentication-cancelled`; it should be non-destructive and normally retryable through a new provider authorization flow. A previously unknown API operation remains governed by its original idempotency identity and must not be confused with login cancellation.

When an access token expires while local work is pending:

1. keep local Purchase/Event/outbox facts unchanged;
2. stop new hosted mutation before sending an invalid credential;
3. renew or reacquire authentication;
4. re-resolve membership and Device authorization;
5. continue with the same pending Event and existing Submission identity where applicable.

`Session expired` must not mean `changes lost`, `signed out of local data` or `Device revoked`.

## 7. Device enrollment, replacement and revocation

Provisional enrollment contract:

- external authentication identifies the provider subject;
- Markei membership maps that subject to an Account role;
- installation metadata creates or reuses one Device through an idempotent enrollment operation;
- successful replay returns the same Device result;
- differing content under the same enrollment identity is a conflict;
- enrollment credentials/proofs must never be reused as DeviceId or displayed as an identifier.

Revocation withdraws server authorization for future hosted operations. It does not erase the local Drift database, revoke the external Auth0 identity globally, delete the Account, or prove that all cached tokens have disappeared. The API must deny revoked Devices even when the external token remains otherwise valid.

Reinstall/replacement should normally create a new installation and Device identity. Recovery from an application snapshot reconstructs Account facts; it does not restore the old Device identity, outbox, inbox, acknowledgement or credential state. Local unsent work on the old installation requires an explicit preservation/export/reconciliation policy before replacement.

## 8. Local-first outage behavior

During Auth0, browser, DNS, Render/API or hosted-database outages:

- local registration remains available when the local database is healthy;
- new events remain `saved-local`/`waiting-upload`;
- no hosted state may be fabricated;
- retries preserve EventId, SubmissionId and enrollment/recovery identity as applicable;
- authentication failure is not server unavailability;
- server unavailability is not Device revocation;
- an empty or failed hosted response is not proof of current synchronization.

Android and Windows must use the same Markei semantic states and terminal evidence. Platform-specific browser callbacks, secure storage and lifecycle behavior may differ operationally, but `signed in`, `authorized`, `accepted`, `acknowledged` and `converged` cannot change meaning by platform.

## 9. Privacy and logging language

Provisional explanation:

`Auth0 authenticates an external identity and issues an access token for the Markei API. Markei validates that token, resolves Account membership and separately authorizes an enrolled Device. Tokens are credentials; AccountId and DeviceId are Markei identifiers. Synchronization sends only the facts and protocol metadata required by the accepted contract.`

Permitted diagnostics:

- platform alias, operation, typed code, outcome and safe action;
- issuer/audience configuration aliases or hashes, never secret-bearing values;
- correlation ID and redacted subject/Account/Device suffixes;
- membership/enrollment status, HTTP class and token validation stage;
- cursor ranges, counts, timings and convergence/recovery pass/fail.

Forbidden diagnostics:

- access, ID or refresh tokens;
- authorization codes, PKCE verifier, raw authorization headers or browser callback URLs;
- client secrets, database URLs or provider credentials;
- full external subject, email or ordinary user profile claims;
- Purchase/Product/Store/Person/Payment facts or snapshot bodies;
- messages that reveal unrelated Account, membership or Device existence.

## 10. Minimum neutral hosted-proof diagnostics

Cycle 10 system tests need plain-text or machine-readable evidence only:

```text
platform=android|windows
login=cancelled|credential-returned
token-validation=accepted|rejected:<stage>
membership=confirmed|absent
device=enrollment-required|enrolled|revoked|expired
operation=<typed operation>
http-class=<status>
outcome=applied|duplicate-equivalent|not-applied|unknown
safe-action=<typed action>
submission/enrollment/recovery identity reused=true|false
cursor-before=<alias> cursor-after=<alias>
local-pending-count=<n>
HOSTED_PROOF=false|true
correlation=<redacted alias>
```

`HOSTED_PROOF=true` requires a real development provider login/token, API-side token validation, membership resolution, idempotent Device enrollment, hosted database synchronization/recovery assertions, Android and Windows semantic parity within the tested boundary, reopen evidence and sanitized teardown/reporting. Preparation screenshots or provider dashboards are insufficient.

## 11. Misleading claims to avoid

- `signed in` does not mean token accepted by the Markei API;
- `token obtained` does not mean membership confirmed;
- Auth0 subject is not AccountId, Person or DeviceId;
- membership confirmed does not mean Device enrolled;
- Device enrolled does not mean every request is authorized forever;
- request accepted does not mean another Device applied it;
- acknowledged does not mean all Devices are current;
- hosted development proof does not mean production ready;
- one Android proof does not establish Windows behavior, or vice versa;
- one successful sync does not prove long-offline recovery;
- revocation does not remotely erase local facts;
- synchronization is not permanent backup, provider restore or export;
- `all Devices`, `universally synchronized`, `permanently backed up`, `restored` and `production ready` remain prohibited without separate accepted evidence.

## 12. Cycle 10 / Cycle 11 boundary

Cycle 10 may define contracts, typed failures, state transitions, system-test names and neutral diagnostics required to prove authentication and hosted synchronization truth.

Cycle 10 must not create or redesign login pages, dialogs, banners, Device lists, membership invitations, enrollment prompts, progress components, retry controls, navigation, visual severity, accessibility composition or Analytics.

Auth0 Universal Login itself is provider-hosted presentation. Markei’s placement, explanation, cancellation treatment, Device lifecycle presentation and synchronization history remain Cycle 11 work after the underlying states are implemented and accepted.

## 13. MCG-02 semantic acceptance criteria

MCG-02 may close semantically only when named evidence proves:

1. separate development Auth0 and hosted API/database configuration is active without secret disclosure;
2. Android and Windows can begin and complete the supported external login flow, with cancellation tested safely;
3. the API validates token signature, issuer, audience, expiry and required permission/scope;
4. wrong issuer/audience and expired/malformed tokens return privacy-safe typed authentication failure;
5. accepted external subject resolves to an explicit active Markei Account membership;
6. AccountId authority comes from server resolution, never an unverified payload claim;
7. a new installation receives one idempotently enrolled Device identity;
8. equivalent enrollment replay returns the same result and conflicting replay is rejected;
9. unknown/revoked/expired Devices are denied independently of external token validity;
10. cross-Account operations are denied without existence leakage;
11. local registration continues through Auth0/API outage and pending work resumes after authorization restoration;
12. one real hosted upload/download/apply/acknowledgement story reaches its terminal evidence;
13. one hosted recovery or explicit retained local-recovery boundary is exercised as authorized by Main;
14. logs and reports pass a credential/token/user-fact secret-pattern inspection;
15. ordinary application composition cannot use synthetic fixture authentication;
16. `HOSTED_PROOF=true` is mechanically tied to the complete checklist, not provider preparation.

This closes only a hosted development proof. Production identity operations, release readiness, broad multi-Device guarantees and polished UX remain outside the claim.

## 14. Unresolved Main decisions

1. Auth0 tenant/application/API separation and exact issuer/audience/permission contract.
2. Universal Login configuration and supported Android/Windows callback/logout behavior.
3. Access-token lifetime, refresh/offline-access policy and secure credential storage per platform.
4. Markei membership creation, invitation, role and removal model.
5. Whether absent membership returns privacy-preserving 403 or 404.
6. Device enrollment proof, idempotency identity and installation-binding fields.
7. Device credential lifecycle, rotation, expiry, revocation and replacement policy.
8. Whether a revoked Device may still read/export local facts and how replacement is authorized.
9. Anti-enumeration policy for Accounts, memberships, Devices and recovery resources.
10. Hosted API/Render deployment identity, availability boundary and secret injection.
11. Exact Android/Windows semantic and operational acceptance matrix.
12. Recovery behavior for reinstalled/replaced Devices and local unsent changes.
13. Which Devices count toward `waiting-peer`, account-level convergence or recovery claims.
14. Exact MCG-01 evidence required before provider-backed migration and MCG-02 execution.
15. Whether C10-S03 includes hosted recovery or only hosted authentication plus synchronization.
16. Teardown, test-user/token cleanup and provider residual-data evidence.

## 15. Disposition

```text
accepted project predecessor:
  local convergence and local retention/rebootstrap mechanisms within named labs

implemented hosted authentication/membership/enrollment:
  none accepted at this investigation baseline

proposed:
  provider/Markei vocabulary separation, state matrix, typed failures,
  idempotent enrollment semantics, privacy rules and MCG-02 evidence floor

blocked / externally dependent:
  reconciled MCG-01 evidence, Auth0/Render configuration and hosted secrets

deferred:
  production identity operations, broad recovery guarantees and all Cycle 11 presentation

learner maturity:
  unchanged; no KANBAN transition or lecture-history event

status:
  SPECULATIVE DIDACTIC INVESTIGATION — NOT MAIN AUTHORITY
```
