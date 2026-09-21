import AR18RaceManMachine.StaticModel

/-!
# Appendix-B comparative-static bridge

This module derives the automation-side normalized relative-price equation
(B10) from the paper's equation (13), and derives (B9) from the factor-income
identity with fixed `K` and `L`. It also proves the normalization bridge
`ω = W / (R K)`. The hypotheses expose differentiability and nonzero-
denominator obligations explicitly. These are proof-support results only: they
do not construct a static equilibrium or establish all hypotheses of
Proposition 3.
-/

open scoped Interval

namespace AR18RaceManMachine

/-- The paper's integral over labor tasks, with the task weight left explicit.
For equation (13), instantiate `weight i = γ(i)^(σ̂-1)`. -/
noncomputable def taskIntegral (weight : ℝ → ℝ) (N I : ℝ) : ℝ :=
  ∫ i in I..N, weight i

/-- The task-composition ratio inside the last logarithm of equation (13). -/
noncomputable def taskRatio (weight : ℝ → ℝ) (N I : ℝ) : ℝ :=
  taskIntegral weight N I / (I - N + 1)

/-- The automation displacement coefficient `Λ_I` appearing in Proposition 3
and Appendix equation (B10), for an explicit task weight. -/
noncomputable def lambdaI (weight : ℝ → ℝ) (N I : ℝ) : ℝ :=
  weight I / taskIntegral weight N I + 1 / (I - N + 1)

/-- The paper's particular integrand `γ(i)^(σ̂-1)`. -/
noncomputable def paperTaskWeight (gamma : ℝ → ℝ) (sigmaHat i : ℝ) : ℝ :=
  Real.rpow (gamma i) (sigmaHat - 1)

/-- The paper's `Λ_I`, before any positivity proof for its ingredients. -/
noncomputable def paperLambdaI
    (gamma : ℝ → ℝ) (sigmaHat N I : ℝ) : ℝ :=
  lambdaI (paperTaskWeight gamma sigmaHat) N I

theorem taskIntegral_hasDerivAt
    (weight : ℝ → ℝ) (N I : ℝ)
    (hcont : Continuous weight) :
    HasDerivAt (taskIntegral weight N) (-weight I) I := by
  simpa only [taskIntegral] using
    intervalIntegral.integral_hasDerivAt_left
      (hcont.intervalIntegrable I N)
      hcont.stronglyMeasurable.stronglyMeasurableAtFilter
      hcont.continuousAt

/-- Differentiating the exact task-composition term in equation (13) with
respect to its lower bound produces `-Λ_I`. -/
theorem taskRatio_hasDerivAt_log
    (weight : ℝ → ℝ) (N I : ℝ)
    (hcont : Continuous weight)
    (hintegral : taskIntegral weight N I ≠ 0)
    (hwidth : I - N + 1 ≠ 0) :
    HasDerivAt (fun x => Real.log (taskRatio weight N x))
      (-lambdaI weight N I) I := by
  have hden : HasDerivAt (fun x : ℝ => x - N + 1) 1 I := by
    simpa only [sub_zero, add_zero] using
      ((hasDerivAt_id I).sub_const N).add_const 1
  have hratio := (taskIntegral_hasDerivAt weight N I hcont).div hden hwidth
  have hratio0 : taskRatio weight N I ≠ 0 := div_ne_zero hintegral hwidth
  have hlog := hratio.log hratio0
  have hlog' : HasDerivAt (fun x => Real.log (taskRatio weight N x))
      (((-weight I * (I - N + 1) - taskIntegral weight N I * 1) /
          (I - N + 1) ^ 2) / taskRatio weight N I) I := by
    simpa only [taskRatio, Pi.div_apply] using hlog
  convert hlog' using 1
  simp only [taskRatio, lambdaI]
  field_simp
  ring

/-- Equation (13), represented as an identity in the automation cutoff. -/
def RelativeDemandEquation
    (sigmaHat K N : ℝ) (laborSupply omega weight : ℝ → ℝ) : Prop :=
  ∀ I,
    Real.log (omega I) + (1 / sigmaHat) * Real.log (laborSupply (omega I)) =
      (1 / sigmaHat - 1) * Real.log K +
        (1 / sigmaHat) * Real.log (taskRatio weight N I)

/-- Equation (13) implies normalized (B10), conditional on the displayed
regularity and nonzero obligations and on the stated labor-supply elasticity. -/
theorem normalized_B10_from_relativeDemandEquation
    (sigmaHat K N I epsilonL omegaDot laborDot : ℝ)
    (laborSupply omega weight : ℝ → ℝ)
    (hequation : RelativeDemandEquation sigmaHat K N laborSupply omega weight)
    (homega : HasDerivAt omega omegaDot I)
    (hlabor : HasDerivAt laborSupply laborDot (omega I))
    (hweight : Continuous weight)
    (hsigma : sigmaHat ≠ 0)
    (hdenominator : sigmaHat + epsilonL ≠ 0)
    (homega0 : omega I ≠ 0)
    (hlabor0 : laborSupply (omega I) ≠ 0)
    (hintegral : taskIntegral weight N I ≠ 0)
    (hwidth : I - N + 1 ≠ 0)
    (helasticity : epsilonL = laborDot * omega I / laborSupply (omega I)) :
    omegaDot / omega I = -lambdaI weight N I / (sigmaHat + epsilonL) := by
  have hlogOmega := homega.log homega0
  have hlogLabor := (hlabor.log hlabor0).comp I homega
  have hleft : HasDerivAt
      (fun x => Real.log (omega x) +
        (1 / sigmaHat) * Real.log (laborSupply (omega x)))
      (omegaDot / omega I +
        (1 / sigmaHat) * (laborDot / laborSupply (omega I) * omegaDot)) I := by
    simpa only [Function.comp_apply] using
      hlogOmega.add (hlogLabor.const_mul (1 / sigmaHat))
  have hlogTask := taskRatio_hasDerivAt_log weight N I hweight hintegral hwidth
  have hconst : HasDerivAt
      (fun _ : ℝ => (1 / sigmaHat - 1) * Real.log K) 0 I :=
    hasDerivAt_const I _
  have hright : HasDerivAt
      (fun x => (1 / sigmaHat - 1) * Real.log K +
        (1 / sigmaHat) * Real.log (taskRatio weight N x))
      (0 + (1 / sigmaHat) * (-lambdaI weight N I)) I := by
    simpa only using hconst.add (hlogTask.const_mul (1 / sigmaHat))
  have hfun :
      (fun x => Real.log (omega x) + (1 / sigmaHat) * Real.log (laborSupply (omega x))) =
        (fun x => (1 / sigmaHat - 1) * Real.log K +
          (1 / sigmaHat) * Real.log (taskRatio weight N x)) := by
    funext x
    exact hequation x
  rw [hfun] at hleft
  have hderiv := hleft.unique hright
  have hel : epsilonL * laborSupply (omega I) = laborDot * omega I :=
    (eq_div_iff hlabor0).mp helasticity
  field_simp [homega0, hlabor0, hsigma] at hderiv
  have hc :
      laborSupply (omega I) * (omegaDot * (sigmaHat + epsilonL)) =
        laborSupply (omega I) * (-(omega I * lambdaI weight N I)) := by
    calc
      laborSupply (omega I) * (omegaDot * (sigmaHat + epsilonL)) =
          omegaDot * (sigmaHat * laborSupply (omega I) +
            epsilonL * laborSupply (omega I)) := by ring
      _ = omegaDot * (sigmaHat * laborSupply (omega I) +
            omega I * laborDot) := by rw [hel]; ring
      _ = omega I * laborSupply (omega I) *
            (sigmaHat * 0 + -lambdaI weight N I) := hderiv
      _ = laborSupply (omega I) *
            (-(omega I * lambdaI weight N I)) := by ring
  have hscaled : omegaDot * (sigmaHat + epsilonL) =
      -(omega I * lambdaI weight N I) :=
    mul_left_cancel₀ hlabor0 hc
  field_simp [homega0, hdenominator]
  nlinarith

/-- Differentiating the fixed-`K`, fixed-`L` factor-income identity gives the
log-change decomposition (B9). -/
theorem B9_from_factorIncome
    (W R Y : ℝ → ℝ) (L K eta t Wdot Rdot Ydot : ℝ)
    (hW : HasDerivAt W Wdot t)
    (hR : HasDerivAt R Rdot t)
    (hY : HasDerivAt Y Ydot t)
    (hfactorIncome : ∀ x, W x * L + R x * K = (1 - eta) * Y x)
    (hW0 : W t ≠ 0)
    (hR0 : R t ≠ 0)
    (hY0 : Y t ≠ 0)
    (heta0 : 1 - eta ≠ 0) :
    let s := W t * L / ((1 - eta) * Y t)
    s * (Wdot / W t) + (1 - s) * (Rdot / R t) = Ydot / Y t := by
  dsimp only
  have hleft : HasDerivAt (fun x => W x * L + R x * K)
      (Wdot * L + Rdot * K) t := by
    simpa only using (hW.mul_const L).add (hR.mul_const K)
  have hright : HasDerivAt (fun x => (1 - eta) * Y x)
      ((1 - eta) * Ydot) t := by
    simpa only using hY.const_mul (1 - eta)
  have hfun : (fun x => W x * L + R x * K) =
      (fun x => (1 - eta) * Y x) := by
    funext x
    exact hfactorIncome x
  rw [hfun] at hleft
  have hderiv := hleft.unique hright
  have hpoint := hfactorIncome t
  have hcomplement :
      1 - W t * L / ((1 - eta) * Y t) =
        R t * K / ((1 - eta) * Y t) := by
    field_simp [hY0, heta0]
    nlinarith
  rw [hcomplement]
  field_simp [hW0, hR0, hY0, heta0]
  nlinarith

/-- The paper's normalized wage `ω = W/(R K)`. -/
noncomputable def normalizedWage (W R : ℝ → ℝ) (K t : ℝ) : ℝ :=
  W t / (R t * K)

noncomputable def normalizedWageDerivative
    (W R : ℝ → ℝ) (K t Wdot Rdot : ℝ) : ℝ :=
  (Wdot * (R t * K) - W t * (Rdot * K)) / (R t * K) ^ 2

theorem normalizedWage_hasDerivAt
    (W R : ℝ → ℝ) (K t Wdot Rdot : ℝ)
    (hW : HasDerivAt W Wdot t)
    (hR : HasDerivAt R Rdot t)
    (hden : R t * K ≠ 0) :
    HasDerivAt (normalizedWage W R K)
      (normalizedWageDerivative W R K t Wdot Rdot) t := by
  simpa only [normalizedWage, normalizedWageDerivative] using
    hW.div (hR.mul_const K) hden

theorem normalizedWage_logDerivative_eq_relativePrice
    (W R : ℝ → ℝ) (K t Wdot Rdot : ℝ)
    (hW0 : W t ≠ 0) (hR0 : R t ≠ 0) (hK0 : K ≠ 0) :
    normalizedWageDerivative W R K t Wdot Rdot /
        normalizedWage W R K t =
      Wdot / W t - Rdot / R t := by
  simp only [normalizedWageDerivative, normalizedWage]
  field_simp [hW0, hR0, hK0]

/-- Model-to-(B10) bridge: equation (13), the labor-supply elasticity, and the
normalization `ω = W/(R K)` imply the relative factor-price response. -/
theorem B10_from_relativeDemandEquation
    (sigmaHat K N I epsilonL Wdot Rdot laborDot : ℝ)
    (W R laborSupply weight : ℝ → ℝ)
    (hequation : RelativeDemandEquation sigmaHat K N laborSupply
      (normalizedWage W R K) weight)
    (hW : HasDerivAt W Wdot I)
    (hR : HasDerivAt R Rdot I)
    (hlabor : HasDerivAt laborSupply laborDot (normalizedWage W R K I))
    (hweight : Continuous weight)
    (hsigma : sigmaHat ≠ 0)
    (hdenominator : sigmaHat + epsilonL ≠ 0)
    (hW0 : W I ≠ 0)
    (hR0 : R I ≠ 0)
    (hK0 : K ≠ 0)
    (hlabor0 : laborSupply (normalizedWage W R K I) ≠ 0)
    (hintegral : taskIntegral weight N I ≠ 0)
    (hwidth : I - N + 1 ≠ 0)
    (helasticity : epsilonL =
      laborDot * normalizedWage W R K I /
        laborSupply (normalizedWage W R K I)) :
    Wdot / W I - Rdot / R I =
      -lambdaI weight N I / (sigmaHat + epsilonL) := by
  have hRK : R I * K ≠ 0 := mul_ne_zero hR0 hK0
  have homega := normalizedWage_hasDerivAt W R K I Wdot Rdot hW hR hRK
  have homega0 : normalizedWage W R K I ≠ 0 :=
    div_ne_zero hW0 hRK
  have hnormalized := normalized_B10_from_relativeDemandEquation
    sigmaHat K N I epsilonL
    (normalizedWageDerivative W R K I Wdot Rdot) laborDot
    laborSupply (normalizedWage W R K) weight hequation homega hlabor
    hweight hsigma hdenominator homega0 hlabor0 hintegral hwidth helasticity
  rw [normalizedWage_logDerivative_eq_relativePrice W R K I Wdot Rdot
    hW0 hR0 hK0] at hnormalized
  exact hnormalized

end AR18RaceManMachine
