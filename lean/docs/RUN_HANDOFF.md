# AR18RaceManMachine run handoff (21 September 2026)

## Source and scope

- Source: NBER Working Paper 22252, revised June 2017, 87 PDF pages.
- Local private source: `source/w22252-june2017.pdf`, SHA-256 `441d01202afd56ef8002fc24ffc2beb51191741c0b5accb11d2534620dd616b7`. The source folder is ignored by the paper's `.gitignore`.
- The source-only intake identified 19 independently labelled result candidates: Propositions 1–9, Corollaries 1–2, Appendix Propositions B1–B4, and Lemmas A1–A3 and B1. This is a preliminary inventory, not a completed v11 coverage audit.

## Exact Lean result

The earlier three algebraic support results remain. This continuation adds two
compiled support modules and closes a substantial part of the model-to-B9/B10
gap:

- `StaticModel.lean` represents `[N-1,N]`, `I* = min {I, Ĩ}`, the source's
  tie-to-capital convention, the exhaustive/disjoint task partition, and the
  unit-cost ordering around `W/R = γ(Ĩ)`. It also proves the constrained
  threshold response, the one-for-one displacement of labor-task mass, and the
  fixed-cutoff new-task creation response.
- `ComparativeStatics.lean` defines the task integral, equation-(13) task
  ratio, `Λ_I`, the paper weight `γ(i)^(σ̂-1)`, normalized wage
  `ω=W/(RK)`, and equation (13) as a functional identity. It proves that the
  lower-bound log derivative is `-Λ_I`, derives normalized (B10), derives
  (B9) by differentiating fixed-`K`, fixed-`L` factor income, and proves the
  normalization bridge from `d ln ω` to `d ln W-d ln R`.
- `MainTheorems.lean` combines those bridges in
  `automation_wage_decomposition_from_equation13` and
  `automation_log_wage_rises_iff_from_equation13`. The result is the exact
  automation-only (`dN=0`) wage equality and strict sign condition, conditional
  on equation (13), factor income, differentiability, and explicit nonzero
  obligations.

These theorems still do **not** construct an equilibrium, derive equation (13)
from primitive market clearing and household optimization, establish all
economic positivity conditions, supply the `Λ_N dN` term, or prove the
existence/order of Proposition 3's capital threshold `K̄ > K_`. They therefore
do not prove Proposition 1, 2, or 3 in full and certify none of the 19 named
results. `PaperInterface.lean` and `ProofInterface.lean` intentionally retain
zero claimed source-facing rows.

The complete source-only inventory and open printed-source issues are preserved
in `docs/SOURCE_ONLY_INVENTORY.md` and
`docs/FORMALIZATION_WORKING_MEMO.md`. The fidelity ledger is explicitly
`in_progress`; it records support steps and six open defects without treating
any as an assumption.

## Later joint task extension

`JointTaskExtension.lean` was added in the same local AppliedModelingLib paper
folder after the initial formalization run. It imports `StaticModel.lean` and
proves the exact change in labor task mass when task creation and automation
occur together, provided both allocations are feasible and the technological
frontier binds in both states. It also proves the strict condition for that
mass to grow. See `docs/EXTENSION_NOTE.md` for the mathematical statement and
scope. This is an independently checked support extension, not a claim that
Lean has proved a new wage or employment theorem.

The two extension theorems were checked with `#print axioms`. Both reported
`[propext, Classical.choice, Quot.sound]` and no paper specific axiom.

## Checks and provenance

- Exact final command:

  ```text
  lake build +AR18RaceManMachine
  ```

  Literal output (exit code 0):

  ```text
  Build completed successfully (8320 jobs).
  ```

- Exact final command:

  ```text
  python3 scripts/paper_contribution.py check AR18RaceManMachine --fast
  ```

  Literal output (exit code 0):

  ```text
  + lake build +AR18RaceManMachine.PaperInterface
  Build completed successfully (8318 jobs).
  + git diff --check -- papers/AR18RaceManMachine papers/AR18RaceManMachine.lean lakefile.toml ':(exclude)papers/AR18RaceManMachine/source/'
  ```

- Independent `#print axioms` checks on the threshold, cost-ordering,
  displacement/new-task, B9/B10, normalization, wage-decomposition, and wage-
  sign theorems all reported exactly `[propext, Classical.choice, Quot.sound]`.
- The only `sorry` matches in paper-local Lean files are instructional prose in
  the generated `PaperInterface.lean` module comment; no declaration body uses
  `sorry`, `admit`, or a paper-specific axiom.
- The source PDF/text remain ignored. No push, publication, or modification to
  another paper was performed.

The accepted closeout protocol, independent source-to-Lean semantic review, and final adversarial audit have not run. `status.json` correctly records a partial formalization.
