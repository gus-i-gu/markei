# E_DDC_STAGE — Closure Diagnostic Semantics

> Sequence: FLX-ORD-01
> Authority marker: C10-MCG02-CLOSURE-DIAGNOSTICS_20260721
> Status: **ACTIVE CODEX SEMANTIC AUTHORITY**

## Vocabulary

- `current status` — a refreshed local observation; not historical evidence by itself.
- `sync attempt` — one explicit user invocation of Sync, from local start to one terminal outcome.
- `pending event` — locally durable work eligible for a future upload attempt.
- `uploading event` — locally leased work whose outcome may require reconciliation.
- `failed event` — locally classified not-applied work with a stable recovery code.
- `unknown event` — work whose hosted result cannot be inferred safely from local evidence.
- `next Device sequence` — the next locally allocated sequence for the current Device; it is not a
  claim about Neon unless separately verified.
- `last successful sync` — shown only when a locally persisted successful completion exists.
- `no recorded attempts` — the ledger contains no post-implementation attempt; it does not mean Sync
  was never tried.
- `provider evidence unavailable` — the local client has no authoritative remote request/status
  evidence; absence must not be rewritten as success or failure.

## Display rules

User diagnostics answer: “Can I sync, what is waiting, what happened last, and what should I do?”
Developer diagnostics answer: “Which local phase and stable code were recorded, and what durable
local state remains?”

Use plain-language labels with the stable machine code available beside or beneath them. Empty,
loading, unavailable and zero are distinct states. A missing value must display `Unavailable` or
`Not recorded`, never `0`.

The attempt ledger is append-oriented observational evidence. Clearing it is an explicit local
privacy/maintenance operation, not synchronization repair. Queue and Device rows remain the
authoritative local sources for their present states.

## Privacy and diagnostic boundary

Display only short non-reversible fingerprints when row distinction is necessary. Never display or
persist for diagnostics: access/refresh tokens, Auth0 subject, complete Device/Event/Submission UUID,
provider URL/host, connection string, request/response body, purchase payload, SQL, filesystem path,
stack trace or raw exception text.

Diagnostic refresh is read-only and offline. The page must not imply that it scans Render, Neon or
Auth0. Provider-side success, request arrival and convergence remain separate human/provider proof.

The prior real attempt may legitimately appear as `No locally recorded attempt history` because it
predates this ledger. Do not seed a synthetic record from conversation evidence.
