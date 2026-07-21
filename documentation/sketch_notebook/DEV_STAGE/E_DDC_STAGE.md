# E_DDC_STAGE — Recovery Orchestration Semantics

> Authority marker: C10-MCG02-RECOVERY-ORCHESTRATION_20260721T003303Z
> Status: **ACTIVE CODEX DIDACTIC AUTHORITY**

## Closed semantics

- `no-recoverable-failure`: proceed with ordinary upload.
- `failed-recovery-available`: one safe not-applied attempt was requeued; proceed once.
- `failed-recovery-blocked`: evidence is unsafe, ambiguous or ineligible; do not upload it.
- `upload-outcome-unknown`: preserve the same submission identity; do not use failed recovery.
- `server-accepted`: exact immutable events committed remotely.
- `sync-completed`: recovery, upload, download and acknowledgement completed as applicable.

Recovery is an internal safety transition, not a request for the user to paste a submission ID or
edit a database. `Sync` may trigger it only within the authenticated Account/Device binding.

Production diagnostics remain bounded (`sync-unavailable` or `sync-interrupted`) and expose no
submission/event identifiers, payloads, hashes, SQL, credentials or provider configuration.

Required semantic tests cover no candidate, one eligible candidate, multiple/ambiguous candidates,
blocked outcomes, reopen, repeat/concurrent invocation, interruption and successful accepted upload.
