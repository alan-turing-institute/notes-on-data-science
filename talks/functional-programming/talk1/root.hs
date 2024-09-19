import Data.List (iterate, find)

f :: Float -> Float
f x = - x * log x - (1 - x) * log (1 - x) - x

narrowRange f (a, b) =
  let guess = (a + b) / 2.0 in
    if f guess > 0 then (guess, b) else (a, guess)

isNarrowed eps (a, b) = abs (b - a) < eps

findRoot eps a b f =
  find (isNarrowed eps) $ iterate (narrowRange f) (a, b)

main = print $ findRoot 0.001 0.5 0.99 f
