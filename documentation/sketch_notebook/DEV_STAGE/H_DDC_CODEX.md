# H_DDC_CODEX - Native Closure R1 Didactic Evidence

- Authority marker: C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z
- Baseline SHA: e59d919ecb776597b13615137cd23413dae42c36
- Final commit SHA: reported after commit by Codex terminal response, not self-embedded.
- Evidence environment: local Flutter tests, Android debug build, Windows host exclusion, no provider operation.
- Result classification: executable local closure readiness; decisive provider proof remains pending.

## Meanings

Materialized closure states:

- `closure-disabled`
- `configuration-missing`
- `signed-out`
- `authenticated`
- `authentication-required`
- `device-enrollment-required`
- `device-enrolled`
- `sync-running`
- `sync-no-new-events`
- `sync-completed`
- `sync-interrupted`
- `sync-unavailable`
- `device-revoked`
- `signed-out-cleared`

`device-enrolled` means Device enrollment or replay is complete. It is not synchronization.

`sync-completed` means the hosted sync coordinator ran the existing upload/download/apply/ack path and reached a committed/acknowledged local action. `sync-no-new-events` is distinct and means the path ran without a pending upload or downloaded remote event. `sync-interrupted` and `sync-unavailable` preserve local facts and pending work.

## Semantic Tests

- Closure surface absent by default.
- Closure surface requires explicit development flag plus valid native configuration.
- Runner sequence exposes sign-in, Device enrollment/query, real sync and logout as semantic states.
- Enrollment success alone cannot produce sync success.
- Real upload/download/apply/ack services are invoked.
- Loopback HTTP/file-backed Drift facts converge and persist after reopen.
- No-new-events is distinct from interruption.
- Token lifecycle tests from the accepted Auth0 adapter remain passing: exact API audience, ID-token substitution rejection, cancellation/rejection/outage/expiry/logout mapping, cold restart token absence and token absence from Drift bytes/diagnostics.

## Boundaries

The surface displays only semantic states. It does not expose tokens, claims, subjects, emails, provider ids, Account ids, Device ids, connection strings or fact payloads.

No Cycle 11 UX, learner maturity, permanent documentation, provider readiness or production acceptance wording was added. Human Android/Windows Auth0 login, Render/Neon hosted convergence and final MCG-02 provider proof remain pending.
