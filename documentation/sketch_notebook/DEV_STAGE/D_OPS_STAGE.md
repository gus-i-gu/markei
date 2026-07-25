# D_OPS_STAGE — Gate 12.6 Copied-Database Reconciliation

Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Codex Operational materialization authority
Round or unit: C10-GCM02-GATE-12.6-COPIED-DATABASE-RECONCILIATION
Branch: `cycle10-intermid-grimoire`
Pre-stage remote baseline: `49534b2029ecc56441cc00a5ad8b5a1a29ddbb38`
Authority: Main Chat, under explicit human request
Writable surfaces: `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`;
`documentation/G_SCRIPTS.md` and `documentation/GRIMOIRE.md` only if a second
sanitized copied-database correlation procedure is proven necessary
Evidence boundary: repository source/history plus the sanitized human-executed
Gate 12.6 copied-database output preserved in J

## 1. Accepted evidence

Treat the following as human-observed, sanitized, copied-database evidence:

- Markei was closed and no relevant Flutter process blocked the copy;
- exactly one `markei_shared_beta.sqlite` candidate was found;
- the copy was size- and hash-verified without printing hash values;
- the live database was not queried;
- `PRAGMA quick_check` returned `ok`;
- all six expected local Sync tables were present;
- submission classes were:
  - one `failed / notApplied / conflict / service-unavailable`;
  - one `superseded / notApplied / conflict / null`;
  - one `superseded / notApplied / conflict /
    device-enrollment-required`;
- each submission contained two members at positions `0–1`, sequences `1–2`,
  and one event-state kind;
- the active failed submission's two events were `failed`;
- device `next_sequence` values were `2`, `3`, and `6`, one device each;
- pending-event summary was two `failed` events at sequences `1–2` and six
  `pending` events at sequences `1–5`;
- the latest Sync attempt was
  `sync-unavailable / provider-evidence-unavailable`, with no HTTP status or
  response headers;
- Retry, Sync, and provider action were not selected.

Do not restate database paths, identifiers, event IDs, submission IDs, payloads,
purchase data, complete hashes, tokens, URLs, or secrets.

## 2. Required source and history proof

Inspect at minimum:

- `clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart`;
- `clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart`;
- `clients/markei_flutter/lib/application/hosted_sync_coordinator.dart`;
- `clients/markei_flutter/lib/domain/sync/sync_event.dart`;
- relevant tests and Git history for the `service-unavailable` mapping.

Establish with commit/date evidence that:

1. current source maps protocol `service-unavailable` to
   `SyncStatusCode.serviceUnavailable`;
2. `persistUploadResult` stores the enum name in `response_code` and the
   protocol body code in `error_code`;
3. before commit `75dc7bed0789d693af93abb3ed15e107fd77433a`, the fallback mapped this
   protocol code to `SyncStatusCode.conflict`;
4. the copied database was last modified before that corrective commit;
5. therefore `conflict / service-unavailable` is a historically coherent
   legacy representation, not evidence that the current mapper still behaves
   that way.

Keep time-zone and filesystem timestamp limitations explicit. Do not claim that
the file timestamp alone proves which executable produced every row.

## 3. Gate 12.6 classification

Update G to classify:

- copied-database procedure: `PASS`;
- SQLite integrity and expected-schema proof: `PASS`;
- active queue class: exactly one `failed / notApplied` submission owning two
  failed events at sequences `1–2`;
- unknown-submission Retry eligibility: rejected for the copied state;
- earlier provisional Conclusion C: superseded;
- legacy response representation: explained by source history, subject to the
  timestamp evidence boundary;
- ordinary Sync: still unauthorized because coordinator order performs failed
  recovery before upload and may also include unrelated pending work;
- Gate 12.6 overall: open only for exact scope/correlation and transition-packet
  completion, not for queue-classification uncertainty;
- Gate 12.7: pending explicit human authorization.

## 4. Exact remaining evidence question

Determine whether the existing sanitized output is sufficient to prove all of:

- which anonymized device scope owns the failed submission;
- that scope's `next_sequence`;
- how the six pending events divide across anonymized device scopes;
- whether failed recovery would requeue exactly the two failed events;
- which pending events the subsequent upload would include;
- whether request identity/hash reuse can be proven without exposing them;
- whether acknowledgement behavior is relevant to the single proposed action.

If source plus current evidence cannot prove these points, add one canonical
follow-up copied-database procedure pair:

- `GS-SQLITE-04` in `G_SCRIPTS.md`;
- `GRM-SQLITE-04` loader/index entry in `GRIMOIRE.md`.

The procedure must:

- query only the already verified copy in
  `markei-gate-12-6-current`;
- open SQLite read-only;
- begin with `PRAGMA query_only=ON`;
- emit only ranks, counts, booleans, enum/status values, sequence ranges,
  positions, and truncated non-reversible equality fingerprints if strictly
  necessary;
- never emit IDs, payloads, purchase content, paths, complete hashes, tokens,
  URLs, or secrets;
- perform no cleanup;
- return the terminal to repository root;
- stop on ambiguity or missing schema;
- include `PRAGMA quick_check`.

Do not add the procedure if the existing evidence is sufficient. Explain the
decision in G either way.

## 5. Validation

For documentation-only reconciliation:

- run Markdown formatting/checks used by the repository;
- run `git diff --check`;
- verify no secret or identifier-shaped values were added;
- verify G/H/I contain consistent gate terminals.

If `GS/GRM-SQLITE-04` is added:

- parse all PowerShell bodies;
- verify every GRM index/loader maps to its GS body;
- execute the SQL against a disposable fixture reproducing zero, one, and
  multiple-device cases;
- prove output contains only allowlisted field classes;
- do not query any user database in Codex.

## 6. Stops and prohibitions

Do not:

- modify Flutter, API, migration, or test source;
- query, copy, upload, delete, repair, or clean the user's database;
- run Retry, ordinary Sync, or any provider operation;
- contact Render, Neon, or Auth0;
- rotate or inspect secrets;
- assert Gate 12.7 authorization;
- close GCM-02;
- define GCM-03 or GCM-04 as authoritative work.

Stop on dirty overlap, branch divergence, contradictory evidence, unsafe output,
or inability to isolate the exact recovery/upload scope.
