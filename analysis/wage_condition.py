"""Transparent arithmetic check of NBER June 2017 Proposition 3's wage wedge.

Inputs are illustrative local comparative-static values, not equilibrium estimates.
"""

from dataclasses import dataclass


@dataclass(frozen=True)
class Case:
    name: str
    productivity_effect: float
    labor_share: float
    lambda_i: float
    sigma_hat: float
    labor_supply_elasticity: float

    def displacement(self) -> float:
        assert 0 < self.labor_share < 1
        assert self.lambda_i > 0 and self.sigma_hat > 0
        assert self.labor_supply_elasticity > 0
        return (1 - self.labor_share) * self.lambda_i / (
            self.sigma_hat + self.labor_supply_elasticity
        )

    def wage_response(self) -> float:
        return self.productivity_effect + (1 - self.labor_share) * self.relative_price_response()

    def rental_response(self) -> float:
        return self.productivity_effect - self.labor_share * self.relative_price_response()

    def relative_price_response(self) -> float:
        return -self.lambda_i / (
            self.sigma_hat + self.labor_supply_elasticity
        )


def main() -> None:
    cases = [
        Case("high productivity gain", 0.40, 0.60, 0.50, 1.00, 0.50),
        Case("low productivity gain", 0.05, 0.60, 0.50, 1.00, 0.50),
        Case("knife edge", 2 / 15, 0.60, 0.50, 1.00, 0.50),
    ]
    for case in cases:
        wage = case.wage_response()
        rent = case.rental_response()
        # Appendix B, equations (B9) and (B10), for a unit increase in I.
        assert abs(case.labor_share * wage + (1 - case.labor_share) * rent
                   - case.productivity_effect) < 1e-12
        assert abs(wage - rent - case.relative_price_response()) < 1e-12
        direction = "up" if wage > 1e-12 else "down" if wage < -1e-12 else "flat"
        print(f"{case.name}: P={case.productivity_effect:.6f}, "
              f"D={case.displacement():.6f}, dlnW/dI={wage:.6f} ({direction}), "
              f"dln(W/R)/dI={case.relative_price_response():.6f}")


if __name__ == "__main__":
    main()
