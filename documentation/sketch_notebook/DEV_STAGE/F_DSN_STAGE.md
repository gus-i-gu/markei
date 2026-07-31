# F_DSN_STAGE — C11-PH01-S02-R01 Layout Architecture Recovery

> Sequence: FLX-ORD-01
> Role: Main design materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S02-R01
> Required branch: `grm-guarded-provisioning-20260727`
> Required remote parent: `f6566a407c2215c1ade61444a7f97994994d93f8`
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the
> initiation prompt
> Authority: **ACTIVE — CORRECTIVE IMPLEMENTATION AUTHORIZED**

## 1. Architecture decision

The preliminary S02 visual architecture is accepted. Recovery changes refine
constraint ownership; they do not replace the token, shell, component or page
system.

## 2. Constraint ownership

- `MarkeiShell` owns navigation and the bounded content canvas.
- Each long-form page owns exactly one primary vertical scroll surface.
- Page sections use natural height; no section may depend on a fixed viewport
  height to expose required controls.
- Shared field/group primitives own consistent gaps between floating labels,
  outlines, values, helper text and adjacent fields.
- Responsive layout changes projection only; it does not create separate
  business or draft state.
- Tables and compact cards consume the same page-owned records and identifiers.
- Shared widgets remain presentation-only and import no repository or
  infrastructure layer.

## 3. Page decisions

### Purchase

Keep one draft controller/state across all layout classes. At wide width, Product
and Quantity/price may remain adjacent; at narrower width or larger text scale,
sections wrap vertically. The page scroll surface must expose review/actions
without nested-scroll traps or clipped controls.

### Catalogue

Keep one page state for search, sort, product creation, similarity resolution
and Stores. Product registration fields may wrap, but field groups must retain
clear vertical separation. Register Product and Stores remain within the same
reachable page scroll surface.

### History

Selection has one source of truth and one visible row control. The header
select-all control updates the same set. Wide columns should consume the
available table surface without inventing values or changing filter/export
ports.

### Home and Lists

Treat their captured wide layouts as accepted regression anchors. Shared fixes
must not alter their information hierarchy, request count, state retention or
estimate semantics.

## 4. Forbidden architecture changes

- repository, domain, database, API, Sync, Auth or provider changes;
- new navigation/state-management framework;
- new dependency, asset or font pipeline;
- duplicate page state for layout classes;
- a repository call from a shared visual component;
- nested scroll surfaces that make final actions unreachable;
- activation or redesign of Analytics, Settings, Audit or Closure.

## 5. Architecture evidence

Tests and `I_DSN_CODEX.md` must establish:

- a single page state survives layout changes;
- one vertical-scroll owner per long-form page;
- final Purchase/Catalogue controls are reachable;
- History selection uses one page-owned set and one row affordance;
- shared components remain dependency-clean;
- repository-call parity is unchanged;
- Home/Lists regression anchors remain intact;
- changed paths stay within D authority.

## 6. Required I report

Replace `I_DSN_CODEX.md` with combined S02-R01 evidence containing:

1. final dependency direction;
2. constraint/scroll ownership;
3. field-group primitive changes;
4. Purchase, Catalogue and History architecture summaries;
5. responsive state-parity evidence;
6. repository-call parity;
7. changed-path inventory;
8. deferred PH02/PH03 boundaries;
9. residual design debt.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02-R01
PRESENTATION_ARCHITECTURE=PASS | PARTIAL | FAIL | BLOCKED
SINGLE_SCROLL_OWNER=PASS | FAIL | BLOCKED
FIELD_GROUP_CONSTRAINTS=PASS | FAIL | BLOCKED
RESPONSIVE_STATE_PARITY=PASS | FAIL | BLOCKED
HISTORY_SELECTION_SOURCE=PASS | FAIL | BLOCKED
SHARED_COMPONENT_BOUNDARY=PASS | FAIL | BLOCKED
REPOSITORY_INTERFACES_CHANGED=NO | YES
DOMAIN_OR_INFRASTRUCTURE_CHANGED=NO | YES
NEW_DEPENDENCY_OR_ASSET_PIPELINE=NO | YES
PH02_PH03_BOUNDARY=PRESERVED | CONTRADICTED
NEXT_DESIGN_REVIEW=<one exact action>
```
