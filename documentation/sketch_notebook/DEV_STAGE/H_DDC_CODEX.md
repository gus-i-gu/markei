# H_DDC_CODEX - C10-GCM03-ST04-R1-C2

> Role: Codex didactic report
> Unit: `C10-GCM03-ST04-R1-C2`
> Evidence boundary: explanation of validated local/static evidence only

## Device Selection Meaning

`ConvertFrom-Json` parsing is not the same thing as member enumeration. On the
observed Windows PowerShell 5.1 host, wrapping the top-level JSON array with
`@(...)` produced one `System.Object[]` element. `Where-Object` then evaluated
aggregate member-expanded properties, so one Android value inside the aggregate
made the whole aggregate look selectable.

That is why this shape appeared:

```text
selectedIds=windows,edge,emulator-5554
adbArgs=-s|windows|edge|emulator-5554|shell|getprop|sys.boot_completed
```

The correct learning boundary is:

```text
parse JSON once
enumerate member objects
filter Android members
preserve cardinality
require one scalar ID
prove exact ADB serial membership
then invoke ADB
```

Cardinality and scalar identity are separate checks. One selected object is not
sufficient if its `id` property expands to several strings. One scalar ID is not
sufficient unless it is exactly present in the current `adb devices` inventory.

## Sign-In Evidence Ladder

The `adb.exe: unknown command windows` terminal is launcher/device-selection
evidence. It happened before clean, dependency resolution, analysis, tests,
APK build, APK install, application launch and interactive Sign in. Therefore
it cannot prove an Auth0 regression and could not replace the installed app.

The Android sign-in evidence ladder remains:

```text
repository static contract
build inputs and Dart defines
Gradle manifest placeholders
merged callback manifest
generated APK provenance
installed package identity
visible app provenance
human-operated Sign in terminal
provider/dashboard correlation when separately authorized
```

This run validated the static side through history inspection, source scan,
focused tests, full Flutter tests, analyzer, debug APK build and generated
manifest inspection. It did not execute live authentication.

## Auth Classification

No static/test-backed Auth0 defect was proved. The proper classification is:

```text
AUTHAND-06=INSUFFICIENT_RUNTIME_SYMPTOM_EVIDENCE
```

This does not mean sign-in works. It means the available evidence does not yet
identify a source/configuration defect. Runtime acceptance remains held for a
later human-operated run.

## Terminals

```text
JSON_PARSE_NOT_MEMBER_ENUMERATION=VISIBLE
CARDINALITY_AND_SCALAR_IDENTITY=VISIBLE
ADB_TERMINAL_IS_AUTH_EVIDENCE=NO
AUTH_STATIC_CONTRACT=VALIDATED
AUTH_RUNTIME_ACCEPTANCE=HELD
ST04=BLOCKED_PENDING_MAIN_RESTAGING
GCM03_ST05_AND_LATER=HELD
```
