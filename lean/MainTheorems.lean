import AR18RaceManMachine.ComparativeStatics

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

/-- Automation-only Proposition 3 wage decomposition derived from equation
(13), the fixed-factor income identity, and their differentiability premises.
This remains a support theorem: it assumes the equilibrium identities as
functional equalities, sets the new-task change to zero, and does not construct
the equilibrium or prove the paper's capital-stock threshold clause. -/
theorem automation_wage_decomposition_from_equation13
    (sigmaHat K N I epsilonL Wdot Rdot Ydot laborDot L eta : ℝ)
    (W R Y laborSupply weight : ℝ → ℝ)
    (hequation : RelativeDemandEquation sigmaHat K N laborSupply
      (normalizedWage W R K) weight)
    (hfactorIncome : ∀ x, W x * L + R x * K = (1 - eta) * Y x)
    (hW : HasDerivAt W Wdot I)
    (hR : HasDerivAt R Rdot I)
    (hY : HasDerivAt Y Ydot I)
    (hlabor : HasDerivAt laborSupply laborDot (normalizedWage W R K I))
    (hweight : Continuous weight)
    (hsigma : sigmaHat ≠ 0)
    (hdenominator : sigmaHat + epsilonL ≠ 0)
    (hW0 : W I ≠ 0)
    (hR0 : R I ≠ 0)
    (hY0 : Y I ≠ 0)
    (hK0 : K ≠ 0)
    (heta0 : 1 - eta ≠ 0)
    (hlabor0 : laborSupply (normalizedWage W R K I) ≠ 0)
    (hintegral : taskIntegral weight N I ≠ 0)
    (hwidth : I - N + 1 ≠ 0)
    (helasticity : epsilonL =
      laborDot * normalizedWage W R K I /
        laborSupply (normalizedWage W R K I)) :
    let s := W I * L / ((1 - eta) * Y I)
    Wdot / W I = Ydot / Y I -
      (1 - s) * lambdaI weight N I / (sigmaHat + epsilonL) := by
  dsimp only
  have hB9 := B9_from_factorIncome W R Y L K eta I Wdot Rdot Ydot
    hW hR hY hfactorIncome hW0 hR0 hY0 heta0
  dsimp only at hB9
  have hB10 := B10_from_relativeDemandEquation
    sigmaHat K N I epsilonL Wdot Rdot laborDot W R laborSupply weight
    hequation hW hR hlabor hweight hsigma hdenominator hW0 hR0 hK0
    hlabor0 hintegral hwidth helasticity
  have hB10' : Wdot / W I - Rdot / R I =
      -(lambdaI weight N I / (sigmaHat + epsilonL)) := by
    rw [hB10]
    ring
  exact automation_wage_change
    (W I * L / ((1 - eta) * Y I)) (Wdot / W I) (Rdot / R I)
    (Ydot / Y I) (lambdaI weight N I) (sigmaHat + epsilonL) hB9 hB10'

/-- Exact strict sign condition corresponding to the preceding automation-only
wage decomposition. It is still conditional on the same model identities and
does not prove Proposition 3's existence of a capital threshold `K̄`. -/
theorem automation_log_wage_rises_iff_from_equation13
    (sigmaHat K N I epsilonL Wdot Rdot Ydot laborDot L eta : ℝ)
    (W R Y laborSupply weight : ℝ → ℝ)
    (hequation : RelativeDemandEquation sigmaHat K N laborSupply
      (normalizedWage W R K) weight)
    (hfactorIncome : ∀ x, W x * L + R x * K = (1 - eta) * Y x)
    (hW : HasDerivAt W Wdot I)
    (hR : HasDerivAt R Rdot I)
    (hY : HasDerivAt Y Ydot I)
    (hlabor : HasDerivAt laborSupply laborDot (normalizedWage W R K I))
    (hweight : Continuous weight)
    (hsigma : sigmaHat ≠ 0)
    (hdenominator : sigmaHat + epsilonL ≠ 0)
    (hW0 : W I ≠ 0)
    (hR0 : R I ≠ 0)
    (hY0 : Y I ≠ 0)
    (hK0 : K ≠ 0)
    (heta0 : 1 - eta ≠ 0)
    (hlabor0 : laborSupply (normalizedWage W R K I) ≠ 0)
    (hintegral : taskIntegral weight N I ≠ 0)
    (hwidth : I - N + 1 ≠ 0)
    (helasticity : epsilonL =
      laborDot * normalizedWage W R K I /
        laborSupply (normalizedWage W R K I)) :
    let s := W I * L / ((1 - eta) * Y I)
    0 < Wdot / W I ↔
      (1 - s) * lambdaI weight N I / (sigmaHat + epsilonL) <
        Ydot / Y I := by
  dsimp only
  rw [automation_wage_decomposition_from_equation13
    sigmaHat K N I epsilonL Wdot Rdot Ydot laborDot L eta
    W R Y laborSupply weight hequation hfactorIncome hW hR hY hlabor
    hweight hsigma hdenominator hW0 hR0 hY0 hK0 heta0 hlabor0
    hintegral hwidth helasticity]
  constructor <;> intro h <;> linarith

end AR18RaceManMachine
