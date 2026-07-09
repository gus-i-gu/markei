# J_MAIN_STAGE.md

> Status: Main staging draft
> Scope: Methodology revision plan after Cycle 03 stress test
> Authority: Main Chat under human-supervised methodological revision
> Persistence class: Main stage / refreshable synthesis

---

# 1. Purpose

This J stage consolidates the current Main-level methodology revision plan before editing `/methodology/` files.

Earlier draft content for `00_PROJECT_STATE.md`, `05_SESSION_LOG.md`, `06_SESSION_SCHEME.md`, and `PROVISORY_[M]_DOUBLE_LAB.MD` has already been materialized into those files. This refreshed J stage now focuses on:

1. Main-root file registration;
2. special status of `00_PROJECT_STATE.md`;
3. `06_SESSION_SCHEME.md` as forward checkpoint;
4. read-window / file-growth protocol;
5. reconciliation protocol;
6. temporary methodology-sprint communication files;
7. methodology rebuild sequence;
8. commit-noise and verbosity-control strategy.

---

# 2. Current Problem Statement

Cycle 03 proved that Sketch Notebook can coordinate:

```text
functional staging
→ Main synthesis
→ Codex materialization
→ Codex reports
→ domain absorption
→ Main reconciliation
```

The method worked, but exposed a documentation-control problem:

- ever-growing files can absorb verbose evidence;
- derived files become disappointing when they duplicate too much;
- checkpoints fail if they become long registers;
- canonical registers may grow, but must not be fully reread by default;
- Main-root files need explicit methodology status;
- temporary lab files need controlled routing;
- reconciliation needs clearer distinction from promotion.

---

# 3. Main-Root File Methodology Proposal

Main-root files usually do not move data across the Sketch Notebook domain folders. They are localized Main continuity files used for closure, retrieval, and next-session orientation.

They should receive a specific clause in `FLUX.md` and be represented in `INDEX.md` flow.

## 3.1 `00_PROJECT_STATE.md`

Proposed class:

```text
Global State Canon-Checkpoint
```

Reason:

`00_PROJECT_STATE.md` behaves as both:

1. a global recovery checkpoint;
2. a Main-owned current-state canon for the project as a whole.

This creates a double authoritative level.

It should be more authoritative than ordinary checkpoints, but less detailed than permanent domain canon.

It should:

- expose the current accepted project state;
- summarize cross-domain reconciliation;
- point to domain checkpoints for depth;
- avoid long history;
- remain concise enough for boot.

Likely methodology homes:

- `PROMOTION_RULES.md` defines the semantic class;
- `FLUX.md` defines routing and authority;
- `INDEX.md` exposes navigation;
- `METHOD_GLOSSARY.md` defines the term.

## 3.2 `05_SESSION_LOG.md`

Proposed class:

```text
Global Ever-Growing Observational Record
```

Reason:

`05_SESSION_LOG.md` records Main-level events, reconciliations, drift, accepted direction, and closure notes.

It is consolidated observational knowledge. It is not ephemeral in meaning, but it is append-oriented in physical behavior.

It should not define current truth by itself. It supports later reconciliation and explains how current truth emerged.

## 3.3 `06_SESSION_SCHEME.md`

Proposed class:

```text
Forward Checkpoint
```

Reason:

`06_SESSION_SCHEME.md` describes a forward-to-be recovery surface: next topics, pending decisions, expected files, and exit criteria.

It is not a historical log.
It is not canon.
It is a refreshable prevision checkpoint for the next session.

It should:

- orient the next Main boot;
- identify expected topics;
- name likely files to inspect;
- preserve unresolved questions;
- be refreshed at session close or before a major pivot.

---

# 4. Methodology Folder Revision Needs

## 4.1 `INDEX.md`

Needs to register:

- `06_SESSION_SCHEME.md` under top-level structure;
- `[M]_STAGE/J_MAIN_STAGE.md` if accepted as a Main staging surface;
- `PROVISORY_[M]_DOUBLE_LAB.MD` as temporary/provisional if retained;
- Main-root file roles in Global Coordination Files;
- Main Chat route including `06_SESSION_SCHEME.md` for next-session orientation.

## 4.2 `FLUX.md`

Needs clauses for:

- Main-root localized files;
- Main-root file write authority;
- read-window / file-growth routing;
- retrievable landmarks;
- temporary methodology-sprint communication files;
- commit-noise strategy for methodology revisions.

## 4.3 `PROMOTION_RULES.md`

Needs semantic clauses for:

- `Global State Canon-Checkpoint`;
- `Forward Checkpoint`;
- `Global Ever-Growing Observational Record` if useful;
- vertical reconciliation;
- horizontal reconciliation;
- relationship between promotion and reconciliation.

Promotion answers:

```text
What does this knowledge become?
```

Reconciliation answers:

```text
How is already-captured/promoted knowledge made mutually consistent across files, time, and domains?
```

Reconciliation should complement promotion, not duplicate it.

## 4.4 `METHOD_FOUNDATIONS.md`

May need a small update only if the special Main-root files affect the foundational ontology.

Possible addition:

- Main-global continuity layer is not a fourth functional domain;
- it is a coordination layer above domain symmetry;
- `00_PROJECT_STATE.md` is a global canon-checkpoint exception;
- `06_SESSION_SCHEME.md` is a forward checkpoint.

Avoid rewriting the whole foundations file unless the specialized methodology chat finds foundational contradiction.

## 4.5 `METHOD_GLOSSARY.md`

Needs definitions for:

- Global State Canon-Checkpoint;
- Forward Checkpoint;
- Ever-Growing File;
- Refreshable File;
- Derived / Resorted File;
- Read Window Protocol;
- Retrievable Landmark;
- Vertical Reconciliation;
- Horizontal Reconciliation;
- Temporary Methodology-Sprint Communication File.

---

# 5. Read Window Protocol Proposal

The Read Window Protocol should live primarily in `FLUX.md` because it constrains routing, recovery, and file-consumption behavior.

## 5.1 Purpose

Prevent future chats from burning tokens by rereading large files unnecessarily.

## 5.2 File thresholds

Candidate constants:

```text
SPRINT_READ_LIMIT = 800 lines
REPARTITION_REVIEW_LIMIT = 1300 lines
```

Checkpoint guidance:

```text
Target: 200–300 lines
Review: near 400 lines
Failure: 800 lines
```

## 5.3 Strict and latu readings

The protocol should distinguish:

```text
strict read window = only header + latest landmark + targeted sections
latu read window   = wider recent region plus targeted older consultation
```

Use strict read window when:

- a file is ever-growing and over threshold;
- the task does not require full history;
- a checkpoint already provides current state.

Use latu read window when:

- drift is suspected;
- canon consistency is being audited;
- a historical decision must be reconstructed;
- prior landmarks are relevant.

## 5.4 Avoid new file creation by default

Reaction policy should avoid creating new files automatically when files pass threshold.

New files can mess the structure and increase routing burden.

Preferred reaction:

```text
insert retrievable landmarks
+ define read-window policy
+ use targeted search
+ compact refreshable files
+ only propose file split under Main/human-supervised structural revision
```

## 5.5 Retrievable landmarks

Proposed landmark format:

```text
<!-- SN_LANDMARK: YYYY-MM-DD | Cycle NN | short-label -->
```

Example:

```text
<!-- SN_LANDMARK: 2026-07-09 | Cycle 03 | read-model-consolidation-closure -->
```

Agents can search for the latest `SN_LANDMARK` and read forward from there, avoiding older token cost unless needed.

Landmarks should be used especially in ever-growing files and large canonical registers.

---

# 6. Reconciliation Protocol Proposal

Reconciliation should be described primarily in `PROMOTION_RULES.md` because it complements semantic promotion.

It may also need routing constraints in `FLUX.md`.

## 6.1 Relationship to promotion

Promotion regulates how knowledge changes state.

Reconciliation regulates how knowledge already captured, promoted, materialized, or summarized is made mutually consistent.

Promotion flow example:

```text
observation → classified concept → canonical concept → glossary → checkpoint
```

Reconciliation flow example:

```text
Codex report says X changed
Design canon says X means Y
Operational state says X is pending
Main checks whether these claims contradict or complement each other
```

## 6.2 Vertical reconciliation

Vertical reconciliation checks consistency through time and semantic layers.

It asks:

- Does checkpoint reflect canonical state?
- Does derived knowledge reflect canon?
- Does observational history explain the current state?
- Does source code agree with notebook memory?
- Does `00_PROJECT_STATE.md` reflect reconciled domain state?

Goal:

```text
stable and robust truth across sessions
```

## 6.3 Horizontal reconciliation

Horizontal reconciliation checks consistency across domain responsibilities.

It asks:

- Does Operational state contradict Design boundaries?
- Does Design duplicate Operational execution rules?
- Does Didactic framing misrepresent implementation or architecture?
- Does Main state distort domain-specific truth?
- Are equivalent terms complementary rather than duplicated as competing canon?

Goal:

```text
complementary constraints and rules without duplicate canonical ownership
```

## 6.4 Difference from horizontal promotion

Horizontal promotion transfers or reinterprets knowledge across domains.

Horizontal reconciliation compares domain outputs after promotion/materialization to ensure they remain compatible.

Avoid overlap by wording:

- horizontal promotion = ownership/perspective movement;
- horizontal reconciliation = compatibility check across already-owned perspectives.

---

# 7. Temporary Methodology-Sprint Files

`FLUX.md` should include a small clause for temporary files created specifically for chat communication within a methodology sprint.

Working term:

```text
Temporary Methodology-Sprint Communication File
```

Example:

```text
PROVISORY_[M]_DOUBLE_LAB.MD
```

Proposed constraints:

- must be explicitly marked provisional;
- must not be treated as canon;
- must have an intended disposal, absorption, or promotion decision;
- must be registered or referenced in current Main staging if used;
- must not proliferate;
- must be removed, archived, or promoted after the sprint;
- must not become a parallel methodology source.

This clause should make temporary lab communication possible without opening uncontrolled file creation.

---

# 8. Methodology Rebuild Sequence Debate

Recommended sequence, minimizing contradiction risk:

## Option A — Conservative in-place patch

1. Patch `INDEX.md` to register new Main-root/stage/provisional surfaces.
2. Patch `PROMOTION_RULES.md` for semantic classes and reconciliation types.
3. Patch `FLUX.md` for routing/read-window/temp-file rules.
4. Patch `METHOD_GLOSSARY.md` for vocabulary.
5. Patch `METHOD_FOUNDATIONS.md` only if needed.
6. Run consistency pass.

Pros:

- low file-creation noise;
- respects current structure;
- avoids protocol sprawl.

Cons:

- existing methodology files may become denser.

## Option B — New protocol file

Create a dedicated reconciliation/read-window protocol file.

Pros:

- focused and easier to consult.

Cons:

- new root/methodology file increases structure;
- more INDEX/FLUX routing updates;
- risks premature protocol fragmentation.

Current Main recommendation:

```text
Prefer Option A for now.
Do not create a new methodology protocol file yet.
```

If the in-place clauses become too large after one more cycle, promote a new protocol file through explicit methodology revision.

---

# 9. Commit Noise And Verbose Noise Strategy

## 9.1 Commit-noise reduction

For methodology revision, prefer clustered commits by semantic concern rather than one tiny commit per file.

Suggested commit groups:

1. `Register Main root and staging surfaces`
   - `INDEX.md`
   - possibly `FLUX.md` routing references

2. `Define reconciliation and global state classes`
   - `PROMOTION_RULES.md`
   - `METHOD_GLOSSARY.md`

3. `Define read-window and temporary sprint file routing`
   - `FLUX.md`
   - `METHOD_GLOSSARY.md`

4. `Adjust foundations if required`
   - `METHOD_FOUNDATIONS.md`

Avoid mixing unrelated application changes with methodology changes.

## 9.2 Verbose-noise reduction

For stage files:

- prefer compact current conclusions over long restatement;
- point to materialized files instead of copying them;
- avoid keeping outdated drafts once they have been materialized elsewhere.

For append/ever-growing files:

- add landmarks;
- append concise entries;
- do not rewrite history unless correcting a factual error.

For derived files:

- resort and compact;
- do not add every observation;
- preserve only the current useful view.

For checkpoints:

- target recovery, not completeness;
- point to deeper files;
- remove repeated explanations.

---

# 10. Current Decisions Staged

1. Main-root files need explicit methodology treatment.
2. `00_PROJECT_STATE.md` should be treated as a Global State Canon-Checkpoint.
3. `05_SESSION_LOG.md` should remain global ever-growing observational knowledge.
4. `06_SESSION_SCHEME.md` should become a forward checkpoint.
5. Read Window Protocol belongs primarily in `FLUX.md`.
6. Reconciliation Protocol belongs primarily in `PROMOTION_RULES.md`.
7. `FLUX.md` should include temporary methodology-sprint communication file rules.
8. Prefer retrievable landmarks over automatic file splitting.
9. Prefer in-place methodology patches before creating a new protocol file.
10. Prefer clustered methodology commits to reduce commit noise.
11. Preserve compactness in J by refreshing the stage rather than appending indefinitely.

---

# 11. Open Questions

1. Should `[M]_STAGE/J_MAIN_STAGE.md` become a permanent Main staging surface?
2. Should `PROVISORY_[M]_DOUBLE_LAB.MD` be deleted after the methodology sprint, archived as evidence, or promoted into a registered temporary-file class example?
3. Should `00_PROJECT_STATE.md` be considered canonical enough to override a stale domain checkpoint, or only to signal drift requiring domain inspection?
4. Should retrievable landmarks be mandatory only after threshold, or recommended from the beginning of ever-growing files?
5. Should line thresholds be exact method constants or recommended defaults adjustable per project?
6. Should the specialized methodology chat propose direct patches or return a staged methodology patch plan for Main review?

---

# 12. Recommended Next Action

Use this J stage as the handoff into methodology revision debate.

Next concrete work:

1. review this plan with the specialized methodology chat;
2. decide Option A vs Option B for methodology patching;
3. prepare concise patch instructions for `INDEX.md`, `FLUX.md`, `PROMOTION_RULES.md`, and `METHOD_GLOSSARY.md`;
4. modify `METHOD_FOUNDATIONS.md` only if the special Main-root class changes the foundational ontology;
5. run a final consistency pass across methodology files;
6. only then return to Markei feature work or mobile-readiness implementation.
