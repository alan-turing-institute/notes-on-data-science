
sumVals :: Num a => [a] -> a

sumVals [] = 0
sumVals (x:xs) = x + sumVals xs

main = print $ sumVals [1, 3, 2, 8, 23, 1, 104]


sumVals' :: Num a => [a] -> a

sumVals' = foldl (+) 0 

