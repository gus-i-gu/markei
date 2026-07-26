# F_DSN_STAGE — Diagnostic Causality and Sync Boundary

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Design materialization authority
Round or unit: C10-GCM02-S12-ERR-01
Branch: `cycle10-intermid-grimoire`
Required remote baseline:
`5f30b9d7a55e1312889873bdb3728233cce72ff2`
Authority: Main Chat under explicit human direction
Status: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
Writable evidence surface:
`documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

## 1. Architecture objective

Build a diagnostic architecture in which:

```text
one registry defines stable event meaning
detectors emit from the boundary that can prove the event
pipeline envelopes preserve phase and outcome
UI and logs project sanitized views
generated documentation explains the same truth
```

The architecture must narrow failures without inventing causal certainty and
must preserve the difference between:

- local preflight block;
- trusted provider `not-applied`;
- applied result;
- duplicate-equivalent result;
- ambiguous/unknown result;
- local persistence failure after a provider result;
- provider transaction uncertainty.

## 2. Dependency direction

Required dependency direction:

```text
contracts/shared_beta/diagnostics_v1 registry
    ↓ deterministic generation
typed Dart registry          typed TypeScript registry
    ↓                                  ↓
Flutter detectors/UI         API/database detectors/logging
    ↓                                  ↓
sanitized local timeline     sanitized lifecycle evidence
             ↘              ↙
       generated documentation
```

The generated documentation is a peer projection of the registry, not an input
to source code.

Flutter must not import TypeScript source.
The API must not parse Markdown.
J must not become a runtime dependency.

## 3. Stable identity versus native cause

Every diagnostic event preserves two identities:

```text
protocolCode = stable MKS-* classification
nativeCode   = existing subsystem/protocol result
```

`MKS-*` owns cross-system meaning.
The native code owns the concrete local/protocol signal.

Many native codes may map to one stable event only when they share the same
causal and safety meaning. One native code may map to different stable events
only when phase/source context makes the distinction deterministic.

No source boundary may emit an arbitrary `MKS-*` string that is absent from the
generated typed registry.

## 4. Detection and cause ownership

Each entry and runtime event must distinguish:

```text
detectorComponent
detectorSource
lastProvedPhase
causeDomain
causeConfidence
externalDependency
```

Required causal domains:

| Domain                     | Ownership                                              |
| -------------------------- | ------------------------------------------------------ |
| `client-ui`                | action selection and presentation                      |
| `client-configuration`     | compiled config/composition/revision                   |
| `authentication-provider`  | Auth0/JWKS/token acquisition or verification           |
| `identity-binding`         | membership/account/Device/enrollment                   |
| `local-sqlite`             | local open/schema/transaction/attempt storage          |
| `failed-recovery`          | failed/notApplied candidate/requeue rules              |
| `local-queue`              | pending/uploading/unknown lease and result persistence |
| `http-transport`           | DNS/TCP/TLS/request/response decoding boundary         |
| `api-ingress`              | route/body/authorization/request contract              |
| `provider-postgresql`      | pool/transaction/RLS/constraint/commit/rollback        |
| `provider-upload`          | submission validation and application                  |
| `provider-download`        | cursor/page/provider-to-local application              |
| `provider-acknowledgement` | acknowledgement request/result                         |
| `cross-boundary`           | correlation, unknown outcome, or invariant             |
| `unknown`                  | evidence cannot localize causal ownership              |

The detecting component does not automatically become the cause owner.

Examples:

- Flutter timeout detector:
  `detector=http-sync-transport`,
  `causeDomain=http-transport`,
  `causeConfidence=boundary-only`;
- API SQLSTATE `23` constraint failure:
  `detector=postgres-transaction`,
  `causeDomain=provider-postgresql`,
  `causeConfidence=confirmed`;
- no trusted response after request start:
  `detector=http-sync-transport`,
  `causeDomain=unknown`,
  `causeConfidence=unknown`.

## 5. Pipeline state model

Use one top-level operation with ordered child events:

```text
operation
  0 local preflight
  1 upload request
  2 download request
  3 acknowledgement request
```

The exact request count may vary, but ordinals must be deterministic within the
operation.

Each event preserves:

```text
phase entered
last phase completed
local transaction state
provider contact state
trusted response state
provider transaction state
result persistence state
terminal outcome
```

Required precedence:

1. proved transaction result;
2. trusted typed provider result;
3. trusted transport response;
4. request-start evidence;
5. local preflight.

Consequences:

- local stop before mutation/request is `blocked`;
- trusted provider rejection with proved rollback is `not-applied`;
- request start without trusted provider outcome is `unknown`;
- provider result plus local persistence failure creates two events, not one
  overwritten result;
- HTTP status alone never proves provider commit state;
- a later resolution may link to an earlier unknown event but not delete it.

## 6. Privacy boundary

The architecture persists fingerprints, never direct identities.

Allowed:

- 12-hex SHA-256 fingerprints;
- queue counts;
- positions and sequence ranges;
- route templates;
- status and closed native codes;
- bounded time bands;
- closed exception class names;
- server-only SQLSTATE class.

Forbidden:

- raw account/Device/event/submission IDs;
- tokens, authorization codes, credentials;
- payloads or purchase data;
- complete hashes;
- connection strings;
- URLs containing identifiers;
- SQL text;
- exception messages or stack traces.

Fingerprint generation must be deterministic for stable identities within the
required comparison boundary, while the random operation identity remains
unique per user action.

## 7. Source adjacency

The registry is centralized, but detection remains attached to the source
boundary that can prove it.

Required detector locations include:

| Layer         | Expected source boundary                          |
| ------------- | ------------------------------------------------- |
| `UI`          | Native Closure page/runner                        |
| `CFG`         | Flutter composition and hosted configuration      |
| `AUT`         | native Auth0 adapter and API JWT verifier         |
| `BND`         | enrollment/binding guard and hosted authorization |
| `LDB`         | Drift database and diagnostics repository         |
| `REC`         | failed/notApplied candidate/recovery repository   |
| `QUE`         | outbox lease and result persistence               |
| `TRN`         | Flutter HTTP transport                            |
| `API`         | Fastify hooks, error handler, and request parser  |
| `PDB`         | PostgreSQL pool/transaction wrapper               |
| `UPL`         | submission service                                |
| `DNL`         | download service and local remote-event applier   |
| `ACK`         | acknowledgement service/transport                 |
| `OBS` / `INV` | coordinator and cross-boundary invariant guards   |

Do not put all detection in the UI or the final API catch-all.
Those layers may project or terminate events but may not fabricate upstream
causes.

## 8. Local diagnostic storage

Model:

```text
Sync operation parent
    1 ── * ordered diagnostic child events
```

The parent owns:

- action identity;
- operation kind;
- start/end;
- current terminal projection;
- source/client revision.

Each child owns:

- request ordinal;
- phase;
- diagnostic/native code;
- contact/transaction states;
- fingerprints and sanitized metrics;
- temporal order;
- outcome and safe action.

Use an additive migration if persistence cannot be represented safely by the
existing table. Do not overload one `resultCode` column with an entire
cross-system history.

The migration must not transform queue, submission, event, cursor, purchase,
account, Device, or hosted-auth state.

## 9. UI projection boundary

UI consumes a view model produced from diagnostic storage and the generated
registry.

UI must not:

- decide retryability from HTTP status;
- infer provider contact from null fields;
- infer causal ownership from a service name;
- parse raw exception text;
- mutate Sync state while building Diagnostics;
- conflate current action with the last ordinary Sync.

UI may:

- display registry meaning and guidance;
- show sanitized envelope fields;
- group child events under one operation;
- highlight blocked/unknown/critical outcomes;
- route to a read-only preflight.

## 10. Failed/notApplied preflight boundary

Implement one read-only application port and Drift adapter for:

```text
InspectFailedNotAppliedCandidate
```

Input authority:

- current authenticated account;
- exact current Device;
- current environment alias.

Output:

- eligible/blocking diagnostic code;
- candidate fingerprint;
- member count;
- first/last Device sequence;
- next Device sequence;
- Device-scope queue counts;
- request-hash shape/equality boolean;
- overlap/isolation booleans.

The preflight must reuse the same validation logic as recovery without invoking
the mutating transition. Extract shared pure validation rather than maintaining
two divergent algorithms.

There must be no method, callback, route, or button in this unit that converts
this preflight into provider execution.

## 11. Unknown-outcome Retry boundary

Rename the current UI and source API to express `unknown-outcome`.

Preserve:

- same submission identity;
- no automatic requeue;
- isolated unknown candidate requirement;
- explicit confirmation before future provider contact;
- compound coordinator phases if the existing implementation still performs
  upload/download/acknowledgement.

Do not describe it as the current Gate 12.7 action.
Do not alter it to accept failed events.

If source inspection proves its implementation is broader than its label,
make the confirmation text and diagnostic operation kind express the actual
compound boundary. Do not silently claim a narrow request.

## 12. Transaction and invariant corrections

### 12.1 Local queue

Enforce:

```text
lease committed
    -> trusted result persisted
    OR unknown result persisted
    OR typed local-persistence invariant emitted
```

No unclassified exit may strand `uploading`.

### 12.2 Failed recovery

Candidate validation must be pure/read-only.

Mutation occurs in one local transaction only after:

- exactly one candidate;
- exact scope;
- complete membership;
- contiguous canonical order;
- request hash equality;
- no accepted member;
- no active overlap;
- uniform compatible member states.

Mixed state rolls back.

### 12.3 Provider upload

Use a two-pass or equivalent transaction-safe design:

```text
validate entire request
↓
acquire/verify required locks
↓
apply all events
↓
store submission result
↓
commit
```

Any failure before commit must prove rollback or produce provider outcome
`unknown`. A returned domain failure must not allow a partially mutated
transaction to commit.

Recompute the canonical request hash server-side if the current protocol
defines a canonical request hash. If full recomputation cannot be implemented
without changing the established wire contract, report it as a blocker rather
than pretending the request hash was validated.

### 12.4 Duplicate-only download

Equivalent duplicates count as successfully observed remote positions.
Advance the greatest contiguous local cursor transactionally after their
equivalence is proved.

Different-content duplicates remain a conflict and do not advance.

### 12.5 Generic exceptions

Catch-alls may provide a sanitized terminal response, but the throwing boundary
must first attach:

- a stable diagnostic code;
- last proved phase;
- local/provider transaction state;
- safe retry policy;
- sanitized exception class.

Unknown exceptions default to no automatic retry.

## 13. Gate invariants

The implementation must preserve:

```text
unknown != not-applied
HTTP success != convergence
HTTP 500 != retry permission
detector != proved cause
documentation != authorization
preflight != mutation
source implementation != provider validation
Gate 12.6 PASS != Gate 12.7 authorization
```

No code in this unit may automatically move an ambiguous submission from
`unknown` to `pending` or `failed`.

No code in this unit may execute the proved failed/notApplied candidate.

## 14. I report

Replace I with an architecture evidence report containing:

- source stage files and inspected baseline;
- final file/dependency graph;
- registry and generation owner;
- detector/cause mappings;
- diagnostic parent/child persistence shape;
- pipeline phase transitions;
- privacy/redaction enforcement;
- unknown/not-applied precedence proof;
- five hazard fixes and tests;
- failed/notApplied preflight dependency boundary;
- explicit confirmation that no execution surface was attached;
- deviations, blockers, and host-unvalidated claims.

End with:

```text
DIAGNOSTIC_REGISTRY_SINGLE_OWNER_IMPLEMENTED_OR_BLOCKED
DETECTOR_CAUSE_BOUNDARY_VALIDATED_OR_BLOCKED
UNKNOWN_OUTCOME_SAFETY_PRESERVED_OR_BLOCKED
FAILED_NOT_APPLIED_PREFLIGHT_NON_MUTATING
FAILED_NOT_APPLIED_EXECUTION_ABSENT
PROVIDER_ACTION_ABSENT
GATE_12_7_HELD
GCM02_OPEN
```

No permanent Design promotion is authorized in this unit.
