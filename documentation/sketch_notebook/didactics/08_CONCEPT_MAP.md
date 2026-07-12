# 08_CONCEPT_MAP.md

> Domain: Didactic
> Status: Cycle 06 Sprint 02 checkpoint
> Authority: Didactic Chat [A]
> Canon source: `02_KANBAN.md`
> Derivative source: `07_GLOSSARY.md`
> Evidence sources: `DEV_STAGE/E_DDC_STAGE.md`, `DEV_STAGE/H_DDC_CODEX.md`, `DEV_STAGE/G_OPS_CODEX.md`, and `[M]_STAGE/J_[M]_STAGE.md`
> Current milestone: Fully executable and installable Windows primary beta

---

## Current Learning State

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut launch
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
```

Sprint 02 crossed the compiled-installer and automated installed-lifecycle boundary. Final learning and release claims remain bounded because human-visible UI acceptance and human-visible SmartScreen behavior are not yet evidenced.

## Maturity

### Green
None. Software success is not learner mastery.

### Yellow
`&&&01`, `&&&02`, `&&&03`, `&&%01`, `&&%02`, `&%%01`, `&%%02`, `&%%03`, `&%%04`, `%%%01`, `%%%03`, `%%%04`, `%%%05`.

### Red
`&&&04`, `&&&05`, `&&%03`, `&&%04`, `&%%05`, `&%%06`, `%%%02`, `%%%06`.

No maturity changed in Sprint 02 because no explicit learner-validation evidence was recorded.

## Dependency Spine

```text
&&&01 Responsibility Boundary
→ &&&03 Naming as Data Contract
→ &&&05 Evidence State and Validation Boundary
→ &&%04 Source, Frozen, and Installed Execution Context
→ &%%06 Packaging and Installation Artifact Lifecycle
→ %%%06 Build-Time, Runtime, and Installer-Time Dependency
```

Supporting spine:

```text
&&&04 Resource Ownership and Lifetime
→ &&%03 Deterministic Cleanup
→ %%%02 SQLite Connection Ownership
→ installed close/reopen evidence
```

Persistence spine:

```text
%%%01 initialization / migration / seeding
→ structural defaults
→ %%%05 bundled resources / writable user data
→ uninstall retention
→ reinstall recovery
```

## Project Learning Spine

```text
source
→ packaging configuration
→ frozen distribution
→ frozen launch
→ installer configuration
→ compiled installer
→ per-user installed files
→ Start Menu launch
→ installed technical workflows
→ close/reopen
→ same-version reinstall
→ uninstall with retained user data
→ reinstall recovery
→ human-visible acceptance — pending
```

## Critical Distinctions

```text
installer source ≠ compiled installer
compiled installer ≠ installed application
installed launch ≠ workflow validation
automated workflow evidence ≠ human UI walkthrough
external data location ≠ observed preservation
same-version reinstall ≠ future-version upgrade compatibility
Defender enabled / NotSigned ≠ observed SmartScreen behavior
technical validation ≠ learner mastery
technical validation ≠ Main/human acceptance
structural defaults ≠ sample seed data
```

## Current Project Examples

- Inno Setup 6.7.3 was installed per-user and discovered as an installer-time dependency.
- `Markei-Setup-0.1.0-x64.exe` is the compiled installer artifact.
- Installed program files live under `%LOCALAPPDATA%\Programs\Markei`.
- User data lives under `%LOCALAPPDATA%\Markei`.
- Category `F` / `General` and store `1` / `Default Store` are structural defaults.
- Products and purchases remain absent on fresh production initialization until the user creates them.
- Installed close/reopen, same-version reinstall, uninstall retention, and reinstall recovery passed in the reported current-user environment.
- Human-visible UI and SmartScreen observations remain pending or unknown.

## Immediate Learner Checks

1. Explain what each evidence state proves and does not prove.
2. Distinguish source, frozen, and installed launch paths.
3. Explain why `ISCC.exe` is installer-time rather than runtime.
4. Distinguish structural defaults from seed/demo data.
5. Identify replaceable installed files and retained user state.
6. Explain the evidence required to claim uninstall preservation.
7. Explain why automated service-backed workflows do not equal a full UI walkthrough.
8. Classify SmartScreen/reputation observations separately from application correctness.
9. Explain why successful software validation does not automatically change concept maturity.
10. Identify who owns final beta acceptance.

## Remaining Learning Boundary

The next Didactic update should depend on explicit learner responses or human-observed lifecycle evidence. Red-to-Yellow movement may be considered only under the Didactic maturity protocol; no automatic promotion follows from installation success.
