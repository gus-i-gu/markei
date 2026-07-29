# E_DDC_STAGE — Identity, projection and evidence semantics

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Didactic materialization stage
> Unit: `C10-GCM03-S10-R02`
> Continuity alias: `C10-GCM02-S09-R02`
> Branch: `grm-guarded-provisioning-20260727`
> Required published ancestry:
> `716ae7f082714944b6b51042d98a56e685978c38`
> Authority: **ACTIVE WITHIN D — IMPLEMENT AND REPORT**
> Evidence boundary: identity and failure-semantics explanation derived from
> the source and bounded evidence in D; no permanent didactic promotion

## 1. Preserve the three identity layers

Keep these distinct:

```text
Flutter object instance
  temporary in-memory object identity

Product/Store surrogate UUID
  stable record and event-reference identity

Account-scoped natural identity
  Product normalized code + exact identity key
  Store current stable display identity
```

The UI needs a stable scalar selection key, not object-instance equality.
Cross-device materialization needs surrogate-ID mapping plus natural-identity
reconciliation, not UUID replacement.

Do not globally redefine `Product.operator ==` as a shortcut. Domain-value
equality and widget selection identity are separate decisions.

## 2. Interpret the Flutter assertion correctly

Flutter requires the current dropdown value to match exactly one menu item.
The assertion combines:

```text
zero matching menu items
two or more matching menu items
```

The screenshot alone does not distinguish them.

Source evidence makes the zero-match path actionable:

```text
listProducts() materializes Product object A for the menu
productByCode() materializes Product object B for Find code
A and B represent the same row but A != B by reference identity
DropdownButton<Product?> receives B while the menu contains A
```

The correction must still guard repeated IDs so that the opposite
multiple-match class cannot reach Flutter.

Required H-report statement:

```text
DATABASE_DUPLICATE_PROVED_BY_SCREENSHOT=NO
OBJECT_INSTANCE_SELECTION_GAP=SOURCE_CONFIRMED
STABLE_PRODUCT_ID_SELECTION=IMPLEMENTED_OR_BLOCKED
```

## 3. Explain cross-device convergence

Two clients may independently contain semantically equivalent catalogue facts
under different local UUIDs. A downloaded event cannot safely assume:

```text
same fact => same local UUID
```

The receiving client must:

1. validate the incoming Account and identity facts;
2. select one coherent local canonical row;
3. map the remote UUID to that local UUID inside the apply operation;
4. write Purchase/Purchase Item references through the map;
5. reject contradictions atomically.

This is identity convergence. It is not destructive deduplication and does not
rewrite the hosted event.

## 4. Explain transaction and diagnostic meaning

Preserve:

```text
trusted response received
≠ local page committed

local page failed
+ transaction rolled back
= no inbox/fact/cursor advancement

no local cursor
=> no acknowledgement request
```

A failure record written after rollback may truthfully say:

```text
trustedResponseState = received
localMutationState = rolled-back
lastProvedPhase = download-local-apply
```

It must not collapse to `not-received` merely because an exception crossed a
later UI boundary.

## 5. Preserve provenance vocabulary

Explain in H:

```text
GitHub branch = repository ref carrying source and staging
Neon branch alias = provider target coordinate
status marker = evidence classification, not resource creation
```

Therefore `CONFIRMED_MARKei-c10` did not create a GitHub branch. New reporting
uses `CONFIGURED_PROVIDER_BRANCH_ALIAS` and separately retains that the
launcher did not independently prove the human-readable provider alias.

## 6. Evidence-state discipline

Report these boundaries without inflation:

- the page transaction rollback is validated by the frozen SQLite snapshot;
- provider non-advancement is validated by the read-only postflight;
- the source identity gaps are source-confirmed;
- the exact runtime SQLite constraint category is not known;
- implementation may become implemented/locally validated through tests;
- real corrected inter-device convergence remains unvalidated until a later,
  separately authorized live assay.

Do not call Cycle 10, GCM03 or synchronization complete from unit tests alone.

## 7. H report

Replace `H_DDC_CODEX.md` and explain:

- object, surrogate and natural identity;
- why ID-keyed selection fixes the dropdown contract;
- why the screenshot does not prove duplicate rows;
- remote-to-local reconciliation and reference remapping;
- atomic rollback and acknowledgement ordering;
- causal diagnostic preservation;
- GitHub branch versus Neon alias;
- the exact remaining human evidence boundary.

Required terminals:

```text
UI_OBJECT_IDENTITY_VS_PRODUCT_ID=VISIBLE
ZERO_VS_MULTIPLE_DROPDOWN_MATCH=VISIBLE
SCREENSHOT_PROVES_DATABASE_DUPLICATE=NO
SURROGATE_VS_NATURAL_IDENTITY=VISIBLE
REMOTE_TO_LOCAL_REFERENCE_MAPPING=VISIBLE
TRUSTED_RESPONSE_VS_LOCAL_COMMIT=VISIBLE
PROVIDER_BRANCH_ALIAS_VS_GITHUB_BRANCH=VISIBLE
LIVE_CONVERGENCE_ACCEPTANCE=HELD
```

Do not edit permanent didactic memory.
