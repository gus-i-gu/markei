# 00_PROJECT_STATE.md

> Status: Active global state
> Authority: Main Chat
> Persistence class: Global State Canon-Checkpoint
> Scope: Fast recovery of current Markei and Sketch Notebook state

---

# 1. Current Milestone

Markei remains after Cycle 03 — Read-Model Consolidation.

Cycle 04 Sprint 01 was started as a Settings boundary and integration-preparation cycle, but it was intentionally stopped before application materialization because domain staging behavior became unreliable.

Current milestone classification:

```text
Cycle 03 application state remains the last validated application baseline.
Cycle 04 is paused after a disturbed staging attempt.
```

This file is the Main-owned global recovery surface. It intentionally combines current-state checkpoint behavior with accepted global project-state canon. It should remain concise and point to domain checkpoints for depth.

---

# 2. Current Application State

Public desktop tabs remain:

```text
Register
Lists
History
Settings
```

Former public Storage / Shortage / Market meanings remain Lists internal views:

```text
Storage  -> in-house
Shortage -> shortage
Market   -> to-buy
```

Lists supports:

```text
all
in-house
shortage
to-buy
in-house + shortage
shortage + to-buy
```

Current feature state:

- Register remains purchase-entry-only.
- Settings remains the store-management surface.
- Product View remains service-driven and operational.
- Lists remains the public inventory surface.
- History remains grouped by service-owned Month -> Week logic.
- History includes embedded read-only analytics.
- Cycle 03 introduced no schema changes.
- Cycle 04 introduced no accepted application implementation.

---

# 3. Current Architecture State

Accepted boundary remains:

```text
Desktop UI
↓
ProductService
↓
Repository
↓
SQLite
```

ProductService owns:

- Product View read models;
- Lists read models;
- grouped History read models;
- History analytics read models;
- inventory status classification;
- latest/delta price meaning;
- analytics frame interpretation;
- expenditure percentages;
- frame average purchase timelapse;
- product-cycle comparison.

UI owns rendering, controls, navigation hooks, and event handling.

Repository owns SQL retrieval, persistence, settings access, and row mapping.

SQLite owns persisted facts, relationships, settings, and migrations.

Cycle 04 design staging temporarily clarified that Settings boundary correction should preserve this architecture, but all A/B/C DEV_STAGE files were later pruned. Treat that design material as historical Git evidence only unless recovered deliberately.

---

# 4. Current Didactic State

Cycle 03 learning focus remains:

```text
raw data
→ filtered frame
→ aggregate
→ derived metric
→ read model
→ UI presentation
```

New or reinforced Cycle 03 concept areas:

- percentage as derived aggregate;
- filtering frame;
- comparative metric;
- baseline definition;
- status classification versus UI filtering;
- platform-neutral read-model shape;
- History analytics read model;
- unified Lists page with internal views;
- mobile readiness without rewrite.

Cycle 04 produced a didactic warning rather than a stable didactic state change:

- Didactic staging may have drifted toward project-local intuitive concepts rather than intrinsic CS and Coding concepts.
- This concern is observational only.
- Do not rewrite `02_KANBAN.md` from this observation without a later explicit didactic audit.

Didactic concepts remain registered in `didactics/02_KANBAN.md`, summarized in `didactics/08_CONCEPT_MAP.md`, and explained through `didactics/07_GLOSSARY.md`.

---

# 5. Mobile Readiness

Current classification remains:

```text
Prepared for future mobile discussion.
Not ready for mobile implementation.
```

Prepared:

- service-owned Lists read model;
- service-owned History analytics read model;
- platform-neutral dictionaries/lists;
- reduced UI calculation ownership;
- clearer Desktop UI / ProductService / Repository / SQLite boundary.

Not ready:

- mobile UI;
- API/backend rewrite;
- sync/auth design;
- mobile persistence strategy;
- typed service contracts;
- dependency injection/service factory;
- formal date validation;
- automated service tests;
- explicit separation between UI labels and semantic values.

Cycle 04 surfaced additional future-mobile pressure through proposed supermarket/reward integration placeholders and possible NFC-e/photo recognition, but no mobile or integration architecture was accepted.

---

# 6. Current Sketch Notebook State

Cycle 03 completed the first full experimental Sketch Notebook loop:

```text
A/B/C functional staging
↓
D/E/F Main synthesis
↓
Codex materialization
↓
G/H/I Codex reports
↓
O/A/D domain absorption
↓
Main reconciliation
```

The Cycle 03 loop worked and produced strong application results, but exposed method refinements around recovery economy, checkpoint compactness, derived-file discipline, read-window rules, Main-root continuity roles, and reconciliation definitions.

Inter-cycle methodology fine-tuning then updated the method enough for `INDEX.md`-driven bootstrap and recovery-economy behavior to be treated as accepted working method.

Cycle 04 then exposed a different class of problem:

```text
Execution / tool / session behavior became unreliable during domain staging.
```

Observed Cycle 04 disturbance:

- Operational and Didactic domain attempts produced canvas-style responses instead of stable repository-backed DEV_STAGE updates.
- Design staging had been committed earlier, but Main later chose to prune all A/B/C DEV_STAGE files for consistency.
- The disturbance appeared at the execution/staging materialization layer rather than as an obvious contradiction in the Sketch Notebook semantic method.
- The cause is unknown.
- No solution is accepted in this state file.

Current DEV_STAGE status:

```text
A_OPERATIONAL.md -> pruned placeholder
B_DIDACTIC.md   -> pruned placeholder
C_DESIGN.md     -> pruned placeholder
```

---

# 7. Achievements Preserved From Cycle 04 Attempt

Cycle 04 preserved these useful outcomes despite being stopped:

- INDEX-driven domain-chat bootstrap was reaffirmed.
- Domain prompts were refined to stress movement according to `INDEX.md` navigation rather than hard-coded methodology enumeration.
- Sprint 01 scope was clarified as Settings boundary correction plus integration preparation.
- The intended Settings work was scoped to:
  - seven-weekday week boundary;
  - configurable month boundary;
  - compact Store section;
  - passive supermarket/reward API placeholder fields.
- The API/reward identifier was classified as provider-neutral for now, not hard-coded as CPF/government-ID semantics.
- A later `PROMPT_COLLECTION.md` artifact was identified as useful.
- A didactic audit need was identified for after Cycle 04 recovery.

These are preserved observations, not implementation proof.

---

# 8. Active Risks

Application risks:

- Manual UI QA remains incomplete.
- Invalid analytics date input behaves like an omitted boundary.
- Same-day purchases can produce sub-day frame average timelapse.
- Multi-store analytics totals need richer validation.
- Old Storage/Shortage/Market page files remain transitional.
- `pages.order` remains persisted but inert.
- Settings boundary correction remains unimplemented.
- Supermarket/reward API fields remain unimplemented and undefined beyond placeholder intent.

Methodology / execution risks:

- Domain-chat staging may produce non-repository canvas outputs under some conditions.
- Long-session/context/tool routing effects may have disturbed reliable staging behavior.
- The cause of the Cycle 04 disturbance is unknown.
- A/B/C DEV_STAGE files are intentionally pruned and should not be treated as current domain evidence.
- The next session must not infer implementation progress from transient Cycle 04 conversation outputs.

---

# 9. Next Recovery Files

Start with:

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
```

Then inspect:

```text
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

For operational state:

```text
documentation/sketch_notebook/operational/10_OPERATIONAL_STATE.md
```

For learning state:

```text
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

For design state:

```text
documentation/sketch_notebook/design/09_DESIGN_STATE.md
```

Use Git history only if forensic reconstruction of pruned Cycle 04 stage content is required.
