import HornerLean.Spec
import HornerLean.CompPolyAssumptions
import CompPoly.Multivariate.CMvPolynomialEvalLemmas

-- Horner spec over ℤ agrees with CompPoly eval ("math correctness on spec layer")

namespace HornerLean

-- Horner spec over ℤ
def hornerZ : List ℤ → ℤ → ℤ
| [],      _ => 0
| c :: cs, x => c + x * hornerZ cs x

theorem eval_polyOfCoeffs_eq_hornerZ (cs : List ℤ) (x : ℤ) :
    evalAt x (polyOfCoeffs cs) = hornerZ cs x := by
  induction cs with
  | nil =>
      -- evalAt x (C 0) = 0
      simp [polyOfCoeffs, hornerZ]
  | cons c cs ih =>
      simp [polyOfCoeffs, hornerZ]
      rw [evalAt_add]
      simp
      rw [evalAt_mul]
      simp
      rw [ih]
      simp
end HornerLean
