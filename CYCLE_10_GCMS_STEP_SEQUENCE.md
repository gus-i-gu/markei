# Cycle 10 — GCMs Step Sequence

> Repository: `gus-i-gu/markei`
> Branch: `intermid-cycle-recovery`
> Recorded after implementation: `e762b64be2a00b43735c3bcb40b8d349afcb0dd3`
> Status: MCG-02 local implementation proved; controlled provider validation pending.
>
> This operational handoff does not replace Sketch Notebook methodology, J reconciliation, or
> active D/E/F authority. Provider operations remain human-operated and evidence must be sanitized.

## Naming

Project conversations sometimes use **GCM** while staged authority uses **MCG**. This file preserves
the user-facing GCM wording in its title but uses the repository's canonical MCG identifiers below.

## Safety and evidence rules

- Use only the development Auth0 tenant, Render development service, Neon development branch, and
  synthetic Markei data.
- Never paste passwords, database URLs, bearer tokens, JWTs, Auth0 subjects, complete callback URLs,
  Account IDs, Device IDs, or provider secrets into Git, chat, screenshots, or staging.
- Record aliases, status codes, state names, row counts, commit SHAs, timestamps, and redacted errors.
- Do not alter the Neon production branch.
- Do not rerun already-ledgered migrations or edit migrations 001–006.
- Stop on cross-Account data, unexpected provider activity, migration/checksum mismatch, or secret
  exposure. Preserve local databases and logs without committing them.
- A local or loopback proof is not provider acceptance.
- MCG-03 and MCG-04 remain undefined until Main reconciles MCG-02 closure.

## Current accepted state

### MCG-01 — Neon development foundation

Accepted development evidence includes:

- isolated Neon development branch and disposable database;
- PostgreSQL 18.4;
- separate `markei_migrator` and `markei_runtime` roles;
- direct migrator and pooled runtime boundaries;
- TLS and channel binding;
- runtime DDL denial;
- migrations 002–006 in the ledger;
- hosted runtime readiness function returning true;
- Render live/ready endpoints returning HTTP 200;
- unauthenticated identity endpoint returning HTTP 401;
- Auth0 metadata, JWKS and RS256 contract checks.

Credential containment and rotation remain operational responsibilities whenever exposure is
suspected. No credential belongs in this file.

### MCG-02 — Local implementation

Commit `e762b64` reports:

- durable hosted Account/server-Device binding;
- `hosted-restart-required` after first enrollment;
- binding activation only after close/reopen;
- Account/Device-scoped outbox and unknown replay;
- Account-scoped inbox, cursor, application and acknowledgement;
- local-only pending-event preservation;
- cross-Account atomic rejection;
- two-Device local convergence;
- 93 Flutter tests plus two expected skips;
- 46 API tests;
- Android debug and Windows release builds;
- disposable Docker/PostgreSQL convergence with `CONVERGED=true`;
- no provider access or provider mutation.

This makes the client ready for controlled provider proof. It does not close MCG-02.

## MCG-02 controlled provider proof

### Gate 0 — Exact implementation and clean workspace

1. Use a clean checkout of `intermid-cycle-recovery`.
2. Pull with fast-forward-only behavior.
3. Confirm `e762b64` is an ancestor of HEAD.
4. Confirm the tracked working tree is clean.
5. Preserve private local configuration outside Git.
6. Confirm Render deploys `e762b64` or a later explicitly reconciled commit before testing.

Pass evidence:

- branch alias;
- HEAD/deployment SHA;
- clean tracked status;
- no secrets printed.

### Gate 1 — Provider foundation health

Confirm without changing provider configuration:

1. Render `GET /health/live` returns HTTP 200 and `{"status":"live"}`.
2. Render `GET /health/ready` returns HTTP 200 and `{"status":"ready"}`.
3. `GET /v1/identity` without a token returns HTTP 401.
4. Auth0 OpenID metadata returns HTTP 200.
5. Auth0 JWKS returns HTTP 200 and contains signing keys.
6. Issuer and audience exactly match Render's configured values.
7. Neon runtime readiness returns true using the pooled runtime role.
8. Render logs contain no tokens, credentials, database URLs, identity subjects, or fact payloads.

Pass evidence:

- HTTP statuses and small non-secret response bodies;
- issuer/audience match booleans;
- JWKS key count;
- runtime-ready boolean;
- sanitized log scan pass/fail.

### Gate 2 — Build both native clients

Windows:

1. Build Release with the private non-secret Auth0/Render Dart defines.
2. Do not modify PATH or manually copy DLLs.
3. Confirm `markei.exe` launches and the native closure surface appears.

Android:

1. Start an emulator or attach a development device.
2. Build/install Debug with the Android Auth0/Render Dart defines.
3. Confirm the native closure surface appears.

Do not record client IDs, domain values, callback URLs, or audience values in evidence.

### Gate 3 — Controlled identity and Account membership

This gate is performed using the already-authorized development procedure and synthetic identity.

1. Authenticate the synthetic user through Auth0.
2. Query `GET /v1/identity`.
3. If the identity is not mapped, use the controlled migrator procedure authorized by current
   staging to create or activate exactly one external identity and one Account membership.
4. Do not derive AccountId or DeviceId from the Auth0 subject.
5. Re-query identity and require an active Account membership.
6. Record counts/statuses only.

Stop if membership is ambiguous, duplicated, cross-Account, or requires ad-hoc SQL not already
authorized by Main.

### Gate 4 — Enroll Windows as Device A

1. Start from authenticated Windows state.
2. Select **Enroll** once.
3. Require `hosted-restart-required`.
4. Do not select Sync in the same process.
5. Close Markei completely.
6. Reopen it with the same private build configuration.
7. Authenticate again if required.
8. Select **Status** and require the hosted binding to be active/enrolled.
9. Query enrollment and require duplicate-equivalent or the existing active Device result.
10. Record state names only.

### Gate 5 — First hosted synchronization from Windows

1. After the restarted hosted binding is active, create one obviously synthetic purchase A.
2. Select **Sync** once.
3. Require a completed or no-new-events result, not interrupted/unavailable.
4. Select Sync again and require an idempotent no-new-events/equivalent result.
5. Confirm older local-only purchases remain visible locally.
6. Confirm the server accepted only the hosted synthetic event.

### Gate 6 — Enroll Android as Device B

1. Authenticate Android using the same synthetic Auth0 user and Account membership.
2. Select **Enroll** once.
3. Require `hosted-restart-required`.
4. Close the application fully and reopen it.
5. Authenticate again if required.
6. Require an active hosted binding with a Device distinct from Windows.
7. Do not expose either Device identifier in evidence.

### Gate 7 — Bidirectional convergence

1. On Android, select Sync and require purchase A to appear.
2. Register synthetic purchase B on Android.
3. Sync Android and require success.
4. Sync Windows and require purchase B to appear.
5. Close both applications.
6. Reopen both local databases/applications.
7. Confirm both contain the same authoritative hosted purchases A and B.
8. Confirm local-only history remains local and was not uploaded.
9. Confirm repeated Sync is idempotent.

### Gate 8 — Authorization and revocation denial

Only after positive convergence:

1. Revoke Device B through the controlled server/provider procedure owned by Main.
2. Attempt Android Sync.
3. Require typed Device-revoked/denied behavior.
4. Confirm no cursor, acknowledgement, event, or hosted fact advances for Device B.
5. Confirm Windows Device A remains authorized and operational.
6. Do not delete the Android local database.

### Gate 9 — Provider outage continuity

Use the least destructive approved method, preferably a temporary development-service suspension or
a controlled unreachable-origin fixture. Do not delete provider resources.

1. Make the development API temporarily unavailable.
2. Register synthetic purchase C locally.
3. Attempt Sync and require interrupted/unavailable behavior.
4. Confirm purchase C remains locally visible and pending.
5. Restore API availability.
6. Sync again and require purchase C to upload exactly once.
7. Sync the other active Device and confirm convergence.

### Gate 10 — Logout and ephemeral credentials

On each supported client:

1. Select Logout.
2. Require signed-out status.
3. Confirm protected Status/Enroll/Query/Sync requires authentication.
4. Close and reopen the application.
5. Confirm no usable access token is recovered from persisted local state.
6. Re-sign-in may be tested afterward as a separate positive check.

### Gate 11 — Sanitized provider evidence

Collect:

- tested commit and Render deployment SHA;
- Windows and Android build pass/fail;
- authentication, enrollment, restart and convergence state names;
- number of Accounts, active memberships, Devices, events and acknowledgements;
- revocation denial result;
- outage/pending/retry result;
- local-only preservation result;
- Render HTTP statuses and secret-log scan;
- Neon fail-closed/cross-Account result;
- exclusions and redacted errors.

Do not collect identifiers or payload contents.

Expected terminal only when all gates pass:

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

If any decisive gate fails, report `MCG-02_PROVIDER_PROOF_PARTIAL` with the exact gate and sanitized
error. Do not improvise provider mutations.

## MCG-02 reconciliation and closure

After the human evidence block returns:

1. Main inspects the exact remote commit and G/H/I.
2. Main reconciles provider evidence in append-only J.
3. Domain chats classify Operational, Didactic and Design claims using PRC-01.
4. Accepted claims are promoted to permanent domain memory.
5. Staging is pruned only after promotion and with preserved provenance.
6. Main declares MCG-02 closed or stages one narrowly bounded correction.

## MCG-03 definition sequence

MCG-03 is inactive until MCG-02 closes. Main must then:

1. inspect permanent memory and remaining Cycle 10 gaps;
2. define the exact MCG-03 objective and provider boundary;
3. request A/B/C investigations if architectural alternatives remain;
4. reconcile J and issue synchronized D/E/F authority;
5. run bounded implementation or human proof;
6. reconcile G/H/I and promote accepted evidence.

Candidate subjects previously discussed—Device lifecycle, hosted operations, retention worker/provider
integration, or hosted recovery—are hypotheses, not authorization.

## MCG-04 definition sequence

MCG-04 is inactive until MCG-03 reconciles. Main repeats the same method:

1. define the final unresolved external/operational gate;
2. investigate alternatives;
3. stage J/D/E/F;
4. implement and validate;
5. reconcile and promote evidence.

Likely concerns include reproducible hosted operations, recovery/rollback, authorization regression,
provider cleanup, and final cross-platform acceptance. These remain hypotheses until Main selects
them.

## Cycle 10 closure

After MCG-02, MCG-03 and MCG-04 reconcile:

1. promote all accepted domain evidence;
2. prune oversized provisional staging without deleting provenance;
3. inventory migrations, schemas, protocol versions and provider resources;
4. verify secret and generated-artifact hygiene;
5. separate development proof from production acceptance;
6. record deferred decisions and rollback boundaries;
7. write final append-only J reconciliation;
8. confirm the Cycle 10 terminal;
9. establish a clean Cycle 11 baseline.

No Cycle 11 implementation begins before that reconciliation.
