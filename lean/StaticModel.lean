import Mathlib

/-!
# Static task allocation support

Source-shaped definitions and elementary consequences of equations (5)--(6)
in the June 2017 paper. These declarations formalize the unit-width task
continuum, the technological/cost cutoff minimum, the tie-to-capital convention,
and the displacement/new-task interval arithmetic. They are support results,
not a claim that a full static equilibrium exists or that Proposition 2 has
been proved.
-/

namespace AR18RaceManMachine

/-- The paper's unit-width continuum of currently used tasks, `[N - 1, N]`. -/
def taskContinuum (N : ℝ) : Set ℝ := Set.Icc (N - 1) N

theorem taskContinuum_endpoint_width (N : ℝ) : N - (N - 1) = 1 := by
  ring

/-- Equation (6): the equilibrium cutoff is the smaller of the technological
frontier and the cost-equality cutoff. -/
def equilibriumThreshold (technologyCutoff costCutoff : ℝ) : ℝ :=
  min technologyCutoff costCutoff

theorem equilibriumThreshold_le_technologyCutoff (technologyCutoff costCutoff : ℝ) :
    equilibriumThreshold technologyCutoff costCutoff ≤ technologyCutoff := by
  exact min_le_left _ _

theorem equilibriumThreshold_le_costCutoff (technologyCutoff costCutoff : ℝ) :
    equilibriumThreshold technologyCutoff costCutoff ≤ costCutoff := by
  exact min_le_right _ _

theorem equilibriumThreshold_eq_technologyCutoff
    {technologyCutoff costCutoff : ℝ}
    (h : technologyCutoff ≤ costCutoff) :
    equilibriumThreshold technologyCutoff costCutoff = technologyCutoff := by
  exact min_eq_left h

theorem equilibriumThreshold_eq_costCutoff
    {technologyCutoff costCutoff : ℝ}
    (h : costCutoff ≤ technologyCutoff) :
    equilibriumThreshold technologyCutoff costCutoff = costCutoff := by
  exact min_eq_right h

/-- Source convention (footnote 12): a task at the threshold is assigned to
capital when firms are indifferent. -/
def IsCapitalTask (N technologyCutoff costCutoff i : ℝ) : Prop :=
  i ∈ taskContinuum N ∧ i ≤ equilibriumThreshold technologyCutoff costCutoff

def IsLaborTask (N technologyCutoff costCutoff i : ℝ) : Prop :=
  i ∈ taskContinuum N ∧ equilibriumThreshold technologyCutoff costCutoff < i

theorem capital_task_is_technologically_automatable
    {N technologyCutoff costCutoff i : ℝ}
    (h : IsCapitalTask N technologyCutoff costCutoff i) :
    i ≤ technologyCutoff := by
  exact h.2.trans (equilibriumThreshold_le_technologyCutoff _ _)

theorem task_factor_partition
    {N technologyCutoff costCutoff i : ℝ}
    (hi : i ∈ taskContinuum N) :
    IsCapitalTask N technologyCutoff costCutoff i ∨
      IsLaborTask N technologyCutoff costCutoff i := by
  rcases le_or_gt i (equilibriumThreshold technologyCutoff costCutoff) with h | h
  · exact Or.inl ⟨hi, h⟩
  · exact Or.inr ⟨hi, h⟩

theorem task_factor_partition_disjoint
    {N technologyCutoff costCutoff i : ℝ} :
    ¬ (IsCapitalTask N technologyCutoff costCutoff i ∧
      IsLaborTask N technologyCutoff costCutoff i) := by
  rintro ⟨hcapital, hlabor⟩
  exact (not_lt_of_ge hcapital.2) hlabor.2

/-- Under Assumption 1 and equation (6), capital has the lower unit cost below
the cost-equality cutoff. Positivity is made explicit because division order
is otherwise invalid over `ℝ`. -/
theorem capital_unit_cost_lt_labor_unit_cost_below
    (gamma : ℝ → ℝ) (W R costCutoff i : ℝ)
    (hgamma : StrictMono gamma)
    (hR : 0 < R)
    (hgamma_i : 0 < gamma i)
    (hcostEquality : W / R = gamma costCutoff)
    (hi : i < costCutoff) :
    R < W / gamma i := by
  have hrelative : gamma i < W / R := by
    rw [hcostEquality]
    exact hgamma hi
  have hproduct : gamma i * R < W := (lt_div_iff₀ hR).mp hrelative
  apply (lt_div_iff₀ hgamma_i).2
  simpa only [mul_comm] using hproduct

/-- Under Assumption 1 and equation (6), labor has the lower unit cost above
the cost-equality cutoff. -/
theorem labor_unit_cost_lt_capital_unit_cost_above
    (gamma : ℝ → ℝ) (W R costCutoff i : ℝ)
    (hgamma : StrictMono gamma)
    (hR : 0 < R)
    (hgamma_i : 0 < gamma i)
    (hcostEquality : W / R = gamma costCutoff)
    (hi : costCutoff < i) :
    W / gamma i < R := by
  have hrelative : W / R < gamma i := by
    rw [hcostEquality]
    exact hgamma hi
  have hproduct : W < gamma i * R := (div_lt_iff₀ hR).mp hrelative
  apply (div_lt_iff₀ hgamma_i).2
  simpa only [mul_comm] using hproduct

/-- Length of the capital-produced portion `[N - 1, threshold]`. -/
def capitalTaskMass (N threshold : ℝ) : ℝ := threshold - (N - 1)

/-- Length of the labor-produced portion `(threshold, N]`. -/
def laborTaskMass (N threshold : ℝ) : ℝ := N - threshold

theorem task_masses_sum_to_one (N threshold : ℝ) :
    capitalTaskMass N threshold + laborTaskMass N threshold = 1 := by
  simp only [capitalTaskMass, laborTaskMass]
  ring

theorem constrained_automation_raises_threshold
    (technologyCutoff costCutoff change : ℝ)
    (hbefore : technologyCutoff ≤ costCutoff)
    (hafter : technologyCutoff + change ≤ costCutoff) :
    equilibriumThreshold (technologyCutoff + change) costCutoff -
        equilibriumThreshold technologyCutoff costCutoff = change := by
  rw [equilibriumThreshold_eq_technologyCutoff hbefore,
    equilibriumThreshold_eq_technologyCutoff hafter]
  ring

/-- The task-allocation displacement component: while the technology frontier
binds before and after the change, expanding it reduces labor-task mass by the
same amount. -/
theorem constrained_automation_displaces_labor_tasks
    (N technologyCutoff costCutoff change : ℝ)
    (hbefore : technologyCutoff ≤ costCutoff)
    (hafter : technologyCutoff + change ≤ costCutoff) :
    laborTaskMass N (equilibriumThreshold (technologyCutoff + change) costCutoff) -
        laborTaskMass N (equilibriumThreshold technologyCutoff costCutoff) = -change := by
  rw [equilibriumThreshold_eq_technologyCutoff hbefore,
    equilibriumThreshold_eq_technologyCutoff hafter]
  simp only [laborTaskMass]
  ring

/-- Holding the cutoff fixed, creation of new top tasks expands the length of
the labor-task region one for one. This is the paper's new-task creation
counterpart to displacement; this June 2017 version does not call it
"reinstatement" in the reviewed passage. -/
theorem new_task_creation_expands_labor_tasks
    (N threshold change : ℝ) :
    laborTaskMass (N + change) threshold - laborTaskMass N threshold = change := by
  simp only [laborTaskMass]
  ring

end AR18RaceManMachine
