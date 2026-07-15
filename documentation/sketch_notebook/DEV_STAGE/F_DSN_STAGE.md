# F_DSN_STAGE — C10-S01B Convergence Architecture Contract

> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITH D/E
> Baseline: `1d5c0b6006831c62320d535ed3c99364d790a465`
> Scope: complete disposable local protocol path and pre-Neon hardening
> Live Neon, production auth and deployment: prohibited

## 1. Required topology and dependencies

```text
explicit lab SyncCoordinator
  → UploadPendingEvents → HttpSyncTransport
  → DownloadAndApplyEvents → HttpSyncTransport → RemotePurchaseEventApplier
  → AcknowledgeAppliedCursor → HttpSyncTransport
  → two app-private Drift v5 files

HttpSyncTransport → loopback Fastify API child process
Fastify routes → AuthVerifier → SyncApplicationService → PgSyncRepository
PgSyncRepository → PostgreSQL-only Docker Compose lab
```

Domain/application code must not import Flutter widgets, Drift, HTTP, Fastify, `pg`, Docker or
Neon. Transport owns HTTP/JSON/timeouts only. API application services own authorization and use
cases. PostgreSQL repositories own SQL. Drift adapters own local atomicity. Default app composition
contains no active transport/coordinator and remains local-only.

Keep handwritten files near 250 lines by splitting contract codecs, routes, services, repositories,
transactions, lab orchestration and remote application. Generated Drift output is exempt.

## 2. Protocol-v3 closure

Retain envelope identities and canonical hash rules:

```text
EventId: immutable domain event UUID
SubmissionId: immutable logical upload-attempt group UUID
DeviceSequence: exact monotonic Device order
ServerCursor: opaque Account-stream position token
contentHash/requestHash: lowercase SHA-256 over canonical UTF-8 JSON
```

Close JSON Schema recursively with bounded strings/arrays and `additionalProperties: false`.
Complete payload shapes:

- Purchase: ID, Account, occurrence, currency/minor totals, Store, Items, optional references;
- Store: stable ID, Account and immutable display identity required by local schema;
- Product snapshot per referenced Product: stable ID, Account, immutable code/exact identity/name,
  brand/mode/measurement/package fields required by local schema;
- Item: stable ID, Purchase/Product IDs, package count, normalized quantity and line total;
- Person/Payment: explicit null or complete stable immutable reference snapshot.

Validate aggregate totals, IDs, currencies, quantity representations and references. Reject bare
non-null foreign IDs, unknown versions/fields, empty submissions and oversized bodies/batches.
Update deterministic fixtures and Dart/TypeScript hash parity in one change.

## 3. Cursor and page contract

Define one documented versioned opaque token, for example base64url-encoded version plus cursor
position with strict canonical decoding. A missing local cursor maps only to the canonical origin;
responses then emit an explicit token. Clients store/echo tokens and never parse/arithmetic them.

`GET /v1/sync/events`:

- authenticate Account/Device before query;
- accept absent/origin/valid `after` and `limit` default 25, range 1..100;
- return all Account events, including origin Device events, strictly ascending;
- query `limit + 1` to determine continuation;
- return page events plus `nextCursor`; empty page preserves `after`;
- never disclose existence of another Account's cursor/event.

Local apply verifies token sequence through decoded page metadata supplied by the validated codec.
Any gap/reorder invalidates the whole page. Duplicate-equivalent events may be skipped, but the
committed cursor advances only once to the verified page end.

## 4. API schemas and errors

Register closed Fastify JSON schemas for every request, query, result and failure. Route handlers
perform only HTTP/auth translation and call application services. Map validation 400, missing auth
401, wrong/revoked Device 403, identity/sequence/cursor conflict 409, unsupported protocol 422,
bounded resource exhaustion 503 and internal unknown 500 without exposing SQL/stack/payloads.

The typed body remains authoritative over status alone and follows E. Health routes reveal only
live/ready and never schema, role or connection details.

## 5. Authentication boundary

`AuthVerifier` returns verified AccountId/DeviceId claims. Payload identity must match claims but is
never authority. C10-S01B adds only an explicit lab adapter/entrypoint:

- synthetic deterministic claims map to fixture aliases;
- only direct lab/test construction may select it;
- listener must be loopback;
- normal `main.ts` continues to use a refusing verifier;
- no environment flag in the normal entrypoint can enable fixture auth;
- no production provider, enrollment/revocation endpoint or real credential format is selected.

Test fixture provisioning uses migration/bootstrap-owned SQL, not runtime API permissions.

## 6. PostgreSQL migration 002

Do not edit `001_init.sql`. Add transactional `002_coordination_hardening.sql` and a migration
ledger/checksum path. It must add or correct:

- composite FKs from submissions/events/acknowledgements to Account/Device;
- Account FKs and indexes for `(account_id, server_cursor)`, Device sequence, Submission replay and
  acknowledgement lookup;
- positive/hash/type/version checks that belong in persistence;
- revoked PUBLIC/default privileges;
- least-privilege grants: runtime cannot DDL, manage roles or provision Accounts/Devices;
- RLS on every Account-bearing runtime table with SELECT/INSERT/UPDATE policies as needed;
- fail-closed behavior when transaction-local `markei.account_id`/Device context is absent.

The runtime still uses explicit Account/Device predicates. RLS is defense in depth, not a substitute
for application authorization. If FORCE RLS conflicts with migration ownership, separate table
owner/migrator and runtime identities rather than weakening isolation. Lab bootstrap may create
roles; later Neon role creation remains human MCG-01 work.

Migration tests apply 001→002 and fresh 001→002, inspect constraints/policies/grants and prove a
failed 002 leaves no partial state. Corrections after application require 003, never editing 002.

## 7. Transaction runner and upload

The runner acquires a fresh client per attempt, begins serializable, sets transaction-local verified
Account/Device context, executes the service and commits once. Retry only SQLSTATE `40001` and
`40P01`, at most three total attempts with deterministic injected delay/jitter and one deadline.
Never retry validation, auth, constraint collision, pool acquisition timeout or unknown commit as a
new logical operation.

Upload preserves prior idempotency:

1. same SubmissionId/request hash → stored result;
2. same SubmissionId/different hash → terminal conflict;
3. validate complete batch before mutation;
4. same EventId/hash → duplicate-equivalent;
5. same EventId/different hash → terminal conflict;
6. require exact next DeviceSequence;
7. allocate Account cursor, append Events, advance sequence and store result atomically.

All Event lookups remain Account-scoped even if Event UUIDs are globally unique.

## 8. Download and acknowledgement services

Download uses verified claims, transaction-local context and cursor contract from section 3. It
returns only stored immutable Events and bounded metadata.

Acknowledgement:

- authenticates matching active Device;
- decodes the cursor for the verified Account;
- rejects beyond the Account high-water mark;
- upserts `greatest_contiguous_cursor = GREATEST(existing, supplied)`;
- treats equal/lower replay as duplicate-equivalent;
- does not imply all Devices acknowledged and triggers no deletion.

The server cannot independently prove local apply; the controlled system proof correlates B's
atomic local commit with its following acknowledgement. Retention remains excluded.

## 9. Flutter HTTP transport

Add one narrowly pinned HTTP package and `infrastructure/remote` adapter implementing existing sync
ports. Inject HTTP client, base URI, token source, timeouts and correlation source. Requirements:

- loopback URI only in lab composition; no provider/database URL in Flutter;
- authorization only in headers; never persisted/logged;
- request/connect/response deadlines and response byte cap;
- content-type/status/schema validation before conversion;
- typed mapping of refusal, timeout, malformed body and API failure;
- no implicit retry inside adapter;
- same Submission object reused after unknown upload outcome.

Extend ports only when needed to carry safe action/correlation/page metadata without leaking HTTP.

## 10. Remote Purchase application

Implement a dedicated type-dispatched applier, not ordinary registration. Before mutation:

1. validate page Account, ordering/contiguity, event hash/type/version and aggregate invariants;
2. classify inbox Event as absent, equivalent or conflicting;
3. validate stable Store/Product/reference identities and visible-code uniqueness;
4. require existing facts to be field-for-field equivalent.

In one Drift transaction:

1. insert/reuse complete Store/Product/reference facts;
2. insert/reuse Purchase and Items idempotently;
3. insert applied inbox rows;
4. advance account cursor once to page end.

No outbound SyncEvent/PendingEvent is created. Any conflict/gap/error rolls back the whole page.
No durable quarantine table/schema v6 is added. After commit, requery existing Lists projections;
do not synchronize or persist them as authoritative facts.

Greatest-contiguous acknowledgement derives from committed page/cursor state, never MAX(inbox).

## 11. Verification architecture

Required layers:

- shared closed-schema and cross-language hash fixtures;
- Dart codec/transport/application unit tests;
- Drift remote apply, atomicity, duplicate/conflict/reopen tests;
- Fastify route/schema/auth tests;
- real PostgreSQL 001→002/constraint/grant/RLS/transaction tests;
- upload/download/ack API integration tests;
- one system harness with two Drift files, real loopback API child and disposable PostgreSQL;
- timeout-after-commit, retry, paging, crash, isolation and exhaustion injections;
- existing Flutter/Python regressions and Windows/Android builds.

Mocks/fakes cannot be the only evidence for SQL transactions, HTTP transport, cross-language
contracts or convergence. The system harness owns all processes/resources and cleans them on fail.

## 12. I report, exclusions and exit

Replace only `DEV_STAGE/I_DSN_CODEX.md`. Report final dependency direction, modules, contract/hash,
migrations, policies/grants, route/service behavior, transaction retry, cursor, remote apply,
fixture-auth containment, system topology, deviations and deferred decisions.

Do not contact Neon, deploy, select production auth/API host, implement retention/rebootstrap,
background sync, edits/deletes, UI/UX or Analytics. Successful evidence prepares Main to activate
MCG-01; it does not itself configure or validate Neon.
