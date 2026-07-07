# [A] Session 002 | 10:44_07_07_2026 | Markei

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Didactic Chat.

Responsibility: learning, glossary candidates, concept mapping, and KANBAN suggestions.

This stage captures the didactic interpretation of the active runtime failure:

```text
KeyError: "color"
```

Context:

```text
StoragePage initialization fails because some code expects a dictionary entry named "color" and that entry is not present.
```

This is staged material only. Main Chat must synthesize before any permanent didactic, glossary, KANBAN, design, or application update.

No application code is modified by this report.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOTSTRAP NOTES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Methodology boot completed from:

1. `AGENTS.md`
2. `documentation/sketch_notebook/INDEX.md`
3. `documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md`
4. `documentation/sketch_notebook/methodology/PROMOTION_RULES.md`
5. `documentation/sketch_notebook/methodology/CHAT_BEHAVIOUR.md`
6. `documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md`
7. `documentation/sketch_notebook/methodology/FLUX.md`

Routing constraint observed:

- Didactic Chat writes only to `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`.
- Didactic Chat does not modify application source files.
- Didactic Chat does not modify permanent notebook files.
- Didactic Chat does not modify methodology files.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. DIDACTIC OBSERVATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## 1.1 The failure is conceptually about an expectation mismatch

`KeyError: "color"` means Python attempted to access the key `"color"` in a mapping object, usually a dictionary, but that key was not present at runtime.

In Markei terms, some part of `StoragePage` initialization is receiving or building structured data for display and expects each item to include a `color` field.

The educational value is that the error exposes a contract mismatch:

```text
consumer expectation: item["color"] exists
actual runtime data: item does not contain "color"
```

This is not necessarily a database failure by itself.

It is a failure at the boundary where one part of the program expects a data shape that another part did not provide.

## 1.2 A Python dictionary is a key-value structure, not a guaranteed schema

A dictionary can hold arbitrary key-value pairs:

```python
item = {
    "product_name": "Rice",
    "price": 10.50,
}
```

Accessing a present key works:

```python
item["price"]
```

Accessing a missing key fails:

```python
item["color"]
```

The program fails because normal dictionary indexing is strict: it assumes the key must exist.

That strictness is useful when missing data should be treated as a real bug.

It is risky when the data shape is uncertain, optional, or produced by another layer that does not promise the requested key.

## 1.3 `KeyError` is Python's signal for missing mapping keys

`KeyError` belongs to the family of runtime exceptions.

It means:

```text
The program was syntactically valid.
The module imports may have succeeded.
Execution reached a dictionary-like lookup.
The requested key was absent.
```

For Markei, that narrows the learning diagnosis:

```text
The current failure is not primarily about Python being unable to find a file or import a name.
It is about a runtime data structure not matching the consumer's expectation.
```

This makes it different from the previous `ImportError` session.

The previous error happened before the application could assemble the expected object graph.

This error happens after enough execution has occurred for `StoragePage` initialization to request structured data.

## 1.4 UI initialization turns data contracts into visible failures

A page constructor usually performs a sequence like:

```text
create widgets
request data
format rows/cards
apply display styling
attach widgets to layout
show page
```

If one row/card construction expects `"color"`, the page cannot finish initialization when the key is missing.

The page failure teaches that UI code is often the first visible place where upstream data-shape assumptions break.

The visible crash may happen in the UI, but the cause can be a mismatch between:

```text
what the UI expects
what the service returns
what the repository retrieves
what the domain model represents
```

## 1.5 Presentation data is different from business data

In Markei, business data describes the supermarket/product domain:

```text
product name
brand
quantity
price
purchase date
expected next purchase
average duration days
reorder threshold
stock/shortage/market status
```

Presentation data describes how the UI displays that business data:

```text
text color
background color
badge color
icon
row emphasis
visual warning style
```

The key name `"color"` strongly suggests presentation data.

The didactic point is not to decide the architecture.

The didactic point is to recognize that the failure sits at the border between domain meaning and visual representation.

## 1.6 Business semantics and visual semantics are separate concepts

A product may have a business status such as:

```text
stored
near threshold
expected ended
```

A UI may represent those statuses with colors.

Those are related, but they are not the same concept.

Example:

```text
business fact: product is near reorder threshold
presentation choice: show row in yellow
```

The business layer should speak in domain language.

The UI layer should speak in display language.

When a UI expects `"color"`, it may be asking for display language.

When a service returns `"status"`, it may be returning domain language.

The `KeyError` can therefore teach the difference between semantic status and visual rendering.

## 1.7 Software contracts can be implicit even without formal interfaces

A contract is an agreement about what one part of the program provides and what another part may rely on.

In Python, many contracts are implicit.

For example, if `StoragePage` uses:

```python
row["color"]
```

then `StoragePage` implicitly requires every row to have a `"color"` key.

If the data provider returns:

```python
{
    "product_name": "Rice",
    "price_variation": "increase",
}
```

then the provider is not fulfilling that implicit UI contract.

The error is Python enforcing the fact that the implicit contract was not met.

## 1.8 Interface expectations are local, but failures are systemic

The exact line that raises `KeyError` may be small.

Conceptually, the failure involves several possible expectations:

```text
StoragePage expects visual metadata.
ProductService may expose product/business data.
Repository may expose raw persistence data.
The UI may translate product state into visual style.
```

The learning point is that a single exception can reveal a larger interface mismatch.

A traceback tells where the program stopped.

It does not automatically tell which layer owns the missing concept.

## 1.9 Defensive programming is about choosing how strict a boundary should be

There are several conceptual strategies for missing keys:

```python
item["color"]
```

Strict access.

Use when missing `"color"` means the program is invalid and should fail loudly.

```python
item.get("color")
```

Optional access.

Use when `"color"` may be absent and the program can continue.

```python
item.get("color", default_color)
```

Fallback access.

Use when a safe default exists.

Didactically, the question is not "which patch should we apply?"

The lesson is that defensive programming is not only syntax.

It is a design choice about whether missing data should:

```text
crash early
fall back safely
be normalized before reaching the UI
be rejected at a boundary
```

## 1.10 Stack traces are execution maps

A stack trace should be read from the most general call path toward the exact failing line.

For this failure, the important questions are:

```text
Which constructor or method starts StoragePage initialization?
Which service method returns the data used by StoragePage?
Which data item lacks "color"?
Which line attempts row["color"] or equivalent?
```

The stack trace identifies the execution chain.

The exception type identifies the kind of failure.

The exception message identifies the missing key.

Together:

```text
KeyError + "color" + StoragePage initialization
```

means:

```text
during UI setup, a mapping lookup expected display metadata that was absent
```

## 1.11 Runtime debugging observes actual data, not intended data

A design may intend that every item has a color.

A service may intend to return display-ready rows.

A UI may intend to receive a complete dictionary.

Runtime debugging asks what actually happened.

For this error, the learning inspection target is the concrete object received by the failing UI line.

The central debugging question is:

```text
What keys are actually present in the dictionary at the moment StoragePage asks for "color"?
```

That question belongs to runtime debugging, not abstract design.

## 1.12 The Shiboken warning should be learned separately unless evidence connects it

The terminal also reports:

```text
Shiboken::Conversions::_pythonToCppCopy:
Cannot copy-convert (...) list to C++.
```

Didactically, this illustrates that one terminal session can contain multiple signals.

A Python exception with a traceback is usually the primary stop point when it crashes the program.

A Qt/Shiboken conversion warning may indicate a separate UI binding issue, especially when Python values are being passed into Qt/PySide C++ APIs.

The learning rule is:

```text
Do not merge two symptoms into one cause without evidence from the execution path.
```

For this didactic report, `KeyError: "color"` remains the active learning sample.

The Shiboken warning is a secondary concept candidate about Python-to-Qt type conversion.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
2. PROMOTED CONCEPTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## &&& Foundational Computer Science concepts

### &&& Mapping / associative array

A mapping stores values by keys rather than by numeric position.

In Markei, a row displayed by `StoragePage` may be represented as a mapping:

```text
"product_name" → "Rice"
"price" → 10.50
"status" → "stored"
```

The `KeyError: "color"` appears when the UI asks the mapping for a key that is not present.

### &&& Data contract

A data contract defines the shape and meaning of data crossing a boundary.

In this case:

```text
StoragePage expects: product row includes "color"
provider supplies: product row without "color"
```

The crash teaches that modules communicate through expectations, even when those expectations are not written in a formal interface.

### &&& Separation of concerns

Separation of concerns means each part of the program should own a distinct responsibility.

In Markei:

```text
business data explains supermarket/product facts
presentation data explains how the UI displays those facts
```

The key `"color"` is a useful teaching example because it likely belongs to presentation concerns, while price variation or storage status belongs to business/domain concerns.

### &&& Boundary

A boundary is the line where one part of the system communicates with another.

The current error occurs at a boundary between data production and UI consumption.

The didactic question is:

```text
What does StoragePage have the right to assume about the objects it receives?
```

### &&& Interface expectation

An interface expectation is what a caller assumes it can do with an object.

If the UI writes `item["color"]`, it expects the object to behave like a dictionary containing a `"color"` key.

The exception proves that expectation was not satisfied at runtime.

## &&% Python language concepts

### &&% Dictionary

A dictionary is Python's common mapping type.

It stores key-value pairs and supports direct key lookup.

In this session, `"color"` is the missing dictionary key.

### &&% Key

A key is the identifier used to retrieve a value from a dictionary.

The key in this failure is:

```python
"color"
```

### &&% KeyError

`KeyError` is raised when code requests a missing key from a dictionary-like object.

Conceptual reading:

```text
Python understood the code.
The object existed.
The requested key did not.
```

### &&% Direct dictionary access

Direct access uses square brackets:

```python
item["color"]
```

It is strict.

It raises `KeyError` when the key is absent.

### &&% Safe dictionary access

Safe access commonly uses `.get()`:

```python
item.get("color")
```

or:

```python
item.get("color", default_value)
```

This avoids `KeyError`, but it also changes the meaning of missing data.

The missing key becomes tolerated rather than rejected.

### &&% Exception

An exception is Python's way of interrupting normal execution when something invalid occurs.

Here, execution is interrupted because the program asks for data that the object does not contain.

### &&% Runtime

Runtime is when the program is actually executing.

The `KeyError` was not detected merely by reading the file.

It appeared when `StoragePage` initialized and reached the missing-key lookup.

### &&% Stack trace

A stack trace is the printed call chain that shows how execution reached the exception.

For this session, it should be read as the path from application startup to `StoragePage` construction to the exact missing `"color"` lookup.

## &%% Markei project concepts

### &%% StoragePage initialization

`StoragePage` is the UI page whose setup currently exposes the failure.

The teaching point is that page construction can depend on both business data and presentation formatting.

### &%% Product row data

A product row/card shown in Storage likely contains product information prepared for display.

The row may include domain fields, derived status fields, and possibly visual metadata.

The error shows that at least one expected display-related field is absent.

### &%% Presentation metadata

Presentation metadata is data used only to render the UI.

Examples:

```text
color
badge color
row highlight
icon name
font emphasis
```

`"color"` is a candidate presentation-metadata field.

### &%% Business data

Business data is data that belongs to the Markei domain itself.

Examples:

```text
product name
purchase price
price variation
expected next purchase
reorder threshold
storage status
```

The current failure teaches that business data and presentation metadata should not be confused conceptually.

### &%% Service-to-UI contract

If `StoragePage` receives data from `ProductService`, then the service-to-UI contract defines what fields the UI may expect.

The `KeyError` suggests the service-to-UI contract is either undocumented, unstable, or not being fulfilled.

### &%% Price variation semantics

Price variation semantics describe the meaning of price movement:

```text
increased
decreased
unchanged
unknown
```

This is project/domain meaning.

A color that represents price movement is a UI representation of that meaning, not the meaning itself.

### %%% PySide6 / Qt / Shiboken

PySide6 connects Python code to Qt, which is implemented in C++.

Shiboken is part of that binding layer.

A Shiboken conversion warning can teach that not every Python object can automatically be converted into every Qt/C++ type.

This is separate from `KeyError` unless the traceback or execution chain proves they are linked.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
3. GLOSSARY ADDITIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Candidate glossary entries for permanent didactic material:

- `dictionary`: A Python mapping object that stores values under keys.
- `key`: The lookup identifier used to retrieve a value from a dictionary.
- `value`: The data stored under a key in a dictionary.
- `missing key`: A key requested by code but absent from the dictionary.
- `KeyError`: Python exception raised when a missing key is accessed through strict dictionary lookup.
- `direct lookup`: Dictionary access with square brackets, such as `item["color"]`.
- `safe lookup`: Dictionary access through methods such as `.get()` that can tolerate absence.
- `default value`: A fallback value used when expected data is missing.
- `exception`: A runtime signal that interrupts normal execution when an invalid situation occurs.
- `runtime`: The phase when the program is actually executing.
- `stack trace`: The printed execution chain that shows where an exception occurred.
- `mapping`: A structure that associates keys with values.
- `data contract`: An agreement about what shape and fields data must have across a boundary.
- `implicit contract`: A contract enforced by code expectations rather than by a formal declaration.
- `interface expectation`: What one module assumes another module or object provides.
- `boundary`: The conceptual line between two layers or modules.
- `presentation data`: Data used to render or style the UI.
- `business data`: Data that represents project/domain facts and rules.
- `presentation metadata`: Display-only information attached to data for UI use.
- `price variation`: Domain meaning describing how a price changed across purchases.
- `defensive programming`: Programming choices that handle missing, invalid, or unexpected data deliberately.
- `fail fast`: Design choice where invalid data causes an immediate error rather than silent fallback.
- `fallback`: A safe substitute used when expected data is absent.
- `Shiboken`: The binding technology used by PySide to connect Python objects with Qt/C++ APIs.
- `type conversion`: Transforming a value from one expected representation/type to another.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
4. SUGGESTED KANBAN ADDITIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Potential `&&&` Computer Science Fundamentals

- Mapping / associative array
- Data contract
- Interface expectation
- Boundary between producer and consumer
- Separation of concerns
- Presentation data vs business data
- Defensive programming
- Fail-fast behavior vs fallback behavior
- Runtime debugging
- Interpreting stack traces

## Potential `&&%` Python Language

- Python dictionary
- Dictionary key
- Dictionary value
- Missing key
- `KeyError`
- Strict dictionary lookup with `[]`
- Optional dictionary lookup with `.get()`
- Default values
- Runtime exception
- Reading exception messages

## Potential `&%%` Markei Project Concepts

- `StoragePage` initialization
- UI data row/card structure
- Product display data
- Service-to-UI data contract
- Business status vs UI color
- Price variation semantics vs presentation color
- Presentation metadata
- Layer boundary between service and UI
- Runtime data-shape inspection

## Potential `%%%` External Libraries / Frameworks / Dependencies

- PySide6 UI initialization
- Qt object/value expectations
- Shiboken Python-to-C++ conversion
- Qt warning vs Python exception distinction

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DIDACTIC CONCLUSION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

The current failure is a compact learning sample for how real programs depend on data shape agreements.

`KeyError: "color"` teaches that a dictionary lookup is not only a Python operation.

In Markei, it also reveals an expectation about what kind of object `StoragePage` receives during initialization.

The central learning distinction is:

```text
business meaning: product state, price variation, storage condition
presentation meaning: color, highlight, visual label
```

The error should be used to teach dictionaries, `KeyError`, runtime exceptions, stack traces, implicit contracts, interface expectations, and the separation between business data and presentation metadata.

It should not be used by Didactic Chat to redesign the application or prescribe a patch.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MAIN CHAT SYNTHESIS REQUEST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Main Chat should decide whether to promote the following into permanent didactic material:

1. A KANBAN entry for Python dictionaries and `KeyError`.
2. A KANBAN entry for software/data contracts between modules.
3. A glossary cluster for dictionary, key, value, missing key, `KeyError`, and stack trace.
4. A didactic note distinguishing business data from presentation data in Markei.
5. A didactic note on reading runtime exceptions as evidence of interface expectation mismatches.
6. A small concept entry for PySide6/Shiboken warnings as secondary runtime signals, only after Operational or Main confirms the warning's role in the current failure.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
UNCERTAINTIES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

- This report explains the active error from the didactic perspective only.
- This report does not inspect, redesign, or modify application code.
- This report does not decide which layer should own colors or price-variation presentation.
- That ownership decision belongs to Design/Main synthesis.
- This report does not treat the Shiboken warning as the primary failure without operational evidence.
