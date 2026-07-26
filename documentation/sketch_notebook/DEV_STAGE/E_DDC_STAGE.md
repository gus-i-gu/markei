# E_DDC_STAGE — Error Meaning and Diagnostic Projection

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Didactic materialization authority
Round or unit: C10-GCM02-S12-ERR-01
Branch: `cycle10-intermid-grimoire`
Required remote baseline:
`5f30b9d7a55e1312889873bdb3728233cce72ff2`
Authority: Main Chat under explicit human direction
Status: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
Writable evidence surface:
`documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`

## 1. Purpose

Make each Sync diagnostic understandable without reducing it to:

```text
something failed
HTTP 500
try again
```

The user-facing system must explain:

- what happened;
- where detection stopped;
- what the result means;
- whether anything changed locally;
- whether provider contact may have started;
- whether the provider outcome is known;
- what action is safe now;
- what action is specifically unsafe.

This is an implementation and documentation projection unit. It does not
promote a permanent Didactic concept and does not authorize provider action.

## 2. One truth, three projections

The complete code list must exist once as machine truth in:

```text
contracts/shared_beta/diagnostics_v1/
```

It must project into:

1. generated Dart lookup used by Flutter;
2. generated TypeScript lookup used by the API;
3. generated `documentation/SYNC_DIAGNOSTICS.md`.

Do not maintain a second hand-written catalogue in documentation or UI source.
J's `System Diagnosis` remains provenance/history; it is not the runtime
registry after materialization.

## 3. Required semantic fields

Every code must answer:

| Field               | Human question                                                         |
| ------------------- | ---------------------------------------------------------------------- |
| `title`             | What is this event called?                                             |
| `meaning`           | What happened in plain language?                                       |
| `severity`          | How seriously should this be treated?                                  |
| `outcome`           | Was it blocked, not applied, applied, duplicate, unknown, or complete? |
| `phase`             | At which pipeline moment was it detected?                              |
| `detectorComponent` | Which component observed it?                                           |
| `causeDomain`       | Which subsystem currently owns the causal hypothesis?                  |
| `causeConfidence`   | Is that cause confirmed, inferred, boundary-only, or unknown?          |
| `safeAction`        | What may the user/operator safely do next?                             |
| `retryPolicy`       | Is another request prohibited, gated, or same-identity-only?           |
| `userGuidance`      | What concise explanation should UI show?                               |

`nativeCode` remains visible as technical detail when it already exists.
`MKS-*` does not erase `unknown-retry-queue-not-isolated`,
`service-unavailable`, `sequence-gap`, or another protocol code.

## 4. Causal/pathogenic explanation

Separate:

```text
where the symptom was detected
from
what is proved to have caused it
```

Examples:

- a timeout detected by Flutter HTTP is a `TRN` event; it does not prove
  Render, Auth0, Neon, or PostgreSQL failed;
- a rejected JWT verified by the Auth0/JWKS adapter is an `AUT` event;
- a Device/membership mismatch is a `BND` event;
- a Fastify route/body contract failure is an `API` event;
- a pool/transaction/constraint/commit event is a `PDB` event;
- a local queue or transaction event is `LDB`, `REC`, or `QUE`;
- provider submission validation/application is `UPL`;
- download and acknowledgement retain `DNL` and `ACK`.

When the exact pathogenic cause is not proved, UI and documentation must say
that the boundary is known but the cause remains unknown. Never convert the
name of a third-party service into blame without evidence.

## 5. UI information hierarchy

Native Closure must present a persistent current-action result near the top of
the page.

Required compact view:

```text
[MKS-CODE] Title
Meaning
Outcome · phase
Local change: ...
Provider contact: ...
Safe next action: ...
Operation: #fingerprint
```

Required expanded view may include only:

- native code;
- cause domain and confidence;
- request ordinal;
- route class;
- sanitized queue counts;
- member count and sequence boundaries;
- transaction states;
- trusted-response state;
- HTTP status if received;
- elapsed band;
- sanitized exception class;
- source/client/API revision identifiers.

Never display:

- tokens or authorization codes;
- account, Device, event, submission, or purchase identifiers;
- payload content;
- URLs containing identifiers;
- connection strings;
- SQL;
- full hashes;
- exception messages or stack traces.

## 6. Current versus historical results

The page must not make a prior `sync-unavailable` look like the result of the
latest blocked preflight.

Label separately:

```text
Current action result
Last ordinary Sync result
Last successful Sync
Recent diagnostic timeline
```

Each result must retain operation kind, order/time band, and operation
fingerprint.

Refreshing Diagnostics must not erase the current warning or change its meaning
without a newer event.

## 7. Recovery action vocabulary

Use these distinctions exactly:

| Term                                   | Meaning                                                            |
| -------------------------------------- | ------------------------------------------------------------------ |
| `Retry unknown-outcome submission`     | Reuses an isolated submission whose provider outcome is unresolved |
| `Inspect failed/notApplied recovery`   | Read-only validation of one provider-proved not-applied lineage    |
| `Recover failed/notApplied submission` | Future mutating transition; not implemented or authorized here     |
| `Sync`                                 | Compound recovery/upload/download/acknowledgement coordinator      |
| `Repair`                               | Correction of a specifically diagnosed local coordination defect   |
| `Diagnostics`                          | Read-only inspection and classification                            |

The failed/notApplied inspection UI must explicitly say:

```text
Read-only
No local Sync state will change
No provider request will be sent
```

It must not offer a misleading execute button.

## 8. Required current-event mappings

At minimum, the implemented projection must make these present events
unambiguous:

| Code          | Meaning                                                                                                  |
| ------------- | -------------------------------------------------------------------------------------------------------- |
| `MKS-UI-001`  | Unknown Retry was blocked because the current Device queue is not an isolated unknown-outcome submission |
| `MKS-UI-002`  | The block existed but was not visibly presented                                                          |
| `MKS-UI-003`  | The action label hid its unknown-outcome-only semantics                                                  |
| `MKS-UI-004`  | A bounded failed/notApplied execution surface does not exist                                             |
| `MKS-UI-005`  | A prior Sync result was visually conflated with the current action                                       |
| `MKS-OBS-003` | An unexpected API exception was collapsed into generic service-unavailable                               |
| `MKS-OBS-007` | Missing provider-contact fields were mistaken for proof of no contact                                    |
| `MKS-INV-001` | Generic HTTP 500 must not authorize automatic retry                                                      |

Expected current blocked-preflight projection:

```text
MKS-UI-001
nativeCode: unknown-retry-queue-not-isolated
outcome: blocked
localMutation: none
providerContact: not-started
safeAction: inspect-failed-not-applied-candidate
```

## 9. Generated documentation

`documentation/SYNC_DIAGNOSTICS.md` must be readable without source inspection.

It must contain:

- diagnostic version and generation warning;
- pipeline/layer legend;
- outcome and severity semantics;
- safe interpretation rules;
- generic-500/unknown-outcome rule;
- privacy/redaction rules;
- one generated row or section for every `MKS-*` code;
- native-code mappings;
- detecting source/component;
- causal domain and confidence rule;
- meaning, safe action, and retry policy;
- a short operator parsing sequence;
- an explicit statement that documentation does not authorize mutation.

The generator/check test must prove the documentation is current.

## 10. H report

Replace H with:

- source stage files;
- terminology and UI behavior implemented;
- registry/documentation generation evidence;
- code-set equality evidence;
- before/after explanation of the latest blocked Retry;
- causal attribution rules;
- redaction checks;
- unresolved language or presentation risks;
- evidence boundary.

End with evidence-supported classifications only:

```text
DIAGNOSTIC_MEANING_PROJECTION_IMPLEMENTED_OR_BLOCKED
GENERATED_DOCUMENTATION_VALIDATED_OR_BLOCKED
CURRENT_AND_HISTORICAL_RESULTS_SEPARATED_OR_BLOCKED
FAILED_NOT_APPLIED_INSPECTION_READ_ONLY
NO_PROVIDER_AUTHORIZATION
GATE_12_7_HELD
GCM02_OPEN
```

No permanent didactic promotion is authorized in this unit.
