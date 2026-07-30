# ALT_DEV.md — Conditional R07 Development Capsule

> Status: postponed implementation aid
> Authority: non-canonical recovery note
> Intended repository path: `documentation/ALT_DEV.md`
> Scope: preserve the core R07 causal-diagnostics proposal and seed a later Main Chat recovery
> Implementation authority: none
> Live Sync authority: none

---

## 1. Purpose

This file preserves the smallest useful statement of the proposed R07 round so
that a later `[M]` chat can recover the idea, inspect the then-current project
truth, and produce fresh D/E/F stages plus a Codex implementation prompt.

It is not a substitute for:

- `documentation/sketch_notebook/INDEX.md`;
- current Main-root continuity;
- current A/B/C reports;
- J reconciliation;
- current G/H/I implementation evidence;
- repository inspection;
- human approval.

If any newer authoritative source disagrees with this capsule, the newer
authoritative source wins.

---

## 2. Activation Boundary

R07 is conditional and remains postponed until Main and the human operator
explicitly activate it.

Expected route:

```text
R06 visible source identity
→ freeze candidate clients
→ serialized Sync assay
→ evaluate causal evidence
→ activate R07 only if attribution remains ambiguous,
  contradictory, wrapper-dominated, or operationally impractical
```

R07 may also be selected later as an observability improvement even after a
successful assay, but success alone does not authorize implementation.

Before activation, this file authorizes no:

- source change;
- database or migration change;
- provider mutation;
- live Sync, Retry, Query, Recovery, or Enroll;
- D/E/F replacement;
- Codex execution.

---

## 3. R07 Core Idea

R07 is not primarily a UI round. It is an operation-scoped causal authority
system. Settings, Audit, and exports are projections of that system.

The model separates:

```text
CASCADE
= failure propagation along a required transactional path

BRANCH
= an independent subsystem outcome that occurs beside the main path
  without rewriting established transaction truth

WRAPPER
= a boundary-level report that contains or summarizes a more specific failure

CONTRADICTION
= incompatible authoritative claims about the same plane and operation

UNKNOWN
= evidence is insufficient; no deeper cause may be invented
```

The primary causal member is not necessarily the first timestamp or first
displayed error. It is:

> The earliest authoritative failed member on the required dependency path
> that sufficiently explains its blocked descendants.

Example:

```text
Product identity conflict                  PRIMARY CAUSAL MEMBER
→ inbound transaction rolled back          CONSEQUENCE
→ cursor advancement not committed         CONSEQUENCE
→ acknowledgement prohibited               CONSEQUENCE
→ Sync success promotion prohibited        TERMINAL CONSEQUENCE

diagnostic serialization failure           INDEPENDENT BRANCH ROOT
runner/Closure failure                      WRAPPER, if a specific cause survives
```

---

## 4. Authority and Invariants

R07 must preserve these laws:

1. Transaction truth comes from authoritative durable transaction state, not
   from the latest UI row.
2. Events are joined only inside the same operation identity/fingerprint.
3. Dependency order outranks timestamp order when selecting a primary cause.
4. A specific inner failure outranks its generic wrapper when both are valid.
5. Consequences remain visible but do not compete with their cause as
   independent roots.
6. Independent diagnostic, presentation, or export failures cannot rewrite a
   committed or rolled-back transaction result.
7. Same-plane contradiction makes the affected operation indeterminate.
8. Missing evidence produces `unknown`, never an invented cause.
9. Acknowledgement and success promotion are prohibited without the required
   durable apply and cursor proof.
10. MKS classifications describe runtime diagnostics. ERR identifiers remain
    development/corrective-history metadata and are not emitted as transaction
    truth.
11. Settings, Audit, and exports consume one shared causal projector.
12. UI and export failure must not change Sync truth.

---

## 5. Operation-Scoped Causal Contract

The eventual design should assess and minimally define:

### Operation identity

- operation fingerprint;
- operation kind: Sync, Diagnostics, Retry, Query, Recovery, Enroll, or other
  explicitly modelled action;
- device reference;
- account context when safely and authoritatively observed;
- start and completion timestamps;
- client-child correlation where applicable.

### Event identity

- monotonic sequence within the operation;
- truth plane;
- exact stage;
- state: entered, succeeded, failed, blocked, unknown;
- MKS or sanitized native classification;
- causal role: primary candidate, consequence, wrapper, branch,
  informational, contradiction;
- causal parent or blocking member;
- durability: durable, transient, unknown;
- sanitized operator-facing message.

### Minimum relationships

```text
CAUSED_BY
BLOCKED_BY
WRAPPED_BY
BRANCHED_FROM
CONTRADICTS
```

### Candidate truth planes

- upload;
- download;
- inbound apply;
- cursor commit;
- acknowledgement;
- diagnostic persistence;
- runner boundary;
- UI presentation;
- export.

The current R05 truth-plane architecture must be reassessed before new storage
is added. R07 should reuse sufficient existing durable truth rather than create
a competing ledger.

---

## 6. Root Selection and Terminal Projection

The shared projector should deterministically:

1. group records by operation identity and kind;
2. separate required transactional stages from independent planes;
3. find authoritative failed members;
4. exclude known consequences from primary-cause candidacy;
5. prefer a specific failure to its wrapper;
6. order candidates by pipeline dependency;
7. retain independent failures as branch roots;
8. surface multiple candidates when evidence cannot select one;
9. surface contradictions explicitly;
10. return unknown when evidence is incomplete.

The terminal projection should remain multidimensional when necessary:

```text
Transaction outcome: successful | rejected | failed | indeterminate | unknown
Diagnostic durability: complete | degraded | failed | unknown
Presentation: available | degraded | failed
Operator attention: none | warning | action required
```

A single generic `failed` value must not collapse independent truths.

---

## 7. Durable and Projected State

The future D/E/F reconciliation must decide the smallest durable ceiling.

Likely durable:

- operation identity and kind;
- authoritative lifecycle members required to explain transaction truth;
- sanitized diagnostic classifications;
- causal links needed after restart;
- terminal transaction facts;
- contradiction/unknown evidence required for audit;
- schema version and retention metadata.

Likely derived or in memory:

- sorted/grouped Audit rows;
- expanded/collapsed UI state;
- labels, summaries, filters, and presentation ordering;
- System Health cards;
- export formatting.

Diagnostic recording should survive transaction rollback where safely possible.
If diagnostic persistence itself fails, that becomes an observability branch;
it must not falsify transaction state.

Retention, pagination, migration, sanitization, and bounded storage must be
decided before implementation.

---

## 8. Proposed Internal R07 Route

The eventual implementation may be decomposed as:

1. **R07-01 — Causal contract:** planes, dependency ordering, roles, edges,
   contradiction rules, root selection, and MKS/ERR boundary.
2. **R07-02 — Durable lifecycle:** minimal append-only operation/event storage,
   migration, retention, sanitization, and fingerprint integrity.
3. **R07-03 — Pipeline instrumentation:** record authoritative entry,
   completion, failure, and blocking at real Sync boundaries without
   duplicating business logic.
4. **R07-04 — Shared projector:** derive primary member, cascade, wrappers,
   branches, contradictions, unknowns, and multidimensional terminal status.
5. **R07-05 — Audit and export:** durable operation history, causal expansion,
   filters, and sanitized Markdown export.
6. **R07-06 — Settings/System Health:** concise latest snapshot consuming the
   same projector.

Main may reduce or reorder these steps if current repository evidence supports
a smaller materialization.

---

## 9. Settings, System Health, and Audit

### Settings → System Health

System Health is a concise, timestamped projection:

- authentication;
- enrollment and last-observed device inventory;
- latest explicit Diagnostics readiness;
- configured deadline;
- client/server availability with observation time and authority;
- two latest operations grouped by operation;
- local queue summary;
- Markdown/CSV snapshot export;
- link to Audit.

It must distinguish:

```text
CURRENT CONFIGURATION
LAST OBSERVED HEALTH
LIVE AVAILABILITY NOT CHECKED
```

Device count and per-device sequence claims must expose observation source and
time. “Next producer sequence” must not be confused with an account download
cursor or acknowledgement boundary.

### Audit

Audit owns durable operation history and causal detail:

- selected/current action result;
- chronological operations of every explicitly supported kind;
- success, rejection, failure, indeterminate, and unknown;
- filters by kind, device, state, and time;
- one expandable causal record per operation;
- MKS/native sanitized events;
- Markdown operation and period exports.

Initial scope should remain local durable audit for the installed client.
Hosted cross-device account-wide audit is a separate authorization.

---

## 10. Export Contract

Markdown is the primary investigation format because it preserves nested
causality. CSV is optional for flat System Health summaries and filtering.

Suggested sanitized exports:

```text
system-health-<device>-<timestamp>.md
system-health-<device>-<timestamp>.csv
audit-<device>-<period>.md
audit-operation-<fingerprint>.md
```

Markdown should contain:

1. schema version;
2. sanitized environment and provenance;
3. health snapshot;
4. device observations;
5. queue/cursor state;
6. operation index;
7. truth-plane summary per operation;
8. causal event sequence;
9. primary member, cascade, wrappers, branches, contradictions, and unknowns;
10. optional related ERR/corrective-history references.

Exports should shorten or pseudonymize account/device identifiers by default.
Secrets, tokens, provider credentials, and unnecessary personal data are
prohibited.

---

## 11. Frozen and Deferred Boundaries

Unless fresh D/E/F explicitly authorize otherwise:

- no Sync semantics redesign;
- no weakening of acknowledgement or success invariants;
- no ERR identifiers as runtime events;
- no hosted cross-device audit;
- no provider-side observability subsystem;
- no automatic recovery or retry;
- no source-of-truth reconstruction inside UI widgets;
- no independent Settings/Audit/export projectors;
- no unrelated UI aesthetic overhaul;
- no provider, enrollment, or account mutation;
- no live Sync in Codex validation;
- no assumption that R07 is required merely because this file exists.

Later UI polish—spacing, animation, visual hierarchy, typography, and unrelated
navigation refinement—should remain outside the causal-correctness round unless
needed for accessibility or truthful presentation.

---

## 12. Activation Outcomes

R07 causal implementation becomes a strong candidate when a controlled assay
produces one or more of:

- wrapper-only evidence hides the failing inner stage;
- events from distinct operations cannot be reliably separated;
- the primary causal member cannot be selected from surviving evidence;
- downstream consequences visually or semantically compete with their cause;
- independent diagnostic/UI failures overwrite transaction truth;
- same-plane evidence contradicts itself;
- durable evidence is insufficient after restart;
- screenshots cannot establish the required plane authority;
- Settings, Closure, diagnostics, and reports disagree about one operation.

R07 may remain postponed when:

- the assay succeeds with coherent authoritative evidence; or
- a failure identifies one specific actionable defect without ambiguity.

In the latter case, correct the proven defect first unless Main determines that
the evidence system itself blocks safe correction.

---

## 13. Minimal `[M]` Seeding Prompt

Copy the prompt below into a future Main Chat only after the human decides to
reassess or activate R07:

```text
You are the Main Chat [M] recovering the postponed Markei R07 proposal.

Repository: gus-i-gu/markei
Required branch: resolve from the current human instruction; do not assume the
historical branch or SHA recorded elsewhere.

Begin with hierarchical recovery:

1. verify the required branch and current remote HEAD;
2. read AGENTS.md;
3. read documentation/sketch_notebook/INDEX.md;
4. invoke the current Main initializer from
   documentation/sketch_notebook/methodology/PROMPT_COLLECTION.md;
5. recover current Main state from 00_PROJECT_STATE.md and
   06_SESSION_SCHEME.md;
6. read current operational, didactic, and design checkpoints;
7. read documentation/ALT_DEV.md;
8. inspect current A/B/C, J, relevant G/H/I, REC_DIAGNOSTICS.md, and
   task-named R05/R06/R07 evidence only as needed;
9. inspect source only where implementation truth or drift remains uncertain.

Treat ALT_DEV.md as a non-authoritative proposal. Reconcile it against current
human direction, notebook authority, live-assay evidence, and repository truth.
Do not assume R07 is activated.

Mission:

- decide whether R07 is now required, useful-but-postponed, or superseded;
- reassess whether the existing R05 truth planes are sufficient;
- define the minimum causal contract, durable-state ceiling, instrumentation,
  shared projector, Audit/export scope, and Settings/System Health projection;
- preserve cascade, branch, wrapper, contradiction, and unknown semantics;
- preserve transaction, cursor, acknowledgement, MKS/ERR, sanitization, and
  no-live-Sync invariants;
- separate GCM03 correctness from later UI refinement;
- stage full Codex-ready D_OPS_STAGE.md, E_DDC_STAGE.md, and F_DSN_STAGE.md only
  if implementation is explicitly authorized;
- then provide one Codex seeding prompt pinned to the verified staging HEAD,
  exact writable/prohibited paths, validation, report terminals, and
  publication rules.

If implementation is not authorized, do not replace D/E/F. Produce an R07
assessment and the exact remaining activation checkpoint instead.

Do not execute Sync, Retry, Query, Recovery, Enroll, provider mutation,
database repair, installation, or preserved-client mutation.

Finish with:

R07_STATUS=REQUIRED | POSTPONED | SUPERSEDED | BLOCKED
R05_CAUSAL_MODEL_SUFFICIENT=YES | NO | CONDITIONAL
R07_IMPLEMENTATION_AUTHORIZED=YES | NO
D_E_F_STAGED=YES | NO
CODEX_PROMPT_READY=YES | NO
LIVE_SYNC_AUTHORITY=NONE
NEXT_HUMAN_CHECK=<one exact step>
```

---

## 14. Recovery Terminal

```text
ALT_DEV_PURPOSE=POSTPONED_R07_RECOVERY
R07_PRIMARY_PURPOSE=CAUSAL_AUTHORITY
R07_UI_PURPOSE=CAUSAL_PRESENTATION
CASCADE=REQUIRED_PATH_PROPAGATION
BRANCH=INDEPENDENT_SUBSYSTEM_OUTCOME
FIRST_TIMESTAMP_IS_ROOT=NO
WRAPPER_IS_ROOT_BY_DEFAULT=NO
SAME_PLANE_CONTRADICTION_PROHIBITS_SUCCESS=YES
MISSING_EVIDENCE=UNKNOWN
UI_AND_EXPORT_SHARE_ONE_PROJECTOR=YES
HOSTED_ACCOUNT_WIDE_AUDIT=DEFERRED
R07_IMPLEMENTATION_AUTHORIZED=NO
LIVE_SYNC_AUTHORITY=NONE
```

---

## 15. 2026-07-30 Schedule Reconciliation — Cycle 11 and Cycle 12

This appendix is append-only. It preserves the original R07 capsule and records
new human/Main schedule authority without converting this proposal into
implementation authority.

### 15.1 Human schedule decision

The former Cycle 10 GCM04 residual is postponed intact. It is no longer a Cycle
10 closure requirement and must not be activated during Cycle 11.

The controlling forward schedule is:

```text
C11
  product-surface and UX development
  mandatory Settings
  mandatory Audit replacing the Closure navigation page
  functional Analytics
  responsive visual recomposition from the five archived target PNGs

C12-PHASE01
  fine tuning and polishing
  mostly UI/UX refinement after C11 materialization and human evidence

C12-PHASE02
  backend fine tuning and assays for multiple users
  deferred GCM04 authorization, resilience and lifecycle scope
  conditional R07 causal-authority/backend assessment
```

### 15.2 C11 relationship to this capsule

C11 may design and materialize Settings and Audit as mandatory product pages.
It may reuse current local diagnostic and operation truth through application
ports and one shared projection boundary.

C11 must not silently implement the postponed R07 engine. In particular:

- Audit may replace the user-facing Closure destination, but authoritative
  transaction, cursor, acknowledgement and diagnostic facts remain owned by
  their existing application/infrastructure boundaries;
- developer-only raw diagnostics, dangerous recovery actions and build
  provenance require an explicit Advanced/Support disposition rather than
  automatic exposure in ordinary Audit;
- Settings and Audit must not grow independent truth reconstruction;
- functional Analytics remains local/account-scoped product analysis, not
  developer telemetry or hosted behavioral tracking;
- no multi-Account, revocation, outage, retention, snapshot, rebootstrap or
  production assay belongs to C11.

The exact Settings/Audit boundary, safe migration of Closure actions, Analytics
definitions and responsive interaction contract require fresh C11 A/B/C
investigation before D/E/F.

### 15.3 C12-PHASE01

Phase 01 follows C11 implementation and validation. It owns measured refinement:

- spacing, hierarchy, typography and component consistency;
- compact/wide responsiveness;
- keyboard, focus, text-scale and screen-reader improvement;
- animation and transition polish where useful;
- human workflow friction found during C11 acceptance;
- visual regression repair against the accepted C11 product language.

It does not reopen Sync semantics or multi-user backend scope.

### 15.4 C12-PHASE02 / deferred GCM04

Phase 02 owns the backend fine-tuning and multiple-user assay family:

1. two Auth0 test users mapped to two isolated Markei Accounts;
2. ordinary Account isolation plus explicit cross-Account denial;
3. membership disablement, Device revocation, logout and token/JWKS lifecycle;
4. outage, timeout, offline queue and exact-once recovery;
5. retention, snapshot, fresh bootstrap and stale-device rebootstrap;
6. reproducible Render/Auth0/Neon migration, secret, deployment and rollback
   operations;
7. conditional R07 causal authority, shared projector, local Audit durability
   and sanitized export only when reassessment justifies materialization.

The second user/Account is required only for the live cross-Account isolation
assays. A second Auth0 tenant, Render account, Neon project or physical device
is not required. A disposable Neon branch/database and disposable client
profile remain strongly preferred.

### 15.5 Schedule terminal

```text
C10_GCM04=DEFERRED_UNSTARTED
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
C11=PREPARED_FOR_A_B_C_INVESTIGATION
C11_SETTINGS=MANDATORY_PAGE
C11_AUDIT=MANDATORY_PAGE_REPLACING_CLOSURE_NAVIGATION
C11_ANALYTICS=FUNCTIONAL_LOCAL_PRODUCT_PAGE
C11_REFERENCE_SET=C09_S02_TARGETS_01_THROUGH_05
C12_PHASE01=UI_UX_FINE_TUNING_AND_POLISHING
C12_PHASE02=BACKEND_FINE_TUNING_AND_MULTI_USER_ASSAYS
C12_PHASE02_INCLUDES_GCM04=YES
R07_IMPLEMENTATION_AUTHORIZED=NO
GCM04_LIVE_ASSAY_AUTHORIZED=NO
LIVE_SYNC_AUTHORITY=NONE
```
