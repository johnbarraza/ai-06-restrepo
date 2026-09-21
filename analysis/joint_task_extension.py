"""Illustrative arithmetic for the Lean checked joint task extension."""

from dataclasses import dataclass
from math import isclose


@dataclass(frozen=True)
class JointTaskCase:
    name: str
    n: float
    frontier: float
    cost_before: float
    cost_after: float
    new_tasks: float
    automation: float

    def labor_mass_before(self) -> float:
        return self.n - self.frontier

    def labor_mass_after(self) -> float:
        return self.n + self.new_tasks - self.frontier - self.automation

    def check_feasibility(self) -> None:
        assert self.n - 1 <= self.frontier <= self.n
        assert self.frontier <= self.cost_before
        assert (
            self.n + self.new_tasks - 1
            <= self.frontier + self.automation
            <= self.n + self.new_tasks
        )
        assert self.frontier + self.automation <= self.cost_after


def main() -> None:
    cases = (
        JointTaskCase("new tasks dominate", 1.0, 0.4, 0.8, 0.8, 0.25, 0.15),
        JointTaskCase("automation dominates", 1.0, 0.4, 0.8, 0.8, 0.08, 0.15),
    )
    for case in cases:
        case.check_feasibility()
        before = case.labor_mass_before()
        after = case.labor_mass_after()
        change = after - before
        assert isclose(change, case.new_tasks - case.automation, abs_tol=1e-12)
        assert (change > 0) == (case.new_tasks > case.automation)
        print(
            f"{case.name}: labor task mass {before:.2f} to {after:.2f}; "
            f"change {change:+.2f}"
        )


if __name__ == "__main__":
    main()
