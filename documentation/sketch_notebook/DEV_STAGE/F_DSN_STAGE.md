# F_DSN_STAGE — Product identity and atomic convergence architecture

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Design materialization stage
> Unit: `C10-GCM03-S10-R02`
> Continuity alias: `C10-GCM02-S09-R02`
> Branch: `grm-guarded-provisioning-20260727`
> Required published ancestry:
> `716ae7f082714944b6b51042d98a56e685978c38`
> Authority: **ACTIVE WITHIN D — IMPLEMENT AND REPORT**
> Evidence boundary: client presentation, local materialization and diagnostic
> responsibility correction; no hosted-contract or schema expansion

## 1. Responsibility map

Implement and preserve:

```text
CatalogueQueryRepository
  owns Account-scoped Product projections and exact code lookup

PurchasePage selection state
  owns one nullable stable Product ID

PurchasePage current projection resolver
  binds that ID to exactly one current Product projection

RemotePurchaseFactWriter
  owns Store/Product snapshot reconciliation and event-local ID maps

DriftRemoteEventApplier
  owns one atomic page transaction and conversion of local apply failures into
  bounded SyncResult values after rollback

DownloadAndApplyEvents
  owns trusted-response and download-local-apply phase diagnostics

HostedSyncCoordinator
  owns phase ordering and prevents acknowledgement after a failed apply

NativeAuthClosureRunner
  owns client-operation declaration without overwriting causal child evidence
```

Do not move domain reconciliation into the widget. Do not move UI selection
state into the database.

## 2. Purchase projection boundary

Use:

```text
selection state = Product ID
rendered/staged facts = Product resolved from current _products projection
```

This makes selection stable across separately materialized repository objects
and refreshes. The dropdown must expose exactly one item per scalar ID.

If the current projection cannot resolve the selection exactly once, the page
owns safe invalidation and recovery feedback. It must not pass ambiguous state
to Flutter.

Preserve:

- Account scope;
- immutable Product code/facts;
- existing/new Product modes;
- staged Purchase Item behavior;
- Store, Person and Payment Method behavior;
- responsive page composition.

## 3. Local canonicalization boundary

Incoming UUIDs remain immutable event identities. The receiving database may
already own an equivalent local row under another UUID.

Required flow:

```text
validate incoming snapshot
↓
resolve UUID and Account-scoped natural keys
↓
choose one coherent local row or insert
↓
record remote -> local ID map
↓
materialize Purchase references through the map
```

Natural keys are conflict detectors and convergence keys. They are not
permission to merge contradictory rows.

Product resolution must use the already persisted normalized code and exact
identity key. Store resolution must use the current Account/display-name
identity without introducing a new normalization version or schema column.

## 4. Atomic page boundary

Preserve the existing page-wide transaction:

```text
all fact reconciliation
+ all Purchase/Purchase Item writes
+ all inbox writes
+ Account cursor advancement
= one commit
```

Any typed conflict or SQLite failure throws inside that transaction so Drift
rolls it back. Only after rollback may the infrastructure boundary translate
the failure into a sanitized `SyncResult`.

Do not catch an exception inside the transaction and return a normal result
that would commit earlier writes.

Duplicate-equivalent replay remains idempotent. A conflict remains
not-applied. An unknown SQLite write category remains unknown, never
misrepresented as applied.

## 5. Diagnostic architecture

The diagnostic graph is causal:

```text
download request
→ trusted response
→ local apply
→ acknowledgement only after committed cursor
→ client terminal
```

The local-apply failure node must retain:

```text
download-local-apply
trusted response received
transaction rolled back / no retained mutation
acknowledgement not started
sanitized category only
```

The Closure client terminal may reference the causal diagnostic. It must not
rewrite the causal node as transport failure.

## 6. Contract and schema invariants

This unit must not change:

- `purchase.registered` payload version 3;
- canonical JSON or content hashes;
- API request/response routes;
- Neon tables, migrations, grants, RLS or functions;
- authentication or Device enrollment;
- Person/Payment Method remote restriction;
- provider retention, snapshot or rebootstrap behavior;
- production configuration;
- local Drift schema version.

No new hosted identifier-mapping table is required. Mapping is local and
transactional during materialization.

## 7. Conflict semantics

Report distinct outcomes:

```text
equivalent identity under different UUID
  => converge and apply

contradictory immutable identity
  => typed conflict / notApplied / complete rollback

SQLite write failure after trusted response
  => sanitized local apply failure / unknown / complete rollback

duplicate equivalent event
  => existing replay behavior
```

Do not turn identity conflict into retryable transport failure.

## 8. I report

Replace `I_DSN_CODEX.md` and report:

- final UI selection responsibility;
- Product and Store reconciliation decision graph;
- remote-to-local reference map ownership;
- transaction placement of catches and result translation;
- diagnostic causality and acknowledgement ordering;
- invariants and non-goals;
- any deviation from the authorized source surface.

Required terminals:

```text
PURCHASE_SELECTION_OWNER=STABLE_PRODUCT_ID
CURRENT_PRODUCT_PROJECTION=EXACTLY_ONE_OR_SAFE_INVALIDATION
REMOTE_PRODUCT_CANONICALIZATION=ACCOUNT_SCOPED
REMOTE_STORE_CANONICALIZATION=ACCOUNT_SCOPED
REMOTE_ID_MAP_OWNER=LOCAL_APPLY_TRANSACTION
FACT_INBOX_CURSOR_ATOMICITY=PRESERVED
CONFLICT_CAUSES_COMPLETE_ROLLBACK=YES_OR_BLOCKED
ACK_REQUIRES_COMMITTED_CURSOR=YES_OR_BLOCKED
HOSTED_CONTRACT_CHANGE=ABSENT
LOCAL_SCHEMA_CHANGE=ABSENT
AUTH_ENROLLMENT_CHANGE=ABSENT
```

Do not edit permanent design memory.
