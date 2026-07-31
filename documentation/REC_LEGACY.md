# REC_LEGACY — Cycle 10 cohesive track record

> Status: closed historical and observational record
> Authority: Main Chat [M] reconciliation of Cycle 10 evidence
> Repository: gus-i-gu/markei
> Branch: grm-guarded-provisioning-20260727
> Covered interval: 2026-07-23 through 2026-07-30
> Accepted implementation boundary: 97cec7f733926f669d2a844feb2b5e6e0b7e6bce
> GCM03 closure publication: 05e630cfe04aa03846bc635c524278d4fa9b7c39
> Final Cycle 10 documentation reconciliation: ec8953fbea4e9a80a712118665c2549a4d21528b
> Supersedes as a recovery surface: the former diagnostic assay file and J Legacy_Progress
> Mutation authority: none; corrections are append-only and must preserve prior evidence

## 1. Purpose

This file is the single historical recovery surface for Cycle 10.

It consolidates:

- the sanitized client, Render, provider, build, and human-assay evidence formerly distributed across Records 001–021;
- the Main-stage chronology formerly retained under J Legacy_Progress;
- the transition from early hosted-readiness ambiguity to same-Device proof and then reciprocal two-Device convergence;
- the corrective R01–R05 line and its exact evidence ceiling;
- the final scheduling decision that closed Cycle 10 at GCM03 and deferred GCM04.

It is a track record, not a runtime diagnostic registry, active staging packet, permanent-domain canon, or command to operate clients or providers.

Current truth must be recovered first from Main-root continuity and the Operational, Didactic, and Design checkpoints. This file is used when exact Cycle 10 chronology, supersession, or evidence provenance is needed.

## 2. Recording and interpretation rules

- Preserve only sanitized fingerprints and bounded observations.
- Never store passwords, tokens, cookies, authorization headers, connection strings, complete private URLs, full Account or Device identifiers, or purchase request bodies.
- Distinguish client declaration, Render lifecycle, provider state, source/tests, build evidence, and human observation.
- A readiness check is not ordinary Sync.
- A pre-result declaration is not a terminal failure.
- A trusted provider response is not erased by a later local diagnostic-persistence failure.
- Current action, newest ordinary-Sync result, and older history are separate surfaces.
- Read-only provider procedures end in rollback unless an explicitly authorized operation owns the mutation.
- Historical authorization is consumed. Nothing in this record authorizes Sync, Retry, Recovery, Query, Enroll, provider mutation, credential inspection, source modification, or production action.

## 3. Cycle 10 objective and final boundary

Cycle 10 established bounded hosted coordination for Markei’s offline-first local truth.

The accepted terminal is:

~~~text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
PRODUCT_NATURAL_IDENTITY_MERGE=PASS
CLIENT_QUEUES_FINAL=0_0_0_0_BOTH
IDEMPOTENT_REPEAT_PER_DEVICE=PASS_CLIENT_RENDER
PRODUCTION_ACCEPTANCE=ABSENT
GCM04=DEFERRED_TO_C12_PHASE02
R07_IMPLEMENTATION_AUTHORIZED=NO
LIVE_SYNC_AUTHORITY=NONE
PROVIDER_MUTATION_AUTHORITY=NONE
~~~

The boundary proves reciprocal Windows/Android convergence for two enrolled Devices on one Account in development. It does not prove a production lifecycle, multiple-Account isolation, revocation, outage recovery, retention, snapshot, or rebootstrap.

## 4. Cohesive progression

### 4.1 Guarded provider foundation

The Cycle 10 provider work began as guarded development-only coordination. The human-facing GRIMOIRE route was converted into an indexed operational chain:

~~~text
human selects one named procedure
→ launcher validates local prerequisites and target role
→ committed non-secret coordinates identify the environment
→ secret input remains masked and local
→ pinned PostgreSQL tooling enforces TLS and channel binding
→ SQL verifies role, database, fixture, and invariant
→ mutation is explicit; read-only evidence rolls back
~~~

Gate 02 established account-cursor provisioning and a reviewable execution route. The five-file reconciliation then separated concise human guidance, scripts, coordinates, database-management queries, and check procedures. Later GRM, General Scripts, NS coordinates, and DB management refactors clarified that scripts perform operations while documentary files explain them.

The hosted pre-Sync gate established a live development service and a bounded readiness route. Dependency and deployment defects were corrected before ordinary Sync was treated as eligible evidence. Provider role, database, TLS, ownership, and fixture checks remained environment-scoped; no production claim followed.

### 4.2 Diagnostic system formation

Early UI evidence showed that one flat “last result” surface could combine unrelated meanings: readiness, prior Sync, local recovery candidates, and transport uncertainty. The diagnostic tightening line therefore established:

- one runtime-owned diagnostic catalogue;
- grouped operation lifecycles;
- current-action and historical separation;
- source, operation, phase, outcome, local-mutation, provider-contact, trusted-response, and correlation fields;
- distinct blocked, not-applied, applied, duplicate-equivalent, and unknown outcomes;
- safe presentation rules that never convert an unknown provider outcome into a retry permission automatically.

The investigation-time System Diagnosis catalogue was a staging inventory. Its stable definitions were materialized into the runtime registry and generated readable projection. It is not reproduced here because that would create a second registry.

Current diagnostic ownership:

| Role | Owner |
| --- | --- |
| Runtime definitions | contracts/shared_beta/diagnostics_v1/diagnostics.registry.json |
| Schema and generation contract | contracts/shared_beta/diagnostics_v1/diagnostics.schema.json and its README |
| Generated readable projection | documentation/ERR_DIAGNOSTICS.md |
| Cycle 10 observations and chronology | this file |
| Domain interpretation | permanent Operational, Didactic, and Design memory |

### 4.3 GCM02 — hosted same-Device proof

Records 001–008 separated readiness, diagnostics, authentication, enrollment, queue truth, and ordinary Sync. Records 009–012 then established exact hosted binding, a clean provider baseline, one controlled same-Device transition, and correlated Render completion.

The accepted same-Device chain was:

~~~text
fresh token and exact Device binding
→ clean provider baseline
→ one local purchase.registered member
→ one ordinary Sync
→ local queue drains
→ provider submission, event, and acknowledgement appear once
→ cursor and Device sequence remain consistent
→ Render correlates authenticated upload, download, and acknowledgement HTTP 200
~~~

GCM02 closed only at hosted same-Device development scope. Second-Device convergence remained explicitly unproved.

### 4.4 GCM03 — two-Device preparation and contradiction

Record 013 froze the Windows candidate member without repeating the accepted provider transition. Records 014–017 established Android build provenance, runtime Closure parity, authentication, durable enrollment after restart, exact hosted binding, and a clean two-Device provider baseline.

The first reciprocal assay exposed two distinct failures:

- Android accepted trusted upload/download responses but local inbound apply encountered a Product natural-identity conflict;
- Windows received a trusted download response but ended with an unclassified local terminal and no acknowledgement.

The failures proved that provider acceptance, local apply, cursor durability, acknowledgement, and diagnostic persistence had to remain independent evidence planes. They did not invalidate trusted server responses and did not authorize blind replay.

### 4.5 R01–R05 corrective line

R01 classified the observed failure chain and isolated the source boundaries. R02 improved immediate behavior but did not complete the evidence model. R03–R05 then progressively corrected:

- Product reference reconciliation by stable natural identity;
- Purchase-page Product selection independently of the Sync defect;
- atomic local page application with typed translation of recoverable conflicts;
- preservation of trusted provider responses;
- separation of business apply, facts/inbox/cursor durability, acknowledgement, and diagnostic-persistence outcomes;
- acknowledgement only after durable local apply and cursor progress;
- cumulative evidence that does not collapse distinct transactions into one mutation field;
- replay and duplicate-equivalent handling without duplicating facts.

Automated tests and builds validated the correction line before preserved-client human acceptance. Automated success was never treated as reciprocal convergence by itself.

### 4.6 Preserved-client closure

Record 021 reconciled the final preserved-client assay:

- both clients displayed the same source revision and source-tree identity;
- the Windows-originated member converged to Android;
- one controlled Android-originated Purchase converged to Windows;
- the Product that previously conflicted converged as one Catalogue Product;
- matching History projections retained the intended five Purchase rows;
- no duplicate Product, Purchase, or Purchase Item was observed;
- both queues settled at 0/0/0/0;
- Android next Device sequence was 3 and Windows next Device sequence was 4;
- no Retry, Recovery, Query, repeated Enroll, or repair action was needed.

One empty-queue ordinary Sync was then executed on each Device. Two distinct operations completed authenticated event download and acknowledgement with HTTP 200. No submission route appeared in the supplied no-op Render window, queues remained empty, and projections remained stable.

A fresh final transactional provider-table recount was not collected. The closure therefore rests on preserved-client evidence, correlated Render evidence, and the previously established provider baseline; it does not claim exact final provider row counts after the golden repeats.

## 5. Normalized assay ledger — Records 001–021

Each record appears once. The ledger preserves purpose, material observation, disposition, and evidence ceiling without repeating full button inventories or unchanged safety guards.

| Record | Purpose and material observation | Disposition | Evidence ceiling |
| --- | --- | --- | --- |
| 001 | Pre-action Windows baseline showed readiness failed-work-needs-review, earlier hosted readiness, two failed local candidates, and no new action. | Baseline accepted; flat UI meaning was ambiguous. | Client screenshot only. |
| 002 | One hosted check ended timeout-before-response while older recovery cards remained visible. | Transport outcome unknown; server failure not inferred. | No matching server terminal. |
| 003 | Post-deployment hosted readiness returned HTTP 200 while failed candidates remained untouched. | Readiness passed; ordinary Sync and recovery still unproved. | Server correlation incomplete. |
| 004 | Read-only Refresh diagnostics, Status, and Query preserved queue and sequence state. | Consolidation into one Diagnostics surface justified. | Client projection; no provider equivalence claim. |
| 005 | Cold hosted check timed out; warm repeat returned ready/HTTP 200. | Pass after warm-up with cold timeout preserved as unknown. | Readiness only, not Sync. |
| 006 | Empty-queue ordinary Sync completed with grouped authentication, binding, queue, download, acknowledgement, and terminal phases. | Client-UI Sync control passed; no implicit recovery. | Render/provider correlation not included. |
| 007 | Consolidated Diagnostics exposed distinct subchecks and operation history; a current-action card still falsely reported historical collapse. | DIAG-01 passed with bounded presentation defect. | Signed-out client/UI scope. |
| 008 | After one enrollment and restart, authentication and Device enrollment persisted; current-action correction displayed MKS-OBS-001 applied. | Durable enrollment and DIAG-01 correction passed at client scope. | Exact hosted binding/provider state still open. |
| 009 | Fresh token, hosted identity, exact Device binding, and rollback provider baseline all passed with empty hosted history. | ST08 read-only reconciliation passed. | Prior client Sync was not corroborated by the replacement provider. |
| 010 | Fresh Windows preflight showed authenticated/enrolled state, empty queue, and local/provider next-sequence alignment. | ST09 preflight passed; a controlled member was still required. | No mutation or second Device. |
| 011 | One controlled purchase.registered member synced exactly once; queue drained and provider counts/cursor/sequence matched. | Same-Device transition passed. | Final Render lifecycle still pending. |
| 012 | Render correlated authenticated upload, download, and acknowledgement HTTP 200 for the same operation. | GCM02 closed at hosted same-Device scope. | Second-Device convergence absent. |
| 013 | Windows held one pending candidate at sequence 2 with no failed, uploading, or unknown residue. | GCM03 Windows candidate preflight passed. | No repeat provider transition. |
| 014 | Android artifact provenance, launcher target, Closure parity, authentication, and clean pre-enrollment state were observed. | Bounded Android runtime/authentication pass. | Same-Account binding remained open. |
| 015 | Android cold hosted check timed out and later warm check returned HTTP 200. | Client readiness passed after cold-start warm-up. | No enrollment or ordinary Sync proof. |
| 016 | Android enrollment and authentication survived restart; queue remained 0/0/0/0 and next sequence 1. | Durable enrollment passed at client scope. | Exact hosted binding still required. |
| 017 | Auth0 contract, exact active Android Device row, two-Device Account fixture, and rollback provider baseline passed. | Read-only exact-binding/two-Device baseline passed. | No Android event or convergence yet. |
| 018 | Preserved Android installation retained data; Purchase selection, review, and registration passed without duplicate Product. | R02 human acceptance preflight passed. | Sync not yet assessed. |
| 019 | Android upload and download received trusted HTTP 200 responses; local apply hit a Product natural-identity conflict before acknowledgement. | Typed inbound conflict reproduced and contained. | Provider response trusted; local convergence failed. |
| 020 | Windows upload/download reached trusted server acceptance, but local apply/cursor result was not durably classified and no acknowledgement followed. | Corrective R03–R05 line required. | Local mutation, facts/inbox/cursor remained unknown. |
| 021 | Reciprocal Windows/Android convergence, singular Product identity, drained queues, and one no-op repeat per Device were observed. | GCM03 and MVP Sync passed at two-Device/one-Account development scope. | No fresh final provider-table recount or production proof. |

## 6. Accepted stable conclusions

### 6.1 Authority and topology

- Local SQLite remains authoritative for Product and Purchase facts.
- Hosted PostgreSQL is a bounded coordination channel, not general application storage.
- Account, membership, Installation, and Device are distinct identities and responsibilities.
- Same-Device hosted proof and reciprocal two-Device convergence are different evidence topologies.
- Client, Render, and provider evidence corroborate one another but do not substitute for one another.

### 6.2 Identity and convergence

- Product user code, local UUID, event identity, and natural Product identity are not interchangeable.
- Exact natural identity owns merge/equivalence decisions during remote apply.
- Duplicate-equivalent is an idempotent success classification, not a failure.
- Provider acceptance does not prove local apply, cursor durability, acknowledgement, or diagnostic persistence.

### 6.3 Transactions and acknowledgement

- Business apply and cursor progress must become durable before acknowledgement.
- Diagnostic persistence is separately contained and cannot roll back an accepted business transaction.
- A trusted response remains evidence even when later local diagnostic work fails.
- Retry and recovery decisions depend on the owning outcome plane; they cannot be inferred from a flat page label.

### 6.4 Evidence and safety

- Build and automated tests prove materialization and regression coverage, not human-platform acceptance.
- Human screenshots prove bounded presentation and assay results, not provider rows they do not expose.
- Read-only provider evidence must be scoped, sanitized, and rollback-backed.
- Development acceptance cannot be silently promoted to production acceptance.

## 7. Superseded and rejected conclusions

The following earlier states remain historically explainable but are not current truth:

| Earlier state or assumption | Final disposition |
| --- | --- |
| One flat Last result can represent readiness, Sync, recovery, and history. | Superseded by operation-aware diagnostics and separate current/history surfaces. |
| A readiness HTTP 200 proves ordinary Sync. | Rejected. |
| Every unknown pre-result row is an error. | Rejected; later result-bearing phase determines the outcome. |
| Provider HTTP success proves local convergence. | Rejected. |
| A later diagnostic failure erases a trusted response. | Rejected. |
| A conflicting Product should be duplicated or selected only by local UUID/code. | Rejected; exact natural identity reconciles it. |
| Acknowledgement may precede durable local apply/cursor progress. | Rejected. |
| GCM02 proves inter-device convergence. | Rejected; it proves hosted same-Device behavior only. |
| GCM03 proves production resilience or lifecycle completeness. | Rejected. |
| Cycle 10 must remain open until GCM04. | Superseded by explicit human/Main schedule; GCM04 moved to C12-PHASE02. |
| R07 should activate merely because a causal-backend capsule exists. | Rejected for Cycle 11; conditional reassessment remains in C12-PHASE02. |

## 8. Validation and provenance map

| Evidence family | Material examples | What it proves |
| --- | --- | --- |
| Client/UI | Closure, Diagnostics, Catalogue, History, queue and sequence projections | Bounded local state and human-visible behavior |
| Local SQLite | queue, attempt, facts/inbox/cursor and Device-sequence checks | Durable local state and transaction partition |
| Render | correlated authenticated upload, download, acknowledgement, and no-op windows | Server ingress and request lifecycle |
| Provider | exact binding, fixture/cardinality, cursor and sequence checks under rollback | Hosted state at the observed checkpoint |
| Source/tests | R03–R05 implementation and focused/full suites | Implemented invariants and regression coverage |
| Builds | Windows release and Android debug artifacts | Buildability and artifact lineage |
| Human assay | preserved two-client reciprocal convergence and no-op repeats | Practical development-scope acceptance |

Key anchors:

| Purpose | Commit |
| --- | --- |
| Accepted Cycle 10 implementation boundary | 97cec7f733926f669d2a844feb2b5e6e0b7e6bce |
| GCM03 closure publication | 05e630cfe04aa03846bc635c524278d4fa9b7c39 |
| Permanent-memory reconciliation inspected through | 526e0de6e294c5fb969d8ee1f35e6eb53914902b |
| Final Main Cycle 10 reconciliation | ec8953fbea4e9a80a712118665c2549a4d21528b |

Intermediate commit identities, detailed diffs, and deleted staging formulations remain recoverable from Git history. They are not duplicated here because the semantic progression and accepted boundary above own current historical recovery.

## 9. Permanent-memory extraction

Cycle 10 has been absorbed into all four semantic layers of each permanent domain.

| Domain | Historical | Canonical | Derived | Checkpoint |
| --- | --- | --- | --- | --- |
| Operational | operational/11_OPERATIONAL_RECORD.md | operational/12_OPERATIONAL_MODEL.md | operational/04_TODO.md | operational/10_OPERATIONAL_STATE.md |
| Didactic | didactics/13_LECTURE_REGISTER.md | didactics/02_KANBAN.md | didactics/07_GLOSSARY.md | didactics/08_CONCEPT_MAP.md |
| Design | design/03_DECISION_LOG.md | design/01_ARCHITECTURE.md | design/14_MODEL_OVERVIEW.md | design/09_DESIGN_STATE.md |

Main-root ownership:

- documentation/sketch_notebook/00_PROJECT_STATE.md — accepted global state;
- documentation/sketch_notebook/05_SESSION_LOG.md — global observational chronology;
- documentation/sketch_notebook/06_SESSION_SCHEME.md — forward recovery frame;
- documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md — current C11 staging/handoff only.

No new Cycle 10 domain registration round is required. Didactic maturity states remained unchanged because direct learner-mastery evidence was not produced.

## 10. Deferred residuals

The following were deliberately deferred rather than omitted:

- two-Account isolation and cross-Account denial;
- disabled membership denial and Device revocation;
- token/JWKS rotation and expired-token behavior;
- outage, timeout, malformed-response, and acknowledgement-uncertainty recovery;
- retention, snapshot, event-tail bootstrap, and stale/replacement Device rebootstrap;
- production migration ownership, deployment, observability, rollback, backup, and lifecycle acceptance;
- deferred GCM04 and conditional R07 reassessment.

These belong to C12-PHASE02 unless a later human/Main decision changes the schedule.

## 11. Cycle 11 handoff boundary

Cycle 10 closed the bounded synchronization objective. It did not authorize Cycle 11 implementation by itself.

The accepted forward schedule is:

~~~text
C11-PH01
  shared visual system and five core-page convergence

C11-PH02
  deterministic local/account-scoped Analytics

C11-PH03
  mandatory Settings and Audit
  complete Closure capability disposition

C12-PHASE01
  UI/UX fine tuning and polishing

C12-PHASE02
  backend fine tuning, multiple-user assays, deferred GCM04
  conditional R07 reassessment
~~~

C11-PH01-S01 established the reversible responsive shell, presentation tokens/primitives, and first Home/Lists recomposition. C11-PH01-S02 is the current five-page visual-convergence unit under its own synchronized D/E/F authority.

## 12. Final historical terminal

~~~text
REC_LEGACY_ROLE=CYCLE10_COHESIVE_TRACK_RECORD
RECORDS_001_021=NORMALIZED_COMPLETE
J_LEGACY_PROGRESS=EXTRACTED_AND_RESTRUCTURED
DUPLICATE_DIAGNOSTIC_REGISTRY=ABSENT
CYCLE10_PERMANENT_INFORMATION=EXHAUSTED
CYCLE10_DOMAIN_RERUN=NOT_REQUIRED
GCM04=DEFERRED_TO_C12_PHASE02
R07_IMPLEMENTATION_AUTHORIZED=NO
CURRENT_FORWARD_UNIT=C11_PH01_S02
LIVE_OPERATION_AUTHORITY=NONE
PROVIDER_MUTATION_AUTHORITY=NONE
~~~
