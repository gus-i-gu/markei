# [M] Session 003 | 11:??_07_07_2026 | Markei

# E_DDC_STAGE — Main Didactic Materialization Stage

> Source stages:
> - `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
> - `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
> - `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
>
> Purpose: Codex-ready didactic notebook update brief for the StoragePage `KeyError: "color"` learning sample.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Didactic Synthesis

The active learning sample is no longer the old Repository ImportError.

The current learning sample is:

```text
KeyError: "color"
```

It occurs during StoragePage initialization when UI code expects a dictionary key that is not present in the service return value.

This teaches a different class of problem than the previous ImportError:

```text
Previous failure:
    module/symbol import-surface failure

Current failure:
    runtime data-shape / interface expectation failure
```

The didactic value is that a small dictionary lookup exposes a larger concept:

```text
software modules communicate through contracts, even when those contracts are implicit.
```

---

# 2. Didactic Promotions Approved

Codex may create or update permanent didactic material under:

```text
documentation/sketch_notebook/didactics/
```

Do not modify methodology files.

Do not modify application code as part of this didactic materialization.

Approved didactic promotions:

1. Python dictionaries and missing keys.
2. `KeyError` as a runtime exception.
3. Direct dictionary lookup vs safe/fallback lookup.
4. Stack trace interpretation as an execution map.
5. Data contracts and implicit contracts between modules.
6. Interface expectations between service and UI.
7. Business data vs presentation metadata.
8. PySide6/Shiboken warning as a secondary runtime signal, not automatically the same cause as the Python exception.

---

# 3. Recommended Permanent File Targets

If these files already exist, append/update conservatively.

If they do not exist, create focused versions:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

Do not invent a large didactic system.

Keep the material focused on the current runtime failure.

---

# 4. KANBAN Material to Add

Add a KANBAN-style learning entry titled:

```text
Runtime data contracts and KeyError in StoragePage
```

Recommended concept markers:

```text
&&& Mapping / associative array
&&& Data contract
&&& Interface expectation
&&& Boundary
&&& Separation of concerns
&&& Presentation data vs business data
&&& Defensive programming
&&% Python dictionary
&&% Dictionary key
&&% KeyError
&&% Direct dictionary lookup
&&% Safe dictionary access
&&% Stack trace
&%% StoragePage initialization
&%% Service-to-UI contract
&%% Price variation semantics
&%% Presentation metadata
%%% PySide6 / Qt / Shiboken
```

Core explanation:

```text
`KeyError: "color"` means Python tried to retrieve the key `"color"` from a dictionary-like object, but that key was absent at runtime.

In Markei, StoragePage expected presentation metadata that ProductService did not provide. This reveals an implicit service-to-UI contract mismatch.
```

Project connection:

```text
ProductService currently returns price variation data as semantic/business information: delta, percentage, and text.

StoragePage attempted to consume that result as if it also contained presentation metadata: color.

The error teaches the difference between domain/business data and UI presentation data.
```

---

# 5. Glossary Entries to Add

Add concise project-contextual glossary entries for:

```text
dictionary
key
value
missing key
KeyError
direct lookup
safe lookup
default value
exception
runtime
stack trace
mapping
data contract
implicit contract
interface expectation
boundary
presentation data
business data
presentation metadata
price variation
defensive programming
fail fast
fallback
Shiboken
type conversion
```

Suggested definitions should be short and grounded in Markei.

Example style:

```text
KeyError
    Python exception raised when code requests a missing key from a dictionary-like object. In the StoragePage failure, the missing key was `"color"`.
```

```text
Presentation metadata
    Display-only data used by the UI, such as color, icon, badge, or row emphasis. In Markei, presentation metadata should not be confused with product/business facts.
```

---

# 6. Concept Map Update

Add relationships similar to:

```text
Python dictionary
    -> key
    -> value
    -> direct lookup
    -> safe lookup
    -> KeyError

KeyError
    -> runtime exception
    -> stack trace
    -> missing key

StoragePage initialization
    -> service-to-UI contract
    -> product display data
    -> presentation metadata

ProductService
    -> business data
    -> price variation semantics

StoragePage
    -> presentation data
    -> maps semantic data to visual style

PySide6 / Shiboken
    -> Python-to-C++ type conversion
    -> warning may be separate from Python exception
```

---

# 7. Didactic Boundary Rules

Codex must not use didactic materialization to prescribe application implementation.

The didactic notebook may explain:

```text
Direct lookup fails if a key is absent.
Safe lookup can provide a fallback.
Business data and presentation data should be distinguished.
```

The didactic notebook must not claim:

```text
The final patch must be exactly X.
ProductService must forever return only these fields.
StoragePage must forever implement colors directly.
```

Implementation decisions belong to D/F synthesis and Codex materialization, not permanent didactic explanation.

---

# 8. Expected Codex Report

Codex must report:

1. didactic files created/updated;
2. KANBAN concepts added;
3. glossary entries added;
4. concept-map relationships added;
5. whether material stayed focused on the current `KeyError: "color"` sample;
6. unresolved didactic risks or duplicated concepts found.
