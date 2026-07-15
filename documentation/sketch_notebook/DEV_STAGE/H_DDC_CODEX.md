# H_DDC_CODEX — C10-S02 Semantic Evidence

Sequence: FLX-INV-02 -> Main D/E/F -> Codex materialization report
Role: Codex semantic/test evidence
Round or unit: C10-S02 disposable local retention, snapshot and rebootstrap proof
Branch: `intermid-cycle-recovery`
Baseline / inspected HEAD: `dee41af3a24bf85e4dcd7db40d3e1179bf0a7471`
Authority: `E_DDC_STAGE.md` plus J/D/F
Evidence boundary: local implementation and tests only; learner maturity unchanged

## Vocabulary and statuses materialized

- Preserved existing meanings for `saved-local`, `waiting-upload`, `server-accepted`, `downloaded-applied`, `duplicate-ignored`, `acknowledged`, `conflict`, `auth-required`, `unknown-outcome`.
- Added typed recovery/status codes in Dart for `device-expired`, `recovery-unavailable`, `full-rebootstrap-required`, `local-changes-block-rebootstrap`.
- Added recovery phases: `fullRebootstrapRequired`, `preparing`, `downloading`, `downloaded`, `applying`, `catchingUp`, `recoveryCompleted`, `recoveryInterrupted`.
- Incremental download now checks retained floor before returning an empty page; old cursor returns typed failure when recovery exists.
- Rebootstrap completion only returns applied after snapshot apply, catch-up cursor, acknowledgement and completion call in the harness.

## Named semantic tests and results

- `v3 fixture hash matches TypeScript canonical serialization`: passed.
- `recovery format 1 fixture hash is independent from v3 event payload`: passed.
- `recovery routes are unavailable without explicit recovery composition`: passed.
- `real_recovery_harness_test.dart`: passed with `RECOVERY_CONVERGED=true`.
- Harness-equivalent semantic coverage:
  - empty/old cursor distinction: old `c10b:0` after cleanup throws typed cursor-expiry path.
  - snapshot download does not claim completion: progress saved as downloading before apply.
  - corrupt snapshot leaves facts/cursor unchanged: corrupt target remained empty.
  - interrupted recovery reuses same session: same session queried after first chunk.
  - snapshot apply followed by incremental catch-up: `c10b:2` snapshot plus one later event.
  - recovery completes after acknowledgement and reopen: C reopened with 3 purchases.
  - pending local events block rebootstrap: `localChangesBlockRebootstrap`.
  - server cleanup leaves local purchases unchanged: A retained 3 local purchases after server cleanup.
  - revoked and expired are represented by distinct status concepts.
  - snapshot is named recovery format 1, not provider backup.

## Diagnostics and privacy inspection

- Diagnostics used operation/status codes, cursors, counts, chunk indexes, hashes and synthetic IDs.
- No Product/Purchase payload logging was added.
- No token, password, provider URL, signed URL, Auth0, Neon credential or snapshot byte logging was added.
- Fixture connection strings/passwords appear only in lab tests/process environment construction.

## Unsupported wording intentionally absent

- No UI claims of `recovered`, `restored` or `up-to-date` were added.
- No claim that application snapshots are provider backups or user exports.
- No production duration promise.
- No claim that server acknowledgement means all Devices converged.

## No UI or learner promotion

- No pages, widgets, navigation, dialogs, cards, progress UI, accessibility composition or analytics were changed.
- Didactic KANBAN, glossary, concept map and lecture history were not modified.
- Learner maturity remains unchanged.

## Deviations

- `python -m pytest` could not run because pytest is not installed; `python -m unittest discover -s tests` passed 5 tests.
- The proof is local-only and synthetic; it does not prove production retention policy, hosted auth, Neon behavior or provider backup behavior.

Terminal state:

```text
C10-S02_LOCAL_RECOVERY_PROVED
MCG-01_EVIDENCE_NOT_RECONCILED
```
