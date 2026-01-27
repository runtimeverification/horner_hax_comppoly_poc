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
      -- goal: evalAt x (polyOfCoeffs []) = hornerZ [] x
      -- polyOfCoeffs [] = C 0, hornerZ [] x = 0
      simp [polyOfCoeffs, hornerZ, evalAt, C]
      -- `simp` will use `eval_C_simp` through `evalAt_C`
      sorry
  | cons c cs ih =>
      -- Unfold definitions into a form where simp can use eval_add/eval_mul,
      -- and our simp lemmas evalAt_C/evalAt_X0.
      -- polyOfCoeffs (c::cs) = C c + X0 * polyOfCoeffs cs
      -- hornerZ (c::cs) x = c + x * hornerZ cs x
      simp [polyOfCoeffs, hornerZ, evalAt, C, X0, ih]
      -- Explanation:
      -- - `simp` reduces evalAt of sum/product using eval_add/eval_mul
      -- - reduces evalAt(C c) using evalAt_C
      -- - reduces evalAt(X0) using evalAt_X0
      -- - uses IH for evalAt(polyOfCoeffs cs)
      sorry
end HornerLean
