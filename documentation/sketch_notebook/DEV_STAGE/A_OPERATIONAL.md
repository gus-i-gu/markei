# Main Synthesis Summary

Cycle 07 Shared Beta Planning, Sprint 02 can operationally support the favored product shape:

```text
one shared cross-platform client
+ offline-first local database per installation
+ verified-email account
+ small authenticated synchronization API
+ Neon Postgres append-only event store
```

The smallest credible synchronized workflow is not “share the database.” It is: register a purchase locally while offline, persist a pending event, upload it after authenticated reconnect, append it idempotently under the account, receive a server cursor, download it on a second device, apply it transactionally, rebuild projections, and prove close/reopen persistence. Clients must never contain a privileged Neon connection string; possession would allow extraction and bypass the API’s account authorization, validation, rate, and protocol boundaries.

Both compared API stacks are operationally plausible. A TypeScript API has a coherent JSON/schema ecosystem and fits serverless Node hosting well. A Python API can reuse team knowledge and may make behavioral comparison with current Python easier, but it does not directly reuse the desktop service/repository because the synchronized client and Postgres event service have different responsibilities. The shared-client family remains unselected; Flutter is a useful feasibility reference because its official documentation covers Android, iOS, Windows, authenticated HTTP, SQLite, testing, and platform-specific tooling, but this is evidence of capability, not framework acceptance.

Recommendation: Sprint 03 should be an isolated protocol experiment, not a UI rewrite. Run one API locally against disposable Postgres, use a fake or test identity issuer, and simulate two device-local stores. Prove idempotent append, cursor download, transactional application, retries, authorization isolation, and restart recovery before provisioning production infrastructure.

# Evidence and Assumptions

Repository evidence was read only from `cycle-07-mobile-preparation`. The accepted baseline is `f6414fbe7394453387067a5a34ca6cc7621bbed3`. Main section 14 activates shared-beta planning while leaving architecture, framework, authentication provider, API runtime/host, Neon project, implementation, and D/E/F unaccepted or postponed. Current Markei evidence provides Python behavior and SQLite semantics, not a sync protocol.

Official Neon documentation states that connection strings contain database role credentials, supports direct and pooled connections, requires encrypted connections, and recommends pooled connections for web applications and connection-per-request workloads. Its PgBouncer pool uses transaction mode; direct connections are recommended for schema migrations, dumps/restores, and session-level operations. Neon supports Node and Python connection routes. [Neon connection guide](https://neon.com/docs/connect/connect-from-any-app) and [pooling guide](https://neon.com/docs/connect/connection-pooling).

Official Auth0 documentation demonstrates one plausible provider pattern: verification links or OTP can establish email access, while JWT/JWKS validation protects an API. It explicitly warns that email verification is not, by itself, proof of identity or complete account security. [Email verification](https://auth0.com/docs/manage-users/user-accounts/verify-emails) and [JWT validation](https://auth0.com/docs/secure/tokens/json-web-tokens/validate-json-web-tokens). Auth0 is an example, not a selected provider.

Official Flutter documentation lists Android, iOS, and Windows support and distinct platform setup/deployment paths. It also documents SQLite persistence, authenticated requests, layer testing, and native debugging. [Flutter supported platforms](https://docs.flutter.dev/reference/supported-platforms) and [iOS setup](https://docs.flutter.dev/platform-integration/ios/setup). Flutter is not selected.

**Assumptions requiring testing:** a candidate shared-client SQLite library is reliable on all three targets; the chosen auth SDK supports Windows desktop and secure token storage; API hosting supports the selected driver and connection mode; cold Neon compute latency is acceptable; event volumes fit low-cost quotas; provider free tiers remain available; local projection rebuild remains deterministic; and one cursor stream per account is sufficient for the first slice.

# Candidate Operational Stacks

## Stack 1 — shared client + small TypeScript API + Neon

Candidate components: shared client family; local SQLite; TypeScript API on a Node-compatible managed runtime; schema validation; Postgres driver or Neon serverless driver; migrations owned by the API repository; external verified-email/OIDC provider.

Operational strengths:

- one typed JSON vocabulary across client-facing protocol and API;
- mature request validation and test tooling;
- Neon documents both ordinary Node Postgres and serverless-driver routes;
- serverless or container hosting options are broad;
- JSON event payload handling is direct.

Operational costs and risks:

- adds Node/package-manager/runtime learning and dependency management;
- runtime differences matter: long-lived Node service, serverless functions, and edge runtimes do not share identical TCP, pooling, process, or filesystem behavior;
- TypeScript types disappear at runtime, so payload validation remains mandatory;
- behavior parity with desktop Python must come from fixtures, not shared source;
- database migrations and transaction behavior still require Postgres-specific tests.

Preferred database mode: pooled Neon URL for ordinary concurrent API traffic; direct URL, held only by controlled migration/administration jobs, for migration tools that need session semantics. The exact driver/serverless choice is **assumption until hosted-runtime testing**.

## Stack 2 — shared client + small Python API + Neon

Candidate components: same shared client/local store; Python ASGI API such as FastAPI; Pydantic-style validation; Psycopg or another supported Postgres driver; API-owned migrations; same external identity boundary.

Operational strengths:

- existing Python familiarity lowers initial API debugging cost;
- deterministic fixtures may be executed against both current Python behavior and API protocol tests;
- Neon documents Python connectivity;
- local API tests are straightforward with a disposable Postgres instance.

Operational costs and risks:

- current Markei repository/service code is SQLite- and desktop-composition-shaped, so reuse must not collapse local application and cloud sync responsibilities;
- Python environment, dependency locking, ASGI server, worker/process, and driver pooling must be reproducible;
- managed/serverless Python hosts may impose cold starts or connection lifecycle constraints;
- a Python API does not remove the shared-client language boundary.

Preferred database mode matches Stack 1: pooled for application requests; direct for migrations and recovery tasks. API transaction scope must atomically validate account/device sequence, insert-or-recognize the event UUID, allocate/return the server cursor, and commit.

Operationally, TypeScript is slightly favored for a compact JSON synchronization service if the client also uses a TypeScript-family framework; Python is slightly favored if rapid protocol experimentation and existing knowledge dominate. Neither advantage is proven, and client framework selection remains outside this report.

# Local and Hosted Environments

Minimum local services:

1. shared-client test harness with two isolated local databases (“device A” and “device B”);
2. API process;
3. local disposable Postgres container or process;
4. migration runner;
5. fake/test OIDC issuer or provider test tenant;
6. network fault proxy or deterministic test doubles;
7. structured log sink visible in test output.

Yes, API and database can be tested locally without Neon. Local Postgres should validate schema, uniqueness constraints, transactions, cursor allocation, account scoping, and restart behavior. A later Neon test environment is still required to validate TLS, pooled/direct URLs, scale-to-zero/cold start, network latency, provider limits, and hosting integration.

Environment separation:

```text
local: disposable Postgres + fake/test identity
test/CI: isolated database/branch + test identity tenant + non-production API
staging: separate Neon project or branch/role + staging auth app + staging API
production: independent credentials, database/role, auth app, API and retention policy
```

No production token, database URL, signing secret, or auth management key belongs in source, client assets, logs, fixtures, or build output. Environment variable names may be committed; values must live in local ignored files or host secret storage. Mobile/desktop clients may contain public auth configuration and API base URL, never API private keys or Postgres credentials.

Schema migrations are API-owned, forward-reviewed artifacts. CI should apply them to a fresh database and upgrade a representative prior schema. Ordinary API traffic uses pooled connections; migrations use a direct connection when required. A failed migration must stop deployment before new API code receives traffic. Rollback defaults to application rollback plus a forward corrective migration; destructive down-migrations are not assumed safe. Backup/restore and Neon branching/time-travel are operational aids, not substitutes for tested migrations.

# Authentication and Secrets Boundary

Verified email answers “was access to this mailbox demonstrated?” It does not safely become the database key or authorization rule. On first accepted identity, Markei maps the provider’s immutable subject (`issuer + sub`) to an internal immutable account UUID. Email may change; account UUID must not.

The client obtains an access token through the provider SDK and sends it to the API. The API validates signature through trusted JWKS, expected issuer, audience, expiry/not-before, permitted algorithm, and required claims. It then resolves the internal account UUID and checks `email_verified` or equivalent policy before sync. Every event query and append is scoped by the resolved account UUID; client-supplied `account_id` is never trusted as authorization.

Refresh tokens or equivalent long-lived credentials must use OS secure storage where the chosen client framework supports it; this is **untested** on Android, iOS, and Windows. Logs must redact authorization headers, cookies, verification codes, database URLs, and event payload fields that may contain user data. Key rotation, JWKS cache refresh, logout/revocation behavior, and clock skew require empirical tests.

# Sync Failure Model

Local purchase registration commits the purchase fact, pending event, event UUID, device UUID, and monotonically increasing device sequence in one local transaction. Sync is manual/foreground in the first slice.

Upload uses bounded batches and request IDs. The server has a unique constraint on `(account_id, event_id)` and likely `(account_id, device_id, device_sequence)`. Re-uploading the same identical event returns the original acceptance/cursor; the same event UUID with different content is rejected and logged. A device-sequence gap is rejected or quarantined rather than silently reordered; exact policy is **assumption pending protocol decision**.

A network failure before response leaves local events pending because acceptance is unknown. Retry is safe through idempotency. A server transaction either accepts the whole valid batch or returns per-event results only if partial acceptance semantics are explicitly designed. For Sprint 03, atomic whole-batch acceptance is operationally simpler.

Download requests events after the last committed local server cursor. The server returns an ordered bounded page and next cursor. The client applies the page and advances its cursor in one local transaction, then rebuilds affected projections. Network loss before commit leaves the old cursor; retry re-downloads safely. Loss after commit but before acknowledgement is also safe because the cursor and applied event identities are durable.

Logs should include timestamp, environment, service version, request ID, account hash/pseudonymous ID, device ID, batch ID, event count, cursor range, outcome code, latency, retry classification, and database error class. They must not include access tokens or privileged connection strings. Client diagnostics should correlate request ID, local pending count, last cursor, and sanitized failure class.

# Two-Device Validation Matrix

| Scenario | Required procedure | Pass evidence |
| --- | --- | --- |
| Offline purchase creation | Disable network on A; register purchase; close/reopen | Purchase and pending event persist; no cloud dependency |
| Retry same event | Upload A event, discard response, retry identical batch | One server row; same acceptance/cursor; pending clears once |
| Two devices upload | A and B create different events offline, then upload | Both account-scoped events append once; stable cursor order |
| Download after cursor | B stores cursor N; add event; request after N | Only later events returned; cursor advances transactionally |
| Loss during upload | Interrupt before/after server commit | Pending retained until confirmed; retry creates no duplicate |
| Loss during download | Interrupt before local page commit | Local cursor/data both remain old, or both advance—never split |
| Invalid/expired auth | Send expired, wrong-audience, or invalid-signature token | 401; no event read/write; sanitized diagnostic |
| Unauthorized account | Token for account X requests Y data | 403/empty according to contract; zero leakage or mutation |
| Malformed payload | Missing IDs, invalid type/version/quantity | 4xx validation result; no append/cursor allocation |
| Duplicate event UUID | Repeat identical, then conflicting payload | Identical is idempotent; conflicting duplicate rejected |
| Device sequence gap | Send sequence 3 before 2 | Defined rejection/quarantine; no silent acceptance |
| API restart | Restart between sync attempts | Durable events/cursors remain; client retry succeeds |
| Local close/reopen | Close each client after apply | Event identities, cursor and projections persist |
| Desktop isolation | Run shared-client test beside Cycle 06 data | Different resolved path; desktop DB hash/path untouched |

# Cost and Operational Risk

A free/low-cost prototype is realistic if it uses two simulated devices, one small API instance, a disposable local Postgres, a test identity tenant, and a low-traffic Neon test database. Neon currently advertises a free plan with scale-to-zero, limited compute/storage, branching, and short restore history, but quotas and provider terms can change. [Neon pricing](https://neon.com/pricing). API hosting, auth email delivery, logs, domain/TLS, CI minutes, macOS access, and device availability may create separate costs.

Largest risks are protocol bugs causing silent divergence; account-scope authorization mistakes; leaked secrets; non-idempotent retries; cursor/local-transaction splits; migration failure; cold-start/connection behavior; auth SDK gaps on Windows; iOS macOS/Xcode dependency; insufficient observability; and treating append-only events as automatically conflict-free. Append-only removes editing conflicts from the first slice, but two devices can still introduce ordering, identity, reference, and duplicate problems.

Operational cost rises sharply when supporting three packaged clients, secure token storage, provider SDK differences, schema evolution, API deployments, logs, recovery, and two-device regressions. Neon reduces Postgres infrastructure work; it does not own sync semantics, authorization, migrations, client queues, or recovery.

# Recommended Sprint 03 Experiment

Authorize only after D/E/F:

1. freeze a versioned event envelope and two deterministic purchase fixtures;
2. implement a local protocol harness with two isolated SQLite stores;
3. run either TypeScript or Python API locally against disposable Postgres;
4. use fake/test tokens with account X/Y claims;
5. implement `POST /sync/events` idempotent atomic append and `GET /sync/events?after=` cursor download;
6. execute every matrix row, including API restart and network interruption;
7. record schema migration, logs, request IDs, batch/cursor evidence, and database counts;
8. repeat the same API tests against a non-production Neon environment using pooled application and direct migration connections;
9. stop before UI framework integration unless the protocol passes.

This experiment answers protocol feasibility independent of final client UI. TypeScript versus Python should be selected for the experiment by smallest reproducible environment, not treated as permanent acceptance.

# Blockers and Stop Conditions

Blockers: no accepted event schema; no auth provider; no shared-client framework; no host/runtime; no Neon project; no secure-storage evidence; no migration tool; no API observability/retention policy; no decision on device-sequence gaps or atomic batch semantics.

Stop if any test can leak another account’s events; retry creates duplicates; cursor advances without local application; event acceptance is non-transactional; secrets appear in client/logs; migration cannot be rehearsed; ordinary desktop data is reachable; provider SDK lacks a required target; or the experiment expands into editing, deletion, real-time/background sync, household sharing, broad schema redesign, or production claims.

# Handoff to Main

Main should reconcile this with Design’s protocol ownership and Didactic’s identity/idempotency ordering. Operationally, both API languages are viable assumptions; the immediate evidence need is a provider-neutral, two-device protocol harness. Preserve pooled connections for API traffic, direct controlled connections for migrations, immutable internal account/device/event identities, transactional cursor application, strict account authorization, and complete request/batch diagnostics. Do not authorize infrastructure or framework implementation until the event envelope, failure policies, environment separation, validation matrix, and Sprint 03 stop conditions are accepted.
