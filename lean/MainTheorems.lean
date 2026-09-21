import Mathlib

/-!
# Paper-Facing Theorems: The Race Between Machine and Man: Implications of Technology for Growth, Factor Shares and Employment

This file is the implementation theorem layer for the source paper. Keep
source-faithful definitions and theorem wrappers here, and expose only the
compact human-review subset in `PaperInterface.lean`.

During the statement-first phase, each exact paper-facing proposition lives in a
transparent `<name>Spec : Prop` declaration in `PaperInterface.lean`; the paired
theorem/lemma endpoint belongs in `ProofInterface.lean` and has exactly that
type. Add proof implementations here only after those specifications pass v11
raw-source-to-expanded-Spec review and recursive premise provenance audit. Before full closeout, the v11
realization audit independently binds pinned source atoms to the elaborated Spec
and accounts for the complete Lean closure; a proof hole or a declaration name
is never evidence for that correspondence.
-/

namespace AR18RaceManMachine

/-- Algebraic consequence of the paper's Appendix B equations (B9) and (B10).
This is a support lemma: it does not prove that a static equilibrium satisfies
either source identity. -/
theorem wage_identity_from_B9_B10
    (s dW dR productivity relativePrice : ℝ)
    (hB9 : s * dW + (1 - s) * dR = productivity)
    (hB10 : dW - dR = relativePrice) :
    dW = productivity + (1 - s) * relativePrice := by
  linear_combination hB9 + (1 - s) * hB10

/-- Automation specialization of the algebraic wage identity. -/
theorem automation_wage_change
    (s dW dR productivity lambdaI denominator : ℝ)
    (hB9 : s * dW + (1 - s) * dR = productivity)
    (hB10 : dW - dR = -(lambdaI / denominator)) :
    dW = productivity - (1 - s) * lambdaI / denominator := by
  have h := wage_identity_from_B9_B10 s dW dR productivity
    (-(lambdaI / denominator)) hB9 hB10
  calc
    dW = productivity + (1 - s) * (-(lambdaI / denominator)) := h
    _ = productivity - (1 - s) * lambdaI / denominator := by ring

/-- The source wage condition, conditional on B9 and B10. -/
theorem automation_wage_rises_iff
    (s dW dR productivity lambdaI denominator : ℝ)
    (hB9 : s * dW + (1 - s) * dR = productivity)
    (hB10 : dW - dR = -(lambdaI / denominator)) :
    0 < dW ↔ (1 - s) * lambdaI / denominator < productivity := by
  rw [automation_wage_change s dW dR productivity lambdaI denominator hB9 hB10]
  constructor <;> intro h <;> linarith

end AR18RaceManMachine
