# H_DDC_CODEX - C10-S03A-R1 Semantic Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex semantic/test evidence
Unit: C10-S03A-R1 local security correction
Branch: `intermid-cycle-recovery`
Authority: `E_DDC_STAGE.md` plus J/D/F
Evidence boundary: local proof only; provider proof and learner-memory promotion excluded

## Semantic distinctions retained

- `token-obtained != principal-verified`
- `principal-verified != membership-confirmed`
- `membership-confirmed != device-enrolled`
- `device-enrolled != device-authorized-for-transaction`
- `device-authorized-for-transaction != operation-committed`
- `local-security-proof-passed != hosted-proof-passed`

The code now treats a verified JWT as `ExternalPrincipal` only. Account and Device authority are resolved inside the database transaction for the named protected operation.

## Named semantic tests

- Token possession is not membership: identity route and hosted tests distinguish verified principal from missing membership.
- Membership is not Device enrollment: protected routes still require active Device header and active enrollment.
- Enrollment is not perpetual authorization: revoked Device is denied by hosted-local harness.
- Authorization is named-operation scoped: route policy inventory declares 8 protected operations.
- Cross-Account requests reveal no foreign existence: harness denies Account B principal using Account A Device.
- Equivalent enrollment replay reuses one result: harness and Flutter coordinator tests cover replay.
- Conflicting replay is rejected without accepted mutation: harness and tests cover conflict.
- Response loss remains replayable: Flutter coordinator `replay` persists enrollment request identity and queries result.
- Local work survives cancellation and outage: Flutter coordinator tests preserve local hosted state without assigning a server Device.
- Local proof never claims provider proof: G/I keep provider proof pending or excluded.

## Failure vocabulary and safe action

Implemented/validated states include:

```text
authentication-required
token-rejected
principal-verified
membership-required
account-selection-required
membership-confirmed
enrollment-required
enrolling
device-enrolled
device-revoked
operation-authorizing
device-authorized-for-transaction
operation-committed
operation-denied
service-unavailable
unknown-outcome
```

Public errors remain generic and bounded to code, operation, outcome, retryability, safe action and correlation ID.

## Local-first and privacy behavior

- Normal local Flutter composition remains available.
- Hosted enrollment is opt-in lab composition only.
- New Flutter code does not persist token bytes.
- Pending local events are not reassigned to a hosted Device by the new coordinator.
- API outage and cancellation preserve durable local enrollment progress/state.

## Unsupported wording absent

No successful report claims:

```text
hosted-auth-ready
Auth0 configured and working
Render deployment accepted
Neon hosted synchronization accepted
MCG-02 complete
production authentication ready
Cycle 10 closed
```

The prohibited hosted-auth readiness diagnostic was removed from the harness.

## Didactic boundary

No KANBAN, glossary, Concept Map or Lecture Register file was modified. Learner maturity and Cycle 11 state are unchanged.

Terminal semantic result:

```text
C10-S03A_R1_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: named barrier-level race tests for membership removal and Device/enrollment revocation across every protected route remain incomplete.
