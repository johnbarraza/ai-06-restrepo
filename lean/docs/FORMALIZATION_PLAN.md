# Formalization Plan: The Race Between Machine and Man: Implications of Technology for Growth, Factor Shares and Employment

This is a working scratchpad for outside-Lean proof thinking. Keep it short and
useful; it is not the final validation report. Once the current source-shaped
target and audited `PaperInterface.lean` skeleton are present, prioritize the
next proof obligation; update this document at material boundaries rather than
after routine proof steps.

- Namespace: `AR18RaceManMachine`

## Initial Outside-Lean Paper Audit

- Source version / local files inspected: exact 87-page June 2017 NBER PDF and
  complete 4,689-line extracted text; PDF SHA-256
  `441d01202afd56ef8002fc24ffc2beb51191741c0b5accb11d2534620dd616b7`.
- Source/version mismatch notes: none; the priority displays and Proposition 3
  were visually checked in the pinned PDF rather than inferred from OCR alone.
- Complete named-result ledger status: source-only inventory has 19 candidates
  (Propositions 1--9, Corollaries 1--2, Lemmas A1--A3, Propositions B1--B4,
  Lemma B1). The v11 source map and selected row dispositions are not complete.
- Formula sanity check:
  - Signs, constants, normalizations, quantifiers, domains: equation (13)'s
    coefficient placement and Proposition 3's denominator `σ̂+ε_L` were
    visually confirmed. Open source inconsistencies are listed in
    `FORMALIZATION_WORKING_MEMO.md`.
  - Density vs mass / likelihood-kernel representation issues: task mass is
    interval length on `[N-1,N]`; no probability kernel is involved.
  - Dependency map between named source results: Proposition 1 supplies the
    equilibrium; Proposition 2 supplies comparative statics; Proposition 3
    combines productivity changes with B9/B10. Appendix B1 generalizes
    Proposition 2 and Appendix B9/B10 provide its wage algebra.
  - Formula-bearing displayed claims that need derivation, not source-row assumptions:
    equation (13), `Λ_I`, B9, B10, both `dI` and `dN` productivity responses,
    and the capital-threshold existence clause.
- Named result sanity check:
  - Results that look correct as stated:
  - Suspected bugs, missing assumptions, or ambiguous wording:
- Source-proof fidelity ledger (`audit/source_proof_fidelity.json`):
  - Proof scopes reviewed by source locator and mathematical claim: static task
    allocation through equation (13), Proposition 3's wage display, and the
    Appendix B9/B10 passage; review remains in progress.
  - Source proof defects, if any, with repair obligation and acceptance condition:
    exponent, sign, and inequality-direction leads are recorded but unresolved.
  - Proof-only defects kept out of `Assumptions.lean`: yes; that module remains
    empty and none of the source issues is treated as an assumption.
- Shared-library reuse checkpoint:
  - Mathlib declarations/modules inspected: interval-integral lower-bound
    differentiation, `HasDerivAt` quotient/log/composition rules, ordered-field
    division lemmas, and ring/linear arithmetic tactics.
  - Cslib declarations/modules inspected:
  - Optlib declarations/modules inspected:
  - Other potential upstream sources inspected:
  - Upstream sources used or ported, with citation/provenance:
  - Existing `AppliedModelingLib` declarations/modules inspected: no suitable
    paper-specific task-continuum or equilibrium bridge was identified during
    this proof seam; a full repository-wide reusable-library search remains due.
  - API chosen and near-misses: Mathlib calculus APIs were used directly.
  - Source-defined objects that will use reusable library definitions, their
    exact source routes, and their planned material-library semantic reviews:
- Proof strategy consequences:
  - Source proof route to follow: derive `-Λ_I` from equation (13), derive B9
    from factor income, bridge `ω=W/(RK)`, then solve B9/B10.
  - Cleaner Lean route or reusable library route: direct real calculus followed
    by algebraic elimination.
  - Major issues already reported to the user: see the source-only inventory
    and working memo; none has been repaired into a source-facing theorem.
- Algorithmic complexity audit, when applicable:
  - Transitive operational dependency graph over every reachable branch and old semantic closure/oracle dependencies:
  - Worst-case recurrence and bound over the stated input-size measure:
  - Traversal/enumeration lengths, duplicates, and materialization/rebuild charges:
  - Representation/container primitives and rational bit-growth work accounting; missing/excluded work withholds a runtime match:
  - Pinned evidence when closure elimination is material: artifact/source hashes and semantic binding to generated IR/C or a cost-threaded executor:

## Source Inventory

- Definitions / formatted paper objects: task continuum `[N-1,N]`, automation
  frontier `I`, cost cutoff `Ĩ`, equilibrium cutoff `I*`, unit costs, normalized
  wage `ω`, labor supply, task ratio, `Λ_I`, factor-income identity, B9/B10.
- Named lemmas / propositions / theorems / corollaries: 19 candidates listed in
  `SOURCE_ONLY_INVENTORY.md`.
- Named assumptions / model conditions used by those results: Assumptions 1,
  2, 3, 1′, 4, 1″, 2′, and 2″.
- Deep-only prose, standalone formulas, algorithms, figures, simulations, and
  computational examples (record scope disposition; do not create normal-mode
  proof targets merely because they are numbered or displayed):

## Reviewed Source Inventory Boundary

Do not begin the main proof campaign until this boundary is complete. The
purpose is to discover missing conclusions and hidden premises while changing
the statement skeleton is still cheap, rather than during final closeout.

- [ ] Exact source version and every source artifact used by the normal-scope
      inventory are byte-pinned.
- [ ] Complete the curator-owned
      `audit/v11_source_map_preparation_config.json`
      `source_named_result_inventory_review` plan under the procedure in
      `skills/econcs-formalizer/SKILL.md`; do not create a second
      `intake_freeze.json` authority.
- [ ] The single `closeout_review_policy` and complete content-pinned
      `source_region_partition` classify all main, appendix, and supplement
      source material before review; Lean names and proof imports do not set
      the tier.
- [ ] The independent normal-scope inventory contains every named theoretical
      definition, result, and source assumption, with explicit dispositions for
      exclusions. Navigation names are not coverage evidence.
- [ ] Every selected result has source-first premise/conclusion atoms, exact
      anchors, and one complete transparent `Spec : Prop` in `PaperInterface`.
- [ ] The proof-obligation dependency order below is acyclic and assigns one
      owning module to each result; concurrent agents do not share an item.
- [ ] One focused Lean claim-graph and raw-source statement review has frozen the exact
      statement identities. After this point, a proof-body-only edit reopens
      proof closure and compilation, not the human statement judgment.
- [ ] The dashboard cache is created once after this freeze, never during bare
      scaffold creation.

### Proof-obligation order

| Order | Source-semantic item | Dependencies | Owning module / agent | Statement frozen | Proof status |
|---:|---|---|---|---|---|
| 1 | Fill from the independent source inventory | none | | no | pending |

## Initial Proof Strategy

- Main theorem chain: task threshold and allocation; equation (13) to B10;
  fixed-factor income identity to B9; B9+B10 to the automation wage response.
- Likely reusable `AppliedModelingLib` seams:
- Paper steps that look underspecified or analytically hard: full equilibrium
  existence/uniqueness, the `dN` response, positivity from primitive model
  assumptions, and the Proposition 3 `K̄` existence/order result.
- Formal target map:
  - Rows to fully prove now:
  - Empirical/descriptive rows out of formal theorem scope:
  - Explicit assumption/certificate boundaries, if any:
- Planned fallback route if the source proof is too informal:

## Audited Statement Skeleton

Before drafting Lean, independently inventory every material source atom against
the exact pinned source quote bytes. Then replace the generated placeholder with
every in-scope paper-facing theorem/formula statement as a transparent
`<name>Spec : Prop`, followed by `theorem/lemma <name> : <name>Spec := by sorry`.
Audit and freeze the specification's canonical declaration-manifest digest; Lean
Meta must confirm the paired proof route has exactly that elaborated proposition.
The inactive source-map `semantic_contract_template` records only the
spec/proof pairing to promote after source review and proof completion. Never
treat the `by sorry` route, an identifier, or a type/container label as active
semantic contract or proof evidence.

At formalized closeout, complete current source-to-Spec correspondence. Bind every
source atom to the current elaborated Spec surface, traverse the full Lean
closure including proof and instance arguments, and give every material closure
terminal a source atom, approved source correction/additional assumption,
checked Lean derivation, or version-pinned foundation disposition. Reuse a
semantic judgment only when that item's source-atom content, Spec closure,
narrow closure environment, and exact theorem type are unchanged. Historical
receipts remain readable records, but only the current accepted obligation graph
is a current closeout credential.

Partition every source and Lean obligation through both the numeric and
discrete semantics reviews. Record coercion, division, rounding, normalization,
strictness, and zero-denominator behavior separately. Distinguish immediate
successor, next active choice, eventual occurrence, restricted support, and
first occurrence literally. Bind any proved equivalence to an explicit
equality/iff Lean conclusion on the reviewed obligations.

For every `source_routes` entry, pin the source item, current statement digest,
exact locator, route kind, and semantic scope/evidence. `direct` is only for an
exact equivalent paper-facing endpoint with an exact source-conclusion/Lean-
conclusion equivalence. A `corrected_source_statement` retains archival text
and has exactly one complete PaperInterface endpoint in `lean_declarations`;
state all repaired clauses as one explicit conjunction there. Aliases, proof
helpers, support declarations, and semantic bridges cannot carry the repaired
target, source-route credit, or coverage credit. A composite row lists each scoped component as
`source_component`, using a Lean conclusion as evidence without claiming a
full-theorem equivalence. `source_model_convention` is for an explicit model
reading, `defect_or_remark_support` for quarantined/support-only material, and
`proof_support` only for a substantive support scope that never gives endpoint
credit. Names route review but never establish it.

| Source item / locator | Spec -> proof route | Lean semantic identity | Statement verdict | Premise provenance | Proof body |
|---|---|---|---|---|---|
| No source-pinned target supplied | `none` | | pending | pending | none |

Signature changes after a `matches` verdict invalidate the row and require a
fresh audit. Replacing `sorry` without changing the type does not.

## Planned Verification And Invalidation

Use these boundaries throughout the paper so closeout is execution of a plan,
not a new discovery pass.

| Material change | Reopen |
|---|---|
| One source item's semantic content or byte anchor | That item's source, coverage, statement, and dependent proof obligations |
| One `Spec` type or elaborated semantic dependency | That statement item and its dependent proof closure |
| Proof body only, theorem type unchanged | Focused compilation and proof closure only |
| Report, README, status prose, or DAG only | Presentation/status consistency only |
| Audit producer or protocol | Only lanes whose pinned producer/protocol identity changed; first run the reuse planner |

Planned commands, in order:

1. Proof loop: `lake build +<TouchedPaperModule>`. At closeout, run
   `env LEAN_NUM_THREADS=1 python3 scripts/private_paper_checkpoint.py AR18RaceManMachine`
   so Lake rehashes and dependency-orders one build containing every tracked
   paper-local source module; a forced root alone may reuse stale imported
   artifacts.
2. Closeout readiness: `python3 scripts/closeout_reuse_plan.py --paper AR18RaceManMachine`.
   Execute only its `next_action`. When it requests terminal closeout documents,
   write the final report and Dependency DAG from the current reviewed graph,
   compile and inspect the DAG, update paper-local status, and replan. Do not
   create or freeze those terminal artifacts during intake or ordinary proof
   work. If the frozen plan gives an action an explicit
   state-qualified successor, continue through that successor to its required
   replan boundary; do not rerun the planner between a cache-miss build and its
   one manifest refresh. A cache miss never erases unchanged semantic judgments.
   An exact current compiled cache skips a redundant standalone build, while a
   rebuilt artifact must be replanned before strict closeout.
4. Consolidated closeout, once the planner exposes it: run the exact
   `strict_closeout` argv/command printed by the plan. It carries a
   non-authoritative operational plan identity, preventing an accidental
   duplicate of the same completed execution. Do not invoke
   `run_paper_closeout.py` from a handwritten command: its planner-issued
   identity and any `--new-run` disposition are required.
   This command records ignored operational state under `.review_traces`; if
   the terminal stream disappears, inspect that state instead of starting a
   duplicate run.
5. Run a repository-wide status/site refresh only at an integration or release
   boundary, not as part of every paper proof closeout.

## Reusable-Library TODO

- Library APIs to use directly:
- Small reusable lemmas to add now:
- Larger reusable components to defer:
- Library-audit risks:

## Execution Checklist

- [ ] Download/cache source PDFs and text extracts, with redistribution notes.
- [ ] Complete the normal named-theory inventory and record deep-only
      dispositions separately.
- [ ] During active source-map repair, run `--source-inventory-check` before a
      necessary manifest refresh. With a current cache, use targeted
      statement/coverage checks; after the source map, interface, and status
      surface are stable, refresh once and let bounded manifest retry/fallback
      handle outliers. At frozen closeout, do not repeat those commands by
      default: let the planner schedule the required delta.
- [ ] Fill the formal target map and declare any intended boundary/certificate.
- [ ] Build or select reusable library APIs before adding paper-local wrappers.
- [ ] Replace the paper scaffold with complete source-facing Lean definitions,
      transparent `<name>Spec : Prop` statements, and theorem/lemma routes typed
      exactly by those specifications; use `by sorry` only for temporary private
      proof bodies.
- [ ] Independently inventory every material source atom from exact pinned quote
      bytes before Lean review. At full closeout, bind those atoms to the
      elaborated Spec and account for every material closure terminal, including
      proof and instance arguments; no declaration, data, or container category
      is an automatic exemption.
- [ ] Run the current Lean-owned recursive closure, premise-provenance, and raw
      byte-pinned-source-to-expanded-Spec reviews on every skeleton claim;
      record and freeze each semantic identity. The paired theorem is only
      proof evidence, not a second semantic match.
- [ ] Complete numeric and discrete obligation partitions; do not claim absence
      when the elaborated manifest exposes arithmetic or list operations.
- [ ] Complete the applicable fidelity-risk dimensions from expanded semantics:
      output/conclusion shape, action or input space, witness/optimization
      semantics, cardinality/quantification, and, for executable results,
      input scope, state transitions, termination, numeric representation, cost,
      and the global-claim bridge.
- [ ] For every runtime claim, audit the transitive operational dependency graph
      over every reachable branch; refinement alone is not cost evidence. Give a
      worst-case recurrence and bound, and completely account for traversal,
      duplicates, materialization, representation primitives, and rational bit
      growth. Missing or excluded work withholds a runtime match; materially
      eliminated closure dependencies need artifact/source hashes and semantic
      binding to generated IR/C or a cost-threaded executor.
- [ ] Review every source proof route used; record source proof defects as
      mathematical repair obligations, never as source assumptions.
- [ ] Prove all rows marked in-scope, or downgrade them with an explicit
      boundary note.
- [ ] Replace every skeleton `sorry` without changing its audited specification
      or theorem type; rerun statement audit whenever either changes.
- [ ] At closeout, run the reuse planner and let its terminal-document action
      schedule the README, paper-local status, DAG, and validation-report update
      from the same current row list.
- [ ] Freeze the paper inputs only after those requested documents are current.
      Let the planner's
      ordered actions own the targeted paper build, audits,
      placeholder/provenance checks, and DAG validation; do not pre-run those
      gates just to recreate an intermediate receipt.
- [ ] Record any unresolved source bug, assumption, or library debt.

## Active Scratchpad

- Current Lean endpoint: `automation_wage_decomposition_from_equation13` and
  `automation_log_wage_rises_iff_from_equation13`.
- Exact current mathematical gap: derive equation (13) from a constructed
  equilibrium, add the `Λ_N dN` branch, and prove the paper's capital threshold.
- Next bridge lemmas to try: continuity/positivity of `paperTaskWeight`, the
  upper-bound/moving-window derivative for `N`, and primitive equilibrium-to-
  relative-demand identities.
- Informal proof sketch / recurrence / construction: apply Leibniz/FTC to the
  task integral and moving denominator, differentiate labor-supply composition,
  cancel positive levels, then solve the two factor-price log equations.

## Issue And Deviation Log

Record possible source clarifications, printed errors, proof-strategy
deviations, model conventions, and extra assumptions in
`docs/FORMALIZATION_WORKING_MEMO.md`. This plan may name the active proof seam,
but it is not a second issue ledger. The working memo is a lead log, not audit
evidence; independently verify every retained item during closeout.
