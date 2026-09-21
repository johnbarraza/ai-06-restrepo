import AR18RaceManMachine.StaticModel

/-!
# Joint task changes

This is a conditional extension of the task allocation accounting in the
June 2017 paper. It compares two feasible task intervals. The automation
frontier binds in both periods, while the cost cutoff may change. The result
concerns the measure of tasks performed by labor. It does not infer a labor
share, employment, wage, or new equilibrium.
-/

namespace AR18RaceManMachine

/-- Simultaneous creation of new tasks and feasible automation. Both actual
cutoffs lie inside their unit task intervals. The two cost cutoffs can differ. -/
theorem joint_task_change
    (N I costBefore costAfter newTasks automation : ℝ)
    (hbindBefore : I ≤ costBefore)
    (hbindAfter : I + automation ≤ costAfter)
    (hfeasibleBeforeLow : N - 1 ≤ I)
    (hfeasibleBeforeHigh : I ≤ N)
    (hfeasibleAfterLow : N + newTasks - 1 ≤ I + automation)
    (hfeasibleAfterHigh : I + automation ≤ N + newTasks) :
    laborTaskMass (N + newTasks)
        (equilibriumThreshold (I + automation) costAfter) -
      laborTaskMass N (equilibriumThreshold I costBefore) =
        newTasks - automation ∧
    0 ≤ laborTaskMass N (equilibriumThreshold I costBefore) ∧
    0 ≤ laborTaskMass (N + newTasks)
      (equilibriumThreshold (I + automation) costAfter) ∧
    0 ≤ capitalTaskMass N (equilibriumThreshold I costBefore) ∧
    0 ≤ capitalTaskMass (N + newTasks)
      (equilibriumThreshold (I + automation) costAfter) := by
  rw [equilibriumThreshold_eq_technologyCutoff hbindBefore,
    equilibriumThreshold_eq_technologyCutoff hbindAfter]
  simp only [laborTaskMass, capitalTaskMass]
  constructor
  · ring
  constructor
  · linarith
  constructor
  · linarith
  constructor
  · linarith
  · linarith

/-- Labor performs more tasks after both changes exactly when the measure of
new tasks exceeds the measure of newly automated tasks. This comparison says
nothing about wages or the labor share. -/
theorem joint_task_change_expands_labor_iff
    (N I costBefore costAfter newTasks automation : ℝ)
    (hbindBefore : I ≤ costBefore)
    (hbindAfter : I + automation ≤ costAfter)
    (hfeasibleBeforeLow : N - 1 ≤ I)
    (hfeasibleBeforeHigh : I ≤ N)
    (hfeasibleAfterLow : N + newTasks - 1 ≤ I + automation)
    (hfeasibleAfterHigh : I + automation ≤ N + newTasks) :
    laborTaskMass N (equilibriumThreshold I costBefore) <
      laborTaskMass (N + newTasks)
        (equilibriumThreshold (I + automation) costAfter) ↔
      automation < newTasks := by
  have h := (joint_task_change N I costBefore costAfter newTasks automation
    hbindBefore hbindAfter hfeasibleBeforeLow hfeasibleBeforeHigh
    hfeasibleAfterLow hfeasibleAfterHigh).1
  constructor <;> intro hsign <;> linarith

end AR18RaceManMachine
