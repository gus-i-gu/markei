# E_DDC_STAGE — Evidence contract for C10-GCM03-S10-R03

D_OPS_STAGE.md is operational authority. This file defines interpretation. F_DSN_STAGE.md assigns responsibilities.

Primary unit: C10-GCM03-S10-R03  
Continuity alias: C10-GCM03-S09-R03

## 1. Separate proofs

| Evidence | Proven conclusion |
|---|---|
| Preserved provenance/auth/enrollment | R02 ran against preserved client state |
| Find Item no longer asserted | Stable Product-ID selector passed human acceptance |
| Purchase registration and sequence delta | One Android outbound event committed locally |
| Android submission HTTP 200/result persisted | Android upload became trusted and left pending |
| Android download HTTP 200 then typed conflict | Provider succeeded; local Product reconciliation rejected |
| Windows upload HTTP 200/result persisted | Windows upload became trusted |
| Windows download-response-received | Windows received a trusted page |
| closure-runner-exception before local-apply result | Post-download failure escaped typed classification |
| No acknowledgement request | No client proved an inbound page eligible for acknowledgement |

Render did not reject the observed operations.

## 2. Identity semantics

A Product has incoming UUID, normalized user code, and exact semantic identity. Exact identity excludes user code. Two clients may independently assign different codes to the same semantic Product.

Safe asymmetry:

~~~
different code + same exact identity = convergence candidate
same code + different exact identity = conflict
~~~

This does not loosen established identity: an existing UUID cannot mutate; split keys and ambiguity conflict; no first-row wins.

Hosted content stays immutable. Local references converge through incoming UUID → selected local UUID mapping.

## 3. Three truth planes

Provider truth asks whether a trusted response arrived. For Windows upload/download: yes.

Transaction truth asks whether facts/inbox/cursor committed. For the supplied Windows evidence: unknown.

Diagnostic truth asks whether a durable declaration was recorded. No durable local-apply result was observed.

Diagnostic failure cannot decide transaction truth.

## 4. Precise states

- entered: execution crossed a boundary;
- proved: authoritative evidence establishes an outcome;
- committed: transaction is durable;
- rolled back: no page mutation retained;
- unknown: evidence cannot distinguish;
- diagnostic degraded: core truth exists but durable observability failed.

The runner may show generic terminal as event kind but must retain the latest entered/proved phase and trusted response.

## 5. Correct ordering

Failure path:

1. update in-memory causal state;
2. run the complete transaction;
3. allow exception to unwind and rollback;
4. translate bounded result;
5. update causal state;
6. attempt sanitized diagnostics;
7. emit lifecycle;
8. prohibit acknowledgement.

Committed apply with diagnostic failure:

1. transaction commits facts/inbox/cursor;
2. core result remains committed;
3. diagnostic failure is contained;
4. report degradation without reversing truth;
5. acknowledgement eligibility follows committed cursor.

Never catch inside the transaction merely to return a result.

## 6. Total but bounded

A total boundary covers every thrown object while exposing only stable categories: identity conflict, database failure, payload shape, local invariant, unexpected local apply, and diagnostic degradation.

Safe sanitized class/category is allowed. Messages, SQL, values, identifiers, payload facts, stacks, and secrets are forbidden.

## 7. Stored exception class

The schema already stores sanitizedExceptionClass. The projection currently drops it, so the UI receives null. Carry it through storage → application summary → current action → Closure UI. This is not a migration.

## 8. Acceptance boundary

Automated R03 validation will not prove live convergence. After Codex publication, Main must reconcile and issue a fresh one-operation preserved-state assay proving commit, acknowledgement, no duplicates, and replay.

Until then both clients’ Sync/Retry remain held.

## 9. Review questions

- Does new UUID + exact identity + different code reuse locally?
- Does same code + different identity still conflict?
- Are item references remapped?
- Do all apply exceptions translate after rollback?
- Can diagnostics fail without changing core truth?
- Does the runner preserve trusted-response evidence?
- Is the sanitized class visible without a message?
- Can acknowledgement start only from committed cursor?
- Are schema, provider, API, and protocol unchanged?
