# H_DDC_CODEX - C11 PH01 S02 Preliminary Didactic Evidence

## Meaning Changes

Home now presents one primary action, Register purchase, with secondary routes to Lists, Catalogue and History. Stale wording that treated Sync as future work was replaced with bounded local-first wording.

Lists language distinguishes Purchase-history estimates, first-use empty, filtered empty, insufficient Product history and read Retry. Catalogue uses Product/Store wording without adding category, image or price-history claims. History uses loaded-entry presentation filters only. Purchase keeps unknown-result guidance separate from ordinary failure.

## Omitted Reference Features

The implementation intentionally omitted Product images, categories, Store/Person/category filters not backed by loaded facts, price movement, remaining-cycle claims, Move to Analytics, Edit/Delete, Household, Audit behavior and Analytics calculations.

## Evidence

Automated evidence passed for formatting, analysis, visual foundation tests, Lists page tests, Lists/export application tests, Purchase calculation contracts, one History app-state case and one Store-selection app case.

Evidence did not pass to full S02 completion because several app-level Purchase review cases timed out without producing Flutter assertion output.

## Accessibility Notes

Theme typography was reduced to the requested weights/sizes, compact gutters increased to 16 dp, interactive controls retain Material targets, and page headers now avoid compact trailing overflow. Automated 200 percent evidence exists only from the visual foundation Home test. Full five-page 200 percent visual acceptance remains unvalidated.

## Terminals

CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02
FIVE_PAGE_MEANING_PARITY=PARTIAL
TRUTHFUL_CAPABILITY_LANGUAGE=PASS
STATE_DISTINCTIONS=PARTIAL
COLOR_ONLY_MEANING=NO
UNSUPPORTED_REFERENCE_CLAIMS=NONE
TABLE_CARD_FACT_PARITY=PASS
RESPONSIVE_STATE_PRESERVATION=BLOCKED
HUMAN_ACCESSIBILITY_ACCEPTANCE=NOT_PERFORMED
KANBAN_TRANSITION=NONE
NEXT_MAIN_ACTION=Investigate the hanging Purchase review cases in test/app/markei_app_test.dart before publication.
