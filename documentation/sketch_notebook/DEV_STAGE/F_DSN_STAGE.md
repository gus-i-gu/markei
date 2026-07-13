# F_DSN_STAGE

> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01
> Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
> Purpose: Domain confrontation; no implementation authority
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Main source: `[M]_STAGE/J_[M]_STAGE.md` at reconciliation commit `fc22f0484b2896f3ee579cd76f489fab1487b56d`

This file is an iterative staging draft. It does not authorize source, dependency, schema, tool, host, infrastructure, permanent-memory, or Codex changes.


# 1. Conciliated Design outcome

Prepare Design Chat [D] to confront a reversible Cycle 08 product architecture derived from J and current repository structure.

This file proposes responsibility boundaries and alternatives. It does not select final widgets, dependencies, schema, migrations or source files for implementation.

# 2. Preserved architecture

Keep:

```text
Flutter presentation
→ application commands/query ports
→ independent Dart domain
← infrastructure adapters
→ Drift application-private SQLite
```

Preserve:

- protected Python/PySide6 beta and isolated database;
- Product internal ID, visible code and identification facts;
- advisory similarity without automatic merge;
- Purchase aggregate and local transaction ownership;
- raw facts versus rebuildable projections;
- local queue as synchronization preparation only;
- platform hosts outside domain behavior;
- current Device debt visibility.

# 3. Provisional responsive shell

Candidate responsibility:

- one shared set of semantic destinations;
- narrow presentation through bottom navigation or equivalent;
- wide presentation through rail or equivalent;
- selection/state independent of the visual navigation control;
- width/constraints rather than platform name choose layout;
- keyboard, focus, Back, safe areas and text scale remain presentation/host concerns.

Candidate destinations requiring human choice:

A. Purchase, Catalogue, History; Store as picker;  
B. Purchase, Catalogue, Stores, History;  
C. Purchase and History top-level; Catalogue/Store as nested selection flows.

No router/state package is justified yet. Prefer injected SDK-level state until requirements prove otherwise.

# 4. Purchase draft coordinator

Provisional boundary below pages and above registered domain facts.

Owns:

- selected or draft Store;
- staged Items;
- add/edit/remove;
- validation;
- running total;
- review phase;
- busy/result state;
- submission identity;
- cancel/reset;
- policy-driven survival across navigation/lifecycle.

Widgets own text controllers, focus and rendering. Drift does not own transient drafts unless process-death restoration is explicitly accepted.

R02 must compare draft lifetimes:

1. mounted page only;
2. app-session/navigation survival;
3. background/rotation survival;
4. process-death restoration.

# 5. Catalogue and Store boundaries

Catalogue:

- first-class query/search surface;
- exact reuse;
- advisory similar candidates;
- explicit existing/create-anyway choice;
- no merge/correction expansion in the first unit.

Store:

- reusable UUID identity;
- search/select/create picker;
- no silent merge;
- minimum visible identity still undecided.

R02 must recommend Store identity among:

- normalized name;
- normalized name + optional branch/location label;
- another explicit visible identifier.

# 6. Registration atomicity and idempotency

Existing atomic transaction remains infrastructure-owned.

Provisional new responsibility:

```text
client submission UUID
+ canonical registration content
→ unique local registration attempt
→ identical retry returns prior Purchase result
→ conflicting content under same ID fails
```

UI busy state complements this rule but cannot replace it.

Potential consequences, not authorization:

- submission ID on Purchase/attempt/event responsibility;
- unique index/constraint;
- migration from schema v2;
- command/result contract change;
- identical/conflicting retry tests;
- recovery after restart.

R02 must determine the smallest coherent model and whether idempotency is mandatory in Sprint 03 or split into a separate schema-bearing unit.

# 7. History and analytics ports

Provisionally separate:

- Purchase History list query;
- Purchase detail query;
- Product observation query;
- comparison query/use case.

Widgets do not traverse Drift tables or event JSON.

First analytic remains pure/versioned and returns:

- comparable result with basis and percentage;
- or explicit incompatibility.

No mutable analytic result becomes authoritative fact. Cache is deferred until measurement justifies it.

# 8. Migration, backup and recovery responsibilities

Drift remains the local transaction/migration owner.

Any schema change requires:

- forward migration from representative v2;
- no silent reset;
- retained raw facts;
- restart/reopen tests;
- generated-source reconciliation.

Backup/export, if accepted, requires an application port and local adapter with:

- versioned format;
- consistent read boundary;
- integrity metadata;
- defined restore promise;
- Device identity handling.

Export UI alone is not backup architecture.

# 9. Device timing

Provisional recommendation:

- avoid changing Device schema during responsive/Catalogue work;
- decide the invariant during Cycle 08;
- materialize no later than Sprint 05 if backup/restore or realistic multi-installation testing needs it;
- otherwise make it a hard, documented Cycle 09 entry unit before upload/download.

Required invariant:

- exactly one current installation record;
- exactly one referenced current Device;
- concurrency-safe bootstrap;
- independent historical Devices;
- restore does not clone Device identity accidentally.

# 10. Bounded implementation candidates

For later activation only:

1. responsive shell and explicit state/error model;
2. Catalogue/Store query and picker flows;
3. Purchase draft coordinator and review;
4. local submission idempotency;
5. History detail and observation ports;
6. first versioned comparison;
7. migration/recovery/backup and Device hardening.

Do not combine all candidates in one Codex unit.

# 11. Design questions for C08-R02

Design Chat must answer:

1. Which destination topology best fits the product?
2. What draft lifetime is required?
3. What is the minimum Store identity?
4. What Product fields form user-visible recognition?
5. Where does submission identity live?
6. What constitutes identical versus conflicting retry content?
7. Which History/analytics ports are minimal?
8. What first comparison basis is semantically valid?
9. Does backup/restore enter Cycle 08?
10. When does Device correction become mandatory?
11. Which choices require dependencies or schema changes?
12. What is the smallest reversible first implementation boundary?

# 12. Required R02 report

Replace C with C08-R02 and report:

- agreement/conflict with J and this F;
- preferred alternatives with rationale and reversibility;
- exact responsibility map;
- lifecycle/state implications;
- likely dependency/schema effects without edits;
- migration and rollback requirements;
- unresolved human decisions;
- recommended revisions to J and F;
- proposed first bounded implementation unit.

No architecture is accepted merely because it appears here. No source or schema mutation is authorized.
