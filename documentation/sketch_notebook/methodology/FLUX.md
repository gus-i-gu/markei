# FLUX.md

> Version: 0.4.1
> Status: Draft
> Persistence Class: Canonical / Operational
> Knowledge Class: Methodological
> Authority: Main Chat
> Scope: Sketch Notebook routing, staging, write authority, materialization flow, recovery order, file naming, and Codex report feedback

---

# 1. Purpose

`FLUX.md` defines the operational routing of information between the Main Chat, the functional chats, Codex CLI, GitHub, VS Code, and the Sketch Notebook.

Its purpose is to prevent:

* uncontrolled edits;
* duplicated writes;
* path drift;
* premature promotion;
* undocumented materialization;
* loss of implementation evidence;
* unnecessary token consumption;
* overloaded Main Chat duties;
* unsuitable documentation responsibility assigned to Codex;
* rogue file creation;
* undocumented file renaming.

`FLUX.md` answers one primary question:

> Which actor may read, write, stage, materialize, report, recover, reconcile, create, or rename which project knowledge, and through which path?

Foundational principles are defined by `METHOD_FOUNDATIONS.md`.

Semantic maturity is defined by `PROMOTION_RULES.md`.

Communication structures are defined by `CHAT_PROTOCOL.md`.

Operational routing is defined here.

---

# 2. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
documentation/sketch_notebook/
```

All notebook files, methodology files, stage files, domain files, and permanent project-memory files must live under this root.

The following path is invalid for Sketch Notebook material:

```text
app/documentation/sketch_notebook/
```

No chat, Codex task, automated tool, or manual update should create or maintain Sketch Notebook files under `app/documentation/`.

New files must not be created in adjacent repositories, misplaced folders, or alternative notebook roots.

---

# 3. Methodological Boot Order

The standard methodology boot order is:

```text
INDEX
↓
METHOD_FOUNDATIONS
↓
FLUX
↓
PROMOTION_RULES
↓
CHAT_PROTOCOL
```

This order loads:

```text
Navigation
↓
Foundational ontology
↓
Routing and authority
↓
Knowledge-state semantics
↓
Communication structure
```

`CHAT_BEHAVIOUR.md` remains a stable ontological guide for role perspectives.

It should be consulted when:

* a role’s reasoning perspective is unclear;
* a new role is introduced;
* the conversational system itself is being revised;
* a role behaves inconsistently with its intended perspective.

It does not need to be re-expanded into every ordinary boot if its principles are already stable and represented through `FLUX.md` and `CHAT_PROTOCOL.md`.

---

# 4. Conversational Actors

The Sketch Notebook workflow uses the following actors.

## 4.1 Main Chat

The Main Chat coordinates the system as a whole.

It performs synthesis, compares functional reports, prepares Codex-ready materialization instructions, checks consistency between project state and notebook state, records drift, and updates global continuity files.

Main Chat is responsible for global coherence.

## 4.2 Functional Chats

The functional chats are:

* Operational Chat;
* Didactic Chat;
* Design Chat.

Functional chats analyze the project from their own domain perspective.

They stage active reports into `DEV_STAGE/A`, `DEV_STAGE/B`, and `DEV_STAGE/C`.

After Codex materialization reports exist, functional chats extract relevant information from Codex report stages into their own permanent domain folders.

Functional chats are responsible for domain memory.

## 4.3 Codex

Codex is the materialization agent.

Codex reads Main-approved materialization stages, applies repository changes, runs validation when instructed, and reports what actually happened.

Codex should not decide semantic promotion.

Codex should not invent methodology.

Codex should not create or rename Sketch Notebook files unless explicitly instructed by Main-approved materialization stages.

Codex reports evidence.

## 4.4 Human / VS Code

The human developer and VS Code provide inspection, review, manual verification, strategic direction, and final acceptance.

Human supervision remains responsible for accepting, rejecting, redirecting, or correcting materialized changes.

---

# 5. DEV_STAGE

`DEV_STAGE` is the staging area of the Sketch Notebook.

Canonical path:

```text
documentation/sketch_notebook/DEV_STAGE/
```

`DEV_STAGE` contains three groups of files.

---

## 5.1 Functional Stage Files

Functional chats write these files during active domain staging:

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
```

Purpose:

* capture current operational, didactic, and design reasoning;
* prepare domain-specific material for Main synthesis;
* avoid losing functional analysis inside transient conversation.

These files are functional stage material.

They are not canonical.

---

## 5.2 Main Materialization Stage Files

Main Chat writes these files:

```text
D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
```

Purpose:

* transform functional reports into Codex-ready instructions;
* specify application changes;
* specify notebook changes;
* identify validation requirements;
* preserve Main-approved implementation direction.

These files are materialization stage material.

They are not final project memory.

---

## 5.3 Codex Report Stage Files

Codex writes these files after materialization:

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

Purpose:

* report what Codex actually changed;
* report what Codex did not or could not change;
* report validation commands and results;
* expose implementation evidence for functional chats and Main Chat;
* provide raw material for operational, didactic, and design permanent memory.

Codex report stages are observational evidence.

They are not canonical.

---

# 6. Permanent Domain Folders

Permanent domain folders live under:

```text
documentation/sketch_notebook/
```

Canonical domain folders:

```text
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
documentation/sketch_notebook/methodology/
```

Domain folders contain persistent project memory.

They are not temporary stage surfaces.

Each functional domain should expose the semantic roles defined by the Domain Symmetry Principle:

```text
Canonical Knowledge
Derived Knowledge
Domain Checkpoint
Observational History
```

The exact filenames may differ between domains.

The semantic roles must remain distinguishable.

---

# 7. Domain Recovery Entry Points

The Hierarchical Recovery Principle requires each domain to expose a low-token entry point before requiring full canonical or historical reading.

These entry points are Domain Checkpoints.

Current checkpoint files:

| Domain      | Checkpoint                                                          |
| ----------- | ------------------------------------------------------------------- |
| Operational | `documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md` |
| Didactic    | `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`         |
| Design      | `documentation/sketch_notebook/design/09_DESIGN_STATE.md`           |

A Domain Checkpoint should answer:

* where the domain currently stands;
* what changed recently;
* what is stable;
* what is active;
* what is unresolved;
* what should be read next if deeper context is required.

A checkpoint does not introduce independent truth.

A checkpoint summarizes the current state of canonical, derived, and observational knowledge.

---

# 8. Hierarchical Recovery Order

Every role should recover project state using the least expensive knowledge source capable of answering the current task.

The standard recovery order is:

```text
Domain Checkpoint
↓
Canonical Knowledge
↓
Derived Knowledge
↓
Observational History
↓
Repository Inspection
```

This hierarchy is a cost discipline, not a prohibition.

A role may inspect deeper sources when:

* the checkpoint is empty;
* the checkpoint is stale;
* the checkpoint is insufficient;
* notebook drift is suspected;
* implementation truth is uncertain;
* repository files are the direct subject of the task;
* materialization must be validated.

A role should not consume full canonical registers, historical logs, or source files when the relevant checkpoint already answers the task.

---

# 9. Domain Folder Responsibilities

## 9.1 operational/

The operational folder stores execution-oriented project memory.

Required semantic roles:

| Role                            | Current / Expected File                    |
| ------------------------------- | ------------------------------------------ |
| Canonical operational knowledge | `12_OPERATIONAL_MODEL.md`                  |
| Derived operational knowledge   | `04_TODO.md` and related operational views |
| Domain checkpoint               | `10_OPERATIONAL_STATE.md`                  |
| Observational history           | `11_OPERATIONAL_RECORD.md`                 |

`12_OPERATIONAL_MODEL.md` should define stable operational knowledge: execution model, validation conventions, operational responsibilities, and implementation workflow principles.

`04_TODO.md` should contain stable backlog items or deferred operational tasks.

`10_OPERATIONAL_STATE.md` should summarize the current operational state for fast recovery.

`11_OPERATIONAL_RECORD.md` should preserve append-oriented operational history: actions performed, commands run, validation results, failures, and outcomes.

If a required semantic role lacks a file, the absence should be reported as a structural gap and materialized through Main-approved instructions.

---

## 9.2 didactics/

The didactics folder stores learning-oriented project memory.

Required semantic roles:

| Role                           | Current / Expected File  |
| ------------------------------ | ------------------------ |
| Canonical didactic knowledge   | `02_KANBAN.md`           |
| Derived didactic knowledge     | `07_GLOSSARY.md`         |
| Domain checkpoint              | `08_CONCEPT_MAP.md`      |
| Observational learning history | `13_LECTURE_REGISTER.md` |

`02_KANBAN.md` should contain canonical learned concepts.

`07_GLOSSARY.md` should derive terminology from canonical concepts and methodology vocabulary.

`08_CONCEPT_MAP.md` should act as the didactic checkpoint: current learning state, stable concepts, unstable concepts, next concepts, and dependency spine.

`13_LECTURE_REGISTER.md` should preserve append-oriented learning history: lectures introduced, questions raised, concepts reinforced, misconceptions detected, and meta-learning observations.

Meta-learning history should not be mixed permanently into `02_KANBAN.md`.

---

## 9.3 design/

The design folder stores architecture-oriented project memory.

Required semantic roles:

| Role                         | Current / Expected File |
| ---------------------------- | ----------------------- |
| Canonical design knowledge   | `01_ARCHITECTURE.md`    |
| Derived design knowledge     | `14_MODEL_OVERVIEW.md`  |
| Domain checkpoint            | `09_DESIGN_STATE.md`    |
| Observational design history | `03_DECISION_LOG.md`    |

`01_ARCHITECTURE.md` should define stable architectural knowledge: dependency direction, responsibility boundaries, domain relationships, and structural principles.

`14_MODEL_OVERVIEW.md` should summarize or reorganize the current architectural model without introducing independent truth.

`09_DESIGN_STATE.md` should summarize the current architectural state for fast recovery.

It should identify:

* active architectural milestone;
* stable decisions;
* unresolved design questions;
* current domain model;
* implementation drift, if any;
* deeper design files to inspect if needed.

`03_DECISION_LOG.md` should preserve append-oriented design history: accepted decisions, postponed decisions, rationale, consequences, and design changes over time.

If canonical, derived, checkpoint, or observational design files are absent or inconsistent, the absence or inconsistency should be reported as a structural gap and materialized through Main-approved instructions.

---

## 9.4 methodology/

The methodology folder stores the rules of the Sketch Notebook Method itself.

Current methodology files include:

```text
METHOD_FOUNDATIONS.md
FLUX.md
PROMOTION_RULES.md
CHAT_PROTOCOL.md
CHAT_BEHAVIOUR.md
METHOD_GLOSSARY.md
```

Only explicit methodological work should modify this folder.

Codex must not modify methodology unless Main Chat explicitly instructs it to do so.

---

# 10. Write Authority

## 10.1 Functional Chat Active Stage Authority

During active functional staging, each functional chat writes only its assigned A/B/C stage file.

| Chat             | Active stage file                                          |
| ---------------- | ---------------------------------------------------------- |
| Operational Chat | `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md` |
| Didactic Chat    | `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`    |
| Design Chat      | `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`      |

During this phase, functional chats must not edit:

* application source files;
* methodology files;
* Main stage files;
* Codex report files;
* other functional stage files;
* another functional domain folder.

---

## 10.2 Functional Chat Domain Memory Authority

After Codex report files G/H/I exist, functional chats may update their own permanent domain folders.

| Chat             | May read         | May update                                   |
| ---------------- | ---------------- | -------------------------------------------- |
| Operational Chat | `G_OPS_CODEX.md` | `documentation/sketch_notebook/operational/` |
| Didactic Chat    | `H_DDC_CODEX.md` | `documentation/sketch_notebook/didactics/`   |
| Design Chat      | `I_DSN_CODEX.md` | `documentation/sketch_notebook/design/`      |

This authority is limited to extracting, classifying, reconciling, and checkpointing Codex-reported evidence into the chat's own domain memory.

Functional chats must separate:

* observational records;
* canonical knowledge;
* derived knowledge;
* domain checkpoints.

Functional chats must not write outside their own domain folders.

Functional chats must not edit methodology files.

Functional chats must not edit application source files.

Functional chats must not independently promote methodology changes.

---

## 10.3 Main Chat Authority

Main Chat may write:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Main Chat may also update global project continuity files, including:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
```

Main Chat checks whether functional domain folders remain consistent with:

* human direction;
* A/B/C functional reports;
* D/E/F materialization stages;
* G/H/I Codex reports;
* source code state;
* domain checkpoints;
* canonical domain files;
* derived domain files;
* observational records.

Main Chat is responsible for reporting consistency, drift, unresolved contradictions, and accepted reconciliation into `05_SESSION_LOG.md`.

---

## 10.4 Codex Authority

Codex reads:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Codex may edit:

* application source files;
* permanent notebook files explicitly named in D/E/F;
* domain folders explicitly named in D/E/F;
* methodology files only if D/E/F explicitly authorize methodology modification.

Codex writes post-materialization reports to:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex must report:

* files changed;
* files created;
* files deleted;
* commands run;
* validation results;
* skipped instructions;
* failed instructions;
* unresolved risks;
* documentation updates performed;
* documentation updates not performed.

Codex reports are not canonical knowledge.

They are evidence for later reconciliation.

---

# 11. Knowledge Classes and Routing

`FLUX.md` uses the knowledge classes defined by `METHOD_FOUNDATIONS.md` and `PROMOTION_RULES.md`.

## 11.1 Functional Stage

A/B/C files are functional stage material.

They are working reports.

They are not canonical.

## 11.2 Main Materialization Stage

D/E/F files are Main-approved materialization instructions.

They are not final memory.

They are the instruction layer before physical change.

## 11.3 Codex Report Stage

G/H/I files are post-materialization reports.

They are observational evidence.

They are not canonical.

## 11.4 Canonical Knowledge

Canonical knowledge belongs in permanent domain files when validated and accepted.

Examples:

* KANBAN concept entries;
* architectural decisions;
* stable operational guides;
* domain models;
* methodology principles.

## 11.5 Derived Knowledge

Derived knowledge summarizes or reorganizes canonical knowledge.

Examples:

* glossary;
* concept map;
* TODO views;
* architecture overview;
* project state snapshot.

Derived knowledge must not create independent truth.

## 11.6 Domain Checkpoint

A Domain Checkpoint is ephemeral derived knowledge optimized for recovery.

Examples:

* `08_CONCEPT_MAP.md`;
* `10_OPERATIONAL_STATE.md`;
* `09_DESIGN_STATE.md`.

Checkpoints should be refreshed when domain state changes.

## 11.7 Observational Records

Observational records preserve what happened.

Examples:

* operational record;
* session log;
* lecture register;
* decision log;
* Codex execution report.

Observational records should be append-oriented unless explicitly corrected by Main Chat.

---

# 12. Standard Flow

The standard workflow is:

```text
Human prompt
↓
Methodological boot
↓
Functional chats recover from domain checkpoints
↓
Functional chats inspect canonical / derived / observational files only as needed
↓
Functional chats inspect repository when required
↓
Functional chats write A/B/C active stage reports
↓
Main Chat reads A/B/C + human prompt + domain checkpoints
↓
Main Chat inspects deeper domain files only as needed
↓
Main Chat writes D/E/F materialization stages
↓
Codex reads D/E/F
↓
Codex materializes application and/or notebook changes
↓
Codex writes G/H/I materialization reports
↓
Functional chats read G/H/I
↓
Functional chats update their own permanent domain folders
↓
Functional chats refresh their domain checkpoints
↓
Main Chat reads domain checkpoints + G/H/I + 00_PROJECT_STATE + 05_SESSION_LOG
↓
Main Chat checks consistency and records drift/resolution in 05_SESSION_LOG
↓
Git/GitHub persistence
↓
Next session boots from improved project memory
```

This flow separates:

* intention;
* recovery;
* reasoning;
* staging;
* synthesis;
* materialization;
* evidence;
* domain memory;
* checkpoint refresh;
* global reconciliation;
* persistence.

---

# 13. Functional Chat Post-Codex Duties

After Codex reports are available, each functional chat has a post-Codex duty.

## 13.1 Operational Chat Post-Codex Duty

Operational Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
```

Then it updates operational memory as appropriate.

Required classification:

```text
canonical operational knowledge
derived operational view
domain checkpoint update
historical / observational record
active action
future TODO
structural gap
```

Typical targets:

```text
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/11_OPERATIONAL_RECORD.md
documentation/sketch_notebook/operational/12_OPERATIONAL_MODEL.md
```

If `12_OPERATIONAL_MODEL.md` is insufficient for a new stable operational rule, Operational Chat should report the structural gap in `A_OPERATIONAL.md` or `10_OPERATIONAL_STATE.md`.

It should not invent permanent filenames unless Main-approved instructions authorize them.

---

## 13.2 Didactic Chat Post-Codex Duty

Didactic Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
```

Then it updates didactic memory as appropriate.

Required classification:

```text
canonical concept
glossary derivative
concept-map checkpoint
unstable concept
next study concept
meta-learning observation
structural gap
```

Typical targets:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md
```

If `13_LECTURE_REGISTER.md` is insufficient for a new learning-history event, Didactic Chat should report the structural gap in `B_DIDACTIC.md` or `08_CONCEPT_MAP.md`.

It should not invent permanent filenames unless Main-approved instructions authorize them.

---

## 13.3 Design Chat Post-Codex Duty

Design Chat reads:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Then it updates design memory as appropriate.

Required classification:

```text
canonical design decision
architectural observation
derived architecture summary
domain checkpoint update
deferred design question
implementation drift
structural gap
```

Typical targets:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

Design Chat may update existing design files according to their semantic role.

If a design update requires a new permanent design file, Design Chat should report the structural gap in `C_DESIGN.md` or `09_DESIGN_STATE.md`.

It should not invent permanent filenames unless Main-approved methodological or materialization instructions authorize them.

---

# 14. Main Chat Continuity Duties

Main Chat is not the primary writer of domain memory after G/H/I exist.

That responsibility belongs to the functional chats.

Main Chat is responsible for global coherence.

Main Chat should check:

* whether `00_PROJECT_STATE.md` reflects the current project state;
* whether `05_SESSION_LOG.md` records the session;
* whether domain checkpoints agree with canonical domain files;
* whether derived domain files reflect canonical domain files;
* whether observational records explain recent changes;
* whether operational, didactic, and design folders agree with each other;
* whether Codex reports contradict intended D/E/F stages;
* whether permanent domain memory contradicts source code state;
* whether human direction overrides prior project memory.

Main Chat records consistency checks, drift, unresolved contradictions, and accepted reconciliations in:

```text
documentation/sketch_notebook/05_SESSION_LOG.md
```

Main Chat may update:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
```

when a project-state change is validated.

---

# 15. Codex Report Duties

Codex reports should be concise but complete.

Each G/H/I report should include:

```text
Source stage files
Files changed
Files created
Files deleted
Commands run
Validation results
Instructions completed
Instructions skipped
Failures or blockers
Unresolved risks
Suggested functional follow-up
```

Codex should avoid long explanatory documentation inside G/H/I.

Codex should report evidence.

Functional chats interpret that evidence.

Main Chat reconciles that evidence.

---

# 16. Checkpoint Refresh Duties

Whenever a functional chat updates its permanent domain folder after reading G/H/I, it should refresh the domain checkpoint if the current state changed.

Checkpoint refresh targets:

| Chat             | Checkpoint                            |
| ---------------- | ------------------------------------- |
| Operational Chat | `operational/10_OPERATIONAL_STATE.md` |
| Didactic Chat    | `didactics/08_CONCEPT_MAP.md`         |
| Design Chat      | `design/09_DESIGN_STATE.md`           |

A checkpoint should remain compact.

A checkpoint should point to deeper files rather than reproduce them.

A checkpoint should make the next boot cheaper.

A checkpoint should not become a historical log.

A checkpoint should not become a canonical register.

---

# 17. Naming and File Creation Rules

Chats must never invent staging filenames.

Chats, Codex, and automated tools must not create new files directly under:

```text
documentation/sketch_notebook/
```

unless explicitly authorized by Main Chat under human-supervised methodological revision.

New files must not be created in adjacent repositories, misplaced folders, or alternative notebook roots.

File creation outside established domain folders creates data fragmentation and increases the risk of data loss during pruning.

Files must not be renamed except by Main Chat under human-supervised methodological revision.

Renaming requires a coherence check against:

* `INDEX.md`;
* `FLUX.md`;
* relevant domain checkpoints;
* affected functional prompts;
* affected Codex materialization instructions.

Valid functional stage files:

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
```

Valid Main materialization stage files:

```text
D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
```

Valid Codex report stage files:

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

Current domain symmetry files are:

```text
operational/
    04_TODO.md
    10_OPERATIONAL_STATE.md
    11_OPERATIONAL_RECORD.md
    12_OPERATIONAL_MODEL.md

didactics/
    02_KANBAN.md
    07_GLOSSARY.md
    08_CONCEPT_MAP.md
    13_LECTURE_REGISTER.md

design/
    01_ARCHITECTURE.md
    03_DECISION_LOG.md
    09_DESIGN_STATE.md
    14_MODEL_OVERVIEW.md
```

Current checkpoint filenames are:

```text
operational/10_OPERATIONAL_STATE.md
didactics/08_CONCEPT_MAP.md
design/09_DESIGN_STATE.md
```

Invalid older names include:

```text
DEV_TRACK/
B_DIDACTICS.md
02_DIDACTICS.md
10_ACTIONS.md
11_OPERATIONAL_TRACKRECORD.md
11_OPERATIONAL_TRACK.md
app/documentation/sketch_notebook/*
```

These names may appear in historical context, but they are not canonical.

---

# 18. Commit Rules

Functional active stage commits should be narrow:

```text
documentation/sketch_notebook/DEV_STAGE/<assigned A/B/C file>.md
```

Functional post-Codex domain-memory commits should be narrow and restricted to the chat's own permanent domain folder.

Examples:

```text
documentation/sketch_notebook/operational/*
documentation/sketch_notebook/didactics/*
documentation/sketch_notebook/design/*
```

Main stage commits should be narrow:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Main continuity commits should be narrow:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
```

Codex materialization commits may include multiple files, but only according to Main-approved stage instructions.

Codex report commits should include:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

---

# 19. Failure Rules

An update is invalid if:

* a chat writes outside its authority;
* a chat writes under `app/documentation/sketch_notebook/`;
* a chat creates files directly under `documentation/sketch_notebook/` without Main-authorized methodological revision;
* a chat creates files in adjacent repositories, misplaced folders, or alternative notebook roots;
* a chat invents a staging filename;
* a chat renames files without Main-authorized methodological revision;
* Codex modifies methodology without explicit Main instruction;
* Codex materializes source changes not supported by D/E/F;
* functional chats modify application source code;
* functional chats write into another functional domain folder;
* derived files introduce truth not present in canonical files;
* domain checkpoints become long canonical registers;
* observational records are rewritten as if they were canonical truth;
* Codex reports silently omit failed or skipped instructions.

Main Chat must inspect invalid updates, recover useful content if necessary, and restore canonical routing.

---

# 20. Summary

Functional chats recover from domain checkpoints first.

Functional chats stage active reasoning in A/B/C.

Main Chat synthesizes and writes D/E/F.

Codex materializes and reports through G/H/I.

Functional chats extract Codex reports into their own permanent domain folders.

Functional chats refresh their domain checkpoints.

Main Chat checks global continuity through `00_PROJECT_STATE.md` and `05_SESSION_LOG.md`.

The canonical notebook root is always:

```text
documentation/sketch_notebook/
```

The staging folder is always:

```text
documentation/sketch_notebook/DEV_STAGE/
```

The current low-token domain checkpoints are:

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

The current domain symmetry files are:

```text
documentation/sketch_notebook/operational/04_TODO.md
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
documentation/sketch_notebook/operational/11_OPERATIONAL_RECORD.md
documentation/sketch_notebook/operational/12_OPERATIONAL_MODEL.md

documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md

documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISION_LOG.md
documentation/sketch_notebook/design/09_DESIGN_STATE.md
documentation/sketch_notebook/design/14_MODEL_OVERVIEW.md
```

The goal of FLUX is not only to move information forward.

The goal is to preserve evidence, responsibility, learning, recovery, file coherence, and reconciliation without confusing stage, synthesis, materialization, report, canonical memory, derivative memory, checkpoint memory, and historical record.
