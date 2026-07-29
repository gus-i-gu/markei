# H_DDC_CODEX - C10-GCM03-ST04-R1-C3

> Role: Codex didactic validation report
> Unit: `C10-GCM03-ST04-R1-C3`

## Ownership

The GRM set is human/Main-owned for mutation. Codex's role in this unit was
limited to:

```text
read
extract
parse
hash
test
report
```

Codex did not edit, restore, format, normalize, stage or regenerate any GRM
file. The seven protected file identities were recorded before and after
validation and matched exactly.

## Parsing And Enumeration

The original C2 defect was not that JSON parsing failed. The defect was that
Windows PowerShell 5.1 could preserve the top-level JSON array as one aggregate
object when wrapped incorrectly. The repaired actual fence separates these
steps:

```text
parse Flutter JSON once
if parsed value is an array, foreach over members
filter each member object
```

That distinction matters because aggregate member-expanded properties can make
a mixed Windows/Edge/Android inventory look like one Android candidate. The
actual-fence mixed fixture now returns only the Android member.

## Cardinality And Identity

The repaired contract keeps three separate gates:

```text
Android device cardinality
selected ID scalar safety
exact ADB ready-serial membership
```

Zero Android targets, one Android target and two Android targets retain their
different meanings. A selected ID must be one non-empty scalar string without
whitespace/control characters, and it must match exactly one ready serial from
`adb devices`.

The captured boot, install, package-path, package-inspection and launch vectors
all put exactly one safe scalar value after `-s`. Neither `windows` nor `edge`
appeared in any captured vector.

## Actual Fence Versus Equivalent Fixture

C2 validated an equivalent selector fixture. C3 validates the actual extracted
repository fence. That is stronger evidence because the test body used the
Main-authored `Get-SupportedAndroidDevices` and `Assert-AdbTargetSerial`
definitions from `documentation/G_SCRIPTS.md` without editing that file or
running the live procedure.

## AUTHAND

`AUTHAND-06` remains held because this validation did not perform interactive
Android Sign in. Static Auth0 composition tests pass, but runtime provider
acceptance requires a later human-operated Sign in observation and, if
authorized, separately controlled provider correlation.

## Terminals

```text
GRM_AUTHORITY=HUMAN_MAIN_ONLY
CODEX_GRM_ROLE=READ_TEST_REPORT
JSON_PARSE_NOT_MEMBER_ENUMERATION=VALIDATED_ON_ACTUAL_FENCE
CARDINALITY_VERSUS_SCALAR_IDENTITY=VALIDATED
ACTUAL_FENCE_VALIDATION=PASS
AUTHAND_06_RUNTIME_HELD=YES
ST04=BLOCKED_PENDING_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```
