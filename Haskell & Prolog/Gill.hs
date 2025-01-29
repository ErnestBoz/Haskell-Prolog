module Main where
import Data.List (permutations)



--ANSWERS
number :: [Int] -> Int
number = foldl (\acc x -> acc * 10 + x) 0


generator1 :: [([Int], [Int], [Int])]
generator1 = [(take 3 p, take 3 (drop 3 p), take 3 (drop 6 p)) | p <- permutations[0..9]]

isPrime :: Int -> Bool
isPrime n
    | n < 2     = False
    | otherwise = null [x | x <- [2..(floor . sqrt . fromIntegral) n], n `mod` x == 0]


selector1 :: ([Int], [Int], [Int]) -> Bool
selector1 (s1, s2, s3) =
    let num1 = number s1
        num2 = number s2
        num3 = number s3
        primes = all isPrime [num1, num2, num3]
        oddSums = odd (sum s1) && odd (sum s2) && odd (sum s3)
        equallySpaced =  (num2 - num1) == (num3 - num2)  
    in primes && equallySpaced && oddSums



--MAIN
main :: IO ()
main = do

  
  putStrLn "Answer to the teaser is: "
  print(filter selector1 generator1)