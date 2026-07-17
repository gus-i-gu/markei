# G_OPS_CODEX - C10-MCG02-R04B Partial Operational Evidence

Authority marker: C10-MCG02-R04B_20260717T133814Z
Controlling J SHA: 0765255c07e3381f74cd9b4e90bc2f9ddd3b13dc
Controlling D/E/F commit SHA: 22467716ae9ba0fb93ee775781c7177db88320fc
Baseline remote SHA: 22467716ae9ba0fb93ee775781c7177db88320fc
Actual implementation start UTC/local: 2026-07-17T14:07:03.8882432Z / 2026-07-17T11:07:03.9099962-03:00
Actual implementation end UTC/local: 2026-07-17T14:18:14.3066132Z / 2026-07-17T11:18:15.8255067-03:00
Implementation tree SHA: not created; worktree remains uncommitted
Final commit status: not committed or pushed
Evidence environment: Windows PowerShell; Docker Desktop desktop-linux; PostgreSQL 18.4 disposable preflight; Node server workspace
Result classification: C10-MCG02-R04B_PARTIAL

## Preflight Evidence

- `docker version`: passed. Client present, Server present, context `desktop-linux`, Server OS/Arch `linux/amd64`.
- `docker ps -a --filter name=markei-c10-mcg02-r04b-preflight --format "{{.Names}}"`: passed, empty before preflight.
- `docker run --name markei-c10-mcg02-r04b-preflight-140703 -e POSTGRES_HOST_AUTH_METHOD=trust -p 127.0.0.1:55448:5432 -d postgres:18-alpine`: passed.
- `docker exec markei-c10-mcg02-r04b-preflight-140703 pg_isready -U postgres`: passed, accepting connections.
- `docker exec markei-c10-mcg02-r04b-preflight-140703 psql -U postgres -tAc "select version();"`: passed, PostgreSQL 18.4.
- `docker rm -f markei-c10-mcg02-r04b-preflight-140703`: passed.
- exact filtered inventory after removal: passed, empty trimmed stdout.

## Changed Paths

Production/test/report paths currently changed and not committed:

- `services/markei_sync_api/src/application/authorization_barrier.ts` - new inert-by-default barrier port.
- `services/markei_sync_api/src/application/hosted_authorization.ts` - optional barrier reach points in hosted authorization paths.
- `services/markei_sync_api/src/postgres/database.ts` - optional before-commit transaction hook.
- `services/markei_sync_api/test/hosted_auth.test.ts` - normal hosted composition/barrier containment test.
- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md` - this report.
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md` - semantic report.
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md` - design report.

No private provider files were read. No A/B/C, J/D/E/F, methodology, permanent memory, migrations, dependencies, lockfiles, UI, provider configuration or deployment files were intentionally modified.

## Validation Run

- `git fetch origin`: passed.
- `git pull --ff-only`: passed, already up to date.
- branch: `intermid-cycle-recovery`.
- `origin/intermid-cycle-recovery`: `22467716ae9ba0fb93ee775781c7177db88320fc`.
- required ancestry: `0765255c07e3381f74cd9b4e90bc2f9ddd3b13dc=true`, `42e4a8375ed8c51765b0a440b2130a31a098c36c=true`.
- initial worktree: clean.
- pre-mutation current authorization producer: executed with Docker/PostgreSQL; still partial with 24 `not-yet-r04` blockers.
- `npm run typecheck`: passed.
- `npm test`: passed, 37 tests.
- `docker ps -a --filter name=markei-c10-mcg02-r04 --format "{{.Names}}"`: passed, empty.
- `git diff --check`: passed.

Not run after partial stop: full server format/lint/build/audit, all proof producers, R04B orchestrator, Flutter full validation, Python regressions, migration hash comparison, staged/tracked secret scan, commit, push.

## Authorization Case Results

The producer currently executes the existing broad harness and remains incomplete. Exact false cases:

1. `membership-disabled-before-fence`: false, `not-yet-r04`
2. `membership-removed-before-fence`: false, `not-yet-r04`
3. `external-identity-disabled-before-mutation`: false, `not-yet-r04`
4. `actor-device-revoked-before-upload`: false, `not-yet-r04`
5. `actor-device-revoked-before-download`: false, `not-yet-r04`
6. `actor-device-revoked-before-acknowledgement`: false, `not-yet-r04`
7. `actor-device-revoked-before-capabilities`: false, `not-yet-r04`
8. `actor-device-revoked-before-rebootstrap-start`: false, `not-yet-r04`
9. `actor-device-revoked-before-rebootstrap-status`: false, `not-yet-r04`
10. `actor-device-revoked-before-rebootstrap-chunk`: false, `not-yet-r04`
11. `actor-device-revoked-before-rebootstrap-complete`: false, `not-yet-r04`
12. `actor-device-revoked-before-device-status`: false, `not-yet-r04`
13. `actor-device-revoked-before-device-revoke`: false, `not-yet-r04`
14. `owner-target-status`: false, `not-yet-r04`
15. `owner-target-revoke`: true, inherited broad harness observation only, not final R04B scenario evidence
16. `member-self-status`: false, `not-yet-r04`
17. `member-self-revoke`: false, `not-yet-r04`
18. `foreign-target-denial`: true, inherited broad harness observation only, not final R04B scenario evidence
19. `cross-account-target-denial`: true, inherited broad harness observation only, not final R04B scenario evidence
20. `concurrent-target-revoke-one-transition-one-event`: false, `not-yet-r04`
21. `independent-repeat-revoke-duplicate-equivalent`: false, `not-yet-r04`
22. `self-revoked-actor-denied-later`: false, `not-yet-r04`
23. `equivalent-concurrent-enrollment`: false, `not-yet-r04`
24. `conflicting-enrollment-request-hash`: true, inherited broad harness observation only, not final R04B scenario evidence
25. `response-loss-query-replay`: false, `not-yet-r04`
26. `process-restart-replay`: false, `not-yet-r04`
27. `serialization-retry-exhaustion-fails-closed`: false, `not-yet-r04`
28. `denied-no-state-advance`: false, `not-yet-r04`

No final before/after protected-state comparisons, response-class table, transition/event/replay/restart/retry counts, or migration hash table were produced.

## Terminal Evidence

C10-MCG02-R04B_PARTIAL
AUTHORIZATION_RACE_PRODUCER=false
R3_LOCAL_SECURITY_PROVED=false
