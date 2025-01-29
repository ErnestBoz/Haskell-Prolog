module Main where



--ANSWERS
digits :: Int -> [Int]
digits 0 = [0] 
digits n
  | n < 0     = digits (-n) 
  | otherwise = if n < 10 then [n]  
                else digits (n `div` 10) ++ [n `mod` 10]


hasCommonLetters :: String -> String -> Bool
hasCommonLetters [] _ = False
hasCommonLetters (x:xs) str2
  | x `elem` str2 = True
  | otherwise     = hasCommonLetters xs str2


checkAllPairs :: [(String, String)] -> [Int] -> Bool
checkAllPairs [] _ = True 
checkAllPairs ((name1, name2):rest) ages =
  let age1 = mapNames name1 ages
      age2 = mapNames name2 ages
  in hasCommonDigits age1 age2 && checkAllPairs rest ages  


checkAllPairsX :: [(String, String)] -> [Int] -> Bool
checkAllPairsX [] _ = True
checkAllPairsX ((name1, name2):rest) ages =
  let age1 = mapNames name1 ages
      age2 = mapNames name2 ages
  in not (hasCommonDigits age1 age2) && checkAllPairsX rest ages

allSatisfying :: [String] -> [Int] -> Bool
allSatisfying names ages = checkAllPairs (pairsWithCommonLetters names) ages

allnotSatisfying :: [String] -> [Int] -> Bool
allnotSatisfying names ages = checkAllPairsX (pairsWithoutCommonLetters names) ages



hasCommonDigits :: Int -> Int -> Bool
hasCommonDigits age1 age2 = 
  let sq1 = age1 ^ 2
      sq2 = age2 ^ 2
      digits1 = digits sq1
      digits2 = digits sq2
  in any (\d -> d `elem` digits2) digits1

mapNames :: String -> [Int] -> Int
mapNames name values = case name of
    "alan"   -> values !! 0
    "cary"   -> values !! 1
    "james"  -> values !! 2
    "lucy"   -> values !! 3
    "nick"   -> values !! 4
    "ricky"  -> values !! 5
    "steve"  -> values !! 6
    "victor" -> values !! 7


pairsWithCommonLetters :: [String] -> [(String, String)]
pairsWithCommonLetters names = 
    [ (name1, name2) 
    | name1 <- names, name2 <- names, name1 < name2, hasCommonLetters name1 name2 
    ]


pairsWithoutCommonLetters :: [String] -> [(String, String)]
pairsWithoutCommonLetters names = 
    [ (name1, name2) 
    | name1 <- names, name2 <- names, name1 < name2, not (hasCommonLetters name1 name2) 
    ]

names :: [String]
names = ["alan", "cary", "james", "lucy", "nick", "ricky", "steve", "victor"]



selector2 :: (Int, Int, Int, Int, Int, Int, Int, Int) -> Bool
selector2 (a1, a2, a3, a4, a5, a6, a7, a8) = 
  let ages = [a1, a2, a3, a4, a5, a6, a7, a8]
      
  in (allSatisfying names ages) && (allnotSatisfying names ages)





validNumbers :: [Int]
validNumbers = [13,14,16,17,18,19,23,24,25,27,28,29,31]


-- functions to get validNumbers
-- isValidTuple :: (Int, Int, Int, Int, Int, Int, Int, Int) -> Bool
-- isValidTuple (a1, a2, a3, a4, a5, a6, a7, a8) = a4 <= minimum [a1, a2, a3, a5, a6, a7, a8]

-- distinctDigits :: Int -> Bool
-- distinctDigits n = length (show n) == length (nub (show n))


generator2 :: [(Int, Int, Int, Int, Int, Int, Int, Int)]
generator2 = filter (\(a1, a2, a3, a4, a5, a6, a7, a8) -> a4 <= minimum [a1, a2, a3, a5, a6, a7, a8]) validTuples 
  where                                                                                                           
    validTuples = [(a1, a2, a3, a4, a5, a6, a7, a8) |  
                   a1 <- validNumbers,
                   a2 <- validNumbers, a2 /= a1,
                   a3 <- validNumbers, a3 /= a1, a3 /= a2,
                   a4 <- validNumbers, a4 /= a1, a4 /= a2, a4 /= a3,
                   a5 <- validNumbers, a5 /= a1, a5 /= a2, a5 /= a3, a5 /= a4,
                   a6 <- validNumbers, a6 /= a1, a6 /= a2, a6 /= a3, a6 /= a4, a6 /= a5,
                   a7 <- validNumbers, a7 /= a1, a7 /= a2, a7 /= a3, a7 /= a4, a7 /= a5, a7 /= a6,
                   a8 <- validNumbers, a8 /= a1, a8 /= a2, a8 /= a3, a8 /= a4, a8 /= a5, a8 /= a6, a8 /= a7]



--MAIN
main :: IO ()
main = do


    putStrLn "Answer to the teaser is: "
    print(filter selector2 generator2)

    













