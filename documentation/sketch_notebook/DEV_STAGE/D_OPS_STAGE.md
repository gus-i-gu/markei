# D_OPS_STAGE — C10-S01B Execution and Evidence Contract

> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED WITH E/F
> Unit: local HTTP/PostgreSQL/Drift convergence completion
> Baseline: `1d5c0b6006831c62320d535ed3c99364d790a465`
> Controlling synthesis: `[M]_STAGE/J_MAIN_STAGE.md`
> External provider status: MCG-01 NOT STARTED

## 1. Authority and preflight

Codex may modify source, tests, shared contracts, dependency locks, disposable lab infrastructure
and G/H/I only as required by J/D/E/F. It may run local Docker/PostgreSQL and loopback processes.

Before editing:

1. read root and notebook AGENTS, INDEX and the full canonical methodology route;
2. read J and D/E/F together; A/B/C remain investigation evidence only;
3. verify branch `intermid-cycle-recovery`, clean/understood status and baseline ancestry;
4. preserve unrelated/untracked work; never stash, reset, clean, discard or force-push;
5. inventory Flutter/Dart, Node/npm, Docker/Postgres client, Java/Android and Python;
6. run available baseline analysis/tests and secret scan;
7. inspect existing migration/test fixtures before mutation.

Stop before editing if D/E/F conflict, local data preservation is unclear or fixture auth could
enter normal runtime. Never substitute Neon for a missing local tool.

## 2. Checkpoint order

### CP0 — Baseline and defect locks

- Add focused failing tests demonstrating current download/ack stubs, incomplete remote apply,
  unsafe contiguous-cursor calculation and absent database-backed vertical slice.
- Record exact dependency/tool versions and current test counts.
- Keep local-only Purchase registration green.

Gate: failures target the reconciled defects rather than unrelated behavior.

### CP1 — Close executable contracts

- Close nested Store/Product/Purchase/Item/quantity/money/reference schemas recursively.
- Include complete immutable Product snapshots and complete optional Person/Payment snapshots when
  referenced; explicit null remains valid.
- Bound strings, arrays, body/page bytes and unknown fields.
- Define request/result schemas for upload, download, acknowledgement and typed failures.
- Freeze versioned opaque cursor origin/encoding and page semantics from J/F.
- Update valid/invalid fixtures and recompute Dart/TypeScript hashes together.
- Prove both languages accept/reject the same fixtures.

Gate: contract parity and hash parity pass before database/application work.

### CP2 — Migration 002 and server services

- Add `002_coordination_hardening.sql`; do not edit migration 001.
- Add required composite FKs, indexes, checks, grants/revokes and Account RLS policies.
- Separate lab role/bootstrap/seed responsibility from application runtime.
- Implement transaction-local verified Account context plus explicit scoped predicates.
- Implement bounded serializable/deadlock retry with deterministic injection.
- Implement authenticated/bounded Postgres download and monotonic acknowledgement services.
- Complete Fastify JSON-schema routes and typed exception/status mapping.
- Add database-backed upload/download/ack route tests against migrated PostgreSQL.

Gate: two synthetic Accounts cannot read/write each other through API or runtime SQL; runtime DDL
fails; upload→download→ack persists correctly.

### CP3 — Complete local apply and HTTP transport

- Implement a dedicated type-specific remote Purchase applier without outbound-event creation.
- Validate Account, hash, version, ordered contiguous cursor and aggregate invariants before writes.
- Reuse only semantically equivalent stable Store/Product/reference/Purchase facts.
- Commit facts, Items, inbox and final page cursor atomically; roll back the entire page on error.
- Replace maximum-cursor logic with proven contiguous-prefix semantics.
- Requery Lists after commit; do not add authoritative List persistence.
- Add a Dart HTTP adapter with injected client/base URI/token source and bounded timeouts/response.
- Keep synchronization absent/disabled in default application composition.

Gate: complete remote facts survive reopen; duplicate creates neither fact nor outbound echo;
gap/conflict leaves facts/inbox/cursor unchanged.

### CP4 — Explicit lab entrypoint and real vertical slice

- Keep Compose PostgreSQL-only and loopback-bound.
- Add deterministic migrator/bootstrap/seed/probe scripts with ignored generated credentials.
- Add a loopback-only API lab entrypoint using fixture claims; normal runtime still refuses them.
- Let the harness allocate the API port, start/stop the child process and clean temp Drift files.
- Run the complete A→HTTP→Postgres→HTTP→B story in J.
- Inject the first upload response loss after committed server state.
- Assert same SubmissionId/hash retry, one server Event/cursor, one B Purchase aggregate, one inbox
  effect, one durable B acknowledgement and equivalent reopened facts/Lists.

Gate: `CONVERGED=true` is earned only by all assertions through real boundaries.

### CP5 — Failure, isolation and crash matrix

Cover at minimum:

- validation/version/body/batch/page limits;
- wrong Account, unknown/revoked Device and missing DB context;
- duplicate-equivalent versus identity/hash conflict;
- sequence duplicate/gap/concurrency;
- empty/multipage/gapped/reordered/duplicate download;
- crash before/inside/after Drift transaction and after commit/before ack;
- SQLSTATE 40001/40P01 retry and bounded exhaustion;
- pool acquisition timeout and API unavailable;
- SELECT/INSERT/UPDATE RLS denial for every Account-bearing runtime table;
- migrations 001→002, fresh migration and failed migration cleanup.

Gate: typed retry/non-retry/unknown meaning matches E; no assertion is weakened to continue.

### CP6 — Regression, reports and stop

Run actual repository commands, including when supported:

```text
dart format --output=none --set-exit-if-changed lib test tool
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
npm ci
npm run format:check
npm run lint
npm run typecheck
npm test
npm audit --omit=dev
docker compose -f infra/sync_lab/compose.yaml up -d --wait
PostgreSQL migration/constraint/grant/RLS probes
real local convergence harness
flutter build windows --release
flutter build apk --debug
python -m unittest discover tests
git diff --check
tracked/staged secret scan
docker compose -f infra/sync_lab/compose.yaml down --volumes
```

Use exact working-directory/script variants in G. Always tear down inventoried processes,
containers, volumes, temporary databases, ignored secrets and test files, even after failure.

## 3. Evidence requirements

### G operational report

Replace only `DEV_STAGE/G_OPS_CODEX.md` and include:

- baseline/final SHA and complete changed-path inventory;
- dependency/tool versions and lockfile changes;
- checkpoint commands/results and test counts;
- migration 001→002/fresh/failure evidence;
- API/Postgres integration results;
- exact A/B/server Event, Purchase, inbox, cursor and acknowledgement counts;
- timeout-after-commit and identical retry evidence;
- fault/isolation/role/crash results;
- Windows/Android/Python boundaries;
- secret scan and teardown inventory;
- explicit Neon/auth/deployment non-use;
- deviations, blockers and one terminal status from J.

H and I must satisfy E/F. Do not overwrite A/B/C, J, D/E/F, permanent memory or Main-root files.

## 4. Stop and rollback gates

Stop on:

- cross-Account access or runtime DDL;
- fixture auth outside explicit loopback lab composition;
- secret, authorization header, connection URL or business payload in tracked/logged output;
- cursor advance/ack without committed facts and inbox;
- gap acknowledged as contiguous;
- unknown retry creates a new SubmissionId or Event;
- duplicate creates a second business effect or outbound echo;
- migration rewrite/reset/data loss;
- unbounded retry, pool wait, response, body, batch or page;
- loss of local-only startup/registration;
- need for live Neon or real authentication.

Rollback boundary is explicit composition removal plus disposable lab teardown. Published migration
001 remains immutable; server corrections are forward-only. Local Drift remains v5 and must never
be reset. If the decisive CP4 gate fails, report partial rather than advancing MCG-01.

## 5. Publication

Review the entire diff, confirm only authorized paths, no secrets/artifacts, and no unrelated
cleanup. Commit implementation plus G/H/I as one bounded materialization commit unless a necessary
safe checkpoint is explicitly reported. Push only `intermid-cycle-recovery`, never force-push.
