# LEGACY_RECONCILIATION

> Status: Provisional archived Main staging
> Authority: Human-supervised Main Chat
> Scope: Cycle 08 acquired-documentation review preserved for later reconsideration
> Source: `[M]_STAGE/J_[M]_STAGE.md`
> Archived: 2026-07-12
> Canonical: No
> Expiry condition: Main/human reconciliation decides whether this material is promoted, absorbed, superseded, or deleted.

---

# J_[M]_STAGE

> Cycle: 08
> Status: Active Main methodology-revision staging
> Branch: `cycle-08-shared-client-product-beta`
> Authority: Human-supervised Main Chat
> Scope: Domain documentation review; no application implementation authority

---

# Cycle 08 Methodology Review — Didactic Domain

## 1. Review purpose

Review the Didactic permanent-memory folder before Cycle 08 product work and stage a bounded documentation-improvement proposal without modifying Didactic permanent files.

Inspected:

- `didactics/02_KANBAN.md`;
- `didactics/07_GLOSSARY.md`;
- `didactics/08_CONCEPT_MAP.md`;
- `didactics/13_LECTURE_REGISTER.md`;
- current methodology contracts governing canonical, derived, checkpoint, and observational knowledge.

## 2. Current semantic assignment

| File | Assigned role | Current condition |
| --- | --- | --- |
| `02_KANBAN.md` | Canonical concept identity and evidence-based maturity | Concept structure is strong; historical implementation reconciliation has accumulated after the canonical register |
| `07_GLOSSARY.md` | Derived learner-facing terminology | Definitions are useful; release/project evidence retrieval sections make it partly checkpoint-like |
| `08_CONCEPT_MAP.md` | Compact Didactic checkpoint | Correct role, but the latest segment is tied to Cycle 07 Sprint 05 and must be refreshed for Cycle 08 |
| `13_LECTURE_REGISTER.md` | Append-oriented observational learning history | Correctly carries chronological evidence; remains the proper home for cycle-specific learning observations |

## 3. Accepted strengths

1. The four-file Domain Symmetry mapping remains valid.
2. KANBAN IDs provide stable concept identity and should not be renumbered during pruning.
3. The marker families `&&&`, `&&%`, `&%%`, and `%%%` remain useful.
4. The distinction between project evidence and learner mastery is explicit and should remain canonical.
5. No maturity transition is inferred from implementation, tests, host execution, or file existence.
6. The concept map already functions as the cheapest Didactic recovery surface.
7. The Lecture Register preserves evidence chronology without pretending that events define current truth.
8. Cycle 07 introduced a useful cross-language learning spine spanning Python, Dart, Flutter, local persistence, identity, synchronization preparation, and analytics.

## 4. Detected drift

### DDT-01 — Canonical/history mixing in `02_KANBAN.md`

The canonical register contains stable concepts followed by Cycle 07 Sprint 03–05 implementation reconciliations. These appended sections are valuable evidence, but their primary semantic role is observational. Their continued growth would make the KANBAN a combined concept canon and implementation history.

Classification: semantic-role drift and recovery-cost drift.

Provisional resolution:

- keep stable concept definitions, IDs, dependencies, statuses, and concise evidence references in KANBAN;
- keep maturity-changing evidence with the affected concept;
- route detailed cycle execution narratives to `13_LECTURE_REGISTER.md`;
- expose only the latest maturity/evidence boundary through `08_CONCEPT_MAP.md`;
- do not renumber or silently change statuses.

### DDT-02 — Glossary/checkpoint overlap in `07_GLOSSARY.md`

The Glossary contains concise derived definitions, but `Sprint 05 Current-Evidence Retrieval` describes current implementation and validation boundaries. That section behaves more like checkpoint material.

Classification: derived/checkpoint overlap.

Provisional resolution:

- retain concise learner-facing terms and references to KANBAN IDs;
- remove or condense cycle-specific evidence summaries after their information is safely represented in the checkpoint and Lecture Register;
- ensure definitions do not make future synchronization or platform behavior sound implemented.

### DDT-03 — Stale checkpoint

`08_CONCEPT_MAP.md` correctly declares Cycle 07 Sprint 05 evidence and limits, but the current active phase is Cycle 08 Sprint 01.

Classification: expected checkpoint staleness at a cycle boundary.

Provisional resolution:

Refresh it after the Didactic revision is approved so it states:

- protected Cycle 07 learning baseline;
- Cycle 08 product-language investigation;
- concepts needed for Catalogue, Product similarity, Store identity, staged Purchase review, atomic registration, detailed History, responsive behavior, and personal price comparison;
- existing maturity unchanged until explicit learner evidence exists;
- Cycle 09 synchronization concepts remain deferred.

### DDT-04 — Prospective language presented too concretely

Some canonical/derived entries describe authenticated API, server cursors, central catalogue behavior, and TypeScript parity in present-tense project-usage language although those remain Cycle 09 work.

Classification: evidence-state wording drift.

Provisional resolution:

Use explicit labels such as:

- current local implementation;
- provisional contract;
- scheduled Cycle 09 behavior;
- unimplemented example.

Do not delete the concepts; correct their evidence framing.

### DDT-05 — Category pressure in `&%%`

The project-implementation category now includes architecture, domain/value models, synchronization preparation, analytics, and product concepts. It remains usable, but navigation cost is increasing.

Classification: information-architecture pressure, not yet a structural gap.

Provisional resolution:

- retain the marker and IDs;
- add internal thematic navigation within the existing KANBAN rather than creating a new file or marker family;
- evaluate whether Product/UI concepts belong as extensions of existing concepts before introducing new IDs.

## 5. Cycle 08 Didactic investigation boundary

Candidate concepts or distinctions for Didactic Chat to investigate—not yet canonical entries:

- Catalogue versus current Purchase entry;
- visible Product identity versus internal record identity;
- exact duplicate versus advisory similarity;
- suggestion versus automatic merge;
- packaged amount, package count, purchased amount, and normalized amount;
- Store identity versus branch/location description;
- staged Item versus registered immutable Purchase Item;
- draft validation versus atomic commit;
- success acknowledgement versus duplicate retry;
- History fact versus derived price comparison;
- unit-price normalization and comparison interval;
- personal price change versus official/general inflation;
- responsive composition versus device-specific design;
- empty, validation, failure, recovery, and retry states;
- export, backup, migration, and synchronization as distinct boundaries.

These are candidates until Didactic investigation classifies identity, prerequisites, overlap, learner need, and evidence.

## 6. Proposed bounded revision unit

If the human approves materialization, revise only the four Didactic permanent files:

1. `02_KANBAN.md`
   - preserve all concept IDs and statuses;
   - separate stable canonical content from detailed cycle narratives;
   - retain concise evidence pointers and maturity rationale;
   - correct present-tense wording for deferred behavior;
   - add thematic navigation without new files.

2. `07_GLOSSARY.md`
   - preserve concise definitions;
   - remove checkpoint-like evidence narration after reconciliation;
   - distinguish implemented local behavior from future synchronization examples;
   - keep every term traceable to a canonical concept or explicitly provisional vocabulary.

3. `08_CONCEPT_MAP.md`
   - refresh as the Cycle 08 Didactic checkpoint;
   - expose current maturity, evidence limits, Cycle 08 investigation spine, next learner questions, and recovery pointers;
   - remain compact and avoid historical narration.

4. `13_LECTURE_REGISTER.md`
   - preserve all existing observations;
   - append a Cycle 08 domain-revision observation;
   - absorb references to detailed Cycle 07 evidence removed from canonical/derived surfaces;
   - remain append-oriented.

## 7. Non-goals

This revision must not:

- change KANBAN maturity without explicit learner evidence;
- renumber existing concepts;
- create a new Didactic file or marker family;
- select product architecture;
- claim Operational validation;
- rewrite observational history;
- implement Flutter UI or application behavior;
- activate synchronization, authentication, API, or Neon work;
- modify another domain or methodology file.

## 8. Validation gates

Before accepting the revision:

- every existing KANBAN ID remains present exactly once;
- every status change, if any, has explicit learner evidence—or no status changes occur;
- Glossary terms trace to KANBAN concepts or are marked provisional;
- Concept Map remains a compact current checkpoint;
- Lecture Register history is preserved and only appended;
- deferred Cycle 09 behavior is not phrased as implemented Cycle 08 behavior;
- no Didactic fact gains duplicate canonical ownership;
- diff is limited to the four Didactic files;
- methodology and application source remain unchanged.

## 9. Human decisions required

1. Should detailed Cycle 07 evidence paragraphs be removed from KANBAN after their observations are confirmed in the Lecture Register, or retained in a compressed evidence-history appendix?
2. Should the Glossary contain only stable terms, or may it keep a small explicitly labeled provisional-vocabulary section for the active cycle?
3. Should Cycle 08 product vocabulary create new KANBAN entries immediately after investigation, or first remain provisional in B/Concept Map until learner relevance is demonstrated?

## 10. Main recommendation

Proceed with a conservative Didactic pruning:

- preserve concept identity and maturity;
- relocate detailed evidence by semantic role;
- refresh the checkpoint;
- allow provisional Cycle 08 vocabulary without premature canonical promotion;
- defer new concept IDs until Didactic investigation establishes non-duplication and learner value.

Status: provisional Main staging. No Didactic permanent-memory mutation is authorized by this section alone.

---

# Didactic Domain Confrontation Prompt — Canon, Checkpoint, and Derived Consistency

> Status: Critical evaluation staged for human/Main review  
> Methodology basis: `METHOD_FOUNDATIONS.md`, `FLUX.md`, and `PROMOTION_RULES.md`  
> Evaluated surfaces: `02_KANBAN.md`, `08_CONCEPT_MAP.md`, and `07_GLOSSARY.md`  
> Excluded surface: detailed observational-history evaluation

## A. Methodological verdict on the prior J proposal

The prior staged proposal is directionally consistent with the methodology, but it requires three corrections before it can become materialization authority.

1. **Relocation is promotion-sensitive.** Moving text out of KANBAN is not mere pruning. The operation must first distinguish canonical concept evidence from observational narrative. Canonical maturity rationale and stable evidence boundaries cannot be removed solely because similar events appear in the Lecture Register.
2. **The checkpoint must be regenerated, not historically edited.** `08_CONCEPT_MAP.md` is refreshable derived knowledge. Its Cycle 07 state should be replaced by a compact Cycle 08 recovery surface rather than extended with another cumulative report.
3. **Glossary cleanup must be derivable.** A term may remain only when it derives from an identified canonical concept or is explicitly labeled provisional. “Useful wording” by itself is insufficient semantic ownership.

The staged proposal correctly preserves:

- unique canonical ownership;
- separation of promotion and materialization;
- learner evidence as the maturity gate;
- the four Didactic semantic roles;
- existing IDs and historical evidence;
- human/Main authority over the revision;
- the prohibition against inventing a new file merely to solve growth.

## B. Canonical-file evaluation — `02_KANBAN.md`

### B1. Canonical coverage inventory

The KANBAN currently owns **39 concepts**:

- 10 foundational-computing concepts;
- 5 language concepts spanning Python and Dart;
- 17 Markei/project concepts;
- 7 dependency, persistence, packaging, or framework concepts.

Current maturity distribution:

- Green: 0;
- Yellow: 13;
- Red: 26.

The register covers four historical learning concentrations:

1. Python/PySide6 application structure and persistence;
2. SQLite, packaging, installation, and resource lifetime;
3. Flutter/Dart shared-client modelling;
4. identity, local event preparation, future synchronization, and analytics.

### B2. Canonical strengths

- IDs are stable and distinct.
- Every concept has an explicit type marker.
- Definitions distinguish general meaning from Markei manifestation.
- Required/related concept fields make dependencies recoverable.
- Maturity is not promoted from implementation evidence alone.
- Stable Identity, Historical Integrity, raw/derived facts, dimensional quantity, minor-unit money, atomicity, and reusable Catalogue provide a strong basis for Cycle 08.
- The register explicitly distinguishes Dart immutability, append-only events, storage migration, protocol versioning, and framework composition.

### B3. Canonical deficiencies

#### CAN-01 — Canonical scope is implementation-led rather than learning-led

Many concepts entered because architecture or implementation introduced them. The register does not yet demonstrate why all 39 belong in the learner’s active curriculum, how often they were actually discussed with the learner, or which are presently necessary.

Critical question:

> Is the KANBAN a canonical register of concepts intentionally learned, or a canonical index of concepts encountered by the project?

The current file behaves partly as the second. The methodology and user-defined maturity system imply the first.

Required resolution:

- preserve encountered concepts;
- explicitly distinguish curriculum-active, reference-only, deferred, and learner-evidenced concepts without inventing maturity;
- do not delete concepts merely because they are currently inactive.

#### CAN-02 — Maturity has become structurally static

No concept is Green; 26 are Red. Multiple materialization cycles added evidence without changing maturity, correctly, because learner evidence was absent. However, a maturity system that never schedules or captures learner checks becomes archival classification rather than learning progression.

Required resolution:

- retain the strict evidence gate;
- define a lightweight learner-evidence capture route;
- identify a small active learning frontier per sprint;
- do not lower the Green/Yellow threshold to manufacture movement.

#### CAN-03 — Template fields impose false symmetry

Every entry uses Description, Formal Definition, Practical Example, Language Implementation, Project Implementation, Required Concepts, Related Concepts, Status, and Source. This is valuable for foundational concepts but sometimes forces language or implementation content into concepts where it is secondary or prospective.

Required resolution:

- keep a minimum canonical schema;
- allow “not applicable” or omit optional manifestation fields under an explicit schema rule;
- avoid speculative implementation language merely to fill a field.

#### CAN-04 — Present and future project truth are insufficiently separated

Authentication, Authorization, Eventual Consistency, Sync Protocol, cursor behavior, and TypeScript/API examples are legitimate concepts, but some Project Usage fields read as present behavior. Under Promotion Rules, this risks promoting planned architecture into canonical implementation implication.

Required resolution:

Every Project Implementation/Usage statement should classify itself as one of:

- evidenced current manifestation;
- provisional design example;
- scheduled future manifestation;
- general illustrative example.

#### CAN-05 — Cycle 08 product-learning coverage is incomplete

The existing canon can support Catalogue, atomic Purchase, responsive composition, history integrity, and analytics. It does not yet explicitly settle the learner-facing distinctions required for:

- exact duplicate versus advisory similarity;
- visible Product identity versus record identity;
- Product correction versus historical mutation;
- Store identity versus Store branch/location;
- draft Item versus registered Purchase Item;
- staged validation versus atomic commit;
- comparison fact versus interpretation;
- personal price change versus population-level inflation;
- responsive adaptation versus platform-specific interaction.

These are **coverage candidates**, not automatic new concepts. Some may be examples or extensions of existing IDs.

### B4. Canonical disposition test

For every existing or proposed concept, ask:

1. What stable knowledge object does this entry own?
2. Is that object already owned by another concept?
3. Is it foundational, language-specific, project-specific, or dependency/tool knowledge?
4. Is it curriculum-active, reference-only, or deferred?
5. What evidence established its present maturity?
6. Does its Project Implementation field state current evidence or future intention?
7. Can future work depend on this definition without reading cycle history?
8. Would removal lose accepted knowledge, or only duplicated narrative?

A concept passes canonical retention only when these questions have explicit answers.

## C. Checkpoint-efficacy evaluation — `08_CONCEPT_MAP.md`

### C1. Current efficacy

The checkpoint is semantically recognizable and answers most recovery questions:

- current evidence boundary;
- maturity state;
- distinctions to preserve;
- dependency spine;
- next learner questions;
- deeper recovery pointers;
- next authority boundary.

It therefore remains the correct Didactic entry point.

### C2. Current inefficiencies

- Its latest active content still describes Cycle 07 Sprint 05.
- It contains substantial execution detail that duplicates Operational/Main state.
- Its recovery pointers refer to B, H, and old J sections that were intentionally cleansed at Cycle 08 entry.
- It describes the prior post-Codex route rather than the current methodology-revision/product-definition route.
- At roughly 11.7k characters, it is not critically large, but it is longer than necessary for a low-token checkpoint.
- The “Current Truth” section includes platform facts beyond the minimum needed to recover learning state.

### C3. Checkpoint success criteria

A refreshed Cycle 08 checkpoint should answer in one bounded read:

1. Which concepts are currently active for learning?
2. What maturity is accepted, and on what learner evidence?
3. Which project evidence strengthens examples without changing maturity?
4. What distinctions are most liable to confusion now?
5. What is the Cycle 08 concept dependency spine?
6. Which vocabulary remains provisional?
7. What should Didactic Chat read next?
8. What is the next valid authority transition?

It should point outward for execution history instead of reproducing it.

### C4. Recommended checkpoint shape

```text
Current Didactic state
→ active learning frontier
→ accepted maturity summary
→ evidence-versus-mastery boundary
→ Cycle 08 distinctions
→ compact dependency spine
→ provisional vocabulary
→ next learner checks
→ recovery pointers
→ next authority boundary
```

The checkpoint should be refreshed as a present-state document, not appended as a new historical episode.

## D. Derived-consistency evaluation — `07_GLOSSARY.md`

### D1. Current consistency

The Glossary successfully translates many canonical concepts into concise learner-facing definitions and points back to KANBAN IDs. It preserves useful distinctions around platform evidence, identity, persistence, local queue preparation, and Flutter composition.

### D2. Derived inconsistencies

#### DER-01 — Incomplete derivation surface

The Glossary is not a systematic derivative of all 39 canonical concepts. This is not automatically wrong: a glossary may contain only retrieval-worthy terms. But the selection rule is implicit, so absence cannot be distinguished from accidental omission.

Required resolution:

Declare that a Glossary term is included when at least one condition holds:

- vocabulary is used across multiple project surfaces;
- wording is liable to confusion;
- a learner requested clarification;
- a current sprint depends on rapid retrieval.

#### DER-02 — Current-state evidence inside derived vocabulary

The Sprint 05 retrieval section mixes definitions with checkpoint-like evidence. This weakens the Glossary’s rebuildability and causes it to age with implementation state.

Required resolution:

- keep stable distinctions as definitions;
- move current evidence classification to the checkpoint;
- allow brief examples, but label them as examples rather than current global state.

#### DER-03 — Prospective examples risk independent truth

Definitions involving server acceptance, cursor download, authenticated accounts, or future APIs may sound like implemented Markei facts.

Required resolution:

Derived wording must preserve the canonical evidence label. It may simplify language, but it may not strengthen maturity or implementation status.

#### DER-04 — Possible duplication rather than derivation

Several Glossary sections reproduce substantial KANBAN “Project Usage” meaning. A derived term should optimize retrieval, not become a second canonical definition.

Required resolution:

Use a compact contract:

```text
Term
Canonical ID
One-sentence learner definition
Current evidence label, only when necessary
See canonical concept
```

### D3. Derived consistency test

For each Glossary entry, ask:

1. Which canonical ID owns the meaning?
2. Does the wording preserve that concept’s scope and evidence state?
3. Does the entry introduce any rule absent from KANBAN?
4. Is this term needed for retrieval or merely copied?
5. Will it remain correct if the implementation changes?
6. If provisional, is that status explicit?
7. If the canonical entry changes, can this definition be regenerated predictably?

Any entry that creates new truth fails the Derived Knowledge rule.

## E. Cross-surface reconciliation

The desired relationship is:

```text
02_KANBAN
stable concept identity + definition + maturity + canonical evidence boundary
        ↓ derives
07_GLOSSARY
selected concise vocabulary; no independent truth
        ↓ summarizes current learning state
08_CONCEPT_MAP
compact present checkpoint + active frontier + recovery routing
```

The current relationship is partially inverted:

- KANBAN contains observational cycle summaries;
- Glossary contains current checkpoint evidence;
- Concept Map contains extensive Operational/Main execution state.

The files remain recoverable, but semantic responsibilities have blurred.

## F. Revised Didactic materialization recommendation

A later authorized revision should:

1. classify every KANBAN section as canonical concept data or appended cycle evidence;
2. preserve stable maturity rationale and evidence boundaries in KANBAN;
3. remove detailed cycle narrative from KANBAN only after confirming no canonical knowledge is lost;
4. give the Glossary an explicit inclusion rule;
5. reduce Glossary entries to predictable derivatives;
6. refresh—not append—the Concept Map as the Cycle 08 learning checkpoint;
7. replace references to cleansed B/H/J evidence with durable permanent or repository references;
8. classify prospective synchronization language explicitly;
9. stage Cycle 08 product vocabulary as provisional until overlap and learner value are tested;
10. preserve all IDs and statuses unless separate learner evidence authorizes change.

## G. Critical evaluation prompt for the next Didactic pass

```text
Evaluate the Didactic domain under METHOD_FOUNDATIONS, FLUX, and PROMOTION_RULES.

Scope:
- canonical: didactics/02_KANBAN.md;
- derived: didactics/07_GLOSSARY.md;
- checkpoint: didactics/08_CONCEPT_MAP.md;
- skip observational-history analysis except to verify that relocated text has a durable home.

For 02_KANBAN.md:
1. inventory every canonical concept and maturity;
2. distinguish learned curriculum from project-encountered reference concepts;
3. identify duplicate ownership and concept overlap;
4. classify every project manifestation as current, provisional, future, or illustrative;
5. preserve IDs and require learner evidence for maturity;
6. test Cycle 08 product vocabulary against existing concepts before proposing new IDs.

For 07_GLOSSARY.md:
1. identify the canonical owner of every retained term;
2. apply an explicit inclusion rule;
3. remove current-state reporting and independent truth;
4. preserve evidence labels;
5. mark provisional vocabulary explicitly.

For 08_CONCEPT_MAP.md:
1. regenerate a compact Cycle 08 current-state checkpoint;
2. expose active concepts, maturity evidence, confusion risks, dependency spine, recovery pointers, and next authority;
3. remove stale references to cleansed staging;
4. point to deeper sources rather than reproducing execution history.

Report:
- accepted canonical coverage;
- canonical gaps;
- checkpoint efficacy;
- derived consistency;
- duplicate semantic ownership;
- proposed relocations;
- proposed Cycle 08 vocabulary;
- maturity implications;
- exact writable paths;
- validation gates;
- unresolved human decisions.

Do not edit files, create concepts, or change maturity during evaluation.
```

## H. Confrontation conclusion

The prior J staging is methodologically valid as a provisional diagnosis, but it is not yet sufficient as direct edit authority. The revision must be driven by semantic classification, not line reduction. The central Didactic problem is not file size: it is that implementation chronology, current-state retrieval, and stable concept ownership have crossed their intended boundaries.

Status: critical evaluation complete; permanent Didactic mutation remains unauthorized.

---

# Cycle 08 Methodology Review — Design Domain

> Status: Critical evaluation staged for human/Main review  
> Methodology basis: `METHOD_FOUNDATIONS.md`, `FLUX.md`, and `PROMOTION_RULES.md`  
> Evaluated surfaces: `design/01_ARCHITECTURE.md`, `design/09_DESIGN_STATE.md`, and `design/14_MODEL_OVERVIEW.md`  
> Observational surface inspected only for routing: `design/03_DECISION_LOG.md`

## 1. Review purpose

Evaluate whether Design canonical knowledge, checkpoint recovery, and derived modelling still satisfy their methodology roles at the Cycle 08 boundary. Stage a bounded revision proposal without modifying permanent Design files or selecting Cycle 08 implementation architecture.

## 2. Current semantic assignment

| File | Assigned role | Current condition |
| --- | --- | --- |
| `01_ARCHITECTURE.md` | Canonical accepted architecture | Strong stable boundaries, but chronological implementation/evidence sections and future topology are mixed into canon |
| `09_DESIGN_STATE.md` | Compact current Design checkpoint | Correct semantic role; stale at Cycle 07 Sprint 05 and overly detailed in Operational evidence |
| `14_MODEL_OVERVIEW.md` | Derived responsibility/model map | Clear and useful, but substantially duplicates the checkpoint and parts of canonical architecture |
| `03_DECISION_LOG.md` | Append-oriented observational Design history | Correct home for decision sequence, alternatives, reversibility, and superseded context; detailed evaluation intentionally skipped |

## 3. Methodological verdict

The Design structure remains valid under Domain Symmetry. No additional file is justified. The required correction is semantic redistribution:

- canonical architecture owns stable accepted responsibilities, dependency direction, invariants, and protected boundaries;
- the derived overview reorganizes canon into a compact system/model map without adding truth;
- the checkpoint exposes current accepted, provisional, implemented, blocked, and deferred Design state;
- the Decision Log preserves chronology, alternatives, and why boundaries changed.

The existing files are recoverable, but vertical reconciliation is incomplete because implementation evidence and chronological acceptance have entered canonical architecture, while the checkpoint and derived overview repeat each other.

Any revision must classify knowledge before moving it. Line reduction is not authority to remove accepted architecture.

## 4. Canonical-file evaluation — `01_ARCHITECTURE.md`

### 4.1 Canonical coverage

The canonical file currently covers:

1. protected Python/PySide6 desktop composition;
2. application/service/repository/persistence boundaries;
3. packaging, installer, writable-state, retention, and release identity;
4. evidence boundaries;
5. shared Flutter client dependency direction;
6. local-first Drift persistence;
7. private Catalogue, Product, Store, Purchase, and Item responsibilities;
8. dimensional quantity, money, and versioned analytics;
9. prepared events, queue, Device sequence, and proposed synchronization topology;
10. account/authentication/authorization direction;
11. protected migration and rollback;
12. implemented Flutter foundation;
13. Product identity and exact/advisory matching;
14. atomic Purchase/event/queue transaction;
15. local schema and contract responsibility;
16. Android host and installation identity;
17. persistent Device ownership and prototype selection debt;
18. functional scaffold and platform-evidence boundaries.

### 4.2 Canonical strengths

- Dependency direction is explicit and stable.
- Domain code remains independent of widgets, Drift, HTTP, Python, and platform hosts.
- Presentation, application, domain, and infrastructure responsibilities are distinguishable.
- Purchase registration has a clear transaction boundary.
- Product visible code, internal record identity, and normalized identification facts are separated.
- Exact matching and advisory similarity are not confused with automatic merge.
- Local event preparation is explicitly distinguished from synchronization.
- Android application identity is separated from Account, Device, and domain identities.
- The Python beta and original data remain protected during transition.
- Prototype Device lookup debt is stated rather than silently promoted.
- Configuration facts are not automatically treated as domain architecture.

### 4.3 Canonical deficiencies

#### DSN-CAN-01 — Canonical architecture is chronological

Sections 17–19 narrate successive implementation sprints. Some content is stable architecture, but some records what was implemented or validated during a particular sprint. Canonical architecture should improve the current definition rather than accumulate one accepted architecture per sprint.

Classification: canonical/observational mixing and recovery-cost drift.

Required resolution:

- reconcile stable rules into thematic architecture sections;
- preserve supersession and rationale in the Decision Log;
- retain evidence boundaries only as concise qualification;
- avoid deleting unique accepted invariants while removing chronology.

#### DSN-CAN-02 — Accepted architecture and implementation evidence are mixed

Statements such as test totals, emulator execution, schema migration results, runtime database observations, and host validation support acceptance but are not themselves architecture.

Classification: canonical/Operational evidence overlap.

Required resolution:

Canonical architecture may state an evidence-qualified boundary, such as “Android is an evidenced host for the shared client,” but detailed commands, test counts, devices, and validation ladders belong to Operational or observational memory.

#### DSN-CAN-03 — Future distributed topology is overly concrete

The file describes authenticated TypeScript API, Neon Postgres, cursor allocation, batch behavior, verified email, and event acceptance in architectural present tense. These are scheduled Cycle 09 boundaries, not implemented Cycle 08 architecture.

Classification: maturity/evidence-state wording drift.

Required resolution:

Label each distributed statement as:

- accepted future boundary;
- provisional candidate;
- deferred implementation;
- explicitly unselected physical mechanism.

Stable prohibitions—such as clients not holding privileged database credentials—may remain canonical if accepted independently of the future stack.

#### DSN-CAN-04 — Stable invariant and provisional implementation choice need clearer grammar

The file already contains exclusions, but readers must infer whether Drift, UUID v4, JSON Schema Draft 7, TypeScript, Neon, schema v2, and first-20 lookup are stable, implemented, provisional, or prototype-only.

Required resolution:

Every technology or mechanism should be classified by architectural status:

- stable responsibility/invariant;
- accepted current implementation;
- reversible adapter choice;
- prototype-only heuristic;
- candidate future dependency;
- deferred/unselected.

#### DSN-CAN-05 — Cycle 08 presentation architecture is intentionally absent

The file correctly refuses to promote the functional scaffold into final UI architecture. Cycle 08 now requires investigation of:

- responsive navigation responsibilities;
- narrow/wide composition;
- Catalogue/Product/Store/Purchase/History screen boundaries;
- staging and review state ownership;
- validation, empty, success, and failure states;
- draft lifetime and recovery;
- atomic registration acknowledgement;
- price-comparison input/output boundaries;
- raw facts versus derived presentation;
- accessibility, focus, keyboard, Back, and lifecycle responsibilities;
- export/backup and recovery interfaces.

These are design questions, not yet accepted canon.

#### DSN-CAN-06 — Structural navigation is uneven

The canonical sequence jumps from section 11 to section 16 and later appends 17–19. Even if historically explainable, it weakens current recovery and suggests that removed or superseded sections are not clearly represented.

Classification: internal navigation drift.

Required resolution:

During authorized reconciliation, either restore a coherent thematic section map or explicitly reserve/supersede missing sections. Renumbering headings is allowed only if references in checkpoints, prompts, and other files are updated coherently; it must not alter architectural meaning.

### 4.4 Canonical disposition test

For every architecture statement, ask:

1. What responsibility, dependency, invariant, or boundary does it define?
2. Is it stable accepted architecture, current implementation, provisional choice, prototype debt, or future direction?
3. Is Design the semantic owner, or is the statement primarily Operational evidence?
4. Would the statement remain valid if the adapter, schema, framework, or host changed?
5. Is the same stable rule owned elsewhere at equal authority?
6. Does the statement describe current reality or scheduled Cycle 09 behavior?
7. Can the reason for a superseded rule be recovered from the Decision Log?
8. Can future implementation depend on this statement without reading sprint chronology?

Only stable accepted Design knowledge belongs in canonical architecture.

## 5. Checkpoint-efficacy evaluation — `09_DESIGN_STATE.md`

### 5.1 Current efficacy

The checkpoint provides:

- a current topology;
- implemented and validated structures;
- accepted boundaries;
- prototype debt;
- evidence limits;
- next route;
- recovery pointers.

Its length is compact relative to the canonical file, and it successfully exposes the Device invariant debt.

### 5.2 Current inefficiencies

- It is still titled and scoped to Cycle 07 Sprint 05.
- Its header version says Sprint 03 while its body says Sprint 05.
- It contains detailed Operational evidence, including test totals and emulator facts.
- It points to C/F/I and old J §24, all of which were cleansed at Cycle 08 entry.
- Its next route concerns closing Sprint 05 rather than Cycle 08 Design investigation.
- It does not expose the active product/UI questions.
- It combines “implemented and validated” without consistently separating source materialization, automated evidence, host evidence, and human acceptance.

### 5.3 Checkpoint success criteria

A Cycle 08 Design checkpoint should answer in one bounded read:

1. What architecture is accepted?
2. What implementation structures currently materialize it?
3. Which choices remain provisional or reversible?
4. Which debts threaten the active cycle?
5. Which Cycle 08 boundaries are under investigation?
6. Which work is explicitly deferred to Cycles 09 and 10?
7. What evidence limits constrain design claims?
8. What should Design Chat read next?
9. What authority transition is valid?

### 5.4 Recommended checkpoint shape

```text
Accepted architecture
→ current materialized topology
→ provisional/reversible choices
→ active Cycle 08 design questions
→ carried invariant debt
→ evidence boundary
→ deferred Cycle 09/10 work
→ recovery pointers
→ next authority transition
```

The checkpoint should be refreshed, not appended as another historical sprint report.

## 6. Derived-consistency evaluation — `14_MODEL_OVERVIEW.md`

### 6.1 Current strengths

- The system map is readable.
- Identity ownership is centralized effectively.
- Device bootstrap and prototype debt are clear.
- Purchase transaction and configuration boundaries are compact.
- The file points to canonical architecture.
- It distinguishes current local structure from deferred synchronization.

### 6.2 Derived inconsistencies

#### DSN-DER-01 — Overview/checkpoint duplication

Sections on prototype debt, evidence, next route, and recovery pointers closely reproduce `09_DESIGN_STATE.md`.

Required resolution:

The model overview should emphasize structural relationships and ownership. The checkpoint should own current status, evidence classification, active questions, and next route.

#### DSN-DER-02 — Implementation topology may outrun canonical status

The overview describes concrete composition calls, table fields, schema version, host facts, and deferred API stack. These are useful, but a derived file cannot silently promote them beyond the architectural status assigned in canon.

Required resolution:

Every concrete mechanism must trace to a canonical accepted/current implementation statement and retain its provisional or prototype label.

#### DSN-DER-03 — Current-state reporting weakens rebuildability

Test totals, emulator observations, and detailed validation classes age quickly. A model map should remain mostly correct when evidence counts change.

Required resolution:

Replace detailed evidence with short boundary labels and point to the checkpoint or Operational memory.

#### DSN-DER-04 — Product model is underrepresented for Cycle 08

The overview maps identity and Purchase transaction well but does not yet expose Store identity, Product reuse/creation, advisory duplicate handling, draft Items, review, History detail, or analytics presentation.

Required resolution:

After Design investigation and canonical acceptance, derive a Cycle 08 responsibility map from the accepted architecture. Do not add speculative product structure before that acceptance.

### 6.3 Derived consistency test

For every section or relationship, ask:

1. Which canonical architecture section owns it?
2. Does it reorganize accepted truth or add a new invariant?
3. Does it preserve provisional/prototype/deferred labels?
4. Is it structural, or is it current checkpoint/evidence material?
5. Would it remain useful if test counts or platform evidence changed?
6. Does it duplicate another derived/checkpoint surface?
7. Can it be regenerated predictably after canonical revision?

Any new responsibility or invariant introduced only in the overview fails the Derived Knowledge rule.

## 7. Cross-surface reconciliation

Desired relationship:

```text
01_ARCHITECTURE
stable responsibilities + dependencies + invariants + accepted boundaries
        ↓ derives
14_MODEL_OVERVIEW
compact structural map + identity/ownership relationships
        ↓ summarizes current design state
09_DESIGN_STATE
accepted/provisional/materialized/deferred status + active questions + recovery route
```

Current drift:

- Architecture carries sprint chronology and detailed evidence.
- Model Overview carries checkpoint/evidence sections.
- Design State repeats much of the overview and old Operational validation.
- All three refer to Cycle 07 evidence surfaces that were cleansed.

## 8. Cycle 08 Design investigation boundary

Design Chat should investigate, without premature architecture selection:

- responsive shell and navigation responsibilities;
- wide/narrow composition and state continuity;
- Catalogue browse/search/select/create;
- exact reuse versus advisory duplicate warning;
- Product corrections and historical integrity;
- Store identity, branch/location, reuse, and creation;
- Purchase draft ownership and lifetime;
- Item edit/remove/reorder and running totals;
- review and atomic registration boundary;
- success, failure, retry, and duplicate-submit prevention;
- History list/detail and immutable facts;
- normalized price observations and versioned comparison analytics;
- personal price change versus broader inflation claims;
- empty/loading/validation/recovery states;
- migration, export, backup, and recovery interfaces;
- Windows/Android focus, keyboard, Back, safe-area, accessibility, and lifecycle composition;
- explicit installation-to-Device invariant timing.

No UI framework, navigation package, state package, schema, API, or synchronization mechanism is selected by this investigation.

## 9. Proposed bounded revision unit

If later authorized:

1. `01_ARCHITECTURE.md`
   - reconcile stable boundaries thematically;
   - separate canonical rules from sprint evidence;
   - classify current, provisional, prototype, future, and deferred mechanisms;
   - preserve the protected transition and Device debt;
   - correct internal navigation and cross-references.

2. `14_MODEL_OVERVIEW.md`
   - rebuild from accepted canonical architecture;
   - focus on responsibilities, identities, dependency direction, and aggregate relationships;
   - remove detailed evidence and next-route duplication;
   - include Cycle 08 product relationships only after canonical acceptance.

3. `09_DESIGN_STATE.md`
   - refresh as the Cycle 08 Design checkpoint;
   - expose accepted state, materialized topology, active investigation, carried debt, evidence limits, deferrals, and next route;
   - remove stale references to cleansed C/F/I/J sections.

4. `03_DECISION_LOG.md`
   - preserve existing history;
   - append only the later accepted Design-revision event and its rationale;
   - do not use it as current-state canon.

## 10. Non-goals

The Design revision must not:

- select the final Cycle 08 UI architecture before A/B/C and human decisions;
- add Flutter dependencies or frameworks;
- modify schema or source;
- activate authentication, API, Neon, or synchronization;
- turn the first-20 Device heuristic into accepted architecture;
- rewrite decision history;
- create or rename Design files;
- claim Operational validation;
- change Didactic maturity;
- duplicate Main global state.

## 11. Validation gates

- every accepted responsibility and invariant has one canonical owner;
- chronological evidence removed from architecture remains recoverable;
- no Operational test/build details become canonical Design truth;
- future Cycle 09 topology is explicitly classified;
- Model Overview introduces no independent truth;
- Design State is compact, current, and free of cleansed-stage dependencies;
- prototype Device debt remains visible;
- Python/PySide6 protection remains explicit;
- Cycle 08 product questions remain proposed until human/Main acceptance;
- diff is limited to the four Design files during later materialization;
- methodology and application source remain unchanged.

## 12. Human decisions required

1. Should canonical architecture be rewritten into one thematic current model, with all sprint-specific acceptance chronology left to the Decision Log?
2. Should TypeScript and Neon remain named accepted Cycle 09 direction in canon, or be generalized to “custom API” and “managed Postgres” until physical selection is revalidated?
3. Should implemented adapter choices such as Drift and JSON Schema remain in canonical architecture as accepted current mechanisms, or live primarily in the derived model with canon owning only their responsibilities?
4. Should section numbers be normalized during pruning, with repository-wide reference repair?
5. At what Cycle 08 point must the explicit installation–Device invariant become mandatory: before Catalogue/Purchase expansion, before backup/recovery work, or only before Cycle 09 synchronization?

## 13. Critical evaluation prompt for the next Design pass

```text
Evaluate the Design domain under METHOD_FOUNDATIONS, FLUX, and PROMOTION_RULES.

Scope:
- canonical: design/01_ARCHITECTURE.md;
- derived: design/14_MODEL_OVERVIEW.md;
- checkpoint: design/09_DESIGN_STATE.md;
- inspect design/03_DECISION_LOG.md only to verify that removed chronology has a durable observational home.

For 01_ARCHITECTURE.md:
1. inventory stable responsibilities, dependencies, invariants, and protected boundaries;
2. separate canonical architecture from sprint chronology and Operational evidence;
3. classify every mechanism as stable, current implementation, reversible adapter, prototype-only, future candidate, or deferred;
4. identify duplicate semantic ownership;
5. preserve accepted Product/Purchase/identity/transaction rules and protected PySide6 transition;
6. treat Cycle 08 UI/product structures as investigation until human/Main acceptance.

For 14_MODEL_OVERVIEW.md:
1. trace every model relationship to canonical architecture;
2. remove independent truth and checkpoint duplication;
3. preserve status labels;
4. optimize the file for structural comprehension and regeneration;
5. add Cycle 08 relationships only after canonical acceptance.

For 09_DESIGN_STATE.md:
1. regenerate a compact Cycle 08 current checkpoint;
2. expose accepted architecture, materialized topology, provisional choices, active questions, Device debt, evidence limits, deferrals, and next authority;
3. remove stale references to cleansed stages;
4. point to deeper sources rather than reproducing validation history.

Report:
- accepted canonical coverage;
- canonical gaps and chronology drift;
- checkpoint efficacy;
- derived consistency;
- duplicate ownership;
- proposed relocations;
- Cycle 08 Design questions;
- exact writable paths;
- validation gates;
- unresolved human decisions.

Do not edit permanent files, select architecture, modify source, or promote provisional Cycle 08 structures during evaluation.
```

## 14. Main recommendation

Proceed later with a conservative thematic reconciliation:

- preserve stable architectural meaning;
- move chronology and detailed evidence out of canon by classification, not deletion;
- rebuild the model overview as a structural derivative;
- refresh the checkpoint for Cycle 08;
- classify future synchronization topology explicitly;
- keep Cycle 08 product/UI architecture provisional until functional investigation and human decisions;
- retain the Device invariant as visible gating debt.

Status: Design confrontation complete; permanent Design mutation remains unauthorized.

---

# Cycle 08 Methodology Review — Operational Domain

> Status: Critical evaluation staged for human/Main review  
> Methodology basis: `METHOD_FOUNDATIONS.md`, `FLUX.md`, and `PROMOTION_RULES.md`  
> Evaluated surfaces: `operational/12_OPERATIONAL_MODEL.md`, `operational/10_OPERATIONAL_STATE.md`, and `operational/04_TODO.md`  
> Observational surface inspected only for routing: `operational/11_OPERATIONAL_RECORD.md`

## 1. Review purpose

Complete the acquired-documentation review by evaluating whether Operational canonical knowledge, checkpoint recovery, and derived executable planning still satisfy their methodology roles at the Cycle 08 boundary. Stage a bounded revision proposal without modifying permanent Operational files, host tools, dependencies, application source, or platform state.

## 2. Current semantic assignment

| File | Assigned role | Current condition |
| --- | --- | --- |
| `12_OPERATIONAL_MODEL.md` | Canonical stable Operational rules | Strong evidence and safety model; some product/repository incidents, concrete release configuration, and future synchronization rules need classification |
| `10_OPERATIONAL_STATE.md` | Compact current Operational checkpoint | Semantically correct but stale at Cycle 07 Sprint 05, internally version-stale, and dependent on cleansed staging |
| `04_TODO.md` | Derived executable gates/backlog | Contains useful gates but combines obsolete Cycle 07 preparation, inactive Cycle 09 work, and carried current debt |
| `11_OPERATIONAL_RECORD.md` | Append-oriented execution history | Correct home for commands, results, contradictions, host changes, and chronological evidence; detailed evaluation intentionally skipped |

## 3. Methodological verdict

The four-file Operational structure remains valid. No new file is justified.

The domain needs vertical reconciliation:

- stable repeatable execution, validation, safety, recovery, and evidence rules belong in the canonical Operational model;
- current passing, partial, blocked, host-unvalidated, and deferred state belongs in the checkpoint;
- executable next gates and bounded backlog belong in TODO;
- commands, versions, hashes, incidents, contradictions, and results belong in the Record.

The existing model itself states this maintenance rule, but later appendices partially violate it. The revision must enforce the rule by semantic classification, not indiscriminate deletion.

## 4. Canonical-file evaluation — `12_OPERATIONAL_MODEL.md`

### 4.1 Canonical coverage

The Operational canon currently covers:

1. runtime and writable-persistence separation;
2. schema-first production initialization;
3. packaging and installer authority;
4. an explicit evidence ladder;
5. installed lifecycle and retained-data rules;
6. startup diagnostics and deterministic shutdown;
7. database ownership and transaction safety;
8. artifact/source separation;
9. beta acceptance boundaries;
10. local synchronization safety;
11. unknown network outcomes and idempotent retry;
12. migration rehearsal and recovery;
13. protection of accepted desktop data;
14. generated-source ownership;
15. platform scaffold versus platform validation;
16. monotonic sequence and identity-normalization proof;
17. contract examples versus complete protocol;
18. host-mutation authority;
19. identity-bearing migration safety;
20. structural schema validation boundaries;
21. Android evidence classification;
22. lifecycle-checklist closure;
23. SDK/AVD recovery;
24. repository/report reconciliation;
25. precise workflow terminology.

### 4.2 Canonical strengths

- The evidence ladder prevents later gates from being inferred from earlier ones.
- Host mutation, cleanup, and ordinary-user-data safety are explicitly bounded.
- Reproducible artifacts are distinguished from source truth.
- Runtime, installer, and build-time dependencies are separated.
- Platform scaffolding does not count as platform validation.
- Transactions, migrations, unknown network outcomes, and cursor advancement have strong safety rules.
- Accepted Python data remains isolated from experiments.
- Generated files are reviewed through generators, configuration, regeneration, and validation.
- Human-visible acceptance remains distinct from automated technical evidence.
- Local queue preparation is not confused with synchronization.
- The model correctly treats report/repository disagreement as drift rather than choosing documentation over source.

### 4.3 Canonical deficiencies

#### OPS-CAN-01 — Stable rule and repository incident are mixed

The model records the specific committed installer binary contradiction and the `x64compatible` warning. These facts were useful, but they are repository incidents or bounded maintenance debt rather than timeless Operational rules.

Classification: canonical/observational mixing.

Required resolution:

- preserve the general artifact policy and warning-classification rule in canon;
- leave the specific binary contradiction, filename, warning instance, and disposition history in the Record/checkpoint/TODO;
- do not erase unresolved cleanup merely to purify canon.

#### OPS-CAN-02 — Concrete Cycle 06 release configuration may be over-canonical

Per-user install paths, exact launcher composition, PyInstaller/Inno Setup roles, and page-specific shutdown chains are accepted for the protected Python beta. They are not universal rules for the Flutter shared client.

Classification: product-generation scope ambiguity.

Required resolution:

Explicitly label rules as:

- project-wide Operational invariant;
- protected Python-beta Operational contract;
- current Flutter-client Operational contract;
- future distributed-safety rule.

This preserves valid historical/current contracts without making them apply to every client.

#### OPS-CAN-03 — Future synchronization safety is canonical before implementation

The synchronization safety rules are valuable technology-independent invariants. However, “canonical” must mean accepted operational requirements for future work, not implemented or validated synchronization behavior.

Required resolution:

Keep rules such as no privileged client credentials, atomic event/fact persistence, safe retry, and atomic cursor application, while labeling them “accepted future gates; implementation absent until Cycle 09.”

#### OPS-CAN-04 — Canonical appendices are cycle-derived

Generated-source, host/migration, and Android recovery sections contain stable reusable rules, but they were appended after individual sprints. Their knowledge is valid; their organization remains chronological and may grow one appendix per cycle.

Classification: canonical navigation/recovery-cost drift.

Required resolution:

Reconcile these rules into thematic sections during authorized revision and preserve their origin in the Record. Do not retain sprint-shaped headings in canon when the rule is cycle-independent.

#### OPS-CAN-05 — Acceptance vocabulary is not fully normalized

The model uses configured, built, launched, installed, validated, accepted, blocked, and unknown. Later documentation also relies on implemented, automated-test evidenced, host-executed, human-observed, partial, host-unvalidated, and deferred.

Required resolution:

Define one Operational evidence taxonomy with permitted combinations and scope:

```text
materialized
automated-test evidenced
built
installed
launched
workflow-observed
persistence-observed
lifecycle-validated
physical-device validated
release/distribution validated
host-unvalidated
blocked
deferred
accepted by human/Main
```

The taxonomy must allow platform and workflow qualifiers and must not collapse implementation into acceptance.

#### OPS-CAN-06 — Cycle 08 product-beta gates are absent

The model has strong platform and persistence safety but does not yet state reusable validation rules for:

- responsive navigation and wide/narrow acceptance;
- Catalogue search/reuse/create and advisory duplicates;
- Store selection/create;
- staged multi-item edits/removal/review;
- duplicate-submit prevention;
- atomic registration and failure recovery;
- History list/detail consistency;
- normalized personal price comparison;
- empty, validation, success, failure, and retry states;
- larger catalogue/history volumes;
- backup/export decision and recovery;
- accessibility/focus/keyboard/Back;
- migration from current local schema;
- the installation–Device invariant before synchronization.

These are candidates for Operational investigation. Only reusable accepted validation rules should later enter canon.

### 4.4 Canonical disposition test

For every Operational statement, ask:

1. Is this a reusable execution, validation, safety, recovery, or evidence rule?
2. Is it project-wide, Python-beta-specific, Flutter-specific, or a future distributed gate?
3. Is it a stable rule or a dated incident/result?
4. Does it prescribe an evidence boundary or claim evidence already exists?
5. Is Operational the semantic owner, or is it primarily Design architecture or Main state?
6. Can the rule survive tool/version/path changes?
7. Is an inactive future gate clearly distinguished from implemented behavior?
8. Can historical origin and failure detail be recovered from the Record?

Only stable reusable Operational knowledge belongs in the canonical model.

## 5. Checkpoint-efficacy evaluation — `10_OPERATIONAL_STATE.md`

### 5.1 Current efficacy

The checkpoint exposes:

- implemented and validated evidence;
- partial and deferred work;
- a current operational decision;
- host recovery requirements;
- authority and next route;
- deeper recovery pointers.

It is the correct Operational entry point and remains moderate in size.

### 5.2 Current inefficiencies

- Header version says Cycle 07 Sprint 02 while the latest body is Sprint 05.
- Branch and inspected head are obsolete for Cycle 08.
- It points to cleansed A/G/J staging.
- It treats the supplemental lifecycle checklist as the current next route even though Cycle 07 is now closed and the debt is carried.
- It contains detailed SDK paths, test totals, emulator details, and repository contradictions that exceed the minimum checkpoint requirement.
- The checkpoint mixes old planning candidates with later implemented reality.
- It does not expose Cycle 08 Sprint 01 investigation authority or product-beta evidence planning.

### 5.3 Checkpoint success criteria

A Cycle 08 Operational checkpoint should answer in one bounded read:

1. What environments and workflows are verified?
2. What evidence survives from Cycle 07?
3. Which claims remain host-unvalidated or partial?
4. What carried debts constrain Cycle 08?
5. What Cycle 08 validation questions are active?
6. What work is blocked or deferred to Cycles 09/10?
7. Which host environments must be preserved?
8. What is the next valid authority transition?
9. What should Operational Chat read next?

### 5.4 Recommended checkpoint shape

```text
Verified baseline
→ protected environments/data
→ carried partial evidence and debt
→ active Cycle 08 investigation
→ failure/recovery risks
→ deferred Cycle 09/10 work
→ recovery pointers
→ next authority boundary
```

Refresh it as current state; do not append another historical report.

## 6. Derived-consistency evaluation — `04_TODO.md`

### 6.1 Current strengths

- Tasks are expressed as executable gates.
- Priorities and completion boundaries are explicit.
- Failure injection, close/reopen, isolation, migration, and platform checks are well formed.
- Host cleanup requires inventory and named removal.
- The lifecycle checklist correctly stops when defects require new authority.
- The file distinguishes future Neon advancement from local proof.

### 6.2 Derived inconsistencies

#### OPS-DER-01 — Obsolete preparation remains active beside completed work

The first ten sections describe Cycle 07 Sprint 03 preparation even though much of the Flutter foundation, persistence, transaction, Windows, and Android work was later materialized.

Classification: stale derived backlog.

Required resolution:

Rebuild TODO from current canonical rules, checkpoint state, and Cycle 08 objective. Completed gates should not remain active merely because their historical plan is useful.

#### OPS-DER-02 — Inactive Cycle 09 work dominates current TODO

Secure credential storage, TypeScript protocol harness, disposable Postgres, Neon, account isolation, and cursor behavior are scheduled for Cycle 09. Keeping them as P0 in the active Cycle 08 TODO misstates priority and authority.

Required resolution:

Move them to an explicitly deferred/scheduled section or concise forward reference. They must not compete with Cycle 08 product-beta gates.

#### OPS-DER-03 — TODO duplicates checkpoint state

The fast recovery card, closure boundary, evidence wording, and current host state partly repeat `10_OPERATIONAL_STATE.md`.

Required resolution:

Checkpoint owns current truth. TODO should own executable outstanding gates, prerequisites, cost, stop conditions, and completion criteria.

#### OPS-DER-04 — Some tasks are no longer correctly scoped

The supplemental Android checklist remains valid debt, but Cycle 07 closure means it should be framed as carried Cycle 08 acceptance debt, not a condition for reopening Sprint 05. Likewise DevTools disposition is hygiene, not product-beta P0.

Required resolution:

Reclassify by current impact:

- Cycle 08 acceptance gate;
- Cycle 08 investigation;
- bounded hygiene;
- deferred Cycle 09;
- deferred Cycle 10.

#### OPS-DER-05 — Cycle 08 operational plan is missing

The active TODO needs gates for:

- current build/run/test reproducibility;
- responsive layout and navigation validation matrix;
- keyboard, Back, focus, larger text, rotation, resume, and process restart;
- Catalogue/Store/Purchase/History workflow validation;
- atomic failure/duplicate-submit testing;
- data-volume and performance evidence;
- migration from existing Flutter schema;
- backup/export decision;
- corruption and recovery behavior;
- app-private persistence across Windows/Android;
- physical-device and release boundaries;
- installation–Device invariant timing;
- privacy-safe diagnostics;
- explicit costs and stop conditions.

These remain investigation candidates until A and Main staging approve exact gates.

### 6.3 Derived consistency test

For every TODO item, ask:

1. Which canonical Operational rule or accepted checkpoint debt derives this task?
2. Is it active in Cycle 08, carried debt, hygiene, Cycle 09, or Cycle 10?
3. Is its authority active, or is it merely scheduled?
4. Does it name prerequisites, command/evidence target, stop condition, and completion boundary?
5. Has it already been completed or superseded?
6. Does it duplicate current-state prose from the checkpoint?
7. Can it be removed or regenerated when the state changes?
8. Would executing it mutate source, host, data, or external infrastructure without D/E/F?

Any task without current derivation and authority should be deferred or removed from the active queue.

## 7. Cross-surface reconciliation

Desired relationship:

```text
12_OPERATIONAL_MODEL
stable execution + evidence + safety + recovery rules
        ↓ derives
04_TODO
current executable gates + prerequisites + costs + stop conditions
        ↓ summarizes current execution state
10_OPERATIONAL_STATE
verified/partial/blocked/deferred baseline + next authority
```

Current drift:

- the canonical model contains dated repository/tool incidents;
- TODO preserves obsolete planning and inactive future work as current P0;
- the checkpoint preserves detailed Cycle 07 evidence and cleansed-stage references;
- all three partially repeat evidence classifications and current route.

## 8. Cycle 08 Operational investigation boundary

Operational Chat should investigate, without implementation:

- current clean clone/bootstrap/run/build/test paths;
- Windows and Android toolchain preservation/recovery cost;
- responsive validation tooling and manual matrix;
- Catalogue and Store workflow testability;
- staged Purchase editing/removal/review;
- atomic commit and duplicate-submit failure injection;
- History detail consistency and price-observation reconstruction;
- analytics fixtures, numeric precision, units, and interval comparison;
- larger catalogue/history volume and performance;
- fresh install, schema migration, reopen, corruption, and recovery;
- backup/export feasibility and acceptance boundary;
- privacy-safe logs and diagnostic export;
- app-private storage behavior;
- keyboard, Back, focus, text scale, rotation, background/resume, and process recreation;
- emulator versus physical-device boundary;
- release/packaging deferrals;
- installation–Device invariant timing;
- exact operational costs, blockers, and stop conditions.

No tool installation, dependency addition, schema mutation, source change, release signing, external infrastructure, or synchronization is authorized by the investigation.

## 9. Proposed bounded revision unit

If later authorized:

1. `12_OPERATIONAL_MODEL.md`
   - reconcile stable rules thematically;
   - label Python, Flutter, and future distributed scopes;
   - move dated incidents and concrete evidence to observational/current surfaces;
   - normalize evidence vocabulary;
   - preserve data safety, transaction, migration, host-mutation, and recovery rules.

2. `04_TODO.md`
   - rebuild from the Cycle 08 checkpoint and objective;
   - remove completed Cycle 07 tasks from the active queue;
   - segregate carried debt, hygiene, Cycle 09, and Cycle 10;
   - define Cycle 08 investigation/acceptance gates with costs and stop conditions;
   - avoid duplicating checkpoint state.

3. `10_OPERATIONAL_STATE.md`
   - refresh as the Cycle 08 Operational checkpoint;
   - retain only the verified baseline, carried debt, active investigation, evidence limits, preserved environment, and next authority;
   - remove stale references to cleansed A/G/J.

4. `11_OPERATIONAL_RECORD.md`
   - preserve all history;
   - append the later accepted Operational documentation-revision event;
   - remain the home for commands, versions, incidents, contradictions, and results.

## 10. Non-goals

The Operational revision must not:

- run builds, tests, emulators, installers, or devices during documentation revision;
- install or remove tools;
- mutate user data or host configuration;
- modify source, dependencies, schema, or external services;
- activate Cycle 09 synchronization;
- claim Design architecture or Didactic maturity;
- rewrite Operational history;
- create or rename files;
- infer product acceptance from prior technical evidence.

## 11. Validation gates

- every canonical rule is stable and scope-labeled;
- dated incidents remain recoverable outside canon;
- evidence taxonomy does not collapse build, launch, workflow, lifecycle, physical-device, release, and acceptance gates;
- TODO contains only current or explicitly deferred work;
- completed Cycle 07 tasks are not presented as active;
- Cycle 09/10 work is clearly inactive;
- checkpoint is current, compact, and free of cleansed-stage dependencies;
- host/tool cleanup remains separately authorized;
- accepted Python beta and data protection remain explicit;
- Cycle 08 gates remain proposed until A/B/C and Main/human approval;
- later diff is limited to the four Operational files;
- methodology and application source remain unchanged.

## 12. Human decisions required

1. Should the Operational canon retain product-generation-specific contracts for both Python and Flutter, or contain only project-wide rules with client-specific appendices?
2. Should accepted future synchronization safety rules remain canonical now, provided they are explicitly labeled unimplemented Cycle 09 gates?
3. Should `04_TODO.md` retain deferred Cycle 09/10 sections, or contain only active-cycle work with forward tasks held in Main continuity?
4. Should the carried Android lifecycle checklist be mandatory during Cycle 08 responsive-foundation work or deferred to the final Cycle 08 acceptance sprint?
5. Should DevTools configuration disposition remain a named hygiene task or be retired unless it causes reproducibility drift?
6. Which evidence taxonomy should become the single Operational vocabulary across checkpoints, reports, and acceptance gates?

## 13. Critical evaluation prompt for the next Operational pass

```text
Evaluate the Operational domain under METHOD_FOUNDATIONS, FLUX, and PROMOTION_RULES.

Scope:
- canonical: operational/12_OPERATIONAL_MODEL.md;
- derived: operational/04_TODO.md;
- checkpoint: operational/10_OPERATIONAL_STATE.md;
- inspect operational/11_OPERATIONAL_RECORD.md only to verify that relocated incidents and results have a durable observational home.

For 12_OPERATIONAL_MODEL.md:
1. inventory stable execution, evidence, safety, transaction, migration, host, artifact, and recovery rules;
2. distinguish project-wide, Python-beta, Flutter-client, and future distributed scopes;
3. separate stable rules from dated incidents, versions, commands, and results;
4. normalize evidence-state vocabulary;
5. preserve data protection and explicit mutation authority;
6. classify Cycle 08 validation rules as candidates until accepted.

For 04_TODO.md:
1. derive every task from canonical rules and the current checkpoint;
2. remove completed or superseded Cycle 07 work from the active queue;
3. distinguish Cycle 08, carried debt, hygiene, Cycle 09, and Cycle 10;
4. require prerequisites, evidence target, cost, stop condition, and completion boundary;
5. prevent inactive tasks from implying authority.

For 10_OPERATIONAL_STATE.md:
1. regenerate a compact Cycle 08 checkpoint;
2. expose verified baseline, partial/host-unvalidated evidence, carried debt, active investigation, preserved environment, deferrals, and next authority;
3. remove stale references to cleansed stages;
4. point to deeper sources rather than reproducing execution history.

Report:
- accepted canonical coverage;
- canonical scope/incident drift;
- checkpoint efficacy;
- derived TODO consistency;
- duplicate semantic ownership;
- proposed relocations;
- Cycle 08 Operational gates;
- evidence vocabulary;
- exact writable paths;
- validation gates;
- unresolved human decisions.

Do not edit permanent files, run tools, mutate hosts/data, modify source, or activate deferred work during evaluation.
```

## 14. Main recommendation

Proceed later with a conservative Operational reconciliation:

- preserve the strong safety and evidence model;
- separate product-generation scope and future gates;
- move incidents out of canon without losing unresolved debt;
- rebuild TODO for Cycle 08;
- refresh the checkpoint;
- keep host mutations and cleanup separately authorized;
- treat carried lifecycle work as named acceptance debt;
- keep Cycle 09/10 operational work inactive.

Status: Operational confrontation complete; permanent Operational mutation remains unauthorized.

---

# Acquired Documentation Review — Cross-Domain Closure

The Didactic, Design, and Operational permanent folders have now been reviewed under the same methodology test.

Common drift pattern:

```text
chronological evidence entered canonical files
+ current-state material entered derived files
+ checkpoints retained obsolete cycle/stage references
= vertical reconciliation and recovery-economy debt
```

Domain-specific emphasis:

- Didactic: protect concept identity and learner-evidence maturity while separating curriculum, vocabulary, checkpoint, and execution chronology.
- Design: protect responsibilities/invariants while separating architecture, implementation evidence, model derivation, and future topology.
- Operational: protect safety/evidence/recovery rules while separating stable procedures, incidents, active gates, and inactive future work.

No domain requires a new permanent file. The next valid transition is human resolution of the staged questions, followed by a single Main-approved documentation-revision authority that names exact writable files and validation gates. Application implementation remains inactive.


---

<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Temporal boundary — Cycle 09 Sprint 02 begins here. Content above is the reviewed pre-Sprint-02 baseline and retains its existing authority and semantic role. Content below belongs to Sprint 02 investigation, current-UI archival evidence, aesthetic reconciliation, staging, implementation, and later closure. This marker alone authorizes no source change, semantic promotion, or methodology revision.

---
<!-- TEMPORAL_MARKER:C12-S00-J-MAIN-STAGE-RETIREMENT-2026-09-25 -->
# Retired J_MAIN_STAGE snapshot — prior C11/C12-entry staging

> Classification: superseded Main-level staging snapshot.
> Preservation method: appended verbatim from the prior `J_MAIN_STAGE.md`.
> Disposition: historical lineage only; it confers no active procedure, source, provider, or Cycle 12 authority.

# J_MAIN_STAGE — Cycle 11 PH03 permanent closure and PH04 authority

> Sequence: FLX-PRM-04 / Main continuity reconciliation
> Role: Main Chat [M]
> Cycle / phase / active unit: C11 / C11-PH04 / implementation authority
> Repository: `gus-i-gu/markei`
> Branch: `grm-guarded-provisioning-20260727`
> Cycle 10 accepted implementation boundary:
> `97cec7f733926f669d2a844feb2b5e6e0b7e6bce`
> GCM03 closure publication:
> `05e630cfe04aa03846bc635c524278d4fa9b7c39`
> Cycle 10 permanent-memory reconciliation inspected through:
> `526e0de6e294c5fb969d8ee1f35e6eb53914902b`
> C11-PH01-S01 materialization:
> `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`
> C11-PH03 implementation:
> `0924e743931ea7aba2c9cc5d2e28063e737b2ff5`
> C11-PH03 permanent-domain head:
> `cc53e6ef063d43342394a55165dd188ddd4ce491`
> C11-PH04 D/E/F authority:
> `35cf23602060fd3a186a2470d7ac322c795e5fce`
> Authority: explicit human-directed Main final reconciliation
> Mutable surface: this file
> Extracted Cycle 10 history: `documentation/REC_LEGACY.md`
> Status: **C11-PH03 PERMANENTLY ABSORBED; C11-PH04 ANALYTICS AUTHORITY ACTIVE**

## 1. Recovery entrypoint

Ordinary global recovery:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
this J prefix
```

Current domain checkpoints:

```text
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Current C11 implementation authority:

```text
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
```

Use current G/H/I for C11-PH03 evidence until PH04 materialization replaces
them. Use the latest PH04 activation-marker tails in D/E/F as current
implementation authority. Use
`documentation/REC_LEGACY.md` only for exact Cycle 10 sanitized
human/client/server/provider chronology. Use `documentation/REC_LEGACY.md` for historical lineage, superseded gates,
normalized Records 001–021, and exact prior Main decision boundaries.

The mutable prefix contains no reusable Cycle 10 D/E/F packet, corrective
domain prompt or unpromoted Cycle 10 narrative.

## 2. Current project terminal

```text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
GCM01=ACCEPTED_DEVELOPMENT_BOUNDARY
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
PRODUCTION_ACCEPTANCE=ABSENT
GCM04=DEFERRED_TO_C12_PHASE02
R07_IMPLEMENTATION_AUTHORIZED=NO

CYCLE10_PERMANENT_INFORMATION=EXHAUSTED_WITHIN_RECORDS_001_021
OPERATIONAL_PERMANENT_MEMORY=COMPLETE
DIDACTIC_PERMANENT_MEMORY=COMPLETE
DESIGN_PERMANENT_MEMORY=COMPLETE
KANBAN_TRANSITIONS=NONE
NEW_CYCLE10_DOMAIN_REGISTRATION_ROUND=NOT_REQUIRED

CYCLE11=ACTIVE
C11_PHASE=C11-PH04
C11_COMPLETED_UNIT=C11-PH03-PERMANENT-CLOSURE
C11_CURRENT_UNIT=C11-PH04-R01
C11_S01_PERMANENT_DOMAIN_ABSORPTION=COMPLETE
C11_PH01_R01_PH02_PERMANENT_DOMAIN_ABSORPTION=COMPLETE
C11_PH03_PERMANENT_DOMAIN_ABSORPTION=COMPLETE
C11_PH03_SOURCE_AUTHORITY=CONSUMED
C11_PH04_D_E_F_AUTHORITY=ACTIVE_AT_35CF236
C11_PH04_SOURCE_AUTHORITY=ANALYTICS_ONLY

LIVE_SYNC_AUTHORITY=NONE
PROVIDER_MUTATION_AUTHORITY=NONE
```

## 3. Cycle 10 permanent extraction boundary

Cycle 10 is no longer staged in this mutable prefix. Its meaning is owned by
the permanent record:

| Layer | Current permanent owners |
| --- | --- |
| Main state and history | `00_PROJECT_STATE.md`, `05_SESSION_LOG.md` |
| Operational | `11_OPERATIONAL_RECORD.md`, `12_OPERATIONAL_MODEL.md`, `04_TODO.md`, `10_OPERATIONAL_STATE.md` |
| Didactic | `13_LECTURE_REGISTER.md`, `02_KANBAN.md`, `07_GLOSSARY.md`, `08_CONCEPT_MAP.md` |
| Design | `03_DECISION_LOG.md`, `01_ARCHITECTURE.md`, `14_MODEL_OVERVIEW.md`, `09_DESIGN_STATE.md` |
| Sanitized assay chronology | `documentation/REC_LEGACY.md` |
| Runtime diagnostic authority | `contracts/shared_beta/diagnostics_v1/diagnostics.registry.json` |

The accepted boundary is reciprocal Windows/Android convergence for two
enrolled Devices on one Account in development, including exact natural
Product identity reconciliation, durable local apply/cursor progress before
acknowledgement, drained queues and one ordinary no-op Sync per Device.

The permanent record does not claim a final provider-table recount after the
golden no-op repeats, production acceptance, multiple-Account isolation,
membership disablement, Device revocation, outage/acknowledgement-uncertainty
recovery, retention, snapshot or rebootstrap.

No later chat should reconstruct Cycle 10 truth from superseded staging when
the permanent files above are sufficient.

## 4. Diagnostic ownership

| Semantic role | Owner |
| --- | --- |
| Stable runtime diagnostic registry | `contracts/shared_beta/diagnostics_v1/diagnostics.registry.json` |
| Generated readable projection | `documentation/ERR_DIAGNOSTICS.md` |
| Sanitized assay chronology | `documentation/REC_LEGACY.md` |
| Domain interpretation | permanent Operational, Didactic and Design files |
| Global sequence and evidence ceiling | this J prefix |
| Historical corrective lineage | `documentation/REC_LEGACY.md` |

No Main, domain or UI document may create a second diagnostic registry or
causal engine.

## 5. Permanent-memory achievement ledger

### 5.1 Operational

Complete:

- Records 001–021 and the ordered GCM02/GCM03 assay chronology;
- stable execution, validation, evidence-ceiling and diagnostic rules;
- current/deferred work regenerated from the accepted terminal;
- checkpoint refreshed away from `C10-S03A_CONTRADICTED_STOP`;
- C11-PH01-S01 absorbed separately at the automated/build-only ceiling.

No further Cycle 10 Operational append or canonical restatement is justified.

### 5.2 Didactic

Complete:

- Cycle 10 learning history, misconceptions and vocabulary;
- KANBAN reconciliation for readiness, identity, outcome, diagnostic,
  acknowledgement, convergence and evidence distinctions;
- Glossary and Concept Map regeneration;
- C11-PH01-S01 meaning/accessibility absorption.

All maturity states remain unchanged because direct learner-mastery evidence
was not produced.

### 5.3 Cross-domain C11-PH01-S01 absorption

Operational, Didactic and Design permanent memory separately record:

- stable destination identity;
- compact, medium and wide shell policies;
- shared presentation foundation;
- Home and Lists recomposition;
- read-only local Lists Retry;
- passed focused/full tests, analysis and Windows/Android builds;
- unchanged business, Sync, diagnostics, recovery and provider behavior;
- absent human Windows/Android visual, screen-reader, keyboard-only and
  real-device acceptance.

This is a C11 event and must not be folded into Cycle 10 acceptance.

### 5.4 Design

Complete:

- Cycle 10 local/hosted authority, identity, event/submission, transaction,
  diagnostic and acknowledgement boundaries;
- reciprocal development convergence topology;
- explicit canonical supersession of the historical §22 stop by the accepted
  §23 boundary;
- derived topology and current checkpoint regeneration;
- C11-PH01-S01 responsibility/dependency absorption.

The historical contradicted stop remains traceable but is not current
architecture. No further Cycle 10 Design chronology is justified.

## 6. Deferred boundaries, not documentation gaps

The following remain deliberately unresolved and must not reopen Cycle 10:

- multiple-Account isolation;
- membership disablement and Device revocation;
- outage and acknowledgement-uncertainty recovery;
- retention, snapshot and rebootstrap;
- reproducible production lifecycle and production acceptance;
- deferred GCM04;
- conditional R07 reassessment.

They belong to `C12-PHASE02` unless later human/Main direction changes the
schedule. Their absence is an evidence boundary, not incomplete Cycle 10
promotion.

## 7. Current C11-PH01-S02 boundary

C11-PH01-S01 established the reversible shell, token/component foundation and
first Home/Lists composition. S02 is the bounded five-page presentation
convergence unit for:

```text
Home
Lists
Catalogue
History
Purchase
```

The synchronized D/E/F packet owns the exact page priorities, target-image
references, responsive rules, writable paths, tests and stop conditions.

Accepted phase order:

```text
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
```

S02 source authority exists only when the branch head is the synchronized
D/E/F-only publication descended from this Main reconciliation and explicitly
named by the Codex initiation prompt. Any later unrelated descendant invalidates
that starting-head guard until Main republishes or reauthorizes the packet.

S02 does not authorize Analytics functionality, Settings/Audit redesign,
Closure relocation, provider mutation, live Sync, GCM04, R07, production claims
or a new diagnostic authority.

## 8. Authority terminal

```text
J_CYCLE10_FINAL_PRUNING=COMPLETE
J_LEGACY_PROGRESS_EXTRACTED=REC_LEGACY
CYCLE10_PERMANENT_EXTRACTION=EXHAUSTED
CYCLE10_STAGING_AUTHORITY=NONE
CYCLE10_DOMAIN_RERUN=NOT_REQUIRED
C11_S01_PERMANENT_ABSORPTION=COMPLETE
C11_CURRENT_UNIT=C11-PH03-INVESTIGATION
C11_S02_SOURCE_AUTHORITY=CONSUMED
C11_PH01_R01_PH02_PERMANENT_ABSORPTION=COMPLETE
C11_PH03_STAGING_AUTHORITY=A_B_C_ONLY
C11_PH03_SOURCE_AUTHORITY=NONE
LIVE_SYNC_AUTHORITY=NONE
PROVIDER_MUTATION_AUTHORITY=NONE
METHODOLOGY_MUTATION=NONE
```

---
<!-- TEMPORAL_MARKER:C11-PH02-MAIN-2026-07-31 -->
> Temporal boundary — Main post-materialization reconciliation. Sections above preserve the pre-PH02 boundary. This section is the latest chronological J authority for C11-PH01-R01 and C11-PH02 permanent-domain reconciliation.

## 9. C11-PH01-R01 + C11-PH02 final materialization reconciliation

### 9.1 Evidence boundary

Repository and branch:

```text
REPOSITORY=gus-i-gu/markei
BRANCH=grm-guarded-provisioning-20260727
IMPLEMENTATION_PARENT=e802d435cf562e422b7f9118db929235488899bf
IMPLEMENTATION_COMMIT=20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6
PUBLICATION=PUSHED
```

Controlling evidence:

```text
DEV_STAGE/D_OPS_STAGE.md
DEV_STAGE/E_DDC_STAGE.md
DEV_STAGE/F_DSN_STAGE.md
DEV_STAGE/G_OPS_CODEX.md
DEV_STAGE/H_DDC_CODEX.md
DEV_STAGE/I_DSN_CODEX.md
```

A/B/C remain pre-materialization investigation, intent and contrary-evidence
inputs. Any earlier claim that the PH01 corrective source or PH02 Analytics was
absent is superseded by the implementation commit and final G/H/I evidence.
D/E/F retain historical materialization authority but do not authorize a new
implementation round.

The implementation commit changed 23 authorized paths: 12 Flutter source files,
8 Flutter test files, and G/H/I. R02 added
`clients/markei_flutter/test/app/markei_app_test.dart` beyond the carried R01
path set to correct deterministic test lifecycle behavior without weakening
substantive assertions.

### 9.2 Reconciled implementation state

PH01-R01 is implemented and validated at the automated/build ceiling:

- Purchase and Catalogue retain the accepted PH01 visual system while correcting
  constrained-height reachability, field separation, wrapping and geometry.
- History exposes one checkbox selection affordance and a separate detail
  activation in wide and compact presentations.
- Home and Lists remain preserved except for bounded shared-presentation
  compatibility.

PH02 Analytics is implemented and validated at the automated/build ceiling:

- deterministic, read-only, local and active-Account-scoped;
- one complete joined evidence load, with no History 50-row reuse or N+1 path;
- session-local repeatable cards above a twelve-field supporting evidence
  matrix;
- Product, Purchase, Store and UTC Time determinants;
- Sum, Mean, Difference and Percentage operations;
- Difference means comparison B minus baseline A;
- Percentage means part of a named containing whole, not percentage change;
- checked fixed-point/rational behavior with typed unavailable results for zero
  denominator and overflow;
- typed History Purchase-ID handoff with no History-side calculation;
- 100-row rendered pages and a 500-ID selected-scope cap;
- shared workspace/controller state across wide and compact layouts.

The final dependency direction is accepted for permanent-domain classification:

```text
presentation
  -> application workspace and read port
  -> analytics domain models and versioned registry
  -> local Account-predicated repository adapter
```

History owns selection and typed handoff only. Analytics widgets remain
repository-free and calculation-free. Analytics cards remain session-local and
are neither serialized nor synchronized.

### 9.3 Validation and measured evidence

Final evidence records:

- focused tests: PASS;
- formerly blocked `markei_app_test.dart --concurrency=1`: PASS, 26 tests;
- full Flutter suite: PASS, 258 tests with 4 lab-gated skips, approximately
  82.7 seconds;
- `flutter analyze`: PASS;
- Windows release build: PASS;
- Android debug build: PASS;
- dependency, lockfile, schema, generated-source, provider, Sync, authorized-path
  and whitespace audits: PASS;
- validation-owned Dart, Flutter and SQLite processes remaining: none observed.

Repository request evidence:

```text
initial complete load=1
each Retry=+1
filtering/selection/execution/focus/reset/reorder=+0
```

Measured Windows-host fixtures:

| Fixture | Purchases / Items | Page | Selected scope | Load | Calculation | Gate |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| Ordinary Sum | 1,000 / 5,000 | 100 | 0 | 2 ms | 22 ms | PASS under 250 ms |
| Stress Mean | 10,000 / 50,000 | 100 | 500 | 6 ms | 302 ms | PASS under 1 s |

These measurements are committed test evidence from one Windows validation host;
they are not universal device-performance guarantees.

### 9.4 Corrective lifecycle classification

The R01 publication blocker was diagnosed as animated test-helper scrolling plus
eager loading of hidden Analytics content, which could leave app-shell tests
unfinished and retain SQLite/native tester resources.

R02 applied the bounded correction:

- tester-owned bounded `ensureVisible` behavior in the app-shell test helper;
- Analytics evidence loading gated by destination visibility;
- substantive assertions preserved;
- overflow converted to a typed unavailable result rather than wrapping or
  substituting floating-point behavior.

This is a validated lifecycle/testability correction, not a new product
capability or a redesign of the Analytics contract.

### 9.5 Evidence ceiling and non-claims

The following remain NOT_PERFORMED:

- screenshot-based rendered review;
- Narrator, TalkBack or other assistive-technology review;
- keyboard-only human acceptance;
- real Windows/Android device review;
- human comprehension and visual acceptance;
- locale review.

Widget/layout assertions and build artifacts are evidence, but they do not
substitute for those human or real-device checks. No KANBAN maturity transition
is implied by implementation alone.

The implementation introduced no schema, migration, dependency, lockfile,
generated-source, platform, API, Auth, Sync, provider or diagnostic change. It
provides no live Sync/provider evidence and changes no Cycle 10 or production
acceptance boundary.

### 9.6 Permanent-domain classification route

Run the ordinary post-Codex route through `SEQ-PRM-04` and the applicable
PDR2 prompt. Each functional chat must compare its checkpoint, paired G/H/I,
this latest J section, paired A/B/C context, relevant repository truth and its
four permanent semantic-role files.

Operational absorption should classify:

- the exact validation ladder, lifecycle correction, request counts, fixture
  sizes/timings, builds and forbidden-surface audits;
- the Windows-host measurement boundary;
- remaining screenshot, assistive-technology, real-device and human acceptance
  work as explicit gates rather than implementation failures.

Didactic absorption should classify:

- learner-visible twelve-field evidence vocabulary and honest unavailable states;
- determinant and operation meanings, especially B-minus-A and part-of-whole;
- History context transfer and responsive semantic parity;
- implementation/test evidence separately from learner mastery;
- KANBAN transitions as NONE unless independent promotion evidence exists.

Design absorption should classify:

- domain/application/infrastructure/presentation ownership;
- Account-predicated joined-read boundary and request-count invariant;
- evidence identity, Purchase-total deduplication and operation-specific types;
- session-local state, History handoff and visibility-gated lifecycle ownership;
- unchanged schema/dependency/provider/Sync boundaries.

Each role may commit and push only its four permanent files. Remote advancement
from another domain reconciliation must be integrated safely without force and
without rewriting another domain's commit.

### 9.7 Current terminal

```text
CYCLE=C11
C11_PH01_R01=IMPLEMENTED_VALIDATED_AUTOMATED_BUILD_CEILING
C11_PH02=IMPLEMENTED_VALIDATED_AUTOMATED_BUILD_CEILING
IMPLEMENTATION_COMMIT=20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6
PH01_CORRECTIONS=PASS
ANALYTICS_LOCAL_ACCOUNT_SCOPE=PASS
ACCOUNT_SCOPED_JOIN=PASS
OPERATION_COMPATIBILITY=PASS
CHECKED_FIXED_POINT_AND_OVERFLOW=PASS
HISTORY_PURCHASE_ID_HANDOFF=PASS
REPOSITORY_REQUEST_COUNT=initial:1; retry:+1; local_transitions:+0
ORDINARY_FIXTURE=PASS
STRESS_FIXTURE=PASS
FOCUSED_TESTS=PASS
FULL_FLUTTER_TEST=PASS
FLUTTER_ANALYZE=PASS
WINDOWS_BUILD=PASS
ANDROID_BUILD=PASS
SCHEMA_MIGRATION=NONE
DEPENDENCY_OR_GENERATED_CHANGE=NO
LIVE_SYNC_OR_PROVIDER_OPERATION=NONE
HUMAN_ASSISTIVE_TECH_REAL_DEVICE_ACCEPTANCE=NOT_PERFORMED
KANBAN_TRANSITIONS=NONE
PERMANENT_DOMAIN_ABSORPTION=PENDING_PDR2_O_A_D
NEXT_MAIN_ACTION=After all three domain commits are published, reconcile their permanent-memory results and select the bounded C11-PH03 entry.
```


---

<!-- TEMPORAL_MARKER:C11-PH03-MAIN-ACTIVATION-2026-07-31 -->
> Temporal boundary — Main permanent-absorption reconciliation and PH03 investigation activation. Section 9 remains the post-materialization record; section 10 is the latest chronological J authority.

## 10. C11-PH01-R01 + C11-PH02 permanent closure and C11-PH03 activation

### 10.1 Permanent-domain absorption verified

Main inspected the branch descendants of the section 9 reconciliation:

| Domain | Commit | Authorized permanent surface | Result |
| --- | --- | --- | --- |
| Operational | `43a3d6af3e254a6e22092203c424ead2f5300821` | four Operational permanent files | complete |
| Design | `318209b3afd8407e42ace1703476311032628558` | four Design permanent files | complete |
| Didactic | `7ca62a06e3dd7b48c28bee93be51a42f66c1aad9` | four Didactic permanent files | complete; KANBAN transitions none |

The three commits descend from the section 9 reconciliation
`0bfc02e8363d8119469a5e8627d8350fa97790b4`. Their combined change surface is
exactly the twelve role-owned permanent files. No source, test, staging,
methodology, Main-root, schema, dependency, generated-source, provider, Sync or
diagnostic file changed.

Operational, Didactic and Design checkpoints agree that C11-PH01-R01 and
C11-PH02 are implemented and validated at the automated/build ceiling and that
the next bounded unit is C11-PH03.

### 10.2 Closed result and retained evidence ceiling

C11-PH01-R01 and C11-PH02 are permanently absorbed. Their accepted result
includes the five-page reachability corrections, deterministic local
Account-scoped Analytics, typed History Purchase-ID handoff, checked
fixed-point/rational outcomes, request-count invariants, ordinary/stress
measurements, focused/full Flutter tests, analysis, Windows release build and
Android debug build recorded by section 9 and G/H/I.

The following remain explicit human or platform evidence gaps:

- screenshot-based rendered review;
- Narrator, TalkBack and other assistive-technology review;
- keyboard-only human acceptance;
- locale variation;
- real Windows/Android device review;
- human visual, interaction and learner-comprehension acceptance.

These gaps do not reopen the materialized implementation and do not authorize a
Didactic maturity transition. They remain bounded acceptance work for a later
human-evidence pass.

### 10.3 Selected PH03 product boundary

C11-PH03 is selected as the next functional investigation:

- Settings is a mandatory functional destination;
- Audit is a mandatory functional destination and replaces Closure in ordinary
  navigation;
- every existing Closure capability must receive an explicit disposition:
  Audit, Settings, an Advanced/Support surface, development-only support,
  retirement, or an unresolved decision retained for Main/human review;
- ordinary product navigation must not retain an ambiguous Closure destination
  after approved materialization.

PH03 is not the former R07 proposal under a new name. The investigation may use
existing local truth and established diagnostic vocabulary, but it must not
silently create a causal engine, diagnostic ledger, durable lifecycle, Sync
instrumentation redesign, provider observability path or hosted cross-device
Audit.

The following remain deferred to `C12-PHASE02`:

- multiple-Account and multiple-user assays;
- membership disablement and Device revocation;
- outage and acknowledgement-uncertainty recovery;
- retention, snapshot and rebootstrap;
- GCM04;
- backend/provider fine tuning;
- conditional R07 reassessment.

### 10.4 Investigation authority and required questions

Only fresh functional investigation is active. Authorized staging writers are:

```text
Operational Chat [O] -> DEV_STAGE/A_OPERATIONAL.md
Didactic Chat [A]    -> DEV_STAGE/B_DIDACTIC.md
Design Chat [D]      -> DEV_STAGE/C_DESIGN.md
```

The three investigations must determine, without source mutation:

1. the complete current Closure/Settings/Audit capability and data inventory;
2. safe read-only Audit history versus configuration, status, support and
   recovery actions;
3. Account scope, sanitization, freshness/staleness and no-network behavior;
4. navigation, responsive, keyboard, assistive-technology and unavailable-state
   meaning;
5. the exact capability-disposition matrix and ownership/dependency direction;
6. which controls are product-visible, Advanced/Support-only,
   development-only, retired or still unresolved;
7. the smallest schema-free, provider-free materialization boundary and its
   validation gates.

A/B/C may preserve disagreement. Their findings do not authorize D/E/F or
source changes. Main must reconcile the completed investigations before any
Codex prompt is prepared.

### 10.5 Current terminal

```text
CYCLE=C11
C11_PH01_R01=PERMANENTLY_ABSORBED
C11_PH02=PERMANENTLY_ABSORBED
OPERATIONAL_ABSORPTION=43a3d6af3e254a6e22092203c424ead2f5300821
DESIGN_ABSORPTION=318209b3afd8407e42ace1703476311032628558
DIDACTIC_ABSORPTION=7ca62a06e3dd7b48c28bee93be51a42f66c1aad9
KANBAN_TRANSITIONS=NONE
C11_CURRENT_UNIT=C11-PH03-INVESTIGATION
PH03_SCOPE=MANDATORY_SETTINGS_FUNCTIONAL_AUDIT_CLOSURE_DISPOSITION
PH03_STAGING_AUTHORITY=A_B_C_ONLY
PH03_SOURCE_AUTHORITY=NONE
D_E_F_AUTHORITY=NONE
CODEX_MATERIALIZATION_AUTHORITY=NONE
R07_IMPLEMENTATION_AUTHORIZED=NO
GCM04=DEFERRED_TO_C12_PHASE02
LIVE_SYNC_AUTHORITY=NONE
PROVIDER_MUTATION_AUTHORITY=NONE
NEXT_MAIN_ACTION=Seed and complete PH03 Operational Didactic Design investigations, then reconcile A/B/C before preparing any D/E/F.
```


---

<!-- TEMPORAL_MARKER:C11-PH03-POST-MATERIALIZATION-2026-07-31 -->
> Temporal boundary — Main post-materialization reconciliation for C11-PH03. Sections above preserve PH01/PH02 closure, PH03 investigation and materialization authority. Section 11 is the latest chronological J orientation for permanent-domain reconciliation.

## 11. C11-PH03 final materialization reconciliation

### 11.1 Repository and evidence boundary

~~~text
REPOSITORY=gus-i-gu/markei
BRANCH=grm-guarded-provisioning-20260727
MATERIALIZATION_AUTHORITY_COMMIT=256ee4dbbcb790419b816862ee42933a115ddd87
IMPLEMENTATION_COMMIT=0924e743931ea7aba2c9cc5d2e28063e737b2ff5
IMPLEMENTATION_PARENT=256ee4dbbcb790419b816862ee42933a115ddd87
ROUND=C11-PH03-R01
PUBLICATION=PUSHED
~~~

The implementation is one descendant of the synchronized PH03 D/E/F authority.
It changed exactly 19 authorized paths:

- 9 Flutter source files;
- 7 Flutter test files;
- G_OPS_CODEX.md, H_DDC_CODEX.md and I_DSN_CODEX.md.

No permanent-domain file, Main-root continuity file, methodology file, A/B/C,
D/E/F, schema, migration, generated Drift source, dependency, lockfile,
diagnostic contract/registry, server/API, provider or environment file changed.

Controlling post-materialization evidence is:

~~~text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
~~~

A/B/C remain the investigative intent and disagreement record. D/E/F are
consumed implementation authority and do not authorize a corrective PH03 source
round. Final G/H/I and repository commit 0924e743 supersede pre-materialization
claims that Audit was reserved or that PH03 remained investigation-only.

### 11.2 Reconciled functional result

Settings is implemented within the bounded PH03 product meaning:

- persisted shortage threshold is loaded rather than overwritten;
- only whole values from 0 through 365 are accepted;
- invalid draft input remains available for correction;
- loading, empty, read-error, save-error and saved states remain distinct;
- reference lists refresh after archive;
- duplicate asynchronous actions are blocked;
- local preference actions remain Account-scoped and local;
- Account and Sync/Device sections delegate through capability-narrow adapters
  over existing behavior rather than changing Auth or Sync contracts.

Audit is implemented as ordinary product activity history:

- available from wide and medium navigation and compact More;
- local, read-only, Account/environment-scoped and sanitized;
- visibility-gated on first load with stale-completion suppression;
- exactly one attempt query plus one child-event query per page;
- default 20-attempt page and hard maximum 50;
- deterministic exclusive cursor using UTC start time plus persisted attempt ID;
- explicit loading, ready, empty, stale, bounded-window and unavailable meaning;
- local Retry repeats only the same read;
- zero Audit network calls and zero Audit writes;
- no broad Closure runner, Auth mutation, enrollment, Sync, Recovery,
  delete-history or provider capability enters Audit.

Closure is retired from ordinary product navigation under both feature-flag
values. Native Closure pages, runners and diagnostic infrastructure may remain
only as unreachable development/support implementation where already present.
No product-facing destructive or highly technical Closure control was
introduced.

### 11.3 Architecture and capability disposition

The accepted PH03 dependency direction is:

~~~text
Audit presentation
  -> Audit controller and capability-narrow read port
  -> local diagnostic projection repository
  -> existing persisted attempts/events and read-only diagnostic registry meaning
~~~

Settings presentation depends on existing local repositories and
capability-narrow Account and Sync/Device support ports. Presentation does not
own provider, Auth, Sync or causal authority.

Accepted capability placement:

| Capability | Reconciled disposition |
| --- | --- |
| local preferences and reference management | Settings |
| current Account, Device and Sync readiness/actions already supported | Settings through narrow adapters |
| recent sanitized local diagnostic attempts/events | Audit |
| local Audit Retry | Audit read retry only |
| Closure product destination | retired |
| raw diagnostics, hosted probes, unknown-outcome recovery, delete-history and provider maintenance | absent from ordinary UI; development-only where retained |
| former R07 causal/backend engine | not authorized and not implemented |

Composition owns one Audit controller and idempotent database/controller
disposal. Audit uses persisted identities, deterministic paging and bounded
two-query loading without schema, migration, provider or generated-source work.

### 11.4 Validation and evidence ceiling

Committed automated/build evidence:

- dependency and lockfile audit: PASS;
- formatting: PASS;
- flutter analyze: PASS;
- all focused Settings, Audit, Closure-navigation, app-shell, visual-foundation,
  composition and repository tests: PASS;
- full Flutter suite with concurrency 1: PASS, 264 tests passed and 4 lab-only
  tests skipped in 88.4 seconds;
- Windows release build: PASS in 49.9 seconds;
- Android debug build: PASS in 80.4 seconds;
- diagnostic-registry drift check: PASS;
- git diff check: PASS with line-ending warnings only;
- resource disposal: PASS;
- schema, migration, generated-source, dependency, API/Auth/Sync/provider
  contract change: NONE;
- live provider, hosted or Sync operation: NOT PERFORMED.

Human direction after UI verification classifies the visible PH03 result as
successful enough for documentation and permanent-domain absorption. Minor
non-blocking UI refinements are deferred to C12-PH01 and do not reopen
C11-PH03 implementation.

That human direction does not establish unperformed evidence. Screenshot sets,
Narrator/TalkBack, locale coverage, real-device coverage, full keyboard-only
acceptance and learner comprehension remain absent unless separately recorded.
No KANBAN maturity transition follows from implementation, tests, builds or the
bounded UI acceptance statement.

### 11.5 State-of-union and documentation drift

C11-PH01-R01 and C11-PH02 remain permanently absorbed. C11-PH03 is now
implemented and validated at the automated/build ceiling, with bounded human UI
acceptance sufficient to proceed.

The current permanent domain checkpoints and Main-root 00/05/06 still describe
the pre-materialization PH03 investigation boundary. This is expected
documentation lag, not source uncertainty.

The next required transition is:

~~~text
J section 11
-> Operational PDR
-> Didactic PDR
-> Design PDR
-> Main verification of all three permanent commits
-> 00_PROJECT_STATE / 05_SESSION_LOG / 06_SESSION_SCHEME closure refresh
-> C12-PH01 bounded UI/UX fine-tuning entry
~~~

Do not update 00/05/06 before the three domain reconciliations are complete.
Do not restage D/E/F or begin another C11 implementation round solely for minor
UI refinements.

### 11.6 Permanent-domain classification route

Operational must absorb:

- exact validation commands/results and the 264-pass/4-skip full-suite boundary;
- Settings persistence, validation, local failure and duplicate-action behavior;
- Audit two-query, zero-network, zero-write, Account/environment and sanitization
  invariants;
- Windows/Android build evidence, resource disposal and unchanged forbidden
  surfaces;
- human UI acceptance as bounded and minor C12-PH01 polish as deferred;
- live provider/Sync and remaining platform/human gates as NOT PERFORMED.

Didactic must absorb:

- Settings as configuration and bounded Account/Device readiness, not recovery;
- Audit as recent sanitized local activity history, distinct from Purchase
  History and current status;
- local, bounded, stale, empty and unavailable vocabulary;
- Closure as retired product vocabulary;
- technical classifications as safe guidance, not causal explanation;
- wide/compact meaning, test-backed focus/text-scale evidence and bounded human
  UI acceptance;
- KANBAN transitions as NONE and learner comprehension as not established.

Design must absorb:

- AuditReadPort/controller/local-projection ownership and dependency direction;
- persisted attempt/event identity and composite cursor paging;
- fixed two-query page boundary, Account/environment predicates and sanitized
  registry projection;
- capability-narrow Settings ports, Closure navigation retirement and explicit
  development-only capability retention;
- composition lifecycle ownership and rollback boundary;
- unchanged schema, generated, dependency, API/Auth/Sync/provider and R07
  boundaries;
- minor UI polish as C12-PH01 work rather than PH03 architectural reopening.

Each role must reconcile from its checkpoint, paired A/B/C and G/H/I, this
section 11 and its four permanent files. Each role may commit and push only its
four permanent files. Compatible sibling-domain commits must be preserved
without force; unrelated advancement is a stop condition.

### 11.7 Current terminal

~~~text
CYCLE=C11
C11_PH01_R01=PERMANENTLY_ABSORBED
C11_PH02=PERMANENTLY_ABSORBED
C11_PH03=IMPLEMENTED_VALIDATED_AUTOMATED_BUILD_CEILING
PH03_IMPLEMENTATION_COMMIT=0924e743931ea7aba2c9cc5d2e28063e737b2ff5
SETTINGS_FUNCTIONAL=PASS
AUDIT_FUNCTIONAL=PASS
AUDIT_LOCAL_READ_ONLY=PASS
AUDIT_NETWORK_CALLS=0
AUDIT_WRITE_CALLS=0
AUDIT_QUERIES_PER_PAGE=2
ACCOUNT_ENVIRONMENT_ISOLATION=PASS
SANITIZATION=PASS
CLOSURE_ORDINARY_NAVIGATION=ABSENT
CLOSURE_CAPABILITY_DISPOSITION=PASS
RESOURCE_DISPOSAL=PASS
FOCUSED_TESTS=PASS
FULL_FLUTTER_TEST=PASS_264_WITH_4_LAB_SKIPS
FLUTTER_ANALYZE=PASS
WINDOWS_RELEASE_BUILD=PASS
ANDROID_DEBUG_BUILD=PASS
SCHEMA_MIGRATION=NONE
DEPENDENCY_GENERATED_API_AUTH_SYNC_PROVIDER_CHANGE=NO
LIVE_PROVIDER_OR_SYNC_OPERATION=NOT_PERFORMED
HUMAN_UI_VERIFICATION=ACCEPTED_WITH_MINOR_C12_PH01_CARRYOVER
HUMAN_ASSISTIVE_TECH_LOCALE_REAL_DEVICE_COMPREHENSION=NOT_ESTABLISHED
KANBAN_TRANSITIONS=NONE
C11_D_E_F_AUTHORITY=CONSUMED
C11_CORRECTIVE_SOURCE_ROUND=NOT_REQUIRED
PERMANENT_DOMAIN_ABSORPTION=PENDING_PDR_O_A_D
C12_PH01=NEXT_AFTER_DOMAIN_AND_MAIN_CLOSURE
C12_PHASE02=BACKEND_GCM04_AND_CONDITIONAL_R07_DEFERRED
NEXT_MAIN_ACTION=Run Operational Didactic and Design permanent reconciliations from J section 11, then verify all three commits before refreshing 00/05/06.
~~~

---

<!-- TEMPORAL_MARKER:C11-PH03-PERMANENT-CLOSURE-PH04-ACTIVE-2026-07-31 -->
> Temporal boundary — Main verified complete C11-PH03 permanent-domain
> absorption and refreshed Main continuity. Section 12 is the latest
> chronological J orientation. The later PH04 D/E/F packet is preserved as
> separate, unconsumed Analytics-only implementation authority.

## 12. C11-PH03 permanent closure and C11-PH04 authority

### 12.1 Verified reconciliation chain

~~~text
PH03_IMPLEMENTATION=0924e743931ea7aba2c9cc5d2e28063e737b2ff5
PH03_POST_MATERIALIZATION_J=33dc1002b4a7b00fa67e863dfe98a43c97d66cee
OPERATIONAL_RECONCILIATION=f8fa5b57829255ff3734a9eebf683f43aaec07cb
DIDACTIC_RECONCILIATION=dc09265a09bc7746b708a5bc93d428d105c3978b
DESIGN_RECONCILIATION=cc53e6ef063d43342394a55165dd188ddd4ce491
PH04_D_E_F_AUTHORITY=35cf23602060fd3a186a2470d7ac322c795e5fce
~~~

Main verified that this is one strict linear descendant chain from section 11.
The three domain commits change exactly their twelve owned permanent files:

- Operational: 04, 10, 11 and 12;
- Didactic: 02, 07, 08 and 13;
- Design: 01, 03, 09 and 14.

The PH04 authority commit changes only D_OPS_STAGE.md, E_DDC_STAGE.md and
F_DSN_STAGE.md. No source, test, G/H/I, Main-root, J, methodology, schema,
migration, generated source, dependency, API/Auth/Sync/provider or diagnostic
surface changed in these four documentation commits.

### 12.2 Permanent PH03 state of union

Operational permanent memory accepts:

- persisted Settings threshold loading and 0–365 whole-value validation;
- correction-preserving failure states, reference refresh and duplicate-action
  prevention;
- local read-only sanitized Account/environment Audit;
- deterministic 20-default/50-maximum composite-cursor paging;
- two local queries per Audit page, zero Audit network calls and zero writes;
- resource disposal, focused/full tests, analysis and Windows/Android builds;
- remaining human/platform gates and live provider/Sync work as unperformed.

Didactic permanent memory accepts:

- Settings as local configuration and bounded readiness, not Recovery;
- Audit as recent sanitized local activity history, distinct from Purchase
  History and current status;
- local, bounded-window, loading, empty, stale and unavailable distinctions;
- diagnostic classification as safe guidance, not causal explanation;
- Closure as retired ordinary product vocabulary;
- automated accessibility evidence and bounded human UI continuation without a
  learner-maturity transition.

Design permanent memory accepts:

- Audit presentation -> controller/read port -> local diagnostic projection;
- persisted attempt/event identity and exclusive UTC-time-plus-ID cursor;
- Account/environment predicates, sanitized projection and fixed two-query
  loading;
- capability-narrow Settings ports and idempotent composition disposal;
- Closure navigation retirement with retained unreachable development/support
  infrastructure;
- unchanged schema, generated, dependency, API/Auth/Sync/provider and former
  R07 boundaries;
- rollback to PH03 authority parent `256ee4dbbcb790419b816862ee42933a115ddd87`.

The three domains agree. No unresolved PH03 cross-domain contradiction remains.
No KANBAN maturity changed.

### 12.3 Evidence ceiling and deferrals

C11-PH03 is permanently closed as implemented and validated at the recorded
automated/build ceiling. The full Flutter result remains 264 passes with four
lab-only skips. Human UI verification is accepted for documentation closure.

The following remain unestablished, not failed or implicitly passed:

- formal screenshot-set evidence;
- Narrator and TalkBack;
- locale and long-string review;
- real-device, density and orientation review;
- complete keyboard-only acceptance;
- learner comprehension or transfer;
- live Sign in, enrollment, hosted connection, Sync, Recovery or provider work.

GCM04, multiple-Account/provider assays, revocation, outage recovery,
retention/rebootstrap, conditional R07 and production lifecycle remain deferred
to C12-PHASE02.

### 12.4 PH04 scheduling correction and authority boundary

Human direction activated C11-PH04-R01 after PH03 domain absorption. This
supersedes section 11's deferral of every UI refinement to C12-PH01 only for the
bounded Analytics correction in the synchronized D/E/F activation-marker tails.

PH04 is authorized to improve the existing Analytics composition through:

- explicit analysis composition and determinant-value selection;
- immutable session-only saved analysis records and bounded fingerprints;
- one selected result with Chart/Table parity and explicit CSV/PDF export;
- truthful interpretation, timeframe and evidence counts;
- Purchase and contained-Item Variables projections below the initial viewport;
- shared wide/compact state, accessibility and rendered-review evidence.

PH04 retains PH02 local Account scope, fixed-point operation semantics,
single-load/request-count rules, History handoff and evidence identity. It does
not reopen PH03 and authorizes no analysis-record persistence, second Analytics
truth, schema/migration/generated/dependency change, Auth, Sync, provider,
diagnostic, causal, predictive or recommendation work.

The current D/E/F authority is unconsumed. PH04 implementation must replace
G/H/I with new evidence, after which Main must reconcile the result and schedule
bounded human rendered comparison. Other UI/UX polish remains in C12-PH01.

### 12.5 Current terminal

~~~text
CYCLE=C11
C11_PH01_R01=PERMANENTLY_ABSORBED
C11_PH02=PERMANENTLY_ABSORBED
C11_PH03=PERMANENTLY_ABSORBED
PH03_PERMANENT_DOMAIN_FILES=12_OF_12
PH03_CROSS_DOMAIN_CONTRADICTIONS=NONE
PH03_HUMAN_UI_ACCEPTANCE=ACCEPTED_BOUNDED
PH03_ASSISTIVE_TECH_LOCALE_REAL_DEVICE_COMPREHENSION=NOT_ESTABLISHED
KANBAN_TRANSITIONS=NONE
C11_CURRENT_UNIT=C11-PH04-R01
PH04_SCOPE=ANALYTICS_FINE_TUNING_ONLY
PH04_D_E_F_ACTIVATION_COMMIT=35cf23602060fd3a186a2470d7ac322c795e5fce
PH04_D_E_F_AUTHORITY=ACTIVE_UNCONSUMED
PH04_IMPLEMENTATION=NOT_YET_MATERIALIZED
PH04_G_H_I=NOT_YET_PRODUCED
PH03_SOURCE_REOPENED=NO
LIVE_SYNC_AUTHORITY=NONE
PROVIDER_MUTATION_AUTHORITY=NONE
GCM04=DEFERRED_TO_C12_PHASE02
R07_IMPLEMENTATION_AUTHORIZED=NO
C12_PH01=REMAINING_UI_UX_POLISH_AFTER_PH04
C12_PHASE02=BACKEND_GCM04_AND_CONDITIONAL_R07_DEFERRED
NEXT_MAIN_ACTION=Materialize C11-PH04 from the 35cf236 D/E/F authority, then reconcile PH04 G/H/I and bounded human rendered evidence.
~~~

---

<!-- RECONCILIATION_MARKER:C11-PH05-R01-2026-07-31 -->

# Cycle 11 PH05 Round 01 — Main Reconciliation and Codex Activation

## 13.1 Identity, authority and branch state

```text
ROLE=Main Chat [M]
SEQUENCE=FLX-INV-02_TO_ACTIVATED_MATERIALIZATION
REPOSITORY=gus-i-gu/markei
BRANCH=grm-guarded-provisioning-20260727
STARTING_REMOTE_HEAD=42cb6fcac60a5033c72864201786f7fcfab9a35b
PH04_ACTIVATION=35cf23602060fd3a186a2470d7ac322c795e5fce
PH04_IMPLEMENTATION=1aea7a5b531b56484e999aa8989978902b8db2c0
PH04_PH05_RECONCILIATION_MERGE=42cb6fcac60a5033c72864201786f7fcfab9a35b
PH05_OPERATIONAL=c4ebbdc2a8957f132f2a97aeed66d1c7e06dabef
PH05_DIDACTIC=611943a4f18cf34f0f1ca5ea58b8b69401c07abe
PH05_DESIGN=837d988715835be13ab7a2657adce06336f5bb2c
```

This section reconciles the three C11-PH05 investigative A/B/C appends against
the final committed PH04 implementation and activates the paired PH05 D/E/F
packet. It authorizes no permanent-domain, Main-root or methodology change.

## 13.2 PH04 reconciliation correction

PH04 is no longer an unmaterialized worktree candidate. The human-supervised
recovery created implementation commit `1aea7a5b531b56484e999aa8989978902b8db2c0`
and reconciliation merge `42cb6fcac60a5033c72864201786f7fcfab9a35b`.
The remote branch now contains the final Analytics composer, immutable
session-record model, Chart/Table projections, Variables Purchase/Item views,
pure CSV/PDF builders and PH04 G/H/I evidence.

The G terminal value `PUBLICATION=NOT_PUSHED` remains truthful about Codex's
blocked attempt at the time that report was written. It is not the current
repository publication state. Current repository truth is:

```text
PH04_CODEX_PUBLICATION_ATTEMPT=NOT_PUSHED
PH04_RECOVERY_PUBLICATION=PUSHED
PH04_IMPLEMENTATION_REMOTE_ANCESTOR=YES
PH04_AUTOMATED_AND_BUILD_EVIDENCE=PASS_AT_RECORDED_CEILING
PH04_HUMAN_RENDERED_ASSISTIVE_TECH_LOCALE_REAL_DEVICE_COMPREHENSION=NOT_ESTABLISHED
```

PH04 does not require source correction before PH05. PH05 may modify the final
Analytics handoff wording and explicit export sink while preserving one
workspace, one local evidence load, session-only records and pure builders.

## 13.3 A/B/C verification and corrections

All three C11-PH05 markers exist once in their paired append-only files. Their
commits are compatible and their conclusions are sufficiently complementary for
Main synthesis. They inspected pre-PH04 source, so their PH04 status statements
are superseded by section 13.2.

| Area | Reconciled repository fact | Main disposition |
| --- | --- | --- |
| Home | Four destination cards; no News/feed/status model | add two build-bundled information cards; zero I/O |
| Purchase | `Store and time` plus independent nullable Person/Payment references | responsive regrouping only; rename optional group |
| Catalogue | `_selectedProduct` plus `DataRow.onSelectChanged` creates automatic checkbox/selected chrome | Operational/Design are correct; Didactic checkbox-absent claim is corrected; remove the complete unused selection owner |
| History | `_selectedIds` already supports zero/one/many/final-uncheck; `_selectedPurchaseId` separately owns detail | harden semantics, stale/filter reconciliation and action safety; no second selection controller |
| History scope | repository returns at most 50 recent Purchases | `Select all shown` means the current filtered loaded window only |
| Analytics handoff | stable Purchase IDs already expand to final PH04 Item scope; current message wrongly says Analytics will calculate | retain typed boundary; change message/copy only where possible; no automatic Run or record |
| Exports | History performs N detail reads; History and Analytics write fixed temp paths | add one shared injected destination; set-based History reads; one final write per explicit success |
| Guide | destination exists as one-sentence `_StaticPage` | dedicated local `GuidePage`, eight sections, contents/anchors, no search |
| Audit | already-loaded bounded local attempts/events; two local queries | add pure System/Readiness summary/Diagnostics projections; no new read or truth owner |
| Settings | one page state; five initial calls; `_runSupportAction` suppresses intended refresh through `_busy` re-entry | Account-first recomposition; visible Advanced; internal refresh correction; current Device only |
| short codes | `@NNN` and `#NNN` are stored visible references; UUIDs remain stable object identity | preserve both; `$NNN` deferred |

## 13.4 Human/Main decisions resolved for PH05

1. Home uses the visible titles `News` and `Updates follow-up`. Both are static,
   local and labelled as preview information; neither links to a live service.
2. `Updates follow-up` exposes only completed/in progress/planned labels whose
   statements are supported by committed repository state. Its date is the
   build-content date, not a remote publication timestamp.
3. Purchase uses `Optional purchase details`. Person and Payment Method remain
   independent optional Purchase metadata; Store/date/time remain required.
4. Catalogue removes automatic checkboxes, selection state, selected copy and
   highlight. Explicit `View details` remains mandatory; identifying cells/cards
   may also open the same detail state.
5. History filters prune action selection to the newly shown filtered set. A
   successful reload intersects selection and detail with returned Account rows.
6. History uses `Select all shown`, `Clear selection`, and `N purchases selected`.
   It does not introduce paging or Account-wide selection in PH05.
7. The History handoff label is `Use in Analytics`.
8. A handoff initializes PH04 composer scope only. It performs no calculation,
   creates no saved record and changes no Purchase fact. Analytics reports
   requested, matched and unavailable Purchase counts.
9. Guide is a dedicated local page with a contents list and anchored/focusable
   sections. Search, CMS and expandable technical topics are deferred.
10. Audit uses `Readiness summary`, not `Health`. It is a pure interpretation of
    the already-loaded bounded local Audit window.
11. Settings order is Account; Purchase references and shortage timeframe; Sync
    and Device; visible non-collapsible Advanced. The current Device summary is
    sufficient; no Device list/revocation work is added.
12. Duplicate reference nicknames remain governed by existing repository truth;
    PH05 adds no new uniqueness rule.
13. `@NNN` and `#NNN` remain the visible stored short codes. `$NNN` is not used.
14. The shared export port and adapter paths are accepted. Windows exports to
    the user-visible Downloads directory through the existing `path_provider`
    dependency. Android public Downloads is not authorized in this packet;
    Android returns a typed unavailable result and never labels temp or
    app-private storage as Downloads. Native sharing remains deferred.

## 13.5 Activated implementation slices

The PH05 packet is one bounded schema-free implementation, but Codex should work
and validate in these internal slices:

1. Home, Purchase and Catalogue presentation correction.
2. History multi-selection, set-based export bundle and typed Analytics handoff.
3. Shared export destination plus final PH04 Analytics sink integration.
4. Guide, Audit interpretation and Settings recomposition/refresh correction.
5. focused validation, full regression/build validation and G/H/I replacement.

Codex may use multiple local commits when useful, but publication must present
one coherent descendant chain on the named branch and no unrelated cleanup.

## 13.6 Cross-domain accepted invariants

- local-first Account scope and registered Purchase immutability remain intact;
- PH04 Analytics calculation, compatibility, session-record identity and one
  workspace remain intact;
- presentation and selection transitions add zero repository/network writes;
- History detail state remains distinct from selected-for-action state;
- explicit export is distinct from sharing and from temporary artifact creation;
- Audit remains local, sanitized, bounded, read-only and non-causal;
- Settings retains existing narrow ports and explicit action coordinators;
- Closure remains absent from ordinary product navigation;
- no schema, migration, generated source, dependency, Auth, Sync, provider,
  diagnostic-registry or production-lifecycle expansion is authorized;
- `KANBAN_TRANSITIONS=NONE`.

## 13.7 Evidence and claim ceiling

PH04 automated tests and builds may be cited only for the final committed PH04
scope. They do not validate PH05. PH05 requires fresh focused tests, the full
Flutter suite, analysis, Windows release build, Android debug build, diagnostic
registry check, exact-path audit and forbidden-surface audit.

Rendered screenshots, keyboard-only review, Narrator/TalkBack, locale/long-copy,
real-device Downloads behavior and human comprehension remain distinct evidence.
Codex must record them as `NOT_PERFORMED` unless directly observed.

## 13.8 Current terminal

```text
CYCLE=C11
PHASE=C11-PH05
ROUND=C11-PH05-R01
STARTING_REMOTE_HEAD=42cb6fcac60a5033c72864201786f7fcfab9a35b
PH04_IMPLEMENTATION=1aea7a5b531b56484e999aa8989978902b8db2c0
PH04_RECONCILIATION_MERGE=42cb6fcac60a5033c72864201786f7fcfab9a35b
PH04_REMOTE_STATE=IMPLEMENTED_AND_AUTOMATED_BUILD_VALIDATED
PH04_HUMAN_EVIDENCE=PARTIAL_NOT_CLOSED
PH05_A_B_C=VERIFIED_RECONCILED
CATALOGUE_CHECKBOX_FACT=AUTOMATIC_CHROME_PRESENT_AND_AUTHORIZED_FOR_REMOVAL
HISTORY_SELECTION=RETAIN_ONE_STABLE_ID_SET_AND_HARDEN
HISTORY_SELECT_ALL=FILTERED_LOADED_WINDOW_ONLY
ANALYTICS_HANDOFF=USE_IN_ANALYTICS_SCOPE_ONLY
EXPORT_WINDOWS_DOWNLOADS=AUTHORIZED
EXPORT_ANDROID_PUBLIC_DOWNLOADS=UNAVAILABLE_DEFERRED
GUIDE=EIGHT_LOCAL_ANCHORED_SECTIONS
AUDIT_CARD_LABEL=READINESS_SUMMARY
SETTINGS_ORDER=ACCOUNT_REFERENCES_SYNC_ADVANCED
REFERENCE_CODES=RETAIN_AT_AND_HASH
KANBAN_TRANSITIONS=NONE
LIVE_PROVIDER_OPERATIONS=NONE
PH05_D_E_F_AUTHORITY=ACTIVE
CODEX_AUTHORITY=ACTIVE_AFTER_THIS_COMMIT
NEXT_MAIN_ACTION=Wait for Codex PH05 implementation and G/H/I, then perform bounded human review and post-materialization reconciliation.
```

---

<!-- RECONCILIATION_MARKER:C11-PH05-R02-2026-07-31 -->

# Cycle 11 PH05 Round 02 — Post-Materialization Main Reconciliation

## 14.1 Identity, publication and evidence boundary

```text
ROLE=Main Chat [M]
SEQUENCE=FLX-PRM-04_PREPARATION
REPOSITORY=gus-i-gu/markei
BRANCH=grm-guarded-provisioning-20260727
PH05_AUTHORITY=b59b2ecdfb69ca98c431b9f36694f011332fbef3
PH05_IMPLEMENTATION=426235d8b67ac719e494b53cfb23a6c3b06fb489
PH05_IMPLEMENTATION_PARENT=b59b2ecdfb69ca98c431b9f36694f011332fbef3
PH05_REMOTE_DELTA=ONE_COMMIT
PH05_G_H_I=REPLACED_AND_PUBLISHED
```

The remote branch advanced from the PH05 authority to the implementation by one
commit with no intervening history. This reconciliation compares section 13 and
the active D/E/F packet with committed source, tests and PH05 G/H/I.

This section authorizes the three functional chats to run their paired PDR2
permanent-domain reconciliations. It does not authorize source changes,
methodology changes, Main-root 00/05/06 changes, a new D/E/F packet or another
Codex round.

## 14.2 Implemented and validated PH05 state

The following outcomes are implemented and supported by the recorded
automated/build evidence:

- Home exposes static local News and Updates follow-up content with zero I/O.
- Purchase uses `Optional purchase details`; Person and Payment Method remain
  independent optional metadata.
- Catalogue ordinary selection ownership, generated checkbox chrome, counter and
  selected highlight are removed while Product detail activation remains.
- History owns one stable selected-for-action Purchase-ID set separate from
  detail state. Final-uncheck, filter pruning, reload intersection and bounded
  `Select all shown` behavior are covered.
- `Use in Analytics` transfers Purchase scope only and exposes requested,
  matched and unavailable counts without calculating, saving or mutating.
- one shared `ExportDestinationPort` and one composition-injected
  `LocalExportDestination` separate pure History/Analytics builders from file
  effects;
- non-empty History selected export performs two set-based Account-scoped local
  reads, zero database writes and zero network calls;
- one successful explicit export produces one collision-safe final file;
  Windows resolves Downloads, while Android public Downloads returns a typed
  unavailable result and writes zero files;
- Audit System, Readiness summary and Diagnostics cards project the already
  loaded bounded local state with no new read, write or network authority;
- Settings is Account-first and its support-action lifecycle refreshes status
  while retaining the duplicate-action guard;
- stored `@NNN` and `#NNN` references remain unchanged.

Recorded validation passed: dependency-lock guard, formatting, analysis, focused
PH05 and affected regression tests, the full Flutter suite with 278 passed and
4 lab-gated skips, Windows release build, Android debug build, diagnostic
registry drift check and diff check. No schema, migration, generated Drift,
dependency, native platform, Auth, API, Sync, provider, diagnostics contract or
Closure expansion was introduced.

Recorded operation ceilings remain:

```text
HOME_IO=0
GUIDE_IO=0
HISTORY_SELECTED_EXPORT_READS=2
HISTORY_SELECTED_EXPORT_DATABASE_WRITES=0
HISTORY_SELECTED_EXPORT_NETWORK_CALLS=0
SUCCESSFUL_EXPORT_FINAL_WRITES=1
ANDROID_UNAVAILABLE_EXPORT_WRITES=0
ANALYTICS_REQUESTS=initial:1; retry:+1; handoff_export_local_ui:+0
ANALYTICS_DATABASE_WRITES=0
ANALYTICS_NETWORK_CALLS=0
AUDIT_IO=initial_queries:2; retry:+2; projection:+0; writes:0; network:0
SETTINGS_CALLS=initial:5; local_refresh:+2
```

## 14.3 Defects, deviations and claim ceiling

PH05 is not classified as completely human-validated.

First, committed `guide_page.dart` contains eight local anchored sections and
therefore establishes the structural owner, navigation and zero-I/O result.
However, its section sequence is Home, Purchase, Catalogue, History, Analytics,
Exports, Audit and Settings. This does not fully materialize E section 35's
accepted learner sequence: the Lists teaching boundary is absent, and the
Getting-started plus local-data/export/Sync-limit boundaries are redistributed.
Accordingly:

```text
GUIDE_STRUCTURE=IMPLEMENTED_AND_AUTOMATED
GUIDE_EIGHT_SECTION_COUNT=VALIDATED
GUIDE_ACCEPTED_LEARNER_SEQUENCE=PARTIALLY_CONTRADICTED
GUIDE_HUMAN_COMPREHENSION=NOT_ESTABLISHED
```

Second, later human runtime screenshots expose an Analytics defect and
composition mismatch that the passing PH04/PH05 tests did not detect. The
visible result may present a Quantity value/unit unrelated to the requested
variables and operation; the composer remains vertically expensive and splits
breakdowns/measures into pill banks; custom time uses a raw interval field; and
the evidence view exposes Purchase identifiers where Date-Time of purchase and
Store name are required.

The human has accepted the correction direction: one compact Group by /
Variables / Operation / Timeframe composer, a unified typed Variables control,
two custom date fields in `dd-mm-yyyy`, and user-facing Date-Time plus Store
identity while retaining stable IDs internally. Those decisions are accepted
human direction, not implemented PH05 state.

The wrong-variable root cause is not established. It may not be described as a
visual-only defect, nor may current tests be used to claim calculation-variable
integrity. A read-only Main state-of-union must trace composer draft through
validation, immutable record, grouped execution, chart/table, interpretation
and CSV/PDF before any corrective J/D/E/F authority is written.

Human screenshot review is therefore partial and defect-finding, not acceptance.
Keyboard-only manual review, Narrator/TalkBack, locale review, real-device
behavior and learner comprehension remain not established. Windows/Android
build success does not establish real-device export acceptance or Android
public-Downloads support.

## 14.4 Permanent-domain classification route

Operational must reconcile:

- the exact PH05 commands, 278-pass/4-skip suite boundary and both build results;
- Home/Guide zero-I/O, History two-read/zero-write/zero-network export and one
  final-write semantics;
- Analytics, Audit and Settings request/query/call budgets;
- Windows Downloads as implemented and automated at the recorded ceiling, with
  manual host/real-device behavior still unvalidated;
- Android public Downloads as typed unavailable with zero writes;
- unchanged schema/dependency/platform/provider surfaces and one-commit
  rollback boundary;
- the human-observed Analytics wrong-variable defect as active corrective work
  with root cause unestablished;
- remaining rendered, keyboard, assistive-technology, locale, real-device and
  comprehension gates.

Didactic must reconcile:

- final PH05 vocabulary: Optional purchase details, Select all shown, Use in
  Analytics, Readiness summary, export-not-sharing and `@NNN`/`#NNN`;
- selection/detail and Analytics scope/calculation distinctions;
- represented/tested/built versus human-observed/learner-understood evidence;
- Guide as eight-section anchored implementation but not faithful completion of
  the accepted learner sequence;
- the Analytics composer/result mismatch as a learner-facing defect;
- unified Variables and two-date-field direction as accepted but not
  implemented;
- `KANBAN_TRANSITIONS=NONE` unless independent evidence justifies a specific
  transition.

Design must reconcile:

- the single shared export port/adapter and pure-builder dependency direction;
- two-query set reconstruction, stable History selection/detail ownership and
  scope-only Analytics handoff;
- one composition-owned Analytics workspace and unchanged fixed-point/schema
  boundaries;
- local Guide typed owner, loaded-state-only Audit projections and unchanged
  Settings controller ownership;
- the Guide content-model deviation from the accepted learner contract;
- Analytics variable integrity as a current defect requiring typed end-to-end
  investigation, without presuming a second controller or schema change;
- rollback to `b59b2ecdfb69ca98c431b9f36694f011332fbef3` and all deferred
  native/provider boundaries.

Each role must run `SEQ-PRM-04` and its selected `PDR2-O`, `PDR2-A` or
`PDR2-D` route. Each role may commit and push only its four permanent files.
Compatible sibling-domain permanent reconciliations may advance the branch and
must be preserved. Unrelated advancement or source overlap is a stop condition.
No role may edit J, A/B/C, D/E/F, G/H/I, Main-root files, methodology or source.

## 14.5 State of union and next transition

PH05 source work is complete at the recorded automated/build ceiling. Its D/E/F
authority is consumed. Permanent memory is now stale until the three domain
PDR2 commits absorb both the achieved state and the preserved defects.

The Analytics correction remains a separate prospective bounded round. Permanent
reconciliation may proceed now because it will classify, not erase, that defect.
A new Main D/E/F packet must wait for the read-only Analytics state-of-union and
root-cause contract already requested by the human.

Do not refresh 00_PROJECT_STATE, 05_SESSION_LOG or 06_SESSION_SCHEME until all
three permanent-domain commits have been verified by Main. Do not activate a
corrective Codex round from this section.

## 14.6 Current terminal

```text
CYCLE=C11
PHASE=C11-PH05_POST_MATERIALIZATION
ROUND=C11-PH05-R02
PH05_AUTHORITY=b59b2ecdfb69ca98c431b9f36694f011332fbef3
PH05_IMPLEMENTATION=426235d8b67ac719e494b53cfb23a6c3b06fb489
PH05_PUBLICATION=PUSHED
PH05_AUTOMATED_BUILD_EVIDENCE=PASS
FULL_FLUTTER_TEST=PASS_278_WITH_4_LAB_SKIPS
WINDOWS_RELEASE_BUILD=PASS
ANDROID_DEBUG_BUILD=PASS
SCHEMA_MIGRATION=NONE
DEPENDENCY_GENERATED_PLATFORM_PROVIDER_CHANGE=NO
HISTORY_EXPORT_QUERY_BOUNDARY=TWO_SET_BASED
EXPORT_DESTINATION_OWNER=SINGLE_SHARED_PORT
ANDROID_PUBLIC_DOWNLOADS=UNAVAILABLE_BY_AUTHORITY
GUIDE_STRUCTURE=IMPLEMENTED
GUIDE_LEARNER_SEQUENCE=PARTIALLY_CONTRADICTED
ANALYTICS_HUMAN_RUNTIME_RESULT=DEFECT_OBSERVED
ANALYTICS_WRONG_VARIABLE_ROOT_CAUSE=NOT_ESTABLISHED
ANALYTICS_CORRECTION_DIRECTION=ACCEPTED_NOT_IMPLEMENTED
HUMAN_ASSISTIVE_TECH_LOCALE_REAL_DEVICE_COMPREHENSION=NOT_ESTABLISHED
KANBAN_TRANSITIONS=NONE
PH05_D_E_F_AUTHORITY=CONSUMED
CODEX_AUTHORITY=NONE
PERMANENT_DOMAIN_ABSORPTION=PENDING_PDR2_O_A_D
ANALYTICS_CORRECTION_CONTEXT=READ_ONLY_STATE_OF_UNION_REQUIRED
MAIN_ROOT_REFRESH=AFTER_THREE_DOMAIN_COMMITS
NEXT_MAIN_ACTION=Run PH05 Operational Didactic and Design PDR2 reconciliations, then verify all three commits; separately complete the read-only Analytics correction state-of-union before any new D/E/F authority.
```

---

<!-- RECONCILIATION_MARKER:C11-PH05-PERMANENT-ABSORPTION-ANALYTICS-CORRECTION-ACTIVATION-2026-07-31 -->

# Cycle 11 PH05 Permanent Absorption and Analytics Correction Activation

## 15.1 Identity and verified repository boundary

~~~text
ROLE=Main Chat [M]
SEQUENCE=FLX-PRM-04
REPOSITORY=gus-i-gu/markei
BRANCH=grm-guarded-provisioning-20260727
PH05_J_RECONCILIATION=e6ced7fe3945925bf5f314ee11c4538029e18d44
PH05_IMPLEMENTATION=426235d8b67ac719e494b53cfb23a6c3b06fb489
PH05_AUTHORITY=b59b2ecdfb69ca98c431b9f36694f011332fbef3
PH05_PERMANENT_DOMAIN_HEAD=74638c33a71eb4bc4e5e16aca49526496d3a3610
ANALYTICS_CORRECTION_ACTIVATION=0e647e76aa8275bda48cea1e9d08427e3d949134
CURRENT_REMOTE_HEAD_AT_RECONCILIATION=0e647e76aa8275bda48cea1e9d08427e3d949134
~~~

Main verified the linear boundary after J section 14:

1. three compatible PDR2 commits advance e6ced7fe to 74638c33;
2. those commits modify exactly the four Operational, four Design and four
   Didactic permanent-domain files;
3. no source, J, Main-root, methodology, A/B/C, D/E/F or G/H/I path is present
   in that three-commit domain delta;
4. the next commit, 0e647e76, modifies only D_OPS_STAGE.md, E_DDC_STAGE.md and
   F_DSN_STAGE.md;
5. no source change follows PH05 implementation 426235d8.

The PH05 permanent-domain chain is therefore compatible, complete and accepted
for Main continuity. The later D/E/F activation is a separate bounded authority;
it does not invalidate or reopen the PH05 permanent record.

## 15.2 Permanent-domain absorption result

Operational permanent memory now owns the PH05 execution boundary:

- Home and Guide zero-I/O behavior;
- History two-read, zero-write, zero-network selected export;
- one final write per successful explicit export;
- Windows Downloads at automated/build ceiling;
- Android public Downloads as typed unavailable with zero writes;
- Analytics, Audit and Settings request/query/call budgets;
- 278 passed tests, four lab-gated skips, analysis and both platform builds;
- unchanged schema, migration, generated, dependency, native and provider
  surfaces;
- manual host, real-device, accessibility, locale and provider gates retained as
  unvalidated or deferred.

Didactic permanent memory now owns the learner distinctions and evidence ceiling:

- Optional purchase details;
- Catalogue detail activation without selection;
- History action selection versus detail opening;
- Select all shown as the filtered loaded recent-History window;
- Use in Analytics as scope handoff;
- export versus sharing;
- Readiness summary;
- Account-first Settings and @NNN / #NNN references;
- implemented/automated/built remaining distinct from human comprehension;
- KANBAN transitions remain NONE.

Design permanent memory now owns the PH05 architecture:

- one ExportDestinationPort and one composition-injected
  LocalExportDestination;
- pure History and Analytics builders separated from filesystem effects;
- two set-based Account-scoped History reconstruction reads;
- separate stable History action-selection and detail identities;
- typed scope-only Analytics handoff to one composition-owned workspace;
- unchanged fixed-point, fingerprint, schema and provider boundaries;
- one local typed Guide owner, loaded-state-only Audit projection and retained
  Settings controller ownership.

These domain summaries do not replace the twelve permanent files. Their current
checkpoints remain the recovery entry points.

## 15.3 Preserved contradictions and evidence ceilings

The Guide has eight local anchored sections, focusable contents navigation and
zero I/O. Its committed learner sequence remains partially contradictory to the
accepted PH05 teaching contract: Lists is absent as its own teaching boundary,
and Getting started plus local-data/export/Sync-limit responsibilities are
redistributed. This is a single-owner content-contract deviation. Human
comprehension is not established.

The Analytics runtime finding is corrected in classification, not erased.
Read-only source tracing found no evidenced default-Quantity insertion: grouping
iterates the selected measures and the immutable saved record feeds Chart,
Table, interpretation, CSV and PDF. The confirmed defect is user-facing raw
fixed-point values and internal compatibility keys, while end-to-end
calculation-variable integrity remains a regression obligation because the
existing suite did not assert all projections together.

The human serial diagnostic:

~~~powershell
flutter test --concurrency=1 --no-pub -r expanded
~~~

completed with TestExit=0. This disproves a general PH05 source failure for the
reported build/run symptom. It identifies drift between the bare parallel test
commands in G_SCRIPTS.md and the serial gate used for PH05 validation. The
procedure correction is Main-owned and remains outside Codex source authority.
GRM.md and I_SCRIPTS.ps1 require no identifier or dispatch change.

## 15.4 PRC-01 classification records

### PH05 permanent absorption

~~~text
Claim: PH05 implementation and its stated evidence ceiling are permanently absorbed.
Source: 426235d8, G/H/I, J section 14 and the twelve PDR2 domain files.
Current state: implemented and validated at named automated/build boundaries.
Evidence: three-commit exact twelve-file domain delta ending at 74638c33.
Evidence boundary: no complete human, real-device, provider or production acceptance.
Contradictions: Guide sequence deviation and Analytics human defect preserved.
Semantic owner: paired Operational, Didactic and Design permanent files.
Target role: Main continuity summary.
History disposition: J section 14 and all domain observational records retained.
Confidence: high within the named boundary.
Human/Main authority: explicit human continuation plus completed PDR2 route.
Required regeneration: J section 15 and Main-root 00/05/06.
Result: permanently absorbed; PH05 D/E/F remain consumed.
~~~

### Analytics correction diagnosis and authority

~~~text
Claim: raw fixed-point/internal-key presentation is confirmed; silent default-Quantity insertion is not evidenced.
Source: human runtime evidence, read-only source trace and D/E/F at 0e647e76.
Current state: accepted diagnosis plus active bounded correction authority.
Evidence: selected measures feed grouping and one frozen record feeds all projections.
Evidence boundary: required end-to-end no-leak tests and human UI acceptance are pending.
Contradictions: earlier wrong-variable wording is narrowed, not erased.
Semantic owner: current J synthesis and active Analytics D/E/F; later permanent ownership follows post-Codex PDR2.
Target role: Codex materialization evidence, then domain reconciliation.
History disposition: original defect observation retained as chronology.
Confidence: high for presentation defect; provisional for complete variable integrity.
Human/Main authority: accepted human correction direction and Main activation.
Required regeneration: replace G/H/I after materialization; later domain and Main closure.
Result: C11-ANALYTICS-CORRECTION-R01 is active at 0e647e76.
~~~

### Build/run procedure drift

~~~text
Claim: the serial full suite passes while the bare parallel procedure produced one earlier failure.
Source: human Windows diagnostic and PH05 validation record.
Current state: validated diagnostic; procedure documentation correction pending.
Evidence: TestExit=0 under --concurrency=1 --no-pub.
Evidence boundary: this does not identify or suppress Drift harness warnings.
Contradictions: no Analytics source regression follows from the failed bare run.
Semantic owner: documentation/G_SCRIPTS.md procedure family under Main authority.
Target role: separate Main-owned documentation correction.
History disposition: preserve both the failed bare run and passing serial rerun.
Confidence: high.
Human/Main authority: explicit request to keep GRM-family changes outside Codex.
Required regeneration: GS-BUILD-02, GS-FLUTTER-WIN and GS-FLUTTER-AND commands.
Result: pending Main procedure edit; not part of Codex writable paths.
~~~

## 15.5 Current authority and next sequence

C11 remains open only for the bounded Analytics correction and final
reconciliation. C11-ANALYTICS-CORRECTION-R01 is controlling at 0e647e76. Codex
may edit only the Analytics source/tests and G/H/I paths named by the active
D/E/F sections. It must use explicit serial validation and must not edit
G_SCRIPTS.md, GRM.md, I_SCRIPTS.ps1, J, Main-root files, permanent domains,
methodology, schema, dependencies, generated files or platform files.

After Codex publication:

1. reconcile new G/H/I and any bounded human UI evidence into J;
2. run final Operational, Didactic and Design PDR2 updates only where the
   correction changes permanent truth;
3. disposition the Guide sequence deviation, Android Downloads limitation,
   accessibility/locale/real-device gates and procedure drift without inflating
   the C11 claim ceiling;
4. refresh Main continuity for final C11 closure;
5. enter C12 while keeping GCM04, multiple-Account/provider resilience,
   revocation, outage recovery, retention/rebootstrap and production lifecycle
   in C12-PHASE02.

## 15.6 Terminal

~~~text
CYCLE=C11
PH05_PERMANENT_ABSORPTION=COMPLETE
PH05_DOMAIN_COMMITS=3
PH05_DOMAIN_FILES=12
PH05_PERMANENT_HEAD=74638c33a71eb4bc4e5e16aca49526496d3a3610
KANBAN_TRANSITIONS=NONE
GUIDE_SEQUENCE=PARTIALLY_CONTRADICTED
ANALYTICS_CONFIRMED_DEFECT=RAW_FIXED_POINT_AND_INTERNAL_KEY_PRESENTATION
DEFAULT_QUANTITY_INSERTION=NOT_EVIDENCED
CALCULATION_VARIABLE_INTEGRITY=REQUIRES_END_TO_END_REGRESSION
SERIAL_FULL_FLUTTER_TEST=PASS
G_SCRIPTS_SERIAL_GATE_CORRECTION=PENDING_MAIN
C11_ANALYTICS_CORRECTION_AUTHORITY=ACTIVE_AT_0e647e76
CODEX_AUTHORITY=ACTIVE_BOUNDED
C11_CLOSURE=PENDING_CORRECTION_AND_FINAL_RECONCILIATION
C12_PHASE02_BACKEND_SCOPE=DEFERRED_AND_PRESERVED
NEXT_MAIN_ACTION=Refresh 00_PROJECT_STATE, append 05_SESSION_LOG, refresh 06_SESSION_SCHEME, then initiate Codex from 0e647e76.
~~~

---

<!-- TEMPORAL_MARKER:C11-ANALYTICS-CORRECTION-R01-RECONCILIATION-2026-07-31 -->

# 16. C11 Analytics Correction Materialization Reconciliation

> Sequence: FLX-PRM-04 / Main post-Codex evidence reconciliation
> Cycle / unit: C11 / C11-ANALYTICS-CORRECTION-R01
> Repository: `gus-i-gu/markei`
> Branch: `grm-guarded-provisioning-20260727`
> Activation authority: `0e647e76aa8275bda48cea1e9d08427e3d949134`
> Pre-implementation reconciled head: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`
> Implementation and evidence commit: `17fd65296e960112787b870363b40339f535f5b6`
> Implementation parent: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`
> Evidence: complete `DEV_STAGE/G_OPS_CODEX.md`,
> `DEV_STAGE/H_DDC_CODEX.md` and `DEV_STAGE/I_DSN_CODEX.md`

## 16.1 Publication boundary

The correction materialized as one focused commit from the reconciled Main
boundary. Its delta contains six handwritten Analytics source files, three
Analytics test files and replacement G/H/I evidence only. The activation
authority, PH05 implementation and earlier C11 ancestry remain preserved.

No schema, migration, generated source, dependency, lockfile, native platform,
GRM/GS, J, A/B/C, permanent-domain, methodology, Auth/API/Sync/provider,
diagnostic, PH03, Closure or unrelated-page surface changed in the implementation
commit. The branch was published directly without force or a pull request, every
changed remote blob was verified, and the implementation worktree was clean and
synchronized.

## 16.2 Reconciled correction truth

One typed `AnalyticsVariable` selection owner now controls the visible
Variables choice and derives both categorical breakdowns and numeric measures:

- Purchased by and Payment method map to categorical breakdowns;
- Purchased for is represented as typed unavailable evidence;
- Quantity, Unit price, Price paid, Purchase total and Evidence count map to
  numeric measures.

Categorical-only selections block with guidance and insert no implicit measure.
Unsupported operation-variable combinations block with selection-specific
guidance. Incompatible numeric series retain Table, CSV and PDF evidence while
Chart becomes typed unavailable by default.

`Run & save` freezes determinant, variables, operation, timeframe, evidence
scope, labels and grouped entries into one immutable session-only
`AnalyticsRecord`. The frozen record controls Chart, Table, interpretation,
CSV and PDF. Later draft changes and saved-record selection do not mutate or
reuse another record. The existing workspace remains the sole controller and
calculation path.

Custom time uses Initial date and Final date in strict `dd-mm-yyyy`. Both
calendar dates are inclusive; the application constructs local midnight at the
start and local midnight after the final day before converting to the existing
UTC half-open interval. Missing, invalid, overflow-normalized and reversed
ranges are rejected.

Pure shared display conversion now presents decimal quantity with canonical
unit, decimal currency, currency per canonical unit, percent, signed Difference
and integer Evidence count. Raw fixed-point storage values and compatibility
keys such as `quantity:mass:kg` are absent from asserted learner-facing
projections and exports. Ordinary Analytics wide and compact presentation hides
Purchase, Product, Store and Item UUIDs while internal stable identity remains
available for selection, History handoff, paging, fingerprints and
reconstruction. Variables evidence exposes Date-Time of purchase and Store name.

This resolves the previously confirmed raw-value/internal-key presentation
defect at automated evidence level. It also supplies the previously missing
end-to-end regression evidence for calculation-selection integrity. The earlier
human screenshot observation remains valid chronology; it is no longer the
current implementation classification. No second calculation path or silent
default-Quantity insertion was found.

## 16.3 Validation and effect boundary

The ten-case regression matrix passed, covering:

1. Product with Price paid and Quantity under Mean;
2. Store with Price paid under Sum;
3. Time by month with Quantity under Sum;
4. mixed categorical and numeric selection;
5. Purchase total counted once per Purchase;
6. an inclusive one-day custom range;
7. invalid and reversed dates;
8. incompatible units with Table/export retained;
9. categorical-only blocking without implicit count;
10. History-selected Purchase scope and reconciliation counts.

Validation passed:

- `flutter pub get`;
- unchanged `pubspec.yaml` and `pubspec.lock`;
- Dart formatting;
- `flutter analyze`;
- focused serial Analytics suite, 24 tests;
- serial full Flutter suite, 286 passed and 4 lab-gated skips;
- Windows release build;
- Android debug APK build;
- sync-diagnostics generation check.

Existing Drift multiple-database test warnings, the existing Windows
Boost/CMake developer warning and the existing Android Auth0 Kotlin Gradle
future-compatibility warning were observed and not suppressed. They are not
classified as correction failures.

Analytics retains one initial Account-local evidence read, Retry +1, all other
Analytics local actions +0 reads, zero database writes and zero network calls.
The serial guarded commands in `documentation/G_SCRIPTS.md` had already been
corrected at the pre-implementation Main boundary and remained unchanged. The
older section 15 `PENDING_MAIN` terminal is historical and superseded on this
specific procedure point.

## 16.4 Evidence ceiling and retained boundaries

Promotable now:

- unified typed Variables ownership and visible choice mapping;
- one frozen-record projection path;
- automated calculation-selection integrity;
- formatted-value and UUID-hiding behavior;
- strict inclusive local-date input mapped to UTC half-open filtering;
- ten-case regression coverage;
- preserved local-only request/write/network budget;
- successful Windows and Android builds without dependency or platform change.

Still host- or human-unvalidated:

- wide and compact screenshot-fidelity review;
- keyboard-only human review;
- Narrator and TalkBack review;
- locale and long-string review;
- Windows application launch;
- Android real-device behavior;
- learner comprehension.

The automated semantics and 200-percent text-scale assertions do not establish
those human gates. Live Auth0, Neon, Render, provider and Sync operations were
not performed and are not implied by the local Analytics correction.

PH05's Guide content-sequence deviation remains partially contradicted and was
outside this correction. Android shared-document/native-sharing work remains
deferred; Android public Downloads remains typed unavailable. C12-PHASE02
continues to own GCM04, multiple-Account/provider resilience, revocation, outage
recovery, retention/rebootstrap and production lifecycle.

## 16.5 Permanent-domain routing

Operational [O] should promote the exact serial test/build results, local effect
budget, warning disposition, zero-change protected surfaces and remaining human
runtime gates. It should replace the active Analytics-defect TODO with only
unperformed executable acceptance gates.

Didactic [A] should promote the unified Variables language, categorical versus
numeric distinction, typed unavailability, no-implicit-variable rule, readable
value scales, custom-date correction guidance, frozen saved-record meaning and
UUID-hidden evidence presentation. Automated representation is not learner
comprehension; `KANBAN_TRANSITIONS=NONE` unless independent explicit evidence
supports a narrow change.

Design [D] should promote the single typed selection owner, derived
breakdown/measure compatibility views, immutable record boundary, single
workspace/calculation path, pure shared display conversion, local-calendar to
UTC half-open boundary, internal identity/presentation separation and typed
unavailable Chart behavior. Fixed-point aggregation, pure export builders,
schema, dependencies, platform and provider contracts remain unchanged.

Each domain must preserve PH05's already-promoted non-Analytics truth without
duplicating it. After all three PDR2 commits, Main must verify the twelve-file
domain delta, perform final C11 permanent absorption and refresh 00/05/06 before
opening C12.

## 16.6 Terminal

~~~text
CYCLE=C11
UNIT=C11-ANALYTICS-CORRECTION-R01
IMPLEMENTATION_COMMIT=17fd65296e960112787b870363b40339f535f5b6
IMPLEMENTATION_PARENT=2cdb8a66bfa75918acbbcae324e8315e0b7b2658
CORRECTION_IMPLEMENTATION=COMPLETE
CALCULATION_SELECTION_INTEGRITY=VALIDATED_AUTOMATED
DEFAULT_QUANTITY_INSERTION=NOT_EVIDENCED
RAW_FIXED_POINT_PRESENTATION=REMOVED
INTERNAL_COMPATIBILITY_KEYS_VISIBLE=NO
VISIBLE_ORDINARY_UUIDS=NO
TEN_CASE_REGRESSION=PASS
FOCUSED_ANALYTICS_TESTS=24_PASS
FULL_FLUTTER_TESTS=286_PASS_4_SKIP
WINDOWS_RELEASE_BUILD=PASS
ANDROID_DEBUG_BUILD=PASS
ANALYTICS_EFFECTS=initial_read:1;retry:+1;other:+0;writes:0;network:0
G_SCRIPTS_SERIAL_GATE_CORRECTION=SATISFIED_BEFORE_IMPLEMENTATION
KANBAN_TRANSITIONS=NONE
HUMAN_UI_ACCESSIBILITY_LOCALE_DEVICE_COMPREHENSION=NOT_PERFORMED
LIVE_PROVIDER_SYNC_VALIDATION=NOT_PERFORMED
GUIDE_SEQUENCE_DEVIATION=RETAINED_OUT_OF_SCOPE
CODEX_AUTHORITY=CONSUMED
NEXT_ACTION=PDR2-O_PDR2-A_PDR2-D_FROM_J_SECTION_16
C11_CLOSURE=PENDING_DOMAIN_AND_FINAL_MAIN_RECONCILIATION
~~~

---

<!-- TEMPORAL_MARKER:C11-ANALYTICS-CORRECTION-PERMANENT-CLOSURE-C12-ENTRY-2026-07-31 -->

# 17. C11 Analytics Correction Permanent Closure and C12 Entry

> Sequence: FLX-PRM-04 / final Main permanent-memory reconciliation
> Cycle / unit: C11 / C11-ANALYTICS-CORRECTION-R01 closure
> Repository: `gus-i-gu/markei`
> Branch: `grm-guarded-provisioning-20260727`
> Post-materialization J boundary: `34eb4b60fd4f9c6455c1774c055c1615581623af`, section 16
> Implementation: `17fd65296e960112787b870363b40339f535f5b6`
> Didactic reconciliation: `e125b241fe8d4705d041aa50b2ccba0d2052caf5`
> Design reconciliation: `b3185e9d6447533db1be615a57ebda371d6a9c71`
> Operational reconciliation / permanent-domain head: `9359200464b9218d336850225445fb40ea055763`

## 17.1 Permanent-domain publication audit

The final PDR2 chain is exactly three commits ahead of J section 16 and changes
exactly the twelve authorized permanent-domain files: four Didactic, four
Design and four Operational. The chain contains no source, J, Main-root,
methodology, A/B/C, D/E/F, G/H/I, GRM/GS, schema, dependency, generated, native
platform or unrelated change.

Didactic completed first at `e125b241…`, Design followed at `b3185e9d…`, and
Operational completed the chain at `93592004…`. Each commit changes only the
four files owned by its role. The current checkpoint segments remain economical:
Didactic 111 lines, Design 87 lines and Operational 77 lines after their active
temporal boundaries.

## 17.2 Permanently absorbed correction truth

The correction is now classified consistently across Main and all permanent
domains:

- `AnalyticsComposerDraft.variables` is the single typed visible selection
  owner; categorical breakdowns and numeric measures are derived views;
- categorical-only and unsupported operation-variable combinations block with
  typed guidance and insert no implicit Quantity, Evidence count or substitute
  measure;
- one immutable session-only `AnalyticsRecord` freezes the complete composed
  meaning and controls Chart, Table, interpretation, CSV and PDF;
- strict inclusive `dd-mm-yyyy` local dates map through local start and
  day-after-final boundaries to the existing UTC half-open interval;
- fixed-point aggregation and internal stable identity remain unchanged, while
  presentation/export boundaries expose readable quantity, money, unit price,
  percent, signed Difference and integer Evidence count;
- raw compatibility keys and ordinary Purchase, Product, Store and Item UUIDs
  are absent from ordinary Analytics presentation; stable IDs remain internal;
- incompatible axes retain Table/export evidence and expose Chart as typed
  unavailable;
- the ten-case regression matrix, focused serial 24-test Analytics suite and
  full serial 286-pass/4-lab-skip suite passed;
- Windows release and Android debug builds passed;
- Analytics retains initial local read `1`, Retry `+1`, other actions `+0`,
  database writes `0` and network calls `0`.

The confirmed raw fixed-point/internal-key presentation defect is corrected at
the automated evidence boundary. End-to-end calculation-selection integrity is
automated-validated. Silent default-Quantity insertion and a second calculation
path remain not evidenced. The former screenshot observation remains historical
defect-finding evidence and is superseded only as the current automated
implementation classification.

## 17.3 Didactic, Design and Operational disposition

Didactic permanently owns the visible Variables vocabulary, categorical versus
numeric distinction, typed unavailability, immutable saved-record meaning,
readable scales and the difference between automated representation and learner
comprehension. `KANBAN_TRANSITIONS=NONE`.

Design permanently owns the single workspace/controller, one request-counted
Account-local load, derived compatibility views, immutable record, single
grouping/calculation path, pure display/export conversion, internal identity
boundary, pure CSV/PDF builders and rollback to `2cdb8a66…` without schema,
data, dependency or provider-contract conversion.

Operational permanently owns the serial validation/build evidence, warnings and
effect counts. Existing Drift multiple-database, Windows Boost/CMake and Android
Auth0 Kotlin Gradle compatibility warnings were observed and not suppressed;
none is classified as a correction failure.

## 17.4 Evidence ceiling and carried work

C11 closes at its recorded implementation and automated/build ceiling. Closure
does not claim wide/compact screenshot acceptance, keyboard-only acceptance,
Narrator/TalkBack acceptance, locale or long-string acceptance, Windows
application launch, Android real-device behavior, manual Windows Downloads
export, learner comprehension, live Auth0/Neon/Render/provider/Sync operation or
production acceptance.

The PH05 Guide learner-sequence deviation remains partially contradicted and
unrepaired. Android public Downloads remains typed unavailable with zero writes.
GCM04, conditional former R07, multiple-Account/provider isolation, revocation,
outage recovery, retention/rebootstrap and production lifecycle remain assigned
to C12-PHASE02.

## 17.5 GRM launcher-path diagnosis

A later read-only Windows diagnosis identified a separate procedure-interface
defect. Invoking `documentation/I_SCRIPTS.ps1` through the GRM copy command from
`clients/markei_flutter` resolves the relative path beneath that subdirectory,
so PowerShell fails before `I_SCRIPTS.ps1`, `GS-FLUTTER-WIN` or Flutter starts.

`I_SCRIPTS.ps1` correctly derives the repository root after launch and maps the
procedure. `G_SCRIPTS.md` contains the corrected serial `GS-FLUTTER-WIN`
procedure. The remaining defect is the location-sensitive outer invocation in
`GRM.md`, whose wording does not establish a repository-root-independent
launcher path. Diagnosis is complete; no solution or repository change was
authorized in that diagnostic round. Carry this as the first bounded procedural
correction before relying on guarded Windows run evidence in C12.

## 17.6 PRC-01 closure records

### Analytics correction permanent absorption

~~~text
Claim: C11-ANALYTICS-CORRECTION-R01 is permanently absorbed.
Current state: implemented and validated at the recorded automated/build boundary.
Evidence: 17fd6529, replacement G/H/I, J section 16 and the exact twelve-file PDR2 chain.
Semantic owners: paired Operational, Didactic and Design permanent files.
Contradictions: human/runtime acceptance remains absent; Guide deviation remains.
History disposition: earlier defect observations and section 16 are preserved.
Main authority: explicit human-directed final reconciliation and C12 transition.
Result: accepted permanent closure; correction D/E/F and Codex authority consumed.
~~~

### C11 cycle closure

~~~text
Claim: Cycle 11 may close without inflating its evidence ceiling.
Current state: accepted at recorded implementation and automated/build boundaries.
Evidence boundary: residual human, host, provider and production gates are carried.
Semantic owner: Main 00/05/06 continuity plus permanent domain checkpoints.
Contradictions: none requires reopening C11 source authority.
History disposition: all J and domain chronology remains recoverable.
Result: C11 closed; C12 entry authorized with no active source packet.
~~~

### GRM launcher invocation

~~~text
Claim: guarded Windows invocation is location-sensitive before launcher execution.
Current state: diagnosed; solution not yet materialized.
Evidence: PowerShell -File path resolution from clients/markei_flutter.
Semantic owner: Main procedural continuity pending bounded documentation correction.
Contradictions: G_SCRIPTS procedure and I_SCRIPTS dispatch are not the failure point.
History disposition: preserve the failed command and read-only diagnosis.
Result: open C12-entry procedural task; not an Analytics regression.
~~~

## 17.7 Authority and next route

All C11 source and correction authority is consumed. J section 17 and refreshed
Main-root continuity are the final C11 global boundary. No new D/E/F, source,
provider or live-operation authority is created by this closure.

C12 begins in entry preparation. Main must first disposition the bounded GRM
launcher invocation correction, then select the first C12 phase before issuing
new A/B/C or D/E/F. C12-PHASE01 retains bounded UI/UX fine tuning and human
acceptance work; C12-PHASE02 retains distributed/backend and production-lifecycle
work. The exact active C12 unit remains unselected.

## 17.8 Terminal

~~~text
CYCLE11=CLOSED_AT_RECORDED_AUTOMATED_BUILD_EVIDENCE_CEILING
C11_ANALYTICS_CORRECTION=PERMANENTLY_ABSORBED
C11_IMPLEMENTATION=17fd65296e960112787b870363b40339f535f5b6
C11_FINAL_DOMAIN_HEAD=9359200464b9218d336850225445fb40ea055763
C11_DOMAIN_COMMITS=3
C11_DOMAIN_FILES=12
CALCULATION_SELECTION_INTEGRITY=VALIDATED_AUTOMATED
DEFAULT_QUANTITY_INSERTION=NOT_EVIDENCED
KANBAN_TRANSITIONS=NONE
HUMAN_UI_ACCESSIBILITY_LOCALE_DEVICE_COMPREHENSION=NOT_PERFORMED
LIVE_PROVIDER_SYNC_VALIDATION=NOT_PERFORMED
GUIDE_SEQUENCE_DEVIATION=RETAINED
ANDROID_PUBLIC_DOWNLOADS=TYPED_UNAVAILABLE
GRM_FLUTTER_WIN_LAUNCHER_PATH=DIAGNOSED_UNRESOLVED
C11_SOURCE_AUTHORITY=NONE
C12=ENTRY_PREPARATION
C12_ACTIVE_UNIT=UNSELECTED
NEXT_MAIN_ACTION=Refresh 00_PROJECT_STATE, append 05_SESSION_LOG, refresh 06_SESSION_SCHEME, then bound the GRM launcher correction and select the first C12 phase.
~~~
