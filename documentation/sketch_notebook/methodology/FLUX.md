# FLUX.md

> Version: 0.2
> Status: Draft
> Persistence Class: Canonical / Operational
> Authority: Main Chat
> Scope: Sketch Notebook routing, staging, write authority, and materialization flow

---

# 1. Purpose

`FLUX.md` defines the operational routing of information between the Main Chat, the functional chats, Codex CLI, GitHub, VS Code, and the Sketch Notebook.

Its purpose is to prevent uncontrolled edits, duplicated writes, path drift, premature promotion, and incorrect file materialization.

`FLUX.md` is the routing specification for the Sketch Notebook Method.

---

# 2. Canonical Notebook Root

The canonical Sketch Notebook root is:

```text
markei/documentation/sketch_notebook/*
```

Inside the repository, this means:

```text
documentation/sketch_notebook/*
```

All notebook files, methodology files, stage files, and permanent project-memory files must live under this root.

The following path is invalid for Sketch Notebook material:

```text
app/documentation/sketch_notebook/*
```

No chat, Codex task, or manual update should create or maintain Sketch Notebook files under `app/documentation/`.

---

# 3. Chat Categories

The conversational system is divided into two categories.

## Main Chat

The Main Chat coordinates the system as a whole.

It performs synthesis, prepares Codex tasks, and authorizes materialization.

## Functional Chats

The functional chats are:

- Operational Chat
- Didactic Chat
- Design Chat

Functional chats analyze the project from their own perspectives and stage their results.

They do not directly edit permanent notebook files.

---

# 4. DEV_STAGE

`DEV_STAGE` is the staging area of the Sketch Notebook.

It replaces the previous `DEV_TRACK` naming.

Canonical path:

```text
documentation/sketch_notebook/DEV_STAGE/
```

`DEV_STAGE` contains two groups of files:

1. Functional staging files: `A`, `B`, `C`.
2. Main materialization staging files: `D`, `E`, `F`.

---

# 5. Functional Chat Write Authority

Functional chats may write and commit only their assigned staging file.

| Chat | Function | Writable File | May Commit? | May Edit Other Notebook Files? |
|---|---|---|---|---|
| Operational Chat | Execution, debugging, commands, immediate actions | `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md` | Yes | No |
| Didactic Chat | Learning, KANBANs, glossary suggestions, concept mapping | `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md` | Yes | No |
| Design Chat | Architecture, decisions, domain modeling, structural review | `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md` | Yes | No |

Functional chats must not write to:

- permanent notebook files;
- methodology files;
- other functional staging files;
- Main staging files;
- application source files.

---

# 6. Main Chat Write Authority

The Main Chat may prepare and write synthesized materialization stage files.

| Main Stage File | Purpose | Downstream Target |
|---|---|---|
| `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md` | Main-approved operational patch brief, commands, and action material | `documentation/sketch_notebook/operational/` and application/source files when needed |
| `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md` | Main-approved didactic patch brief, KANBAN/glossary/concept-map material | `documentation/sketch_notebook/didactics/` |
| `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md` | Main-approved design patch brief, architecture/decision/domain material | `documentation/sketch_notebook/design/` |

The Main Chat uses `D`, `E`, and `F` to transform functional chat reports into Codex-ready materialization instructions.

The Main Chat may read all notebook files.

The Main Chat coordinates permanent updates but should still preserve domain ownership.

---

# 7. Codex CLI Role

Codex CLI is the materialization agent.

Codex reads the Main stage files:

```text
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

Codex may then edit:

- application source files;
- permanent Sketch Notebook files;
- operational, didactic, and design folders;
- methodology files only when explicitly instructed by Main Chat.

Codex should not invent methodology or promote unstaged content.

Codex materializes Main-approved instructions.

---

# 8. Permanent Notebook Folders

After Main synthesis and Codex materialization, stable notebook content should be written into the appropriate permanent folders.

Canonical permanent folders:

```text
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
documentation/sketch_notebook/methodology/
```

Functional chats do not write directly to these folders.

Main prepares material for them through `D`, `E`, and `F`.

Codex applies the materialization.

---

# 9. Standard Flow

The standard workflow is:

```text
Conversation input
↓
Functional chats read methodology and their domain context
↓
Functional chats write A/B/C stage files
↓
Functional chats commit and push only their assigned stage file
↓
Main Chat reads A/B/C
↓
Main Chat synthesizes conclusions
↓
Main Chat writes D/E/F materialization stage files
↓
Codex CLI reads D/E/F
↓
Codex edits app files and/or permanent notebook folders
↓
VS Code verifies diff
↓
Git commit/push persists state
↓
Main Chat rereads repository state
```

---

# 10. Naming Rules

Chats must never invent staging filenames.

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

Invalid older names include:

```text
DEV_TRACK/
B_DIDACTICS.md
02_DIDACTICS.md
app/documentation/sketch_notebook/*
```

These names may appear in historical context, but they are no longer canonical.

---

# 11. Commit Rules

Functional chat commits must be narrow.

Allowed commit scope for functional chats:

```text
documentation/sketch_notebook/DEV_STAGE/<assigned_file>.md
```

Suggested commit messages:

```text
Update DEV_STAGE/A_OPERATIONAL: <short topic>
Update DEV_STAGE/B_DIDACTIC: <short topic>
Update DEV_STAGE/C_DESIGN: <short topic>
```

Main stage commits should be narrow as well:

```text
Update DEV_STAGE/D_OPS_STAGE: <short topic>
Update DEV_STAGE/E_DDC_STAGE: <short topic>
Update DEV_STAGE/F_DSN_STAGE: <short topic>
```

Codex materialization commits may include multiple files, but only according to the Main-approved stage instructions.

---

# 12. Failure Rules

If a functional chat writes outside its assigned `A`, `B`, or `C` stage file, the update is invalid.

If a chat writes under `app/documentation/sketch_notebook/`, the update is invalid.

If a chat invents a filename, the update is invalid.

If permanent notebook files are modified before Main synthesis, the update is invalid.

Main Chat must inspect invalid updates, recover useful content if necessary, and restore the canonical file structure.

---

# 13. Summary

Functional chats stage.

Main Chat synthesizes.

Codex materializes.

VS Code verifies.

GitHub persists.

The canonical notebook root is always:

```text
documentation/sketch_notebook/*
```

The staging folder is always:

```text
documentation/sketch_notebook/DEV_STAGE/
```
