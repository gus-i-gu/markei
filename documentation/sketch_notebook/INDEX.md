# INDEX.md

> Version: 0.6
> Status: Draft
> Persistence Class: Derived / Navigational
> Knowledge Class: Navigational
> Authority: Main Chat
> Scope: Sketch Notebook navigation, mandatory chat bootstrap, recovery routing, and staging entrypoints

---

# 1. Purpose

`INDEX.md` is the mandatory first entrypoint for every Sketch Notebook participant.

Every Main Chat, functional chat, Codex task, agent, or human reviewer must begin here before loading project memory, staging material, or repository implementation.

This file is a navigation contract. It identifies the canonical notebook root, initializes the methodology context, and routes later recovery. It does not replace the methodology file that owns a rule.

---

# 2. Canonical Notebook Root

```text
documentation/sketch_notebook/
```

The following is not a valid notebook root:

```text
app/documentation/sketch_notebook/
```

Notebook material must not be created in adjacent repositories, misplaced directories, or alternative roots.

---

# 3. Mandatory Chat-Context Bootstrap

Before performing project reasoning, staging, materialization, validation, promotion, or repository modification, load the following files into the active chat context in exactly this order:

```text
documentation/sketch_notebook/INDEX.md
↓
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
↓
documentation/sketch_notebook/methodology/FLUX.md
↓
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
↓
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

This order is cohesive and cumulative:

```text
INDEX
    establishes navigation and the canonical root

METHOD_FOUNDATIONS
    establishes ontology, principles, domains, and role meaning

FLUX
    establishes routing, authority, staging, materialization, and recovery economy

PROMOTION_RULES
    establishes semantic maturity, promotion, reconciliation, and knowledge-state constraints

CHAT_PROTOCOL
    establishes the communication shape used by each role
```

The sequence is not a suggested reading list. It is the standard context-initialization contract.

A participant must not selectively reorder these files or treat a later file as a substitute for an earlier one.

After the sequence is loaded, the participant should retain the combined methodology context throughout the task rather than applying each file as an isolated checklist.

Consult additionally when required:

```text
documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
    when role perspective is unclear or inconsistent

documentation/sketch_notebook/methodology/METHOD_GLOSSARY.md
    when methodology vocabulary is unclear
```

If token or context pressure prevents full loading, stop before materialization and report the bootstrap limitation. Do not silently skip the sequence.

---

# 4. Methodology Ownership

| File | Primary responsibility |
| --- | --- |
| `METHOD_FOUNDATIONS.md` | What the Sketch Notebook Method is |
| `FLUX.md` | How information is routed, staged, written, materialized, reported, recovered, created, renamed, and controlled for recovery economy |
| `PROMOTION_RULES.md` | How knowledge changes semantic state and how reconciliation prevents duplicate semantic ownership |
| `CHAT_PROTOCOL.md` | How each role communicates and structures output |
| `CHAT_BEHAVIOUR.md` | How each role reasons from its perspective |
| `METHOD_GLOSSARY.md` | What methodology-specific terms mean |

Methodology files are protected. They may be changed only through explicit methodology work under Main Chat authority and human supervision.

---

# 5. Project-Memory Layers

```text
Methodology
    defines the method

Main-Root Continuity
    stores global current state, session history, and forward recovery

Domain Memory
    stores interpreted operational, didactic, and design knowledge

Staging Surfaces
    store active reports, Main materialization instructions, Codex evidence, and Main synthesis work

Repository Implementation
    stores physical implementation
```

The repository may show what exists. The notebook explains what it means.

---

# 6. Hierarchical Recovery

After methodology bootstrap, recover project state from the least expensive sufficient source:

```text
Main-root continuity file, when global orientation is required
↓
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

Repository inspection is appropriate when implementation truth is uncertain, source files are directly relevant, drift is suspected, or materialization must be validated.

---

# 7. Main-Root Continuity

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
    global current-state checkpoint

documentation/sketch_notebook/05_SESSION_LOG.md
    global observational history

documentation/sketch_notebook/06_SESSION_SCHEME.md
    forward checkpoint and next-session recovery frame
```

Main-root continuity coordinates global recovery without replacing domain memory.

---

# 8. Domain Checkpoints

Read checkpoints before deeper domain files:

| Domain | Checkpoint |
| --- | --- |
| Operational | `documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md` |
| Didactic | `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md` |
| Design | `documentation/sketch_notebook/design/09_DESIGN_STATE.md` |

A checkpoint summarizes current state. It is neither a canonical register nor a historical log.

---

# 9. Domain Symmetry

Each permanent functional domain exposes:

```text
Canonical Knowledge
Derived Knowledge
Domain Checkpoint
Observational History
```

## Operational

| Role | File |
| --- | --- |
| Derived | `operational/04_TODO.md` |
| Checkpoint | `operational/10_OPERATIONAL_STATE.md` |
| History | `operational/11_OPERATIONAL_RECORD.md` |
| Canonical | `operational/12_OPERATIONAL_MODEL.md` |

## Didactic

| Role | File |
| --- | --- |
| Canonical | `didactics/02_KANBAN.md` |
| Derived | `didactics/07_GLOSSARY.md` |
| Checkpoint | `didactics/08_CONCEPT_MAP.md` |
| History | `didactics/13_LECTURE_REGISTER.md` |

## Design

| Role | File |
| --- | --- |
| Canonical | `design/01_ARCHITECTURE.md` |
| History | `design/03_DECISION_LOG.md` |
| Checkpoint | `design/09_DESIGN_STATE.md` |
| Derived | `design/14_MODEL_OVERVIEW.md` |

---

# 10. DEV_STAGE Routing

Canonical staging root:

```text
documentation/sketch_notebook/DEV_STAGE/
```

## Functional stages

```text
A_OPERATIONAL.md
B_DIDACTIC.md
C_DESIGN.md
```

Functional chats write domain analysis here. These files are staged and non-canonical.

## Main materialization stages

```text
D_OPS_STAGE.md
E_DDC_STAGE.md
F_DSN_STAGE.md
```

Main Chat writes Codex-ready instructions here. D coordinates operational implementation and validation, E coordinates didactic evidence capture, and F coordinates design guardrails and architectural evidence.

## Codex report stages

```text
G_OPS_CODEX.md
H_DDC_CODEX.md
I_DSN_CODEX.md
```

Codex records what physically changed and what validation occurred. These reports are observational evidence, not canonical truth.

---

# 11. Main Stage Routing

```text
documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md
```

`[M]_STAGE` stores Main synthesis that is not ordinary D/E/F materialization staging. It is not canonical methodology, domain memory, or a substitute for Main-root continuity.

---

# 12. Standard Materialization Flow

```text
A / B / C functional staging
↓
Main reconciliation
↓
D / E / F materialization instructions
↓
Codex implementation and validation
↓
G / H / I evidence reports
↓
Human validation
↓
Functional-domain absorption
↓
Main continuity reconciliation
```

Promotion is semantic. Materialization is physical. A materialized change is not automatically canonical.

---

# 13. Recovery-Economy Rule

Use the smallest sufficient read surface.

Do not read full canonical registers, long historical records, or repository trees when a checkpoint or staged report already answers the task. Deeper inspection must have a stated reason.

The mandatory methodology bootstrap is exempt from opportunistic reordering, but later project recovery remains governed by recovery economy.

---

# 14. Write Safety

Before modifying repository or notebook files, a materialization agent must verify:

1. the mandatory bootstrap sequence was loaded;
2. the active notebook root is correct;
3. write authority is explicit;
4. the target file belongs to the authorized stage;
5. staging and canonical memory are not being confused;
6. unrelated files will not be changed;
7. required evidence-report destinations are known.

When any item is unresolved, stop and report the blocker.

---

# 15. Orientation Summary

Every task begins with:

```text
INDEX
→ METHOD_FOUNDATIONS
→ FLUX
→ PROMOTION_RULES
→ CHAT_PROTOCOL
```

Then recover current project state through the appropriate continuity file and domain checkpoint.

Then inspect staging or implementation only as required.

This sequence is the shared context foundation for cohesive development across Main Chat, functional chats, Codex, and human review.
