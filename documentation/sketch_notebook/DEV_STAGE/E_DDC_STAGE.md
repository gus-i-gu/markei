# E_DDC_STAGE — Recovery and evidence-scope vocabulary

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Didactic materialization authority
Hierarchy: Cycle 10 → GCM-02 → Step 12 → Gate 12.7 pre-authorization
Unit: C10-GCM02-S12-ERR-04
Parent sequence: C10-GCM02-S12-SYNC-01
Branch: `cycle10-intermid-grimoire`
Required ancestry: `27e1b77b81f658b5e704e46923ea48cce2274b3a`
Status: **ACTIVE — NARROW SOURCE MATERIALIZATION; LIVE ACTIONS HELD**

## 1. Accepted meaning

Preserve these conclusions:

- the 19:50 ordinary Sync completed at the aggregate client level;
- upload, download and acknowledgement each completed at the server-request
  level with authentication accepted and HTTP 200;
- the shared operation fingerprint joins the aggregate client run to Render;
- Render's current distinct correlation fingerprints identify server request
  instances but do not yet prove the client's child correlation identity;
- this proves one observed Sync lifecycle, not second-device convergence;
- the unchanged Next Device sequence is correct because replay does not create
  a new local event;
- the ordinary action improperly crossed into controlled failed/notApplied
  recovery;
- technical success does not erase the authorization-boundary defect.

## 2. Action vocabulary

Keep these actions distinct in code, UI, tests and logs:

| Action | Meaning |
| --- | --- |
| Ordinary Sync | upload ordinary pending work, download, apply and acknowledge |
| Inspect failed/notApplied | read-only candidate diagnosis |
| Recover failed/notApplied | explicitly confirmed bounded recovery |
| Retry unknown outcome | separately controlled retry of an unknown outcome |
| Hosted readiness | health/readiness route only |

Do not call failed/notApplied recovery “ordinary upload” merely because it
eventually used the submission route. Do not call ordinary Sync successful
recovery authorization merely because the server accepted the request.

## 3. Success wording

For this assay, the accurate concise statement is:

```text
Ordinary Sync completed and every observed server request returned HTTP 200.
The run also executed failed/notApplied recovery implicitly, so the recovery
authorization boundary failed and the assay was not the intended empty-queue
control.
```

Avoid:

```text
full convergence proved
all synchronization gates passed
empty Sync passed
Gate 12.7 passed
```

Those claims exceed the evidence.

## 4. Client/server evidence wording

Use:

```text
Client operation
  owns aggregate Sync terminal and local persistence

Client phase
  owns one local orchestration observation

Server request
  owns one received HTTP request and its terminal
```

Use explicit identity labels:

```text
Operation
Client child correlation
Server request
```

Do not call a server-generated request fingerprint the client correlation.

An aggregate multi-request attempt has no single HTTP status/header result.
When those fields are not applicable, say `not applicable—see child
requests`, not `not observed` or `not received`.

Phase-local axes must be labelled as phase-local. A final observation with
`provider contact=not-started` cannot be presented as the aggregate operation
state after upload/download/acknowledgement were proved.

## 5. Terminal presentation

The Flutter terminal and Closure UI should make the paired evidence scannable:

```text
operation #cf23...
client terminal: sync-completed
client elapsed/deadline
latest client phase
child server evidence: correlated in server logs
safe next action
```

Render retains one structured line per server lifecycle event. Flutter gains
equivalent sanitized client-operation/client-phase lines for local assay
diagnosis.

Never expose full IDs, secrets, headers, URLs, payload contents, SQL,
exception messages or stack traces.

## 6. Tests

Tests must prove:

- action labels remain distinct;
- ordinary Sync cannot silently mean controlled recovery;
- successful request wording remains request-scoped;
- aggregate client success remains client-scoped;
- unavailable child evidence is not described as a received/transport
  failure;
- phase-local and aggregate evidence are visibly different;
- client-child and server-request identities are separately labelled;
- terminal lines remain compact and redacted;
- existing five-result and timeout-owner meanings remain unchanged.

Do not edit permanent didactic memory.

H terminal markers:

```text
ORDINARY_SYNC_RECOVERY_MEANING=SEPARATE_OR_BLOCKED
TECHNICAL_SUCCESS_AUTHORIZATION_MEANING=SEPARATE_OR_BLOCKED
CLIENT_PHASE_SERVER_REQUEST_SCOPES=VISIBLE_OR_BLOCKED
AGGREGATE_HTTP_WORDING=TRUTHFUL_OR_BLOCKED
NEXT_SEQUENCE_REPLAY_MEANING=ALIGNED_OR_BLOCKED
TERMINAL_LOG_REDACTION=VALIDATED_OR_BLOCKED
GATE_12_7=HELD
GCM02=OPEN
```
