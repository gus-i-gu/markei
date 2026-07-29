# D_OPS_STAGE — Main-owned Android launcher repair validation

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Operational validation stage
> Unit: `C10-GCM03-ST04-R1-C3`
> Branch: `grm-guarded-provisioning-20260727`
> Required published ancestry:
> `084e637e6771b8713b2504b155a82cd4d3bd792a`
> Authority: **ACTIVE — READ, TEST AND REPORT ONLY**
> Evidence boundary: repository inspection, Windows PowerShell 5.1 fixtures,
> Flutter/static validation and sanitized build evidence; no GRM mutation,
> live Android action, authentication, enrollment, Query, Sync, provider
> mutation, deployment, commit or push

## 1. Reconciled starting state

The C2 reports are accepted at their stated evidence boundary:

```text
DEVSEL-01=POWERSHELL_5_1_TOP_LEVEL_JSON_ARRAY_NESTING
AUTHAND-06=INSUFFICIENT_RUNTIME_SYMPTOM_EVIDENCE
POWER_SHELL_5_1_REPRODUCTION=PASS
EQUIVALENT_SELECTOR_ADB_FIXTURE=PASS
AUTH_STATIC_CONTRACT=VALIDATED
AUTH_SOURCE_CHANGE=NONE
ST04=BLOCKED_PENDING_MAIN_RESTAGING
```

C2 could not repair the owning procedure because later human direction made
the GRM set non-writable. Main Chat has now materialized the narrow
`GS-FLUTTER-AND` repair in `documentation/G_SCRIPTS.md` under explicit human
direction.

The repair is an input to this Codex unit. It is not a Codex edit target.

The preserved Windows `purchase.registered` event remains at Device sequence
2, next sequence 3, queue `1/0/0/0`.

## 2. GRM protection contract

The complete protected GRM set is:

```text
documentation/GRM.md
documentation/G_SCRIPTS.md
documentation/I_SCRIPTS.ps1
documentation/NS_COORDINATES.md
documentation/DB_MGMT.sql
documentation/ERR_DIAGNOSTICS.md
documentation/REC_DIAGNOSTICS.md
```

For Codex, these files have the same mutation boundary as protected Sketch
Notebook methodology files.

Codex may read, extract, compare, hash and test them. Codex must not edit,
restore, format, normalize line endings, regenerate, replace, delete, rename,
stage or otherwise mutate them.

Neither D/E/F nor a Codex inference may override this protection. A GRM change
requires explicit human direction to Main Chat and Main-owned materialization.
If validation identifies another required GRM correction, preserve the file,
describe the exact proposed correction in G/H/I and stop for Main.

Record the Git blob or SHA-256 identity of all seven protected files before and
after validation. Any identity change during the Codex run is a stop condition.
Do not use `git restore`, checkout or another overwrite operation on them.

## 3. Main-authored correction under validation

Verify the actual extracted `GS-FLUTTER-AND` fence, not only an inline
equivalent.

The Main-authored correction should:

1. parse `flutter devices --machine` JSON exactly once;
2. explicitly enumerate a PowerShell 5.1 top-level array into member objects;
3. accept only individual objects whose:

   ```text
   targetPlatform is one scalar string beginning with android
   isSupported is one Boolean true
   id is one non-empty scalar string without whitespace/control characters
   ```

4. preserve zero/one/multiple Android-target cardinality;
5. bind the chosen Flutter ID to exactly one ready serial from the current
   `adb devices` inventory;
6. stop on missing, unsafe, stale or ambiguous identity;
7. pass each ADB call through one explicit argument array;
8. preserve `DEV-GRM` as the stable AVD definition while discovering the
   transient serial;
9. preserve application data and package `com.gusigu.markei`;
10. prevent `windows`, `edge`, web identifiers or an ID collection from
    crossing the ADB boundary.

## 4. Required non-mutating validation

Run on Windows PowerShell 5.1 when available:

```text
exact GS-FLUTTER-AND heading/fence extraction
PowerShell 5.1 AST parse
actual-fence function extraction
mixed Windows + Edge + one Android fixture
one Android physical-target fixture
zero Android target fixture
two Android target fixture
malformed JSON fixture
supported=false fixture
missing, empty and non-scalar ID fixtures
unsafe whitespace/control ID fixtures
exact, missing and ambiguous ADB serial fixtures
captured ADB argument vectors for boot/install/inspect/launch
```

The mixed fixture must yield only the Android object. Every captured `-s`
position must have exactly one safe scalar value. Neither `windows` nor `edge`
may appear in any captured ADB vector.

Also run and report:

```text
focused native-auth composition test
focused Closure surface and diagnostics tests
flutter test
flutter analyze
Android debug APK build with reviewed placeholder values
merged manifest inspection with host/value redaction
git diff --check
changed-content sensitive-pattern scan
protected-file before/after identity comparison
```

Do not perform a live Android install, launch or interactive Sign in merely to
satisfy validation.

## 5. Writable and prohibited scope

Only these files are writable:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Do not modify application source, tests, D/E/F, J, A/B/C, permanent memory,
methodology or any GRM file. If any further source change is required, stop
for Main restaging.

Do not authenticate, log out, enroll, Query, Sync, Retry, recover, clear
Android storage, uninstall, reset the AVD, alter local data, consume the
Windows event, mutate Auth0/Render/Neon, commit, push, deploy or open a PR.

## 6. G report

Replace `G_OPS_CODEX.md` and report:

- protected-file identities before and after;
- actual-fence DEVSEL fixtures and captured ADB vectors;
- whether the Main-authored repair satisfies every requirement;
- retained `AUTHAND-06` classification and explicit absence of auth changes;
- exact validation commands, results and unavailable evidence;
- exact worktree inventory and absence of live/provider actions.

Required terminals:

```text
GRM_PROTECTED_SET_MUTATION=ABSENT_OR_STOP
DEVSEL_CLASSIFICATION=DEVSEL-01
ACTUAL_GS_FLUTTER_AND_FIXTURES=PASS_OR_BLOCKED
ANDROID_DEVICE_ENUMERATION=CORRECTED_OR_BLOCKED
NON_ANDROID_ID_REACHES_ADB=NO_OR_BLOCKED
ADB_SERIAL_CARDINALITY=EXACTLY_ONE_OR_BLOCKED
ANDROID_SIGN_IN_CLASSIFICATION=AUTHAND-06
AUTH_SOURCE_CHANGE=NONE
ANDROID_LIVE_SIGN_IN=NOT_EXECUTED
ST04=BLOCKED_PENDING_HUMAN_RETEST
GCM03_ST05_AND_LATER=HELD
```
