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
