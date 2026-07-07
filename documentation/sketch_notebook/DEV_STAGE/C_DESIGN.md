# [D] Session 002 | 10:45_07_07_2026 | Markei

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Design Chat

Responsibility: architecture, domain boundaries, responsibility allocation, abstractions, and long-term maintainability.

This pass evaluates only architectural responsibilities after the Repository repair. It does not edit application code.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOTSTRAP STATUS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Read successfully:

- AGENTS.md
- documentation/sketch_notebook/INDEX.md
- documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
- documentation/sketch_notebook/methodology/PROMOTION_RULES.md
- documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md
- documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
- documentation/sketch_notebook/methodology/FLUX.md
- documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md

Relevant methodology constraints:

- Functional Design Chat may write only `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`.
- Functional Design Chat must not edit application source code.
- Design Chat observes architecture, domain modeling, separation of responsibilities, and structural consistency.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROBLEM ANALYSED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Reported current failure:

    StoragePage initialization fails with:

        KeyError: "color"

Reported context:

- Repository repair has already moved the application beyond the previous persistence adapter failure.
- The current failure happens during StoragePage initialization.
- The question is whether the service layer should provide UI metadata such as colors, and whether Qt objects such as QColor belong inside ProductService.

This Design Chat pass evaluates architecture only. It does not propose a code patch except where necessary to explain layer ownership.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. ARCHITECTURAL OBSERVATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Observation 1 — The failure moved upward in the dependency chain.

The previous architectural concern was whether ProductService could correctly depend on a concrete Repository adapter. The current reported failure occurs during StoragePage initialization, which places the symptom in the UI/presentation area rather than in the persistence repair itself.

Architectural implication:

    Repository repair exposed the next boundary problem.

The system now appears to be failing not because persistence cannot be imported, but because the UI expects a presentation field named `color` that is not present in the data object it receives.

Observation 2 — `KeyError: "color"` indicates a contract mismatch.

A missing `color` key means one layer expects the returned product/status structure to contain presentation metadata.

There are two possible architectural interpretations:

1. ProductService promised a UI-ready dictionary containing `color`, but failed to provide it.
2. StoragePage invented an expectation that ProductService should provide `color`, even though ProductService owns business semantics rather than visual rendering.

The second interpretation is architecturally preferable because it preserves layer separation.

Observation 3 — Price variation has two meanings.

Price variation can mean:

- domain semantics: price increased, decreased, stayed stable, has no previous comparison, or is affected by promotion logic;
- presentation styling: green/red/gray/yellow, QColor objects, table brushes, labels, or icons.

These are not the same responsibility.

The domain meaning may belong to the business layer.
The color representation belongs to the UI layer.

Observation 4 — QColor is a Qt presentation object.

QColor is not a domain value. It is part of the PySide6/Qt presentation framework.

If ProductService imports, constructs, stores, or returns QColor, then the service layer becomes coupled to the UI framework. That would make the service less testable, less reusable, and less clearly separated from presentation concerns.

Observation 5 — Shiboken warning is not itself an architectural diagnosis.

A Shiboken warning usually belongs to the Python/Qt binding runtime boundary. By itself, it does not prove an application architecture violation.

However, if Qt objects are being created, passed, retained, or transformed outside the UI layer, the warning may become supporting evidence that presentation objects are leaking into non-presentation code.

Therefore:

    Shiboken warning alone: runtime/UI binding concern.
    Shiboken warning plus service-owned QColor: architectural boundary smell.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
2. BOUNDARY OWNERSHIP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Canonical dependency direction remains:

    UI
    ↓
    ProductService
    ↓
    Repository
    ↓
    database.py / SQLite

Layer ownership for this problem:

1. Repository

Owns:

- persisted products;
- persisted purchases;
- persisted prices;
- raw historical purchase data;
- SQL and row reconstruction.

Does not own:

- price variation meaning;
- shortage/market interpretation;
- UI colors;
- QColor;
- table styling.

2. ProductService

Owns:

- business interpretation of purchase history;
- product availability status;
- price variation semantics;
- domain labels or enum-like semantic states such as `price_up`, `price_down`, `price_same`, `no_previous_price`;
- calculations needed to decide what a product means in the application domain.

Does not own:

- PySide6 objects;
- QColor;
- table item styling;
- visual palettes;
- UI widget concerns;
- final presentation colors.

3. StoragePage

Owns:

- rendering storage data;
- translating domain status into visible UI representation;
- choosing table colors, labels, icons, or text formatting;
- handling absent optional presentation fields defensively if UI metadata is used internally.

Does not own:

- domain calculations for price variation;
- purchase interval calculation;
- expected depletion logic;
- persistence queries;
- direct SQL access.

4. Presentation adapter / UI mapper, if introduced later

May own:

- mapping domain semantic states to UI metadata;
- converting `price_down` into green text;
- converting `price_up` into red text;
- converting shortage status into warning style;
- constructing QColor or other Qt presentation values.

This can live inside the UI layer without burdening StoragePage directly, but it must still remain presentation-side, not service-side.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
3. DESIGN DECISION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Decision 1 — Price variation semantics belong to the service/domain side.

ProductService may expose semantic information such as:

    price_status = "increased"
    price_status = "decreased"
    price_status = "same"
    price_status = "unknown"

or equivalent non-UI domain values.

This is acceptable because price comparison is business meaning, not visual rendering.

Decision 2 — Presentation colors belong to the UI side.

Color is not domain meaning. Color is a chosen representation of meaning.

The UI may decide:

    increased -> red
    decreased -> green
    same -> neutral
    unknown -> muted

But ProductService should not decide that mapping.

Decision 3 — ProductService should not expose UI metadata.

ProductService should not expose fields whose purpose is directly visual, such as:

- `color`
- `background_color`
- `text_color`
- `brush`
- `qcolor`
- `display_role`
- `font_weight`

If ProductService returns dictionaries, those dictionaries should describe domain/application facts, not Qt presentation objects.

Decision 4 — QColor does not belong inside the service layer.

QColor belongs to PySide6/Qt presentation code.

ProductService should remain independent of Qt imports. A service layer that imports QColor would violate the intended architecture by making business logic depend on a GUI framework.

Decision 5 — StoragePage currently appears to violate the boundary if it expects ProductService to provide `color`.

If StoragePage currently reads something equivalent to:

    product_data["color"]

from service output, then StoragePage is depending on service output as if it were UI-ready presentation data.

That is an architectural boundary smell.

The correct expectation is:

    StoragePage receives semantic state.
    StoragePage or a UI-side mapper converts semantic state into presentation style.

Decision 6 — The Shiboken warning is secondary.

The Shiboken warning should not be treated as the primary design problem unless evidence shows Qt objects leaking into ProductService or domain structures.

The primary design problem is the unclear service-to-UI contract around `color`.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
4. RECOMMENDED ARCHITECTURAL REPAIR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Recommended repair direction:

    Replace UI metadata crossing the service boundary with semantic domain state crossing the service boundary.

The repaired architecture should be:

    ProductService
        returns domain/application semantics:
        - product data
        - storage status
        - price variation status
        - dates / quantities / calculated values

    StoragePage or UI mapper
        translates semantics into presentation:
        - QColor
        - text color
        - background color
        - icons
        - labels
        - table item decoration

Minimal architectural correction:

1. Do not add QColor to ProductService.
2. Do not make ProductService return `color` as a required field.
3. Do let ProductService return a stable semantic field for price variation if the UI needs one.
4. Do map that semantic field to QColor inside the UI layer.
5. Do make StoragePage stop assuming that service data contains presentation keys.

Acceptable service fields:

    price_variation
    price_trend
    price_status
    stock_status
    days_until_expected_end
    expected_next_purchase

Unacceptable service fields:

    color
    qcolor
    text_brush
    background_brush
    qt_display_role

Possible UI-side abstraction:

    StoragePresentationMapper

This mapper would be a presentation concern, not a domain/service concern. It may be introduced later if StoragePage becomes too large, but the key design rule is that it remains on the UI side of the boundary.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
5. LONG-TERM IMPLICATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Implication 1 — Service independence remains preserved.

Keeping QColor out of ProductService keeps the service usable from:

- PySide6 UI;
- tests;
- future CLI tools;
- future API layer;
- future alternate UI.

Implication 2 — UI styling remains flexible.

If colors belong to StoragePage or a UI mapper, the project can later change themes, accessibility contrast, dark mode, icons, or visual language without touching business logic.

Implication 3 — Domain semantics become testable.

A test can assert:

    price_status == "decreased"

without needing a QApplication, QColor, QBrush, or Shiboken-managed Qt object.

Implication 4 — Avoids presentation-driven service contracts.

If ProductService starts returning `color`, later pages may request `icon`, `font`, `tooltip`, `css`, or table-specific formatting from the service. That would gradually turn the service into a view-model factory instead of a business/application service.

Implication 5 — A UI mapper may become useful later.

As the UI grows, repeated mappings such as:

    domain status -> color
    domain status -> label
    domain status -> tooltip

may justify a dedicated presentation mapper. This should be considered a UI architecture refinement, not a service-layer expansion.

Implication 6 — The current bug should not trigger a service-layer workaround.

The tempting fix is to add `color` into the service response. Architecturally, that would solve the immediate KeyError by weakening the boundary.

Preferred repair:

    make the service contract semantic;
    make the UI responsible for presentation.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MAIN CHAT SYNTHESIS REQUEST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Main Chat should synthesize this design decision with Operational evidence before materialization.

Recommended synthesis direction:

1. Treat `KeyError: "color"` as a UI/service contract mismatch.
2. Preserve ProductService as business/application layer.
3. Keep price variation semantics in ProductService.
4. Keep presentation colors and QColor in the UI layer.
5. Do not patch the service by adding QColor or visual metadata.
6. Repair StoragePage so it maps semantic service output into presentation locally or through a UI-side mapper.
7. Treat Shiboken warning as secondary unless Operational evidence proves Qt objects are leaking across the service boundary.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STAGING RESULT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File updated:

- documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md

Commit scope:

- This file only.
