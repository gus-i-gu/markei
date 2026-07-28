# H_DDC_CODEX — GRM cascade and evidence correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Codex didactic evidence
> Unit: `C10-GCM03-ST04-R1-C1`
> Branch: `grm-guarded-provisioning-20260727`
> Baseline / inspected HEAD:
> `231a76281d0016ee47dd719d3ddc24d422b18c35`
> Authority: E within synchronized D/E/F plus explicit human GRM-set audit
> Evidence boundary: procedure meaning and static source/coordinate
> reconciliation; no Windows PowerShell or Android runtime acceptance

## Corrected meaning

The defect demonstrates four separate evidence layers:

```text
PowerShell text parses
  ≠ strict-mode variables exist at runtime

one GS fence defines a variable
  ≠ another independently extracted GS fence can consume it

Flutter accepts MARKEI_BUILD_PROVENANCE
  ≠ GRM-FLUTTER-AND can derive and pass the value

static procedure correction
  ≠ installed Android artifact acceptance
```

`I_SCRIPTS.ps1` selects one Markdown section, extracts one PowerShell fence,
creates one scriptblock, and executes only that body. A producer in
`GS-FLUTTER-WIN` is therefore invisible to `GS-FLUTTER-AND`.

## Corrected operator cascade

```text
GRM-FLUTTER-AND
→ I_SCRIPTS.ps1 exact GS-FLUTTER-AND extraction
→ resolved repository/client containment
→ active branch
→ one full inspected HEAD
→ short provenance derived from that same HEAD
→ coordinate loading
→ branch, ancestry and dirty-input guards
→ MARKEI_BUILD_PROVENANCE build argument
→ generated APK evidence
→ installed package evidence
→ later human visible-provenance comparison
```

The source-facing names were audited rather than renamed. They already match
the Flutter and Gradle consumers exactly, so inventing aliases would have
created a second vocabulary rather than fixing the defect.

The catalogue and coordinate branch labels were also reconciled so the
machine-readable value, human target guard, and catalogue context no longer
describe different branches.

## Evidence distinction

Passed here:

- one producer before consumers inside the Android fence;
- one-fence extraction;
- complete GRM-to-catalogue and coordinate-name alignment;
- Flutter/Gradle public-variable and package-name alignment.

Still required on the Windows operator host:

- Windows PowerShell 5.1 AST parse;
- strict-mode prefix execution;
- the full human `GRM-FLUTTER-AND` retest;
- visible provenance and consolidated Diagnostics comparison.

No permanent didactic memory was edited.

```text
PARSE_NOT_DATA_FLOW=VISIBLE
GS_FENCE_SCOPE=VISIBLE
PRODUCER_BEFORE_CONSUMER=PASS_STATIC
PRIOR_FLUTTER_PROVENANCE_MEANING=RETAINED
SOURCE_VARIABLE_VOCABULARY=ALIGNED
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05=HELD
```
