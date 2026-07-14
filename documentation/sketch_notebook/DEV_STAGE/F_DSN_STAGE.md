<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# F_DSN_STAGE — Product-Reference-Preserving Edit

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Status: CONTROLLING with D_OPS_STAGE.md and E_DDC_STAGE.md
> Authority: Main Chat
> Codex report destination: DEV_STAGE/I_DSN_CODEX.md

## Authorized source unit

Modify only the smallest necessary subset of:

```text
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/test/app/markei_app_test.dart
```

Additional source paths require a stop and Main clarification.

## Required invariant

When a staged line enters edit mode, edit state must retain:

- the line key;
- the original `ProductReference`;
- the original Product label.

Saving the edit must rebuild only the Item values from the editable controls and
must reuse the retained reference and label. It must not route through new
Product creation, similarity checks, the current Product dropdown selection, or
a newly constructed Product draft.

Both `ExistingProductReference` and `NewProductReference` must remain
preservable. Saving or removing the edited line must clear all associated edit
state coherently.

## Preferred shape

Keep the correction presentation-local and reversible. A small retained
`_DraftLine`, reference/label edit state, or equivalent explicit edit model is
acceptable. Prefer one clear save-edit path over conditional reconstruction
from visible Product controls.

Do not change application contracts, domain identity types, Drift tables,
migration logic, repository transaction boundaries, composition, or navigation.

## Regression contract

Focused coverage must exercise the public widget behavior:

1. make an existing Product available;
2. select and stage it;
3. edit the staged line;
4. change at least one Item value;
5. save through the edit action;
6. register;
7. verify the persisted/registered Item uses the same Product ID;
8. verify Product count/identity did not duplicate.

Retain the existing six focused scenarios.

## Report

Append the Design result to:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Describe the chosen edit-state ownership, invariant evidence, changed paths, and
any deviation. I is evidence, not canon.

## Stop conditions

Stop before mutation or further expansion if the correction appears to require:

- schema or migration change;
- Product merge/correction semantics;
- Store identity work;
- durable submission identity;
- persisted drafts;
- synchronization architecture;
- changes outside the authorized source paths.
