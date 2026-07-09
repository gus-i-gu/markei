# Functional Stage — Didactic

## 1. Scope
This stage captures the didactic requirements for the Register-page Product View feature, focusing on the coding principles exposed by separating purchase rhythm from shelf-life rhythm. It is staged reasoning for Main Chat synthesis only, not canonical didactic memory.

## 2. Accepted Facts
- Current feature: lower Product View appears after double-clicking a product from an inventory table on the Register page.
- `average_duration_days` means purchase-to-purchase rhythm.
- `average_shelf_life_days` means purchase-to-expiration rhythm.
- `expected_next_purchase` is predicted from purchase rhythm.
- `expected_expiration_date` is predicted or known from shelf-life rhythm.
- Purchase rhythm and shelf-life rhythm must not be merged.
- Didactic focus is coding-principle learning, not business-domain expiration alone.

## 3. Requirements for Main Synthesis
- Preserve the distinction between fields with similar technical types but different domain meanings.
- Teach raw data versus calculated data before teaching Product View display behavior.
- Treat naming as a data contract across model, repository, service, and UI layers.
- Classify derived/cached summary fields as a separate concept from raw purchase/expiration records.
- Keep service-layer calculation responsibility distinct from UI display responsibility.
- Present repository query result shape as a learning topic because it affects downstream meaning.
- Treat dataclass evolution and schema evolution as conceptual consequences of domain-language refinement.

## 4. Risks / Open Questions
- Risk: learner collapses purchase-to-purchase duration and purchase-to-expiration shelf life because both are day intervals.
- Risk: UI labels appear to own domain meaning instead of merely displaying prepared data.
- Risk: derived summary fields are confused with raw historical records.
- Risk: repository result names become vague and force service/UI layers to infer meaning.
- Open question: whether schema migration is needed belongs to Operational/Design synthesis, not Didactic Chat.
- Open question: exact PySide6 widget structure belongs to Design/Operational synthesis, not Didactic Chat.

## 5. Recommended Materialization Targets
- `documentation/sketch_notebook/didactics/02_KANBAN.md`
- `documentation/sketch_notebook/didactics/07_GLOSSARY.md`
- `documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md`
- `documentation/sketch_notebook/didactics/13_LECTURE_REGISTER.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`

## 6. Handoff Summary
- Primary concept: domain model field semantics.
- Core contrast: same technical type, different domain meaning.
- Required distinction: purchase rhythm versus shelf-life rhythm.
- Suggested first lecture: `average_duration_days` and `average_shelf_life_days` as separate semantic fields.
- Suggested second lecture: raw purchase/expiration facts versus calculated predictions.
- Suggested third lecture: naming as a data contract.
- Suggested fourth lecture: service responsibility for calculations.
- Suggested fifth lecture: UI display contract for Product View.
- Suggested KANBAN markers: `&&&`, `&&%`, `&%%`, `%%%`.
- Do not promote to canonical didactic files until Main Chat approves materialization.
