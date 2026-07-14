# J_MAIN_STAGE — Cycle 09 Main Reconciliation

> Sequence: FLX-INV-02 → FLX-ORD-01 activation
> Round: C09-R01 / implementation unit C09-U02
> Status: RECONCILED; D/E/F ACTIVE FOR CODEX
> Branch: `intermid-cycle-recovery`
> Baseline: `b93c688496d2995c17d5328aadb348ee8c980da5`
> Inputs: C09-R01 A/B/C, human UI mockup decisions, Intermid closure memory
> Authority: Human-supervised Main Chat

---

<!-- ROUND_MARKER:C09-R01-MAIN-RECONCILIATION-2026-07-14 -->

## 1. Purpose

This refresh supersedes older active J prose; Git history preserves it. It reconciles
Cycle 09 investigation and activates one local product-beta materialization envelope.

Cycle 09 is local database/UI expansion. Authentication, API, Neon, synchronization,
production distribution, registered-Purchase mutation, manual Lists, split payments,
multiple People, persisted drafts and durable SubmissionId remain deferred.

## 2. Reconciled repository truth

- Current shell has Purchase, Products and History; accepted navigation is broader.
- Domain quantity supports MASS/VOLUME/COUNT, but UI always supplies MASS; `L`, `ml`
  and `un` therefore fail at the presentation boundary.
- Money accepts comma/dot; quantity accepts dot only.
- Internal Product UUID, visible Product code and versioned exact identity already differ.
- Creation checks exact identity and code collisions, but there are no exact lookup ports.
- Similarity is advisory and must never bypass exact collisions.
- History selects one Purchase; no multi-selection, CSV, PDF or share path exists.
- No Home, Lists, Product-details route, People, Payment Methods or typed failures exist.
- Schema v2 has only v1→v2 migration; v3 needs representative migration evidence.
- Seven focused tests, 32 total tests and clean analysis are inherited evidence, not
  Cycle 09 validation.

## 3. Cross-domain agreements

1. Home content is bundled/static, not database or remotely fetched news.
2. Lists is a rebuildable projection, never a manually authored List aggregate.
3. Person and Payment Method are dedicated local reference entities managed through
   Settings; neither belongs in an untyped settings table.
4. A Purchase may reference zero or one Person and zero or one Payment Method.
5. Product identification is not operation idempotency.
6. Product details uses one semantic route/read model with adaptive presentation.
7. History selection is transient; export/share never mutates registered Purchases.
8. Typed application failures plus compiled presentation messages own error recovery;
   no error-description table or occurrence analytics is authorized.
9. Derived estimates must remain visibly distinct from Purchase facts.
10. Indexes/caches require measured evidence.

## 4. Main decisions frozen for C09-U02

### Navigation and pages

Startup lands on Home. Destinations are Home, Lists, Purchase, History and Catalogue.
Analytics and Household are visible but disabled/PIN-labelled. Guide, Documentation and
Settings use bounded local content. Preserve responsive rail/bar behavior and mounted
draft state.

### Product identity and lookup

- Product UUID remains internal and immutable.
- Visible Product code is required, Account-scoped unique and immutable for new data.
- Legacy null codes receive deterministic collision-safe migration codes.
- Lookup accepts exact visible code or exact normalized identifying fields.
- PACKAGED exact identity: name + brand + normalized package quantity/unit.
- BULK exact identity: name + brand; transaction dimension remains an Item fact.
- Introduce a new normalization rule/version rather than rewriting released v2 meaning.
- Migration must stop on collisions; never merge Products or rewrite Purchase history.
- Product identity fields are immutable this cycle; Product correction remains deferred.

### Quantity and pricing

Visible units: `kg`, `g`, `L`, `ml`, `un`. Quantity inputs accept comma or point and
normalize before domain use. Fractional COUNT remains invalid.

PACKAGED owns package quantity/unit and positive package count. BULK has no package
count; it records amount bought and price per applicable unit. Persist package count as
nullable/not-applicable for BULK. Store line total in minor units; derive it from BULK
amount and unit price with explicit half-up minor-unit rounding.

### Lists v1

For each Product, use distinct registered Purchase local dates. Require at least two
dates and one positive interval. `personal-cycle-v1` is the rounded arithmetic mean of
positive whole-day intervals. Expected next Purchase = latest date + cycle.

Default shortage threshold is 5 days and is editable in Settings. Classification:

- Storage: remaining days > threshold;
- Shortage: remaining days from 0 through threshold;
- Market: remaining days < 0;
- unavailable: insufficient compatible history.

All includes every Product. Labels must say these are personal estimates. The approximate
next-purchase total sums the latest comparable line total for Shortage and Market Products;
omit it when required data/currency is incompatible.

### Local references and Settings

Person and Payment Method each have opaque immutable ID, Account ownership, nickname,
normalized nickname, active/archived state and timestamps. Nickname is unique among
active rows per Account. Archived rows remain resolvable in History/export and are hidden
from ordinary new-Purchase selectors. Physical deletion is not in scope.

Schema v3 adds both tables, nullable Purchase references, nullable BULK package count and
typed Account preference for shortage threshold. Backfill references as null; preserve
all history; never store payment credentials.

### History and exports

History owns transient selected Purchase IDs. Checkbox/tap/keyboard are primary;
double-click is a desktop convenience. Actions:

- Move to Analytics: visible disabled;
- Export CSV: active, deterministic UTF-8 Item-row format;
- Share as list: active PDF grouped by Purchase where dependency/platform support passes.

Export DTOs are application-owned and independent of Drift/widgets. PDF/file/share
dependencies are authorized only for these capabilities and must be minimal, maintained,
SDK-compatible and reported. No silent upload. Registered edit/delete remain disabled.

## 5. Implementation envelope

D/E/F jointly authorize application, domain, Drift v3 migration/generated code,
presentation, focused tests and minimal CSV/PDF/save/share dependencies. Implement in
separable checkpoints:

1. identity/quantity/error contracts;
2. schema v3 + Settings optional references;
3. Home/navigation/Catalogue/details/Purchase;
4. Lists projection;
5. History selection/CSV/PDF share;
6. regression, file-backed migration and platform evidence.

Stop rather than silently narrow if collision-safe migration, atomic registration,
protected Python isolation, or truthful export/share behavior cannot be preserved.

## 6. Evidence gates

Required: format; targeted domain/repository/widget/export/migration tests; full Flutter
tests; analysis; generated Drift reconciliation; fresh v3 and representative v2→v3
file-backed reopen; rollback/no-silent-reset evidence; five Python regressions; Windows
build; Android build when host permits. Manual/lifecycle/platform gaps remain explicit.

## 7. Documentation-size constraint

For Cycle 09 notebook writes, refreshable stage/report/checkpoint files target about 250
lines maximum. Canonical permanent files may grow by at most about 400 lines in one
writing cycle when promotion later authorizes it. Existing history is not rewritten only
to meet this constraint. D/E/F and each G/H/I report must remain at or below 250 lines.

## 8. Authority

`D_OPS_STAGE.md`, `E_DDC_STAGE.md` and `F_DSN_STAGE.md` are ACTIVE — CODEX IMPLEMENTATION
AUTHORIZED as one envelope. A/B/C remain evidence. Permanent-memory promotion and
00/05/06 updates remain inactive until G/H/I reconciliation.
