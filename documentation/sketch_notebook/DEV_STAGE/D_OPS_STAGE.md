<!-- TEMPORAL_MARKER:INTERMID-CYCLE-RECOVERY-ENTRY-2026-07-14 -->
> Temporal boundary — Intermid Cycle Recovery begins here (2026-07-14). Content above this marker belongs to Cycle 08 or earlier reviewed project history. Content below belongs to Intermid Cycle Recovery and later reconciliation.


---

# D_OPS_STAGE — Existing-Product Edit Correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Status: CONTROLLING with E_DDC_STAGE.md and F_DSN_STAGE.md
> Authority: Main Chat
> Codex report destination: DEV_STAGE/G_OPS_CODEX.md

## Objective

Validate the bounded staged-line Product-reference correction defined by the
complete D/E/F envelope. This file does not authorize unrelated operational
work.

## Required evidence

Codex must:

1. record the starting branch and commit;
2. inspect the affected Purchase edit/stage path before mutation;
3. add or update focused regression coverage proving that editing an existing
   Product line preserves its original Product ID and creates no duplicate;
4. run formatting for touched Dart files;
5. run the focused `test/app/markei_app_test.dart` suite;
6. run the full Flutter test suite;
7. run Flutter analysis;
8. inspect the final diff for scope.

Use commands from `clients/markei_flutter/`. If the host blocks a command,
report the command, output, and blocker without claiming it passed.

## Acceptance

The unit passes only when:

- “Save staged Item” retains the original Product reference;
- edited quantity/price values reach the registered Item;
- the original Product row is reused;
- no duplicate Product is created;
- existing focused/full tests and analysis pass, or an exact environmental
  blocker is reported;
- no schema, migration, dependency, generated artifact, or unrelated source
  change appears.

## Report

Append the Operational result to:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
```

Include changed paths, commands/results, defect before/after behavior, residual
risks, and any blocker. G is evidence, not canon.

## Prohibitions

Do not perform Android/Windows acceptance, transaction-failure infrastructure,
bytecode cleanup, schema work, synchronization, permanent-memory updates, or
methodology changes in this unit.
