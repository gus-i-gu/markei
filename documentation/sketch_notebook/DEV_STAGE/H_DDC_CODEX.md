# H_DDC_CODEX - C11-ANALYTICS-CORRECTION-R01

## Learner-Facing Result

- Composer reading order is `Create analysis`, `Group by | Variables | Operation | Timeframe | Run & save`, `Saved analyses - this session`, selected result, then `Variables`.
- One visible Variables selection set now names Purchased by, Purchased for, Payment method, Quantity, Unit price, Price paid, Purchase total and Evidence count.
- Purchased by and Payment method break down selected numeric results. Purchased for explains that recorded data does not support it.
- Categorical-only selections say: `Choose at least one numeric variable. Categorical variables break down a result but are not calculated.`
- Unsupported operation copy names the operation and selected numeric variable.
- Custom Timeframe uses `Initial date` and `Final date` with `dd-mm-yyyy`; missing, invalid and reversed pairs explain the smallest correction.
- Result values display ordinary scales: decimal quantity and unit, decimal currency, currency per unit, percent, signed Difference and integer Evidence count.
- Compatibility keys such as `quantity:mass:kg`, fixed-point storage integers and ordinary UUIDs are absent from user-facing result/export assertions.
- Variables evidence presents `Date-Time of purchase`, `Store name`, Purchased by, Purchased for, Payment method, Item count, Purchase total and item facts without ordinary Purchase/Product/Store/Item UUID labels.
- Clear draft remains visible as a compact secondary action and preserves saved records.

## Automated Learner Evidence

- Focused Analytics tests prove draft changes do not mutate saved records and selected records do not reuse the live draft.
- Result, interpretation, CSV and PDF assertions prove selected variables and formatted values agree from one frozen record.
- Widget tests cover compact and wide Variables presentation, UUID hiding, Date-Time/Store visibility, and 200 percent text scale containment in the component harness.
- Human screenshot, keyboard-only, Narrator/TalkBack, locale, real-device and comprehension reviews were not performed.

## Terminal

```text
CYCLE=C11
UNIT=C11-ANALYTICS-CORRECTION-R01
COMPOSER_READING_ORDER=PASS
UNIFIED_VARIABLES_LANGUAGE=PASS
NO_IMPLICIT_VARIABLE_SUBSTITUTION=PASS
DISPLAY_SCALE_LANGUAGE=PASS
CUSTOM_DATE_LANGUAGE=PASS
PURCHASE_PRODUCT_UUIDS_VISIBLE=NO
CHART_TABLE_EXPORT_MEANING=ALIGNED
CLEAR_DRAFT_MEANING=PRESERVED
WIDE_COMPACT_PARITY=PASS
TEXT_SCALE_200=PASS
KEYBOARD_SEMANTICS=PASS
SCREENSHOT_REVIEW=NOT_PERFORMED
ASSISTIVE_TECH_REVIEW=NOT_PERFORMED
LOCALE_REAL_DEVICE_REVIEW=NOT_PERFORMED
HUMAN_COMPREHENSION=NOT_ESTABLISHED
KANBAN_TRANSITIONS=NONE
```


## 2026-10-02 — Flutter release packaging evidence

Direct human-authorized Flutter packaging work completed. See G_OPS_CODEX.md section dated 2026-10-02 for exact source changes, environment recovery, validation, and evidence limits. This append is observational evidence, not semantic promotion. Windows setup compiled and installation lifecycle checks passed; Android release signing awaits explicit human choice. Existing C11 staging was retained.


2026-10-02 Android follow-up: human approved signing key creation. Signed APK built and signature verified. G_OPS_CODEX.md contains exact evidence and the remaining Auth0 fingerprint registration requirement. This supersedes the earlier signing-pending statement; no semantic promotion or provider mutation.


## 2026-10-03 — Marc branding evidence

Direct human branding request implemented. Visual name and image assets changed while technical application/update identities were retained. Adobe PNG artwork drives runtime rendering; the traced SVG is a reusable design master. Existing validation: analysis plus 44 app/layout/Windows packaging checks passed; Windows and Android release builds passed. No learner-mastery or semantic-promotion claim. Detailed evidence: C:\Users\gyg29\Documents\Codex\2026-10-03\g-we-need-now-to-check\outputs\Marc-branding-integration.txt.

## 2026-10-03 — New-account migration evidence

Direct human-authorized migration retained Flutter source, package identities, signing key, Marc branding and beta notice. New Auth0 native clients/API and Render service are configured; existing empty development Neon schema is reused through restricted markei_runtime. GRM hosting/auth metadata checks and Windows/Android build 1.0.0+2 pass. Real-user sign-in, guarded membership provisioning, enrollment and cross-device sync remain open. Clean remote-aligned source is still required for GRM-AUTH-03. See the same-date G_OPS_CODEX migration section for exact evidence. No semantic promotion, methodology edits, data purge or publication.

## 2026-10-03 — First-beta bundle evidence

Human-authorized AAB preparation and safety checks completed locally. Existing Flutter suite: 286 pass / 4 skip; backend: 61 pass, lint/type/build pass and zero npm advisories after compatible patches. Release Android callback restricted to configured HTTPS; AAB/APK signatures, manifest and 16KB native alignment verified. Security patches have NOT been deployed. Native sign-in/provisioning/enrollment/sync and store acceptance remain open; see same-date G_OPS_CODEX details. No semantic promotion or public release.
