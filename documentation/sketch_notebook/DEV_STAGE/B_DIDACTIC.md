# Didactic Canonical Reconstruction Stage

> Status: Active functional stage
> Role: Didactic Chat [A]
> Branch: `sketch-notebook-recovery`
> Scope: Reconciliation of current structural evidence with recoverable Main synthesis and preparation of the first canonical didactic reconstruction tranche
> Knowledge state: Staged, reconciled, not yet materialized into permanent didactic memory
> Supersedes: `Didactic Structural Recovery Report` at commit `6b20498b3893eb8d8fc3d0aeb53668393f87391a`

---

## 1. Purpose

This stage begins reconstruction of the permanent didactic domain after the recovery branch pruned the current contents of:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md
```

The reconstruction order follows Domain Symmetry:

```text
Canonical Knowledge
↓
Derived Knowledge
↓
Domain Checkpoint
↓
Observational History
```

This file stages canonical reconstruction only. It does not yet derive glossary entries or refresh the concept-map checkpoint.

---

## 2. Sources Reconciled

### 2.1 Current Didactic structural evidence

The superseded `B_DIDACTIC.md` structural review established the contemporary implementation chain:

```text
PySide6 desktop adapter
→ ProductService business boundary
→ Repository persistence adapter
→ database lifecycle manager
→ SQLite schema and user database
```

Its main stable observations were:

1. desktop pages call `ProductService`, not SQL;
2. `ProductService` owns business interpretation and read-model assembly;
3. `Repository` owns SQL operations and row mapping;
4. the database manager owns configured connection creation, initialization, and migration;
5. domain models carry named application state without executing SQL;
6. raw persisted facts, cached summaries, and presentation projections are distinct representations;
7. initialization creates new persistence state while migration evolves existing persistence state.

### 2.2 Recoverable Main-stage synthesis

`[M]_STAGE/J_MAIN_STAGE.md` is absent from the current recovery branch. The latest recoverable version was read from commit:

```text
c51938b7d603f05aa8745db7a54f3a257dd27ee5
```

That Main stage carried this accepted application boundary:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

It also preserved the following stable conclusions:

- UI labels and persisted semantic values are separate;
- `ProductService` owns business interpretation;
- `Repository` is a persistence adapter rather than a business-meaning owner;
- service-owned read models are platform-neutral contracts;
- mobile or alternate presentation work must not copy PySide6 widget behavior into the application core;
- typed contracts, dependency boundaries, persistence ownership, migration, and validation require explicit treatment.

The recoverable J file is Main staging evidence, not canonical didactic truth. Its claims are accepted here only where they agree with contemporary repository evidence and recoverable historical didactic canon.

### 2.3 Recoverable historical canonical register

The last pre-pruning `02_KANBAN.md` was recovered from commit:

```text
bd4b4cd9233d08c2907c2bfe0644206994ad351a
```

That register proves that the following identifiers were already canonical and occupied:

```text
&&&01  Domain Model Field Semantics
&&&02  Raw Data Versus Derived Data
&&&03  Naming as Data Contract
```

These concepts remain directly supported by the current models, repository rows, service calculations, settings keys, read-model dictionaries, and desktop rendering boundary.

No new KANBAN number is assigned in this tranche.

---

## 3. Reconciliation Result

### 3.1 Stable agreement

The current structural review, recoverable Main synthesis, historical canonical register, and contemporary source code agree on one foundational learning sequence:

```text
Names carry semantic responsibility
↓
Some values are source facts and others are derived interpretations
↓
Each layer must preserve those meanings while transforming representation
```

This supports restoration of the first three historical canonical concepts without semantic invention.

### 3.2 Conflicts and limits

The following material is not promoted in this tranche:

- mobile architecture proposals from the historical J stage;
- unresolved connection-lifetime ownership;
- dependency injection as an implemented capability;
- typed view models as current implementation;
- versioned migration history;
- package subdivision proposals;
- any new KANBAN identifier.

These remain staged questions or later canonical candidates because contemporary implementation does not yet prove a stable accepted answer.

### 3.3 Promotion decision

The first canonical reconstruction tranche should restore:

```text
&&&01
&&&02
&&&03
```

Their wording is refreshed only where necessary to reflect the current repository. Their identities, semantic roles, and numbering remain historically continuous.

---

# 4. Proposed Canonical Materialization

The following text is prepared for later materialization into:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
```

It remains staged until the authorized materialization step occurs.

---

## &&&01

### Domain Model Field Semantics

#### Description

A field is not merely a place where a value is stored. Its name and location express what the value means, which layer owns that meaning, and how other parts of the program may use it.

Two fields can use the same Python or SQLite type while representing different domain concepts. Treating them as interchangeable because their technical types match can corrupt business meaning without producing an obvious syntax error.

#### Formal Definition

Domain model field semantics are the stable meaning, responsibility, and permitted interpretation assigned to a named field within the application domain, independently of the field's storage type or presentation format.

#### Practical Example

Two integer fields may both count days, while one describes the typical interval between purchases and another describes expected shelf life. Their shared type does not make their meanings equivalent.

#### Language Implementation

In Python, field semantics appear through:

- dataclass attributes;
- function parameters and return values;
- dictionary keys;
- type annotations;
- property names;
- validation rules.

Python does not automatically enforce the full business meaning of similarly typed values. Clear naming and responsibility boundaries therefore carry part of the contract.

#### Project Implementation

In Markei:

- `average_duration_days` represents purchase-cycle duration;
- `average_shelf_life_days` represents shelf-life duration;
- `current_quantity` represents current inventory state;
- `quantity` on `Purchase` represents one historical receipt event;
- `status` and `status_label` in a Lists read model represent service interpretation prepared for presentation.

The schema, domain models, repository mappings, service calculations, and desktop rendering must preserve these distinctions.

#### Required Concepts

None.

#### Related Concepts

`&&&02`, `&&&03`.

#### Status

Yellow.

#### Source

Recovered historical `02_KANBAN.md`; current `app/core/models.py`, `app/core/repository.py`, `app/core/services.py`, `app/database/schema.sql`, and desktop read-model consumption; reconciled with recoverable `J_MAIN_STAGE.md`.

---

## &&&02

### Raw Data Versus Derived Data

#### Description

Applications work with both source facts and values calculated from those facts. The distinction matters because a calculation, label, prediction, or cached summary does not have the same evidential role as the records from which it was produced.

Confusing raw and derived data can cause the application to overwrite history with interpretation or persist values that should instead be recalculated.

#### Formal Definition

Raw data is information directly entered, observed, imported, or retrieved as a source fact. Derived data is information produced by applying calculation, aggregation, filtering, grouping, formatting, prediction, or business interpretation to other data.

#### Practical Example

A receipt purchase is a source event. A predicted next-purchase date, inventory status, formatted price label, or expenditure percentage is derived from one or more source records.

#### Language Implementation

In Python, raw and derived values may both appear as object attributes or dictionary entries. Their distinction is therefore expressed through:

- naming;
- construction responsibility;
- mutability rules;
- service workflows;
- persistence decisions;
- recalculation behavior.

A value being present in a dataclass or dictionary does not by itself reveal whether it is raw or derived.

#### Project Implementation

In Markei:

- `Purchase` records are historical source events;
- store, category, and settings rows are persisted facts;
- product summary fields such as expected dates and price deltas are derived or cached interpretations;
- Lists and History read-model labels are derived presentation data;
- initialization and migration operate on persistence structure rather than business interpretation.

`ProductService` is the main owner of business derivation. `Repository` retrieves and persists facts without becoming the owner of their business meaning.

#### Required Concepts

`&&&01`.

#### Related Concepts

`&&&03`.

#### Status

Yellow.

#### Source

Recovered historical `02_KANBAN.md`; current Product/Purchase distinction, service read-model assembly, repository persistence boundary, and Main-stage responsibility synthesis.

---

## &&&03

### Naming as Data Contract

#### Description

Names connect the meanings used by different layers. A field name, settings key, method name, or read-model key tells another component what value it is receiving and how that value should be interpreted.

A naming mismatch can break a system even when every individual value has the expected technical type.

#### Formal Definition

Naming as a data contract is the use of stable, precise, and responsibility-aware names to define the expected meaning and shape of information exchanged between components.

#### Practical Example

`product_name`, `quantity_label`, `expected_next_purchase`, and `history.week_boundary` identify different kinds of data. Replacing them with vague or inconsistent names would force each consumer to guess their meaning.

#### Language Implementation

In Python, naming contracts appear in:

- dataclass fields;
- abstract and concrete method signatures;
- keyword arguments;
- dictionary keys;
- constants;
- settings keys;
- imported symbols.

Untyped dictionaries make naming especially important because their keys function as runtime contracts between producer and consumer.

#### Project Implementation

Markei preserves names across several representations:

```text
SQLite column
→ repository row mapping
→ domain model or service projection
→ desktop rendering
```

Examples include:

- `product_name` across schema, model, repository, service, and UI;
- settings keys such as `history.week_boundary`;
- Lists read-model keys such as `quantity_label`, `remaining_label`, `status`, and `status_label`;
- distinct names for raw values and formatted display values.

The current dictionary-based view models are platform-neutral, but their correctness depends on producer and consumer agreeing on every key and its meaning.

#### Required Concepts

`&&&01`.

#### Related Concepts

`&&&02`.

#### Status

Yellow.

#### Source

Recovered historical `02_KANBAN.md`; current schema/model/repository/service/UI naming chain; recoverable Main-stage distinction between persisted semantic values and UI labels.

---

## 5. Canonical File Header Proposal

When materialized, `02_KANBAN.md` should begin with metadata equivalent to:

```text
# 02_KANBAN.md

> Domain: Didactic
> Status: Canonical concept register under recovery reconstruction
> Recovery source: repository evidence, recoverable historical canon, and reconciled Main staging
> Current tranche: &&&01–&&&03
```

The header should not claim that the complete historical register has already been restored.

---

## 6. Next Investigation

Before the second canonical tranche, commit-oriented recovery should determine:

1. the complete historically occupied ranges for `&&&`, `&&%`, `&%%`, and `%%%`;
2. which historical concepts remain valid under the current package structure;
3. which concepts were superseded, renamed, or only checkpointed but never materialized canonically;
4. whether the structural candidates `package/module boundary`, `layered responsibility`, `resource ownership`, `initialization versus migration`, and `view model` already have historical identifiers;
5. which concept should follow `&&&03` in dependency order rather than merely file order.

Only after canonical recovery is sufficiently stable should Didactic Chat derive `07_GLOSSARY.md` and refresh `08_CONCEPT_MAP.md`.

---

## 7. Stage Conclusion

The first safe canonical reconstruction is not a newly invented curriculum. It is a historically continuous restoration of three concepts whose identifiers, meanings, and current implementation evidence agree:

```text
&&&01  Domain Model Field Semantics
&&&02  Raw Data Versus Derived Data
&&&03  Naming as Data Contract
```

This stage is ready for Main review and authorized materialization into the canonical didactic register.