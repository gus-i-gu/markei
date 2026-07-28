# E_DDC_STAGE — GRM cascade and evidence correction

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Didactic materialization stage
> Unit: `C10-GCM03-ST04-R1-C1`
> Branch: `grm-guarded-provisioning-20260727`
> Required ancestry:
> `231a76281d0016ee47dd719d3ddc24d422b18c35`
> Authority: **ACTIVE WITHIN D**
> Evidence boundary: procedure meaning and static validation; no runtime
> acceptance

## 1. Corrected meaning

Preserve these distinctions:

```text
PowerShell fence parses
  ≠ every strict-mode variable is initialized

Flutter build with an explicit provenance value
  ≠ GRM-FLUTTER-AND can derive that value

source/test provenance projection passes
  ≠ Android procedure provenance is operational

correct generated APK
  ≠ installed Android runtime acceptance
```

The prior Flutter and widget evidence remains valid. Only the executable
Android GRM cascade is contradicted.

## 2. Operator contract

The corrected chain is:

```text
GRM-FLUTTER-AND
→ I_SCRIPTS.ps1 exact GS dispatch
→ GS-FLUTTER-AND producer initialization
→ branch and ancestry guards
→ MARKEI_BUILD_PROVENANCE build argument
→ generated APK evidence
→ installed package evidence
→ later human visible-fingerprint comparison
```

Every consumed procedure variable must have one visible producer in the same
PowerShell fence before first use. Variables in a different `GS-*` fence are
not shared, because the dispatcher extracts and executes only the selected
fence.

## 3. Validation meaning

Codex must report syntax and data-flow evidence separately:

- AST parse: the fence is syntactically valid;
- structural data flow: producers precede consumers inside the same fence;
- strict-mode prefix assay: the initialization prefix evaluates without an
  undefined-variable error;
- live human rerun: the full procedure builds, installs, launches and displays
  the matching provenance.

Only the first three belong to this correction. The fourth remains held.

## 4. H report

Replace `H_DDC_CODEX.md` and include:

- the cross-fence producer/consumer defect;
- why parse-only validation missed it;
- the corrected operator cascade;
- retained Flutter evidence;
- held human runtime acceptance.

Required terminals:

```text
PARSE_NOT_DATA_FLOW=VISIBLE
GS_FENCE_SCOPE=VISIBLE
PRODUCER_BEFORE_CONSUMER=PASS_OR_BLOCKED
PRIOR_FLUTTER_PROVENANCE_MEANING=RETAINED
ANDROID_RUNTIME_ACCEPTANCE=HELD_FOR_HUMAN_RETEST
GCM03_ST05=HELD
```

Do not edit permanent didactic memory.
