# I_DSN_CODEX - C11-ANALYTICS-CORRECTION-R01

## Design Result

- `AnalyticsWorkspaceController` remains the single composition-owned Analytics workspace controller.
- The local dataset load remains Account-only and request-counted once per load, with Retry adding one more read.
- `AnalyticsComposerDraft.variables` is the single typed selection owner; `breakdowns` and `measures` are derived compatibility views.
- Run & save freezes determinant, selected keys, variables, operation, timeframe, evidence scope, selected labels and grouped entries into an immutable `AnalyticsRecord`.
- Later draft changes and saved-record selection do not mutate existing records.
- Grouping and calculation remain in the existing workspace path; `executeAnalyticsCard` was not activated as a second workspace calculation engine.
- Display conversion is pure and shared through `analyticsDisplayValue`, converting storage integers only at the presentation/export boundary.
- Fixed-point integer aggregation remains unchanged.
- Compatibility keys remain internal comparison identity and are not normal user-facing units.
- Local date conversion constructs local start and local day-after-final before converting to the existing UTC half-open period condition.
- Stable IDs remain in models, keys, selection, History handoff, pagination, fingerprints and reconstruction; ordinary Variables labels hide UUIDs.
- CSV/PDF builders remain pure; the shared export destination behavior is unchanged.

## Changed Architecture Boundary

- `analytics_models.dart`: typed variables, local-date timeframe labels and pure display-value conversion.
- `analytics_workspace.dart`: unified variable toggling, derived breakdowns/measures, validation messages, frozen-record seed and internal Purchase label presentation.
- `analytics_components.dart`: compact unified Variables presentation, two custom date fields, formatted result/table/chart semantics and UUID-hidden Variables projections.
- `analytics.dart`: formatted CSV/PDF result and evidence projection without ordinary UUID columns.
- `analytics_registry.dart`: categorical variables explicitly unsupported for calculation definitions.

## Terminal

```text
CYCLE=C11
UNIT=C11-ANALYTICS-CORRECTION-R01
COMPOSER_SELECTION_OWNER=SINGLE_TYPED
WORKSPACE_CONTROLLER_OWNER=SINGLE
CALCULATION_PATH=SINGLE_FROZEN_RECORD
DISPLAY_CONVERSION=PURE_SHARED
FIXED_POINT_AGGREGATION=UNCHANGED
COMPATIBILITY_KEYS_USER_VISIBLE=NO
CUSTOM_TIME_BOUNDARY=LOCAL_INCLUSIVE_TO_UTC_HALF_OPEN
INTERNAL_IDS=PRESERVED
VISIBLE_UUIDS=ABSENT
CHART_INCOMPATIBLE_AXIS=TYPED_UNAVAILABLE
EXPORT_BUILDERS=PURE
ANALYTICS_EFFECTS=initial_read:1; retry:+1; writes:0; network:0
SCHEMA_MIGRATION=NONE
DEPENDENCY_PLATFORM_CHANGE=NONE
SECOND_CONTROLLER_REPOSITORY_ENGINE=ABSENT
ROLLBACK=PARENT_OF_CORRECTION_COMMIT
```


## 2026-10-02 — Flutter release packaging evidence

Direct human-authorized Flutter packaging work completed. See G_OPS_CODEX.md section dated 2026-10-02 for exact source changes, environment recovery, validation, and evidence limits. This append is observational evidence, not semantic promotion. Windows setup compiled and installation lifecycle checks passed; Android release signing awaits explicit human choice. Existing C11 staging was retained.


2026-10-02 Android follow-up: human approved signing key creation. Signed APK built and signature verified. G_OPS_CODEX.md contains exact evidence and the remaining Auth0 fingerprint registration requirement. This supersedes the earlier signing-pending statement; no semantic promotion or provider mutation.


## 2026-10-03 — Marc brand presentation

Original northern emblem with the human-approved steely-green M is the selected artwork. MarcBrand uses the full logo on wide navigation and the emblem on compact/medium layouts; tapping opens About. Windows ICO and Android legacy/adaptive resources are packaged separately. Functional theme colors and application identifiers are retained. No new dependency; earlier work preserved. Builds and 44 focused existing checks passed; physical-device review remains open. Detailed evidence: C:\Users\gyg29\Documents\Codex\2026-10-03\g-we-need-now-to-check\outputs\Marc-branding-integration.txt.

## 2026-10-03 — New-account migration evidence

Direct human-authorized migration retained Flutter source, package identities, signing key, Marc branding and beta notice. New Auth0 native clients/API and Render service are configured; existing empty development Neon schema is reused through restricted markei_runtime. GRM hosting/auth metadata checks and Windows/Android build 1.0.0+2 pass. Real-user sign-in, guarded membership provisioning, enrollment and cross-device sync remain open. Clean remote-aligned source is still required for GRM-AUTH-03. See the same-date G_OPS_CODEX migration section for exact evidence. No semantic promotion, methodology edits, data purge or publication.

## 2026-10-03 — First-beta bundle evidence

Human-authorized AAB preparation and safety checks completed locally. Existing Flutter suite: 286 pass / 4 skip; backend: 61 pass, lint/type/build pass and zero npm advisories after compatible patches. Release Android callback restricted to configured HTTPS; AAB/APK signatures, manifest and 16KB native alignment verified. Security patches have NOT been deployed. Native sign-in/provisioning/enrollment/sync and store acceptance remain open; see same-date G_OPS_CODEX details. No semantic promotion or public release.

## 2026-10-05 — C02 Purchase refinement materialization

Direct human authority: implement the bounded Purchase refinement, with decimals for package contents/bulk amounts, whole package counts, and unit dropdowns instead of free text. Implementation base: markei-season-02, ebe9fc9af6d048462a1d69b84134671619fed117. The unlocked H: checkout was clean and matched that baseline; work was validated in an isolated matching checkout before transfer.

Purchase details now share one responsive header: Store/date/time are purple and bold with Required labels; Person/payment method are blue with normal weight and Optional labels. Date/time insert separators as digits are typed. Product-code lookup also accepts the keyboard search/Enter action. Purchase and Catalogue offer mL, mg, g, L, kg and un with their meanings. Existing product measurement facts stay fixed; compatible bulk display units remain available.

Packaged contents derive from whole packages multiplied by immutable Catalogue contents (or the new product's contents); the former independent total-quantity entry is read-only. Both packaged and bulk forms accept either unit price or total price and calculate the other. The last edited price is authoritative when quantity changes. A read-only comparable rate uses canonical total contents. Arithmetic uses fixed decimals/BigInt and cent rounding. Milligrams normalize to canonical kg; amounts finer than stored precision and numeric overflow are rejected instead of truncated. Canonical event/schema units remain kg/L/count; no schema migration is needed.

Fresh machine evidence: Flutter analysis reports no issues. The complete client run passed 308 tests, skipped four existing tests, and exceeded two unchanged Analytics timing thresholds while tests ran concurrently (312 ms / 2861 ms). The isolated Analytics rerun passed all 18 checks, including those thresholds (160 ms / 1639 ms). Thus all 310 distinct enabled checks passed across the runs; this is not a claim that the concurrent run was entirely green. New coverage includes price-direction authority, packaged persistence, bulk grams-to-kg staging/editing, six unit options, whole-count validation, date/time editing and compact layout. The rendered desktop form was inspected with the bundled MarcRoboto font. Local source and automatic Sync regression evidence do not substitute for a new real-device acceptance test.

Stop boundary: source refinement and observational evidence only. Installed APK/setup artifacts have not been rebuilt by this change. Real Windows/Android visual acceptance and purchase/Sync smoke checks remain human gates. This append is observational evidence, not semantic promotion or a replacement of historical C11 staging.

## 2026-10-05 — C02 Purchase, Lists and Analytics refinement

Direct bounded human authority: implement faint green required source inputs and blue linked prices, early validation with understandable feedback, Lists time-view selection and Account-wide notes/tags, and the clarified Analytics matrix. The human confirmed month as rows, Nescau as Analytics 01, Condor as Analytics 02, mean as the operation and price per kg as the value. Multiple selected comparison values produce separate contexts/series. This follow-up supersedes the preceding purple-required Purchase palette; historical evidence remains intact.

Implementation base remains markei-season-02 at ebe9fc9af6d048462a1d69b84134671619fed117, including the preceding uncommitted Purchase refinement. Work was implemented and validated in the matching isolated checkout. Canonical transfer is guarded by normalized baseline hashes for each existing changed file and absence checks for each new file. Previous source edits are preserved; branch topology and the index are unchanged.

Purchase now uses faint green/blue input and header tones, explicit Required/Optional/Linked labels, a small live price-guidance card and complete-date/time validation before review. Incomplete typing stays quiet. New-product facts, quantity and one price are checked before staging; similarity-query failures prevent staging. Diagnostics remain separately available below understandable feedback. Successful registration states that the Purchase was saved locally and must be synced to share it.

Lists switches Expected next purchase / Days from last purchase in the table header and compact controls. This is presentation over the existing history projection; it does not change forecast classification. Product identity displays name, brand and packaged/bulk mode. Notes and free-text tags are searchable and editable on compact and wide layouts. @person/#payment are descriptive tags, not new foreign-key assignments to People or Payment Methods. Notes save locally and join the existing explicit Sync queue.

Shared note architecture: SQLite schema 13 adds Account-scoped list_note_revisions. product.list-note.recorded payload version 1 uses the existing Account/Device sequence, canonical hash, transactional outbox/inbox and contiguous cursor. Product facts travel with the note. Duplicate replay is equivalent. Edits replace only revisions observed by the author; unobserved concurrent edits remain visible until the user combines them. No new dependency, service, background retry or automatic network write was added. Async note loads are guarded against stale Account/view results.

Analytics retains one workspace controller, evidence read path and calculation engine. Searchable Determinants / rows, Analytics 01 and Analytics 02 group by stable identities. Operation and numeric values are separate controls; duplicate dimensions are rejected. Comparison operations pair determinant rows within matching comparison contexts. Saved records freeze selections and retain context in tables, charts and CSV/PDF. Chart pagination exposes all entries with one shared scale and stable series colors. The PDF contains paginated result columns and vector charts; Latin EN/PT accents render. The built-in PDF font replaces characters outside ASCII/Latin-1 with ?, so unrestricted Unicode export remains a limitation. Shared chips now explicitly use the existing MarcRoboto font.

Hosted recovery needs migration 009_list_note_recovery, ledger checksum c02-list-note-recovery-v1. It permits snapshot format 1/schema 6 and format 2/schema 13. Note-bearing snapshots use format 2 and preserve all revisions. Older recovery clients refuse format 2 rather than dropping notes; older incremental clients also cannot consume the new event. Rollback refuses to remove format 2 support while such snapshots exist. DB_MGMT.sql registers 009 with raw SHA-256 hashes for up/down files. GRM-MIG-01 / GS-MIG-01 reads an ordered registry containing 001 through 009; its clean, committed/tracked source guards remain in effect. The local hosted harness includes 009. Migration 009 has NOT been applied to Neon by this work.

Fresh machine evidence: Flutter analysis has no issues; the complete serial client suite passes 319 enabled tests with four existing skips. The API passes 64 tests, type checking and lint. Tests cover linked prices, early input validation, compact note editing/reopening, two-peer note sharing, duplicate replay, Account isolation, concurrent merge, invalid-note transaction rollback, snapshot note restoration, Analytics contexts/frozen exports and chart pagination. A disposable localhost PostgreSQL fixture applied migrations 001-009, replayed 009, checked its ledger/hash registration and format/schema constraints, proved protective rollback, then clean rollback/reapply. The fixture was stopped. This is local machine evidence, not a Neon/provider claim. Actual Flutter widgets were rendered and inspected at desktop/phone widths; the two-page sample PDF was rendered and inspected.

Rollout / remaining acceptance gate:

1. Review and commit/publish this bounded source change with the existing Purchase refinement; satisfy GS-GIT-01 before invoking the guarded migration walker.
2. With the human's development Neon target independently confirmed, run GS-MIG-01 to move the existing verified 008 ledger to 009. Verify the matching 009 ledger and the two recovery constraints. Retain the existing restricted runtime role.
3. Deploy the same reviewed API source, then verify hosted health/readiness. No Auth0 change is required by this refinement.
4. Build and install updated Windows and Android clients for ALL Devices in the test Account before creating shared notes. Existing setup/APK artifacts still contain earlier source.
5. On Windows/TL10, check one package and one bulk Purchase, note/tag sharing in both directions, duplicate-free repeated Sync, concurrent offline note edits, date/time feedback and the confirmed monthly Analytics table/chart plus PDF/CSV.

Stop boundary: validated source and this observational append. No provider changes, membership provisioning, deployment, Git commit/push, installer build or real-device acceptance is claimed. This record does not promote canonical semantics or rewrite historical C11 staging.

## 2026-10-05 — C02 Analytics start/end date range

Direct bounded human authority: replace date checkboxes with a timeframe between two dates. Analytics now presents Start date and End date without All/Custom chips or per-date checklists. Both local calendar dates are inclusive; the existing UTC predicate runs from local start midnight through, but excluding, midnight after the final date. Leaving both fields blank includes all recorded time; a partial, invalid-calendar or reversed range blocks execution and retains typed text. Clear and remount restore the field state coherently.

Daily/monthly determinant rows and temporal comparison axes follow this shared range. Temporal row keys derive from recorded evidence after timeframe, comparison and selected-evidence scope filters, so difference eligibility counts matching groups. Saved records retain their frozen selections. Product/Purchase/Store choice, prior Purchase/Lists refinements, calculations and exports are preserved. Normalization preserves explicitly supplied measures/breakdowns as well as the variable-based UI draft.

Fresh validation: Flutter analysis reports no issues. Thirty focused Analytics tests pass, including six new date-range widget tests and two new controller regressions. Checks cover sequential/partial entry, invalid and reversed dates, clearing/remount, inclusive day boundaries, compact/wide layouts, derived temporal groups, filtered comparison eligibility, selected evidence scope, frozen records and explicit measure compatibility. Actual Flutter desktop and phone widgets were rendered and visually inspected. This follow-up was validated in the matching isolated checkout and transferred with per-file normalized baseline hashes; previous uncommitted changes are preserved.

Stop boundary: source refinement and this observational append. No migration, provider change, Git commit/push, deployment or installer build; installed clients still require an updated build. No historical notebook record was rewritten and no canonical semantics were promoted.

## 2026-10-05 — C02 Portuguese and Spanish localization

Direct bounded human authority: dedicate this turn to full Portuguese/Spanish app localization, a language preference in Settings, and a Home notice that translations will receive human review for the first official app update. This is the human's reprioritization of C02 language refinement. Acceptance gate: translated main pages and exports, persistent preference with safe fallback, unchanged Purchase drafts/user data/calculations, clean analysis and passing client regressions. Stop at validated source plus this observational record.

Materialized English, Brazilian Portuguese and Spanish presentation catalogues (804 messages each), with editable ARB resources and a local generator checking key/placeholder parity. App localization delegates also localize Flutter's standard controls. Settings offers Device language, English, Português (Brasil) and Español. The preference is saved in the application support directory on this Device, independently of Account membership and Sync. Unsupported device languages fall back to English. Read/write failures are visible; a failed save retains the previous active preference. The app preserves the selected page and editable Purchase draft when the language changes.

Navigation, Home, Purchase, Catalogue, Lists, History, Analytics, Household, Guide, Documentation, Settings and Audit use translated application copy, including field hints, validation, status explanations, tooltips and accessibility labels. Names, product codes, brands, emails, notes, tags, Account/Device IDs, protocol values and diagnostic identifiers remain verbatim. Numeric presentation uses comma decimals in PT/ES while existing canonical input/calculation/storage values remain unchanged. CSV column/enum identifiers remain stable for machine use; human fallback captions and PDF headings use the selected language. History PDF now escapes Latin-1 accents with WinAnsi encoding; Analytics reports translate the frozen interpretation without recalculating its values, counts or groups.

Home contains a violet translation-review notice in all three languages. The note explicitly describes future human review for the first official app update; it does not claim that such review has already occurred. Auth0-hosted browser pages are outside this local preference; no provider configuration was changed.

Fresh validation: Flutter analysis reports no issues. The full serial client suite passes 336 tests with four existing skips. Nine localization tests cover catalog parity/placeholders, dynamic parameter and diagnostic-code preservation, device preference persistence/reload/default reset/failure, unsupported OS fallback, all main-page navigation in PT/ES, validation text, raw user labels, language switching with a retained draft, and accented History/Analytics exports retaining frozen calculations. Actual Flutter Home/Purchase pages at 1280/390 widths and desktop Settings were rendered with the bundled fonts and visually inspected in both languages. These are fixture-based UI renders, not new Windows/TL10 runtime or hosted authentication evidence.

Human next check: stop and restart the configured VSCode debug run after dependency resolution, then use Settings > Language. Confirm terminology, long text, purchase fields, date/price errors, a retained draft across language changes, and preference persistence after closing/reopening. Physical Windows/TL10 acceptance and human Portuguese/Spanish wording review remain open. Existing installed clients/APKs still need an updated build.

Transfer is bounded to named localization client files and this append, with normalized pre-edit hashes checked before replacement and backups retained outside the checkout. Earlier uncommitted Purchase/Lists/Analytics work and the Git index are preserved. No schema migration, API change, Auth0/Neon/Render mutation, Git commit/push, release/deployment or installer build is claimed. No historical notebook record or canonical domain semantics were rewritten.


## 2026-10-05 — C02 native sharing / Marc MVP beta 1.2.0+4

Direct bounded human authority: complete sharing and prepare update builds for Windows, TL10 and Play Console testing, with Home notes for studied NF/NF-e scanning and exploratory Marc pour Resto. The human explicitly narrowed this Step to sharing any List condition, a selected History fragment and a saved Analytics result. Household invitations are deferred; profile display remains the existing Household capability. No invitation endpoint, role/account switching or invitation schema was materialized.

Materialized a typed ContentSharingPort and share_plus 13.3.1 native adapter, injected through the existing composition. Lists shares the currently filtered/ordered visible products and estimates as text, with a content preview; notes/tags are excluded. History shares only selected Account-scoped Purchases as PDF/CSV after a scope/data confirmation, including assigned person/payment labels. Analytics shares the frozen saved result as PDF/CSV without recalculation. Native Android/Windows sharing lets the human choose the app/recipient. Cancellation, handoff, unknown completion and failures are distinct; handoff never claims delivery. A user-opened sharing menu gives no Marc membership. No background send or new hosted sharing API was added.

File sharing uses bounded payloads, validated file names and UUID directories under the app's temporary marc-shares cache. Recent files remain available for asynchronous recipient reads; app-owned expired directories are cleaned on later file shares. The adapter requests no broad storage permission. Existing Downloads export remains available on Windows. All new app copy is present in English, PT-BR and Spanish (830 messages per catalog). Home describes conditional scanning viability and Resto research over the coming months, without representing these proposed features as available or promising delivery dates. Version is 1.2.0+4, with existing application identifiers/signing key retained.

Fresh source evidence: analysis reports no issues; full serial client suite passes 341 tests with four existing skips, and API type checking/lint plus all 64 API tests pass. Sharing tests cover private cache bytes/MIME, name validation, unsupported platform, duplicate action lock, cancel/unconfirmed/exception handling, visible filtered List scope, selected History scope and frozen Analytics identity. The first full client run caught an extra toolbar row overflow in a standalone Analytics fixture; absent sharing support now omits that control and the complete rerun passes. A subsequent cancellation-message refinement passes all three History tests. Actual Flutter Portuguese Home roadmap and phone review dialog were rendered; these are fixture-based visual evidence, not physical recipient-delivery proof.

Packaging boundary: prepare signed APK, upload-signed AAB and Windows setup from this source, then publish as an MVP beta test candidate. Exact artifact hashes/signatures and packaging outcomes are recorded in the task's outputs/Marc-MVP-1.2.0-4-manifest.json when produced. The accompanying testing guide names direct-device updates, Play internal testing and Play App Signing/Auth0 fingerprint verification. Windows publisher signing remains unconfigured; Google Play acceptance and real-device sharing remain human gates. No production launch is claimed by tests/compilation.

Existing provider rollout remains separate: the earlier List note/tag changes need migration 009_list_note_recovery and the matching API deployment before Account-wide note tests; all Devices in that Account must use updated clients. This Step adds no new backend migration. No Neon, Auth0, Render or Play Console mutation is claimed. Test users still need fresh onboarding/isolation acceptance, and C01 privacy/account-deletion/store requirements remain open. This observational append preserves prior evidence and does not promote canonical semantics.


---

## 2026-10-05 — C02 statistics, Household and disclosure refinement / Marc 1.2.1+5

**Class:** observational materialization and beta release evidence; no canonical promotion. This dated entry follows the existing C02 materializations in `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`.

### Authority, recovery and bounded scope

Direct human instructions authorized the Analytics usability correction, Household/Settings People and Payment Method refinements, two Lists date interpretations, a future-Purchase review gate, and accurate in-app data/permissions/provider documentation. The human confirmed version **1.2.1+5**, Device-local payment assignments, and the labels **Most recent Purchase Registered** / **Last Purchase up to date**. After viewing the real-widget preview, the human confirmed the Variables table as the remaining section to refine, then approved the result and requested wrap-up. These instructions govern this bounded follow-up; the historical C11 D/E/F material remains unchanged and is not represented as newly granted C02 authority.

Recovery used repository `AGENTS.md`, Sketch `INDEX.md`, the existing C02 evidence in `I_DSN_CODEX.md`, and relevant implementation/test/build evidence. Main/root and domain checkpoints retain older C11/C12 planning context; this report exposes the new observations without silently rewriting those checkpoints or declaring Cycle 13 definitive UI acceptance.

Base: `81c958a4fba9370f47c2dcdbc173cbd177d0248c` on the active `markei-season-02` lineage. Reproducible candidate source: **`8d707ef3b52738b9b6e38b975b2c3793bf42d070`**, committed in the isolated matching checkout. Git tree object: `7a0c53a800d2ebc131a0c41aad9e18f976e1fc21`. Source-tree SHA-256: `cc90eed11552b5fcae07d63ee5c534d64d5abc951bd32870bd3de092ef7d167c`, using UTF-8 `markei-source-tree-v1`, LF, the tree object ID, LF. The candidate's 45 changed files are confined to `clients/markei_flutter`; no API or hosted migration source changed in this refinement. Source identity is recorded in `outputs/Marc-1.2.1-5-source.json`. The clean canonical checkout was fast-forwarded without rewriting history; GitHub beta source and all 11 asset digests were verified. Notebook reconciliation is a documentation-only follow-up whose client tree matches this build commit.

### Completed behavior

- **Statistics:** identical configuration and normalized evidence cannot create another analysis until configuration or actual evidence values change. Input order alone does not create a distinct run. Frozen saved analyses retain their evidence and selections; selecting a card restores its configuration and result without recalculation. Compact cards show two lines. The controls use **Determinant**, **Analytics**, and **Analytics constraint**, with a type dropdown and a searchable, scrollable five-row checklist of recorded values plus all-record selection. The selected statistic remains separate. `Statistics: …` identifies the selected measures. Interpretation uses a subheader and body explaining the selected rows, contexts, counts, measure units, and formula. Purchase Total is counted once per purchase within a group; monetary/quantity comparisons retain compatible units and currency. Undefined zero-denominator results disclose eligibility rather than fabricate a value.
- **Variables table:** wide and compact layouts now display actual recorded Purchase/item values in a horizontally scrollable table with a persistent visible scrollbar. Purchase rows include date/time, Store, Purchased by, Purchased for availability, Payment Method, item count and Purchase Total. Item rows additionally expose separate product code/name/brand, quantity, Unit Price and Price paid. Item Price paid and whole Purchase Total are distinguished; the latter may repeat visually across item rows without being summed repeatedly by the purchase-grain calculation. Search, sort, pagination and selection remain active, with paging based on the complete filtered count. **Purchased for** remains explicitly unavailable until actual recipient data exists; descriptive tags are not reinterpreted as a person identity.
- **Dates:** Analytics inserts `-` during date entry, retains strict calendar validation, and preserves the prior inclusive start/end date range. Future Purchase dates remain permitted, but registration first opens Review/Confirm; Review or dismissal preserves the draft without a database write, and Confirm performs one registration. Submission is locked while the confirmation/write is active.
- **Lists:** Cycle presents the existing estimate alongside **Most recent Purchase Registered** (latest entry order) and **Last Purchase up to date** (latest purchase occurrence on or before today, excluding future dates). These presentation choices leave forecasts and price projection policy intact; shared List text identifies the selected Cycle interpretation.
- **Household/Settings:** local People cards expose name/code, an expandable assigned-payment list and latest locally registered Purchase. Assignment to one active Account-local Person is editable or clearable in Settings. Archive/unarchive preserves reference identity and historical Purchase associations; archived variables are unavailable for new use. Local SQLite schema **13 → 14** adds the nullable assignment relation without rewriting history. Assignments, People and Payment Methods remain local to this Device, as the human requested. No assignment Sync event or shared-reference protocol was added.
- **Documentation:** eight local topics explain business records, local technical/Sync data, explicit sharing/login/Sync, permissions, database/backup limitations, provider involvement, responsibilities and unresolved publication details. Five provider-policy links are readable/copyable; opening Documentation itself initiates no provider request. Copy does not claim zero metadata, database encryption, guaranteed recipient delivery, or blanket immunity from mandatory rights. It records the absence of current camera/microphone/location/contact access; Internet and inherited biometric/fingerprint/receiver permissions are disclosed, with no current biometric-template authentication call found. There is currently no in-app Account deletion. EN, PT-BR and ES catalogues each contain **922** validated messages, including the new controls, disclosures and interpretation text. Human language review remains a release gate.

“Evidence” here means the recorded Purchase/item facts actually loaded and used by a calculation, with identity, scope, units and counts. It does not certify factual truth, external audit, legal compliance, hosted deployment, or physical-device acceptance.

### Fresh validation and packaging observations

| Scope | Observed result | Evidence ceiling |
| --- | --- | --- |
| Integrated client suite before final Variables presentation follow-up | **368 passed; four existing skips**, serial run | Complete regression evidence for the pre-follow-up client; `refinement-client-acceptance.log` |
| Final affected Variables/component/localization checks | **17 passed**; additional actual-widget preview **1 passed** | Final follow-up coverage, not a second full-suite run; `refinement-variables-final.log` |
| Static analysis | **No issues found** | Local Dart/Flutter analysis; `refinement-analyze-final.log` |
| Locale generation/parity | **922 messages** per EN/PT-BR/ES catalogue | Keys/placeholders/local copy, not independent human translation approval |
| Source whitespace | `git diff --check` passed | No source syntax guarantee by itself |
| Android release candidate | Signed APK built, `com.gusigu.markei`, `versionName=1.2.1`, `versionCode=5`, min SDK 24/target 36; label Marc | Packaging proof, not installed runtime proof |
| Android signature/native packaging | Existing RSA-3072 certificate retained, one signer; CRC and native ELF/ZIP 16 KB alignment passed | `refinement-apk-signature.txt`, `refinement-apk-manifest.txt`, `refinement-apk-native-validation.json` |
| Windows release/setup | Release build and installer passed; setup version 1.2.1.5 | Existing installer/update identity retained; Authenticode status NotSigned |
| Play internal-testing bundle | AAB built; Google bundletool validation, release/package/version manifest and jarsigner verification passed | Upload is a separate human action; self-signed certificate/timestamp/stream warnings are recorded |
| GitHub beta publication | v1.2.1-mvp-beta.5 points to build source 8d707ef; all 11 uploaded asset SHA-256 digests match local bytes | Prerelease publication, not store or hosted acceptance |
| Visual review | Real Flutter desktop/phone widgets rendered with synthetic fixture records; human approved final Variables refinement | Not a live Account or physical Windows/TL10 acceptance test |

Commands/procedures exercised: dependency resolution, locale generator, Drift generation, Flutter analysis, serial client tests (`--concurrency=1`), affected Analytics/widget/localization tests, temporary fixture preview rendering, release APK build with ignored public definitions, Android package/signature/native checks, and Git diff/source-tree inspection. Shared Flutter caches were serialized; initial concurrent timing/cache interference was corrected without relaxing acceptance thresholds. Temporary preview test code was removed. Private signing/configuration material remains ignored and is not part of the source commit or this report.

**Not repeated:** API tests/provider checks, because no API/provider source changed in this unit. The earlier 64 API tests and migration 009 fixture are inherited evidence only. Migration **009_list_note_recovery**, compatible API deployment and updated clients still govern Account-wide notes/tags; this report does not assert that 009 is applied to Neon or that the matching service is deployed. Earlier human Windows↔TL10 Purchase Sync remains historical evidence, not fresh proof for 1.2.1.

### Changed-file inventory

All paths below are relative to `clients/markei_flutter/`.

Modified application/UI: `lib/app/markei_app.dart`, `lib/app/markei_composition.dart`, `lib/app/pages/analytics_page.dart`, `lib/app/pages/household_page.dart`, `lib/app/pages/lists_page.dart`, `lib/app/pages/purchase_page.dart`, `lib/app/pages/settings_page.dart`, `lib/app/widgets/analytics_components.dart`, `lib/app/widgets/marc_brand.dart`.

Modified application/domain: `lib/application/analytics.dart`, `lib/application/analytics_workspace.dart`, `lib/application/local_references.dart`, `lib/application/product_lists.dart`, `lib/domain/analytics/analytics_models.dart`, `lib/domain/analytics/analytics_registry.dart`, `lib/domain/references/local_reference.dart`.

Modified local persistence: `lib/infrastructure/local/local_database.dart`, generated `lib/infrastructure/local/local_database.g.dart`, `lib/infrastructure/local/local_purchase_repository.dart`, `lib/infrastructure/local/local_query_repository.dart`.

Modified localization/version: `lib/l10n/analytics_copy.dart`, `lib/l10n/marc_messages.dart`, generated `lib/l10n/messages.g.dart`, `lib/l10n/strings_en.arb`, `lib/l10n/strings_es.arb`, `lib/l10n/strings_pt_BR.arb`, `pubspec.yaml`.

Modified tests: `test/app/analytics_components_test.dart`, `test/app/analytics_page_test.dart`, `test/app/analytics_timeframe_test.dart`, `test/app/household_page_test.dart`, `test/app/lists_page_test.dart`, `test/app/localization_test.dart`, `test/app/markei_app_test.dart`, `test/app/purchase_refinement_test.dart`, `test/app/settings_page_test.dart`, `test/application/analytics_axes_test.dart`, `test/application/analytics_workspace_test.dart`, `test/infrastructure/local_database_migration_test.dart`, `test/local_purchase_repository_test.dart`.

Created: `lib/app/pages/documentation_page.dart`, `lib/application/household.dart`, `test/app/documentation_page_test.dart`, `test/infrastructure/local_household_repository_test.dart`, `test/infrastructure/local_list_dates_test.dart`. Deleted tracked files: none.

### Handoff, stop conditions and remaining gates

1. Complete and verify both update artifacts; record exact byte sizes/SHA-256 and final manifest. Windows publisher signing remains unconfigured unless separately established. Preserve Android signing/package/update identity. Do not replace build verification with fixture previews.
2. Transfer the reviewed source only against unchanged canonical baseline, then publish through the existing non-force guarded Git procedure and verify remote identity. If canonical HEAD/bytes/index diverge or unrelated edits appear, STOP and reconcile. Keep notebook/release metadata follow-up in a separate commit; verify `clients/markei_flutter` tree remains identical to the build source so a report commit cannot falsely masquerade as newly built code.
3. Update the existing Notion C02 tracklog (`3f0a3e26-eacd-818d-b42a-f6399252d4fe`) with a dated superseding status, retaining earlier fixture evidence. Its old unimplemented-language/share/no-rebuild wording is stale after these implemented steps. C02 root is `3f0a3e26-eacd-81f7-9568-c559a94ae2d4`; do not create a duplicate cycle or tracklog.
4. Install/update on actual Windows/TL10 and verify database upgrade, Person/payment assignment/archive/restore, both Lists date options, future-date Review/Confirm, saved-analysis restoration, duplicate-run guard, Variables scrolling, EN/PT-BR/ES, exports/sharing and bidirectional repeat/empty Sync. Fresh-user automatic onboarding and declared Account/Device isolation remain independently required; no emulator workaround is claimed as their acceptance.
5. Refresh IP/release preparation from the exact approved source/artifacts, preserving the earlier 1.2.0 dossier as historical. INPI software copyright/trademark and conditional patent/PCT/Madrid routes remain distinct. No filing, registered right, patentability conclusion, WIPO global protection, provider change, store approval or production launch is created by this report.
6. Before public store launch, resolve publisher/contact, retention/deletion workflow, provider disclosures/legal basis/international transfer, final policies, signing/store requirements and human language review. Existing code supports local use and explicit Sync/sharing; unresolved publication policy must not be represented as complete merely because app tests pass.

Stop boundary: reviewed client refinement, reproducible beta artifacts and observational release/documentation follow-up. No provider mutation, secret entry, hosted migration, Auth0/Render/Neon change, household invitation implementation, fiscal scan, Resto feature, account reset or irreversible IP filing is part of this unit. Methodology, permanent domain semantics and branch topology remain unchanged.

### Verified release artifacts and IP preparation

Release: https://github.com/gus-i-gu/markei/releases/tag/v1.2.1-mvp-beta.5. All 11 remote SHA-256 digests match local artifact bytes.

| Artifact | Bytes | SHA-256 |
| --- | ---: | --- |
| Marc-Android-1.2.1-5.apk | 71369740 | 3d8c599aea551c08f7312433201b5592af0bbc73cb3ff9b1912a22b2d7d778e5 |
| Marc-Windows-1.2.1-5-x64.exe | 16574510 | 5e800292a0398068b3a1e3a708407e90e9ef6ba99fe70c19feef0864b3ad36be |
| Marc-Play-1.2.1-5.aab | 67825909 | cad14ae72753c7f65865d3220278afa06e2fcb1812969b10fd5735cd34a1c301 |

The local Marc-IP-preparation-1.2.1-5.zip contains a 353-file source candidate matching the build commit. Exact source ZIP SHA-256: 43E097E50E2D905AA4C5C8D07153C83244A03B7BF0283959E63CA58464B3973F. SHA-512: 93AFAE7BD8DB0AB8C08915F31E0E53BEAE4D04FD06630F84DB9D55E70E0D4D6A92A694B9A545CF5B4909C9724C65240B4E1E91C6BA28FD8A4BC21FD8B798D706. The 1.2.0 packet remains unchanged. Owner/authors/scope/classification/qualified-signature approval is pending; no INPI/PCT/Madrid filing is claimed.

Source, beta downloads and version-specific IP preparation are complete. The current human step is the actual Windows/TL10 update and release-guide acceptance. Hosted notes rollout, fresh-user/Account isolation, publisher/privacy/store and legal filing gates remain independent.
