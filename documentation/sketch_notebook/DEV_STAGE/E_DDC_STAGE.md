# E_DDC_STAGE — Windows Recovery Retest Semantics

> Authority marker: C10-MCG02-WINDOWS-RECOVERY-RETEST_20260721T014246Z
> Status: **ACTIVE HUMAN VALIDATION AUTHORITY; CODEX MUTATION PAUSED**

## Truthful outcomes

- `authenticated` plus `device-enrolled`: authorization prerequisites pass.
- `sync-completed`: confirmed synchronization phases completed.
- `sync-no-new-events`: valid only after the first recovery/upload was already confirmed.
- `sync-interrupted`: outcome may be unknown; do not create another identity or edit local state.
- `sync-unavailable`: bounded failure; inspect evidence before another attempt.
- preserved History: server cleanup/recovery does not remove local Purchase history.

Build success and disposable lab proof are not human provider acceptance. Provider acceptance needs
the named Windows observation plus sanitized Neon and Render evidence. Evidence must contain counts,
states and commit SHA only—never tokens, credentials, IDs, payloads or connection strings.
