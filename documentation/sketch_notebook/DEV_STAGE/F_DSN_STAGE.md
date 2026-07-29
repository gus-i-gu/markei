# F_DSN_STAGE — Architecture for C10-GCM03-S10-R03

## Objective

Close cross-device Product convergence and post-download observability gaps while preserving protocol v3, page atomicity, causal diagnostics, and acknowledgement ordering.

## 1. Responsibility map

| Responsibility | Owner | Constraint |
|---|---|---|
| Semantic Product identity | domain Product | identityKey excludes code/raw display |
| Incoming resolution | remote fact writer | asymmetric UUID/code/exact table |
| Reference mapping | event/page applier | map Product/Store before dependent facts |
| Facts/inbox/cursor | Drift transaction | one transaction; exception escapes |
| Failure translation | local sync boundary | bounded result after rollback |
| Causal state | operation recorder/runner | in-memory update before diagnostics |
| Durable diagnostics | repository | best effort; never redefine core outcome |
| UI projection | application/app | preserve phase and sanitized class |
| Safety fallback | NativeAuthClosureRunner | keep strongest causal snapshot |
| Acknowledgement | coordinator | only after committed cursor |

## 2. Product state machine

~~~mermaid
flowchart TD
    A["Incoming Product"] --> B{"Existing UUID?"}
    B -->|yes| C{"Full snapshot coherent?"}
    C -->|yes| D["Reuse UUID row"]
    C -->|no| X["Typed conflict"]
    B -->|no| E{"Code / exact matches"}
    E -->|"none / none"| F["Insert"]
    E -->|"same / same"| G["Reuse row"]
    E -->|"code only"| X
    E -->|"exact only"| H["Reuse exact row; preserve local code"]
    E -->|"split or ambiguous"| X
    D --> M["Map incoming to local UUID"]
    F --> M
    G --> M
    H --> M
~~~

The relaxed comparison applies only to exact-identity convergence for a previously unseen incoming UUID. Established UUIDs retain full immutable coherence.

## 3. Page apply flow

~~~mermaid
flowchart TD
    A["Trusted page"] --> B["Causal state: apply entered"]
    B --> C["One Drift transaction"]
    C -->|commit| D["Core committed"]
    C -->|throw| E["Rollback completes"]
    E --> F["Translate bounded failure"]
    D --> G["Persist diagnostic"]
    F --> G
    G -->|success| H["Emit lifecycle"]
    G -->|failure| I["Diagnostic degraded; retain core truth"]
    H --> J{"Committed cursor?"}
    I --> J
    J -->|yes| K["Ack eligible"]
    J -->|no| L["Ack prohibited"]
~~~

Translation cannot happen inside the transaction. Diagnostic persistence cannot decide whether the transaction committed.

## 4. In-memory causal snapshot

Keep per-operation state with phase, latest proved phase, provider contact, trusted response, local apply state, mutation/result persistence, acknowledgement, bounded result, and sanitized class.

Update synchronously before awaiting durable diagnostics. Do not retain payloads, business facts, UUIDs, SQL, tokens, messages, stacks, or secrets.

## 5. Recorder containment

Allowed designs include a diagnostic-write outcome, guarded best-effort sink, or split core recorder/sink. Regardless:

- write failure becomes bounded degradation;
- it cannot throw beyond the coordinator after core truth is known;
- it cannot flip committed/rolled-back truth;
- it cannot create provider/ack evidence;
- avoid recursive recording of recording failures.

## 6. Apply result and fallback

Extend result models minimally for applied/notApplied, bounded code, proven mutation state, retry/protocol fields where needed, and sanitized class/category.

Runner fallback consumes the causal snapshot. It retains trusted download received, server accepted where proved, unknown local mutation only where truly unknown, and acknowledgement not-started unless proved.

## 7. Exception-class projection

Carry the stored class through a typed summary to the UI. Prefer stable allow-listed categories. Never show toString(), messages, SQL, values, payload, or stack.

## 8. Compatibility

Preserve schema version/tables, API, payload v3, auth/binding, upload result persistence, stable Product selector, Account scope, Store rules, Person/Payment restrictions, branch, and non-forced publication.

## 9. Test injection points

Inject at Product decision branches, mid-transaction, translation, diagnostic persistence before apply, after rollback, after commit, final runner fallback, and repository-to-UI projection.

Each failure test asserts facts, inbox, cursor, acknowledgement, causal state, and diagnostic state separately.
