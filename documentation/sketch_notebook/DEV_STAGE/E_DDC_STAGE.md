# E_DDC_STAGE — Gate 12.6 Evidence Semantics

Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Codex Didactic materialization authority
Round or unit: C10-GCM02-GATE-12.6-COPIED-DATABASE-RECONCILIATION
Branch: `cycle10-intermid-grimoire`
Authority: Main Chat, under explicit human request
Writable surface: `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
Evidence boundary: sanitized copied-database observation, repository source,
and Git history

## 1. Required distinctions

Update H so future readers can distinguish:

- a database file from the separate SQLite CLI;
- a live database from a verified copied database;
- copied-database integrity from Sync correctness;
- `response_code` as a persisted client enum name from `error_code` as a
  persisted protocol-body code;
- a current mapping from a legacy persisted representation;
- `failed / notApplied` recovery from unknown-outcome Retry;
- failed recovery from the upload that follows it in ordinary coordinator
  order;
- a successful read-only diagnosis from authorization to mutate;
- a passed subprocedure from a closed Gate 12.6;
- a complete Gate 12.6 packet from explicit Gate 12.7 human approval.

## 2. Accepted wording

Use the following semantic conclusions:

- the copied state contains no unknown submission candidate;
- the unknown-retry route is inapplicable to that state;
- exactly one failed/notApplied candidate is visible, but the exact
  device-scoped recovery/upload boundary still requires correlation;
- `conflict / service-unavailable` is compatible with the pre-fix fallback
  mapper because current explicit mapping entered in commit
  `75dc7bed0789d693af93abb3ed15e107fd77433a`;
- timestamp ordering supports historical coherence but does not uniquely prove
  row provenance;
- ordinary Sync is not a read-only check and remains unauthorized.

## 3. PRC-01 vocabulary

Classify claims as:

- **human-observed:** terminal output copied by the user;
- **repository-proven:** current source or Git history directly establishes it;
- **inferred:** multiple evidence classes support it but do not uniquely prove
  it;
- **unavailable:** the sanitized evidence intentionally omits the value;
- **prohibited:** obtaining the value would cross the current authority
  boundary;
- **superseded:** an earlier provisional classification has been replaced by
  stronger evidence.

Do not convert human-observed terminal output into repository-executed evidence.

## 4. Gate terminals for H

End H consistently with:

```text
COPIED_DATABASE_PROBE_PASS
FAILED_NOT_APPLIED_CLASS_CONFIRMED
UNKNOWN_RETRY_INAPPLICABLE
LEGACY_RESPONSE_REPRESENTATION_EXPLAINED_WITH_BOUNDARY
EXACT_DEVICE_SCOPED_TRANSITION_CORRELATION_PENDING
GATE_12_6_OPEN
GATE_12_7_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```

No permanent didactic promotion is authorized in this round.
