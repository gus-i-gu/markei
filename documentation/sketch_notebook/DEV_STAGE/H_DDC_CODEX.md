# H_DDC_CODEX - C10-S03A-R3B Semantic Evidence

Sequence: FLX-ORD-01 corrective Codex materialization
Role: Codex semantic/test evidence
Unit: C10-S03A-R3B local contract and decisive-proof completion
Branch: `intermid-cycle-recovery`
Authority: `E_DDC_STAGE.md` plus J/D/F
Evidence boundary: local proof only; provider proof and learner-memory promotion excluded

## Result

```text
R3_LOCAL_SECURITY_PROVED=false
C10-S03A_R3B_PARTIAL
MCG-02_PROVIDER_PROOF_PENDING
```

Exact blocker: all source-level contradictions were narrowed, but decisive race, migration lifecycle, real Flutter HTTP/file-backed and aggregator producers are not complete.

## Closed Semantics Materialized

- `deadline != inactivity-timeout`: body reads recompute remaining total attempt time before each read.
- `owned-client != borrowed-client`: default attempts own and close their client; borrowed clients are not closed and are not used to claim cancellation.
- `device-enrolled != duplicate-equivalent`: transport success carries the server success status.
- `known-replay-outcome != enrolling`: replay conflict, unavailable and unknown outcomes overwrite stale `enrolling`.
- `key-set-changed != requested-key-present`: a changed JWKS that still lacks the requested key installs negative cooldown.
- `provider-metadata-changed != public-signing-key-changed`: semantic JWKS revision uses normalized public RSA signing material only.
- `route-construction-snapshot != readiness-inventory`: inventory comparison now runs at Fastify readiness.
- `Device-state != enrollment-state`: Device status endpoint projects the locked Device row status.

## Named Semantic Tests

- Expired JWKS miss refreshes once.
- Changed set still missing key installs cooldown.
- Irrelevant JWK metadata does not break known-key verification.
- Private JWK material is rejected.
- Late direct route fails readiness.
- Encapsulated plugin route fails readiness.
- Injected unclassified route fails readiness.
- Server `device-enrolled` maps to applied in existing coordinator flow.
- Server `duplicate-equivalent` remains distinct and durable.
- Replay conflict, service-unavailable and unknown-outcome replace stale `enrolling`.

## Privacy And Local-First Evidence

- Access tokens remain method parameters and are not stored in `HostedIdentityState`.
- Hosted enrollment failure paths do not alter local facts, purchases or sync cursors in the changed coordinator code.
- Ordinary local registration and UI were not changed.
- No token, claim, JWK body, provider URL, connection string, generated credential or fact payload was intentionally logged by new code.
- Public failures remain closed and bounded.

## Unsupported Wording Absent

No report claims:

```text
HOSTED_AUTH_READY=true
Auth0 verified
Neon accepted
Render deployed
MCG-02 complete
production ready
Cycle 10 closed
```

## Didactic Boundary

No KANBAN, glossary, Concept Map, Lecture Register, permanent didactic memory, methodology, A/B/C, J or D/E/F file was modified. Learner maturity and Cycle 11 UI state remain unchanged.
