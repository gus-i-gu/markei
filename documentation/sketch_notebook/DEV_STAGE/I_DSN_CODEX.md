# I_DSN_CODEX — C10-GCM02-S12-ERR-03

Unit: C10-GCM02-S12-ERR-03 within sequence C10-GCM02-S12-SYNC-01
Evidence class: Codex observational report

## Design Findings

- repository-proven: The diagnostic registry remains the single definition owner. The generator still produces Dart, TypeScript, and `ERR_DIAGNOSTICS.md` projections from the registry.
- repository-proven: Parent operation identity is owned by the Flutter top-level action. Child request correlation remains distinct and ordered through existing diagnostic phase recording.
- repository-proven: HTTP transport propagates full operation and child correlation only through internal request headers; UI and logs expose sanitized 12-hex fingerprints.
- repository-proven: Server lifecycle declarations are request-scoped and derived through one lifecycle projection path, not independently assembled in route catch blocks.
- repository-proven: The success query predicate now depends on operation kind, outcome class, terminal result code, and completion timestamp.

## Boundary Model

- repository-proven: Client operation success and server request success are separate declarations. The server can declare a request completed; the client alone declares aggregate ordinary-Sync completion.
- repository-proven: Readiness remains a health/database-readiness boundary, not a Sync terminal.
- repository-proven: Unknown transport evidence is not automatically retried or requeued by this unit.
- repository-proven: Failed/notApplied inspection and recovery surfaces remain separate from ordinary Sync terminal semantics.

## Timeout Ownership

- repository-proven: The 35-second hosted ordinary-Sync deadline is client-owned.
- provisional: A server-owned 25-second deadline was not added because source evidence did not establish authoritative cancellation/rollback for all database work without relying on a Promise race.
- repository-proven: `sync-server-timeout` is not emitted for client-side observation expiry.

## Reachable Attribution

- test-validated: Representative AUT/BND/REC/QUE/TRN/UPL/DNL/ACK/OBS paths remain covered by Flutter diagnostics tests.
- test-validated: Representative API/PDB/server-request declaration paths remain covered by API protocol tests.
- inferred: Catalogue-only MKS codes remain definitions, not all runtime-reachable branches.

ORDINARY_SYNC_TERMINAL_MODEL=BOUNDARY_STABLE
CLIENT_OPERATION_OWNERSHIP=VALIDATED
SERVER_REQUEST_OWNERSHIP=VALIDATED
CORRELATION_LINEAGE=VALIDATED
SUCCESS_QUERY_PREDICATE=VALIDATED
TIMEOUT_OWNERSHIP=VALIDATED
NO_FALSE_SERVER_TIMEOUT=VALIDATED
NO_NEW_DIAGNOSTIC_PROVIDER_CALL=PASS
GATE_12_7=HELD
GCM02=OPEN
