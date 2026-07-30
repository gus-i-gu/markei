# E_DDC_STAGE — Evidence contract for C10-GCM03-S10-R05

D_OPS_STAGE.md is executable authority. This file limits what evidence can
establish. F_DSN_STAGE.md assigns architectural responsibility.

Sequence: FLX-ORD-01

Primary unit: C10-GCM03-S10-R05

Continuity alias: C10-GCM03-S09-R05

Pre-stage head: 0fdd2b9fbadbf935d8e20f09f597516a93f4e7dd

## 1. Accepted evidence entering R05

R04 is accepted at implementation and deterministic-test scope for cumulative
retention of trusted download/apply facts, diagnostic-degradation containment,
the Product decision matrix, unexpected apply rollback, poison-page recovery,
mixed-client replay, idempotency, full Flutter regression, and both platform
builds.

R04 is not accepted as complete evidence for independent acknowledgement or
transaction-plane truth.

Source inspection directly establishes:

- one generic local-mutation field receives both upload and inbound-apply facts;
- one generic provider/trusted-response field receives upload, download, and
  acknowledgement facts;
- acknowledgement lacks an independent cumulative transition/result;
- a valid upload commit followed by inbound rollback can be classified as a
  causal invariant conflict.

These source facts are sufficient to authorize source correction. A live assay
of the old installed binaries cannot invalidate them.

## 2. Runtime checkpoint evidence boundary

No new runtime checkpoint is required to prove that R05 source work is
necessary. R05 is prohibited from changing preserved runtime state.

A read-only WIN/AND/provider checkpoint is still required after R05
reconciliation and before corrected-client installation or live Sync. Because
R05 cannot touch those surfaces, the later pre-install checkpoint anchors the
same preserved runtime state without creating a source-evidence gap.

```text
SOURCE_CORRECTION_EVIDENCE=SUFFICIENT
PRESERVED_RUNTIME_STATE_EVIDENCE=NOT_REFRESHED_BY_R05
PRACTICAL_SYNC_EVIDENCE=ABSENT
POST_R05_PRE_INSTALL_CHECKPOINT=MANDATORY
```

## 3. Independent evidence planes

| Plane | Minimum direct question | Authoritative source |
|---|---|---|
| Upload request | Did upload start? | upload use case/transport invocation |
| Upload provider | Was a trusted response received and how was it classified? | upload transport result |
| Upload local | Did lease/result persistence commit, fail, or remain unknown? | outbox repository result |
| Download provider | Did download start and return a trusted page? | download transport result |
| Inbound apply | Did facts/inbox/cursor commit or roll back? | applier transaction/result |
| Acknowledgement | Did ack start, receive a response, and reach a classified outcome? | acknowledgement transport/result |
| Diagnostic | Were begin/event/completion records durable or degraded? | recorder repository |
| Terminal | What bounded state and safe action reached the runner/lifecycle? | cumulative projection |

Truth in one row cannot be substituted by another row.

## 4. Required compound-state proof

R05 passes only if tests inspect the separate fields that coexist in one
ordinary operation.

Required valid state:

```text
upload provider=committed
upload local result persistence=committed
download trusted response=received
inbound apply=rolled-back
acknowledgement=not-started
```

This is not an invariant conflict.

Required acknowledgement-failure state:

```text
inbound apply=committed
ack request=request-started
ack trusted response=not-received
ack outcome=unknown
```

Earlier upload state may be committed or absent; neither value may be presented
as acknowledgement success.

Required invariant state:

```text
inbound apply=failed-or-unproved
ack request=request-started
```

The test must prove that the contradiction is within one authority boundary,
not merely that two different transactions ended differently.

## 5. Direct-test adequacy

A test is direct only when it:

- executes the relevant coordinator/runner sequence;
- controls upload, download/apply, acknowledgement, and diagnostics through
  bounded fakes or repositories;
- inspects independent cumulative and terminal fields;
- asserts forbidden downstream calls;
- distinguishes core truth from diagnostic durability.

Insufficient substitutes include:

- asserting only `sync-completed` or `sync-failed`;
- asserting only event order;
- inspecting only the final generic `providerTransactionState`;
- inspecting only the final generic `localMutationState`;
- calling the page applier without the upload/coordinator sequence;
- relying on the full-suite count to infer a named compound case;
- swallowing a diagnostic exception without asserting core planes.

## 6. Compatibility evidence

Legacy generic event fields may remain as phase-row chronology. Their continued
existence does not prove the cumulative model is partitioned.

If R05 adds in-memory or lifecycle fields without a database migration, H and I
must establish:

- which event-specific legacy fields remain;
- which independent fields are cumulative authority;
- how each producer maps into its own plane;
- that old durable rows are not reinterpreted beyond their recorded phase;
- that no schema, payload, API, or provider contract changed.

Event-row compatibility and cumulative correctness are separate conclusions.

## 7. Diagnostic degradation evidence

Begin, row, and completion failures must be injected across compound operations.

Required conclusions:

- diagnostic degradation is visible;
- upload truth remains unchanged;
- download/apply truth remains unchanged;
- acknowledgement eligibility and outcome remain unchanged;
- the core result is not manufactured or reversed;
- no recursive diagnostic write occurs;
- no automatic retry/recovery operation begins.

One injection at an isolated phase is not sufficient for the compound R05
claim. At least one committed upload + committed apply + acknowledgement case
and the committed upload + rolled-back apply case must experience diagnostic
degradation directly.

## 8. Negative and sanitization evidence

Directly assert that cumulative state, lifecycle JSON, UI/repository projection
when touched, test failure output, and G/H/I do not retain or emit:

- payload or serialized business facts;
- Product, Purchase, Store, Person, or Payment values;
- UUIDs or raw operation/correlation identifiers;
- request hashes or full hashes;
- tokens, credentials, secrets, paths, SQL, or database values;
- exception messages, `toString()` output, or stacks.

Allowed evidence remains bounded codes, allow-listed/sanitized class names,
short fingerprints, counts, sequences, state names, status classes, and timing
bands already authorized by D.

## 9. PRC-01 ceilings

| Evidence | Maximum conclusion |
|---|---|
| Source inspection | R05 model implemented |
| Focused compound deterministic test | named truth-plane sequence validated |
| Full Flutter suite | repository regression evidence |
| APK/Windows build | package materialized |
| Manifest inspection | expected packaged configuration present |
| Disposable lab skipped | no provider-lab conclusion |
| No live operation | no practical convergence conclusion |
| Future read-only checkpoint | preserved-state description only |
| Future one-client live assay | only that authorized client/provider operation |

`IMPLEMENTED_VALIDATED` may be reported only when every D terminal has direct
evidence. Any residual field inference, missing compound case, or unclassified
same-plane contradiction must be `PARTIAL` or `BLOCKED`, not inferred from the
full suite.

## 10. R03/R04 regression ceiling

Passing existing Product/apply/replay tests preserves their previously accepted
automated scope. It does not create new live Product or Sync evidence.

The R05 diff should not touch Product resolution or transaction application
code. If it does, D's stop condition applies unless the change is a strictly
mechanical evidence-model fixture adaptation in an already authorized path.

## 11. Acceptance boundary

A fully passing R05 may establish:

- source and deterministic-test truth-plane separation;
- no false cross-transaction invariant;
- bounded same-plane invariant detection;
- independent acknowledgement terminal truth;
- regression and package viability.

It cannot establish or authorize:

- current WIN/AND/provider preserved-state freshness;
- installation against preserved data;
- live Android or Windows Sync;
- Retry, Recovery, Query, enrollment, or new Purchase registration;
- hosted acknowledgement;
- bidirectional same-account convergence;
- GCM03 closure or MVP Sync acceptance.

Main must reconcile R05. The next authorized operation, if reconciliation
passes, is a read-only preserved-state checkpoint before installation.

## 12. Review questions

- Are upload local persistence and inbound apply represented separately?
- Are upload provider and acknowledgement represented separately?
- Does acknowledgement expose request, trusted response, and result?
- Does a valid upload-commit/apply-rollback sequence avoid false invariant?
- Does a same-plane contradiction still fail closed?
- Do runner success and catch project the same cumulative snapshot?
- Do diagnostic failures leave every core plane unchanged?
- Are R03/R04 accepted tests still passing?
- Did any preserved client/provider state or prohibited contract change?
