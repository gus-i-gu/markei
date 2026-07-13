# F_DSN_STAGE — Cycle 08 Codex Design Directive

> Cycle: 08 — Shared-Client Product Beta
> Directive: C08-IMP-01
> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED
> Authority: explicit human instruction reconciled by Main [M]
> Scope: responsive shell and explicit presentation-state architecture
> Paired directives: `D_OPS_STAGE.md`, `E_DDC_STAGE.md`
> Temporal control: this directive supersedes the earlier provisional and C08-ACT-01 text in this file

## 1. Accepted implementation boundary

C08-IMP-01 is the first schema-free Cycle 08 unit.

Implement:

1. a single semantic model for the existing Purchase and History destinations;
2. constraint-driven compact and wide navigation presentations;
3. selected-destination preservation across layout changes;
4. continued mounted-page preservation through the existing indexed content strategy or an equivalent SDK-only mechanism;
5. explicit presentation-state models for touched asynchronous/result surfaces;
6. focused tests for navigation, resize, state rendering and current draft preservation.

Do not add Catalogue or Stores as destinations in this unit.

## 2. Required dependency direction

Preserve:

```text
Flutter presentation
→ application commands and query ports
→ independent Dart domain
← infrastructure adapters
→ Drift application-private SQLite
```

Presentation may interpret application results. It must not query Drift tables, parse event payloads or own persistence rules.

The shell owns navigation presentation and selected destination. Purchase and History pages own only their bounded presentation state. Registered Purchase facts remain owned by domain/application/infrastructure layers.

## 3. Responsive-shell design

Use one destination definition containing, at minimum:

- stable destination identity;
- label;
- icon;
- corresponding page/content.

The compact and wide controls must derive from the same definition.

Use constraints, not `Platform`, to select navigation. Keep the breakpoint as a named presentation constant near the shell. Codex may choose its numeric value as a local reversible implementation detail, but must:

- explain the choice in I;
- test immediately below it;
- test at or above it;
- demonstrate no destination or page-state loss when crossing it.

Do not introduce a router, state-management package or UI framework.

## 4. Presentation-state design

Use small explicit presentation types rather than interpreting “no data” as every non-success condition.

History requires the conceptual algebra:

```text
loading
| empty
| data(Purchase summaries)
| failure(safe retry capability)
```

Purchase registration requires the conceptual algebra:

```text
editing
| invalid(field feedback)
| submitting
| succeeded(local Purchase result)
| failed(safe product failure)
```

The concrete Dart representation may be sealed types, immutable value objects or another dependency-free typed form consistent with the repository’s supported Dart version. Keep it presentation-focused; do not redesign application/domain contracts unless the existing contract cannot express the currently evidenced result.

Raw exceptions may be retained for diagnostics where the repository already supports diagnostics, but must not become ordinary UI state or copy.

## 5. State and lifecycle invariants

The implementation must preserve:

- selected destination across compact/wide transition;
- Purchase page mounting across destination changes;
- current in-memory Purchase draft across tab changes and shell resize;
- no new promise of process-death restoration;
- no duplicate registration behavior introduced by shell rebuilds;
- application-private local persistence boundaries.

Focus, Back behavior, safe areas and larger text must not regress on touched layouts. Host-level claims require host evidence.

## 6. Tests required by design

Add focused tests proving:

- compact layout selects compact navigation;
- wide layout selects wide navigation;
- both controls expose the same destinations;
- selection survives resizing across the breakpoint;
- Purchase draft state survives destination change and resize;
- History loading does not look empty;
- History failure does not look empty and does not expose exception text;
- History data remains renderable;
- Purchase success copy does not expose Device sequence.

Prefer behavior assertions over widget-tree implementation details.

## 7. Explicit exclusions

Do not modify:

- domain identities or Product construction;
- Product-code requirements;
- Store identity or registration command structure;
- Purchase atomic transaction rules;
- schema version, tables, indexes or migrations;
- Device bootstrap or first-20 lookup debt;
- queue/event semantics;
- authentication, API, Neon or synchronization;
- Python/PySide6 architecture or data;
- analytics, export or restore.

Generated Drift changes indicate scope drift and require a stop unless they are unrelated pre-existing work.

## 8. Codex exit contract

Codex completes C08-IMP-01 only when:

- implementation matches D/E/F;
- required focused tests pass;
- available baseline validation is reported;
- the diff remains bounded;
- G/H/I contain exact evidence and deviations;
- all exclusions remain untouched.

If repository truth requires a materially different architecture, Codex must stop, document the contradiction and return to Main instead of broadening the unit.

## 9. Subsequent architecture route

After G/H/I and PDR2 reconciliation, Main may activate later units in this order, subject to human decisions:

1. session draft coordinator and explicit review;
2. Product resolution and Store picker;
3. isolated durable SubmissionId;
4. History detail and Product observation ports;
5. versioned personal price comparison;
6. recovery/export and installation-Device hardening.

Schema-free and schema-bearing units must remain separate.
