euclid a b
  | a == b    = a
  | a > b     = euclid (a - b) b
  | otherwise = euclid a (b - a)

main = do
  print $ euclid 32 24 
