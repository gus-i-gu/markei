# I_DSN_CODEX - C10-GCM03-S10-R05

## Architecture Summary

R05 partitions cumulative operation truth into upload, download/inbound-apply, acknowledgement, diagnostic, and terminal planes.

`SyncDiagnosticPhaseEvidence` remains the event compatibility boundary. It now also supports bounded optional plane fields used by the in-memory cumulative recorder. Durable `SyncDiagnosticEnvelope` rows still persist the legacy event-specific generic fields, so no Drift schema, migration, hosted payload, API, or provider contract changed.

## State Vocabulary

- Upload request: `not-started`, `started`.
- Upload trusted response: `not-received`, `received`.
- Upload provider outcome: `not-started`, `unknown`, `committed`, `rejected`.
- Upload lease local state: `not-started`, `committed`, `failed`, `unknown`.
- Upload-result persistence: `not-started`, `started`, `committed`, `failed`, `unknown`.
- Download request: `not-started`, `started`.
- Download trusted response: `not-received`, `received`.
- Inbound apply: `not-started`, `committed`, `rolled-back`, `unknown`.
- Cursor proof: `available`, `unavailable`, `unknown`.
- Acknowledgement request: `not-started`, `request-started`.
- Acknowledgement trusted response: `not-received`, `received`.
- Acknowledgement outcome: `not-started`, `unknown`, `applied`, `rejected`.
- Diagnostic durability: `durable`, `degraded`.
- Same-plane invariant: `diagnostic-invariant-conflict` / `diagnostic-causal-invariant-conflict`.

## Producer Ownership

- `UploadPendingEvents` owns upload lease, upload request, upload provider, and upload-result persistence evidence.
- `DownloadAndApplyEvents` owns download request, download trusted response, inbound apply, and cursor-proof evidence.
- `AcknowledgeAppliedCursor` owns acknowledgement request, trusted response, and outcome evidence.
- `HostedSyncCoordinator` preserves ordering and adds bounded terminal catch evidence where transport/auth/download errors occur.
- `NativeAuthClosureRunner` owns cumulative merge, diagnostic durability containment, runner fallback, and lifecycle projection.

## Merge Laws And Invariant Scope

- Later defaults do not erase earlier proof within the same plane.
- Trusted response receipt is monotonic per request plane.
- Upload local persistence cannot satisfy or contradict inbound apply.
- Upload provider outcome cannot satisfy or contradict acknowledgement.
- Inbound apply cannot satisfy acknowledgement.
- Diagnostic durability cannot establish provider, apply, cursor, or acknowledgement truth.
- Terminal evidence adds bounded result and guidance without overwriting core planes.
- Runner exceptions add terminal classification and sanitized class without rewriting proved planes.
- Different transaction outcomes coexist without conflict.
- Incompatible authoritative values within the same plane produce the bounded invariant.
- Acknowledgement request with inbound apply not committed or cursor proof not available is a bounded invariant.

## Event-Row Compatibility

Legacy generic event fields remain for durable phase chronology:

- `localMutationState`
- `providerTransactionState`
- `trustedResponseState`
- `resultPersistenceState`

Those fields describe the emitting event row and remain available to existing repository/UI projections. They are no longer the canonical cumulative representation for the operation. The authoritative cumulative whole-operation view is the in-memory/lifecycle plane projection.

Old durable rows are not reinterpreted as if they contain new R05 plane evidence.

## Runner And Terminal Projection

Both runner success and catch paths consume the cumulative snapshot. Lifecycle declarations expose:

- upload request/provider/local persistence;
- download trusted response;
- inbound apply and cursor proof;
- acknowledgement request/response/outcome;
- diagnostic durability;
- terminal result, safe action, retryability, and sanitized exception class.

The operation-started lifecycle uses initialized plane defaults. Terminal declarations retain the same accumulated planes and add bounded terminal guidance.

## Acknowledgement Eligibility

Acknowledgement remains eligible only after committed inbound apply and committed contiguous cursor proof.

Failed, rejected, rolled-back, or unproved inbound apply leaves acknowledgement not-started. Diagnostic degradation does not remove eligibility when inbound apply and cursor proof are independently available. Acknowledgement transport failure after committed apply leaves upload truth and inbound apply truth intact while acknowledgement remains request-started, trusted response not-received, and outcome unknown.

## Frozen Boundaries

R05 did not alter:

- Product identity resolution or remote-to-local Product UUID mapping;
- Store convergence;
- Purchase/Purchase Item materialization;
- facts/inbox/cursor Drift transaction boundary;
- post-rollback apply exception translation;
- poison-page and mixed-client replay behavior;
- Protocol v3 Person/Payment restrictions;
- hosted API, payloads, Auth0, enrollment, Account/Device binding, dependencies, generated files, schema, migrations, or provider configuration.

## Residual Design Risk

The remaining risk is evidence class. R05 proves source truth-plane partitioning through deterministic automated tests and builds. It does not prove preserved runtime state, installed-client behavior, live provider convergence, or overall Sync acceptance.

After Main reconciles R05, the next possible sequence remains the separately authorized read-only preserved-state checkpoint before any installation or live assay.
