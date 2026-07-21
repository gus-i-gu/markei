# D_OPS_STAGE — Windows Recovery Provider Retest

> Authority marker: C10-MCG02-WINDOWS-RECOVERY-RETEST_20260721T014246Z
> Required ancestor: 82db09dbb56883ec00b309c1444df8197337947c
> Status: **ACTIVE HUMAN VALIDATION AUTHORITY; CODEX MUTATION PAUSED**

## Accepted evidence

`82db09d` wires scoped failed/notApplied discovery through the production coordinator. A reopened
file-backed v8 fixture using the real coordinator and HTTP/PostgreSQL lab recovers the legacy
attempt, transmits immutable sequences `1,2`, advances the server to `3`, preserves unrelated local
events, and remains idempotent. Reported validation passes: 133 Flutter tests, 46 API tests, lab
proof, Android debug build and Windows release build.

## Objective

Validate that the preserved human Windows database follows the proved path against the development
Render/Neon environment. This phase gathers sanitized evidence only; it authorizes no source,
database, provider configuration or identity mutation.

## Sequence

1. Close Markei and copy the local database to a private backup outside Git.
2. Fast-forward the local branch to `82db09d`; keep private define files untracked.
3. Build Windows release with the previously validated Auth0 audience/domain/client and Render
   origin defines. Do not print or commit private values.
4. Launch from the release directory; confirm Status `authenticated` and Query `device-enrolled`.
5. Confirm History still contains the two local Purchases exactly once.
6. Press Sync once and wait for a terminal state. Expected: `sync-completed` or
   `sync-no-new-events`; `sync-unavailable`/`sync-interrupted` is not acceptance.
7. Reopen Markei, repeat Status/Query/History, press Sync again, and prove no duplication.
8. Using sanitized Neon queries, verify the scoped Device expectation advanced `1 -> 3`, exactly
   two purchase events exist for that Device, one accepted submission exists, and acknowledgement
   did not advance beyond committed application state.
9. Verify Render health remains live/ready, no startup failure appears, and logs contain no tokens,
   credentials, connection strings or fact payloads.

## Stop rules

Stop without retry loops or manual database edits on authentication loss, Device mismatch,
`sync-interrupted`, `sync-unavailable`, unexpected counts, duplicate History or provider errors.
Do not reenroll, renumber events, alter Neon rows, rotate identities, or begin Android convergence.

Pass terminal:

~~~text
MCG02_WINDOWS_RECOVERY_UPLOAD_VALIDATED=true
~~~
