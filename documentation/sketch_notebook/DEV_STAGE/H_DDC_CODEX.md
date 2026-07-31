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
