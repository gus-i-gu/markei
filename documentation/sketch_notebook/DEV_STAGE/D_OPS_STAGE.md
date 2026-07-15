# D_OPS_STAGE — C10-S03A-R1 Corrective Operational Authority

> Sequence: human-authorized direct Main restaging after J reconciliation
> Unit: transaction-safe local hosted-authentication correction
> Baseline: `d411e4ee92d5977984913b9bba21cc9aa1c37bbf`
> Joint authority: D/E/F
> Provider authority: none
> Target size: compact; ordinary files remain below 600 lines

## 1. Method and evidence boundary

This unit corrects the contradicted C10-S03A result recorded by J. The human explicitly requested
direct D/E/F restaging; the otherwise prescribed A/B/C corrective refresh is therefore omitted and
recorded as a bounded methodology deviation. Scope comes only from:

- permanent Operational, Didactic and Design Cycle 10 checkpoints;
- `[M]_STAGE/J_MAIN_STAGE.md` at or after `75fbba6`;
- the prior G/H/I C10-S03A reports;
- repository truth at the baseline above.

Do not reinterpret the previous terminal claim as accepted. Starting state:

```text
C10-S03A_CONTRADICTED_STOP
MCG-02_HOSTED_PROOF_NOT_PERFORMED
```

## 2. Objective and terminal status

Correct and prove locally:

```text
bounded JWT/JWKS verification
→ transaction-scoped membership and Device authorization
→ protected sync/recovery operation in the same transaction
→ separate migrator/runtime database authorities
→ two-Account isolation and concurrency failures
→ provider-neutral Flutter enrollment lab
```

Success reports exactly:

```text
C10-S03A_R1_LOCAL_SECURITY_PROVED
MCG-02_PROVIDER_PROOF_PENDING
```

Any missing decisive gate reports:

```text
C10-S03A_R1_PARTIAL
```

with the exact blocker. Do not emit `HOSTED_AUTH_READY=true` or claim provider readiness.

## 3. Non-negotiable provider and secret boundary

- Do not access Auth0, Neon, Render or any public hosted service.
- Do not request, inspect or use provider credentials.
- Do not read `.vscode/`, `NEON_DOC.md`, `NEON_SESSION.ps1`, `.env` or user-private helpers.
- Do not place a Neon hostname, tenant, audience, client ID, token, password or URL in source,
  tests, reports, logs or commands.
- Use disposable PostgreSQL and generated local RSA/JWKS fixtures only.
- Database passwords belong to database roles, not Markei Accounts.
- Two test Markei Accounts are ordinary synthetic rows and require no passwords.
- Hosted configuration may expose variable names only.
- Keep loopback services bound to loopback and tear them down.
- No provider migration, deployment, user provisioning or manual UI action is authorized.

## 4. Baseline controls

- Preserve migrations 001–004 byte-for-byte unless a schema correction is unavoidable.
- If schema correction is required, add forward-only migration 005; never edit 001–004.
- Preserve event payload v3, opaque `c10b:*` cursor and recovery format 1.
- Preserve Drift v7 facts, outbox, inbox, cursor and recovery state.
- Preserve ordinary local-first Flutter composition.
- Preserve fixture authentication only in tests and explicit loopback labs.
- Preserve C10-S01B and C10-S02 synchronization/recovery behavior.
- Do not add Account signup, invitation, account-selection UI or Device-management UI.
- Do not begin Cycle 11 UI/UX, Analytics, background sync or production retention work.

Before editing, Codex must confirm:

```text
current branch and HEAD
required baseline is an ancestor
working tree scope
existing migration hashes
existing G/H/I contradiction
```

Stop on divergence, overlapping user changes, secret-bearing files or contradictory D/E/F.

## 5. CP1 — Transaction-scoped authorization

The existing flow authorizes in one committed transaction and mutates in another. Replace that
trust boundary with a transaction-scoped operation contract equivalent to:

```text
verifyBearerToken(request) -> ExternalPrincipal

database.inTransaction(tx =>
  authorizeOperation(tx, principal, requestedAccount, requestedDevice)
  -> TransactionAuthorizedContext

  performProtectedOperation(tx, authorizedContext, request)
)
```

Requirements:

- JWT verification may occur before the database transaction.
- AccountId is never accepted from token claims.
- DeviceId is never accepted as authority merely because it appears in a request.
- Resolve exact issuer+subject to active external identity inside the operation transaction.
- Resolve or select the requested active Account membership inside that transaction.
- Recheck active enrollment and Device status inside that transaction.
- Lock membership/enrollment/Device rows, or use an equally explicit concurrency control that
  prevents a revoke/remove operation from committing without a deterministic ordering.
- Perform the protected database operation through the same transaction object.
- Do not commit authorization and later pass a trusted context into another transaction.
- Do not allow services to open hidden nested transactions.
- Preserve RLS/account context and explicit Account predicates.
- Deny disabled/removed membership, unknown/revoked Device and mismatched Installation/Device.
- An authorization failure must cause no operation mutation or acknowledgement advancement.

Apply the invariant to every protected hosted path, including:

```text
event upload
event download
acknowledgement
capabilities/retention metadata where Account scoped
rebootstrap start/status/chunk/complete
Device status
Device revocation
```

Enrollment may begin without a Device but must transactionally recheck identity and membership.
Revocation must transactionally verify actor authority and target Account ownership.

Add a route inventory test so a newly added protected route cannot silently omit the guard.

## 6. CP2 — Bounded JWT/JWKS verification

Preserve `jose` and pin `RS256`, issuer and audience. Materialize an explicit bounded JWKS
retrieval boundary, or an equivalent adapter that proves all limits before untrusted bytes reach
the verifier.

Configuration must include bounded, validated values for:

```text
token byte ceiling
JWKS response byte ceiling
JWKS request timeout
cache maximum age
refresh cooldown
maximum redirects (prefer zero)
```

Never log bearer tokens, claims, JWKS bodies, provider URLs or configuration values.

Required named cases:

```text
valid RS256 token
missing authorization header
duplicate authorization values
wrong/malformed scheme
empty/malformed token
oversized token
invalid signature
wrong issuer
wrong audience
wrong algorithm
expired token
not-yet-valid token
missing/oversized subject
missing kid
unknown kid
known-key cache hit
key rotation and bounded refresh
JWKS timeout
JWKS unavailable with valid cached key
JWKS unavailable without usable key
malformed JWKS JSON
oversized JWKS response
duplicate/conflicting key identifiers
redirect refusal
parallel unknown-kid refresh coalescing
refresh failure and later bounded retry
```

Use deterministic time and generated local keys. Tests must not rely on the public network.

## 7. CP3 — Separate database authorities

The decisive harness must use two distinct disposable PostgreSQL login roles and connections:

```text
lab_migrator_url
  migrations, migration ledger and controlled synthetic provisioning only

lab_runtime_url
  Fastify pool and application transactions only
```

Requirements:

- Generate disposable credentials inside the harness; never reuse Neon values.
- Apply 001→002→003→004, and 005 only if created, through the migrator.
- Seed synthetic external identities, Accounts and memberships through controlled setup authority.
- Close or isolate migrator access before starting the hosted HTTP service.
- Start Fastify using only the runtime pool.
- Do not expose migrator variables to the hosted composition.
- Runtime must be denied DDL, role administration, migration-ledger mutation, membership
  provisioning and worker-only cleanup/snapshot actions.
- Runtime must succeed for authorized HTTP operations under explicit transaction context.
- RLS/no-context and cross-Account probes must fail closed.

Record role names as synthetic aliases only. Never record passwords or database URLs.

## 8. CP4 — Decisive two-Account/race harness

Use two synthetic Markei Accounts and at least two external principals:

```text
Account A: identity A, installations A1 and A2
Account B: identity B, installation B1
```

These are rows in disposable PostgreSQL, not Auth0 tenants or administrator accounts.

Prove over real loopback HTTP:

1. Valid identity A resolves only Account A.
2. Valid identity B resolves only Account B.
3. A cannot request B membership, Device, events, cursor, snapshot or recovery session.
4. B cannot request A resources.
5. Installation A1 enrollment succeeds.
6. Equivalent enrollment replay returns the same Device/result.
7. Same request identity with a different hash returns conflict without mutation.
8. Concurrent equivalent enrollment produces one committed Device binding.
9. Concurrent conflicting enrollment has one deterministic winner/outcome.
10. Installation A2 enrolls as a distinct Device in Account A.
11. Authorized upload/download/acknowledgement succeeds under runtime identity.
12. Membership disable/remove before operation denies it.
13. Membership remove racing an operation has a serializable outcome: either the authorized
    operation commits before removal or removal commits first and the operation is denied.
14. Device/enrollment revocation before operation denies it.
15. Revocation racing an operation has the same deterministic ordering rule.
16. Revoked Device cannot use synchronization or recovery routes.
17. Restart preserves enrollment idempotency and revocation state.
18. Unknown outcomes are safely queryable/replayable where the existing contract permits.
19. No denied request advances cursor, acknowledgement, sequence or recovery state.
20. Existing local facts remain available when the API is unavailable.

Use barriers/hooks at defined transaction points rather than timing sleeps for race tests.

## 9. CP5 — Provider-neutral Flutter lab boundary

Complete only the missing application/infrastructure seam required for local proof:

- an opt-in lab `ExternalAuthenticationSession`;
- an opt-in lab `AccessTokenSource`;
- a bounded HTTP `DeviceEnrollmentTransport`;
- a coordinator using `HostedIdentityRepository` and `HostedSyncGuard`;
- durable enrollment request/progress/result across reopen;
- equivalent replay after response loss;
- conflict, cancellation, unavailable service and rejected credential handling;
- no reassignment of pending local events to a new server Device;
- ordinary local composition remains independent and functional.

The lab may use generated local tokens and loopback HTTP. It must not add:

```text
Auth0 SDK dependency or invocation
real callback/protocol registration
provider tenant/client identifiers
native client secret
production token storage
account-selection or Device-management UI
polished Cycle 11 presentation
```

If the existing ports cannot support safe orchestration, change them minimally and test the
dependency direction. Do not broaden into production sign-up.

## 10. CP6 — Regression and validation floor

Run and record exact commands/results for:

- TypeScript formatting, lint, typecheck and full tests;
- focused JWT/JWKS and transaction-race tests;
- decisive local hosted harness using distinct migrator/runtime identities;
- migrations fresh 001→004/005, incremental, failure rollback and ledger checks;
- per-table RLS and privilege probes;
- Drift regeneration only if schema declarations changed;
- Dart formatting, Flutter analysis and complete Flutter tests;
- provider-neutral Flutter lab tests including restart and API unavailable;
- existing recovery/convergence harness;
- Android debug build when host-supported;
- Windows release build when host-supported;
- protected Python regressions;
- `npm audit --omit=dev` with environment noted;
- `git diff --check`;
- tracked/staged secret scan;
- disposable-resource teardown verification.

Host-blocked work remains `host-unvalidated`; it does not become product failure or success.

Decisive diagnostic:

```text
LOCAL_TRANSACTION_AUTHORIZATION=true
LEAST_PRIVILEGE_HTTP=true
TWO_ACCOUNT_ISOLATION=true
JWKS_FAILURE_FLOOR=true
FLUTTER_HOSTED_LAB=true
```

## 11. G/H/I evidence contract

Replace only the existing G/H/I reports after implementation.

G records:

- baseline/final SHA and complete changed-path inventory;
- dependency and migration versions/hashes;
- exact validation commands, results, counts and exclusions;
- route inventory and authorization/race cases;
- JWT/JWKS case counts;
- migrator/runtime role and denial evidence without credentials;
- Account/identity/installation/Device counts and cross-Account denials;
- Flutter lab/reopen evidence;
- secret scan and teardown;
- confirmation no provider was accessed.

H records:

- exact semantic states from E;
- transaction-scoped authorization wording;
- named failure mappings and safe actions;
- local-first/privacy behavior;
- unsupported readiness wording intentionally absent;
- no learner maturity or Cycle 11 promotion.

I records:

- final dependency direction and transaction ownership;
- JWT/JWKS boundary and limits;
- migrations/Drift/protocol versions;
- role separation and RLS responsibilities;
- enrollment/revocation idempotency and concurrency behavior;
- Flutter lab containment;
- deviations and provider/manual deferrals.

## 12. File, commit and stop discipline

- Modify only files required by this corrective unit plus G/H/I.
- Keep permanent documentation, methodology, J and A/B/C unchanged.
- Keep migrations 001–004 immutable; add 005 only with explicit necessity recorded.
- Preserve unrelated and untracked user files.
- Do not stash, reset, clean, force-push or overwrite provider helpers.
- Review the complete diff and secret scan before commit.
- Commit one bounded C10-S03A-R1 unit; push only the intended branch, never force.
- Report final SHA and exact changed paths.

Stop before any Auth0, Neon or Render action. Successful local proof authorizes only a new Main
reconciliation; it does not itself activate MCG-02.
