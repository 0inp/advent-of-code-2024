import Data.Char(digitToInt)

-- utils section. A package might do this already.
-- window function : pairs each element with its next neighbour
-- ex: window [1,2,3,4] -> [(1,2), (2,3),(3,4)]
window :: [Integer] -> [(Integer, Integer)]
window [] = []
window xs = zip xs (tail xs)

-- deleteN function : delete th nth element of a list
-- ex: deleteN 2 [1,2,3,4] -> [1,2,4]
deleteN :: Int -> [a] -> [a]
deleteN _ [] = []
deleteN i (a:as) | i == 0    = as
                 | otherwise = a : deleteN (i-1) as

-- isSorted function: tells if a list of integers is sorted either ascending or descending
-- ex: isSorted [1, 2, 3] -> True
-- ex: isSorted [3, 2, 1] -> True
-- ex: isSorted [1, 3, 2] -> False
isSorted :: [Integer] -> Bool
isSorted xs = (and [x <= y | (x, y) <- windowedList]) || (and [x >= y | (x, y) <- windowedList])
              where windowedList = window xs

-- main function of the module
main :: IO ()
main = do
  fileContent <- readFile "input.txt"
  print (countSafe (processFile fileContent) )

-- processFile function : read the file line by line and return a list of integer
-- obviously, this is relevent regarding the input file
processFile :: String -> [[Integer]]
processFile s = [map read a :: [Integer] | a <- map words (lines s)]

-- countSafe function : says how many reports are safe
countSafe :: [[Integer]] -> Integer
countSafe xs = sum [1 | x <- map isOneVariantSafe xs, x == True]

-- isOneVariantSafe function : checks if a list or one of its variants is "safe".
-- one variant is the original list where we removed one of its element.
isOneVariantSafe :: [Integer] -> Bool
isOneVariantSafe [] = True
isOneVariantSafe original = or [isSafe variant | variant <- variants]
                            where variants = original : [deleteN i original | i <- [0..length original - 1]]

-- isSafe function : checks if a list of Integer is "safe".
-- This means if the list sorted and if the difference between each element and its neighbour is 1, 2 or 3
--ex: isSafe [1,2,3] -> True
--ex: isSafe [1,3,2] -> False
--ex: isSafe [7,3,1] -> False
isSafe :: [Integer] -> Bool
isSafe [] = True
isSafe xs | isSorted xs = and [0 < abs(x-y) && abs(x-y) <= 3 | (x, y) <- window xs]
          | otherwise   = False
