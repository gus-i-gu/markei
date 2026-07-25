# F_DSN_STAGE — Failed-Recovery Transition Boundary

Sequence: FLX-PRM-04 — Promotion/Reconciliation
Role: Codex Design materialization authority
Round or unit: C10-GCM02-GATE-12.6-COPIED-DATABASE-RECONCILIATION
Branch: `cycle10-intermid-grimoire`
Authority: Main Chat, under explicit human request
Writable surface: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`
Evidence boundary: sanitized copied-database observation plus repository
state-machine inspection

## 1. Architecture question

Update I to answer one bounded question:

> Given exactly one failed/notApplied submission containing two failed events,
> what state transitions can `HostedSyncCoordinator.run` perform before, during,
> and after its next upload, and what additional correlation is required to
> isolate the authorized action from six other pending events?

## 2. Required state-machine proof

Trace:

```text
HostedSyncCoordinator.run
  -> RecoverFailedNotApplied
  -> LocalSyncRepository.recoverFailedNotApplied
  -> candidate validation
  -> failed submission becomes superseded
  -> candidate events become or remain pending
  -> UploadPendingEvents
  -> subsequent download
  -> acknowledgement
```

For every transition, state:

- local or provider side;
- read or mutation;
- eligibility precondition;
- affected scope;
- persisted post-state;
- whether it can include the six unrelated pending events;
- whether failure stops later phases;
- evidence class.

## 3. Design conclusions

Preserve these invariants:

- unknown Retry and failed recovery are different state-machine branches;
- current evidence rejects the unknown branch;
- a UI button label does not define queue state;
- ordinary Sync is a compound coordinator operation, not a narrowly isolated
  failed-recovery command;
- a Gate 12.7 packet cannot authorize “Sync” generically;
- exact device/account scope and pending-event composition must be established
  before proposing any mutation;
- provider-success expectations must be expressed as allowlisted state deltas,
  not as an assumption that HTTP success equals end-to-end convergence.

If current architecture provides no independently invocable operator surface
for failed recovery without immediate upload, record that fact. Do not design
or implement a new surface in this round.

## 4. Required Gate 12.7 packet skeleton

I must provide a skeleton containing:

- immutable branch and source baseline;
- copied-database freshness statement;
- anonymized candidate rank and device scope;
- candidate event count and sequence range;
- pre-state for submission and member events;
- other pending-work counts by anonymized scope;
- exact coordinator phases proposed;
- exact expected local and provider deltas;
- allowed terminal results;
- mandatory stop results;
- evidence-capture order;
- no-second-action rule;
- explicit statement that the skeleton is not authorization.

Any field not proven must be marked `PENDING`, not guessed.

## 5. Prohibitions

No architecture, Flutter, API, schema, migration, test, provider, or database
mutation is authorized. Gate 12.7, Retry, ordinary Sync, and GCM-02 closure
remain held.
