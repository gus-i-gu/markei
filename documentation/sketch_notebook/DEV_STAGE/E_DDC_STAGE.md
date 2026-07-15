# E_DDC_STAGE — C10-S03A-R1 Semantic Authority

> Unit: transaction-safe local hosted-authentication correction
> Baseline: `d411e4ee92d5977984913b9bba21cc9aa1c37bbf`
> Joint authority: D/E/F
> Learner maturity: unchanged
> Provider acceptance: not authorized

## 1. Controlling correction

The earlier G/H/I wording overstated local readiness. An identity, membership or Device check that
committed before the protected operation is not authorization for that later operation.

Use this exact rule:

> A Device is authorized only for one named operation, inside the database transaction that
> commits or rejects that operation.

Starting status remains:

```text
C10-S03A_CONTRADICTED_STOP
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```

## 2. Identity distinctions

| Term | Meaning | Does not mean |
| --- | --- | --- |
| Auth0 tenant | provider workspace/configuration boundary | Markei Account |
| external user | person authenticated by a provider | Account, Person fact or Device |
| access-token candidate | credential bytes held by a client | valid or authorized request |
| external principal | verified issuer+subject | AccountId or DeviceId |
| external identity | opaque Markei mapping for a principal | active membership |
| Markei Account | application data/authorization boundary | database login |
| membership | identity-to-Account authorization relation | Device enrollment |
| InstallationId | stable local app-installation identifier | secret or authorization proof |
| DeviceId | server-owned synchronization actor | hardware identifier or Auth0 object |
| database role | migrator/runtime PostgreSQL login | Markei user or Account |

Two Markei Accounts in tests are PostgreSQL rows. They have no passwords. Database passwords
belong only to the disposable migrator/runtime test roles or later human-managed provider roles.

## 3. Required vocabulary

Use the narrowest accurate state:

```text
locally-available
authentication-required
authenticating
authentication-cancelled
token-obtained
token-rejected
principal-verified
membership-required
membership-disabled
account-selection-required
membership-confirmed
enrollment-required
enrolling
device-enrolled
device-revoked
device-expired
operation-authorizing
device-authorized-for-transaction
operation-committed
operation-denied
service-unavailable
unknown-outcome
local-security-proof-passed
provider-proof-pending
hosted-proof-passed
```

Do not use bare `authenticated` when only token possession or provider sign-in is known.

Do not use bare `device-authorized` outside the transaction and named-operation boundary.

## 4. State progression

The normal conceptual flow is:

```text
locally-available
→ authentication-required
→ authenticating
→ token-obtained
→ principal-verified
→ membership-confirmed
→ enrollment-required (first installation only)
→ device-enrolled
→ operation-authorizing
→ device-authorized-for-transaction
→ operation-committed
```

These are application/test states, not values a human enters into Auth0, Neon or Render.

Provider signup alone does not create a Markei Account, membership or Device. For the local lab,
controlled setup provisions synthetic Account/membership rows and the enrollment API creates the
Device. Production Account signup/invitation remains a Main decision outside R1.

## 5. Outcome contract

Every operation reports one outcome:

```text
applied
duplicate-equivalent
not-applied
unknown
```

| Condition | Outcome | Safe action |
| --- | --- | --- |
| missing/malformed/unverifiable token | not-applied | reacquire credential; preserve local work |
| valid principal, no membership | not-applied | request membership/provisioning |
| multiple memberships without selection | not-applied | select Account in a later authorized flow |
| no active Device binding | not-applied | run idempotent enrollment |
| disabled/removed membership | not-applied | stop hosted operation |
| unknown/revoked Device | not-applied | stop; do not silently enroll a replacement |
| enrollment replay, same hash | duplicate-equivalent | reuse recorded Device/result |
| enrollment replay, different hash | not-applied | surface conflict |
| response lost after possible commit | unknown | query/replay same identity; never invent another |
| API unavailable | not-applied/unknown by phase | preserve local facts and queue |
| committed protected operation | applied | report only that named operation |

## 6. Transaction semantics

`device-authorized-for-transaction` requires all of the following in one transaction:

- exact verified principal input;
- active external identity;
- active Account membership;
- Account ownership of the requested resource;
- active Installation/Device enrollment when required;
- active Device status;
- protected operation commit.

Revocation/removal races must have a serializable explanation:

```text
operation commits before revocation/removal
OR
revocation/removal commits first and operation is denied
```

There must be no successful operation authorized by stale committed state.

## 7. JWT/JWKS semantics

- `token-obtained` is client state only.
- `principal-verified` requires signature, issuer, audience, algorithm and time checks.
- Unknown key, unavailable key source or malformed/oversized key response does not become an
  accepted principal.
- A cached valid key may support a bounded outage only under the frozen cache policy.
- Key refresh failure remains a generic authentication failure to clients.
- Never distinguish signature/key/provider internals in public errors.
- Never log a token, claims, JWKS body, subject, provider URL or credential.

## 8. Account and Device isolation

- Account A identity cannot read or mutate Account B.
- A request-supplied AccountId is a selector to validate, not authority.
- A request-supplied DeviceId is an identifier to validate, not authority.
- One external identity may later have multiple memberships, but R1 must not silently select one.
- Two installations for one membership become two Devices through explicit enrollment.
- Device revocation withdraws future hosted authorization; it does not erase local facts.
- Lost InstallationId does not authorize reusing an old Device automatically.

## 9. Flutter/local-first semantics

- Local registration remains available without authentication or API availability.
- Hosted enrollment is opt-in during R1.
- Pending local events retain their original local Device/event identity.
- Enrollment does not silently rewrite or reassign pending work.
- Cancellation returns to a truthful local state.
- Service unavailable preserves local facts, queued work and durable enrollment progress.
- Lab success must not be presented as Auth0 callback or hosted-provider success.

## 10. Failure presentation and privacy

Public failures remain closed and neutral. They may expose:

```text
code
operation
outcome
retryable
safeAction
correlationId
```

They must not expose:

```text
token or claims
issuer/subject
JWKS response or key data
provider/database URL
membership existence across Accounts
SQL/constraint detail
Purchase or snapshot payload
```

Cross-Account, unknown identity and foreign Device failures must not become enumeration oracles.

## 11. Required semantic tests

Name tests that prove:

- token possession is not membership;
- membership is not Device enrollment;
- enrollment is not perpetual authorization;
- authorization is transaction/named-operation scoped;
- stale authorization cannot cross a committed transaction;
- removal/revocation races have deterministic outcomes;
- cross-Account requests reveal no foreign existence;
- equivalent enrollment replay reuses one result;
- conflicting replay is rejected without mutation;
- response loss preserves unknown-outcome semantics;
- local work survives authentication cancellation and API outage;
- local proof never claims provider proof.

## 12. Prohibited completion language

Until a later Main reconciliation accepts R1, do not claim:

```text
hosted-auth-ready
Auth0 configured and working
Render deployment accepted
Neon hosted synchronization accepted
MCG-02 complete
production authentication ready
Cycle 10 closed
```

On decisive local success, only this pair is allowed:

```text
C10-S03A_R1_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

## 13. Didactic and UI boundary

- No KANBAN maturity change follows from code/test evidence.
- Do not modify glossary, Concept Map or lecture history during materialization.
- No Cycle 11 navigation, account-selection, Device-management or polished retry UX.
- Minimal typed lab diagnostics are allowed.
- Actual Auth0 callback/login observations belong to later human MCG-02 evidence.
