import Data.List(findIndices)

-- e01 function: exercise 01
e01 :: IO ()
e01 = do
  fileContent <- readFile "input.txt"
  let lines = processFile fileContent

  let allPositionByLineIndex = [(i,x) | (i, x) <- zip [0..] (map (\line -> findPosCharInLine 'X' line) lines)]

  let rightLookPositions = [('X', 0, 0), ('M', 0, 1), ('A', 0, 2), ('S', 0, 3)]
  let leftLookPositions = [('X', 0, 0), ('M', 0, (-1)), ('A', 0, (-2)), ('S', 0, (-3))]
  let upLookPositions = [('X', 0, 0), ('M', 1, 0), ('A', 2, 0), ('S', 3, 0)]
  let downLookPositions = [('X', 0, 0), ('M', (-1), 0), ('A', (-2), 0), ('S', (-3), 0)]
  let rightUpLookPositions = [('X', 0, 0), ('M', 1, 1), ('A', 2, 2), ('S', 3, 3)]
  let rightDownLookPositions = [('X', 0, 0), ('M', (-1), 1), ('A', (-2), 2), ('S', (-3), 3)]
  let leftUpLookPositions = [('X', 0, 0), ('M', 1, (-1)), ('A', 2, (-2)), ('S', 3, (-3))]
  let leftDownLookPositions = [('X', 0, 0), ('M', (-1), (-1)), ('A', (-2), (-2)), ('S', (-3), (-3))]
  let lookPositionsList = [rightLookPositions, leftLookPositions, upLookPositions, downLookPositions, leftUpLookPositions, leftDownLookPositions, rightUpLookPositions, rightDownLookPositions]
  -- For every direction, looks if the word XMAS is present. Then sum the occurences.
  print (sum [metaCheck i x lookPositions lines | (i,x) <- allPositionByLineIndex, lookPositions <- lookPositionsList])

-- processFile function : read the file line by line and return a list of integer
-- obviously, this is relevent regarding the input file
processFile :: String -> [[Char]]
processFile s = [a | a <- lines s]

-- findPosCharInLine function : from a line, return the list of positions of the char c
findPosCharInLine :: Char -> String -> [Int]
findPosCharInLine c line = findIndices (\x -> x==c) line

-- isPosEqualToChar function : returns a True or False if the char checked at one position is equal to the char we want.
isPosEqualToChar :: Char -> Int -> Int -> [String] -> Bool
isPosEqualToChar c i j lines | i < 0 = False
                  | i >= length lines = False
                  | j < 0 = False
                  | j >= length (lines!!i) = False
                  | otherwise  = if (lines!!i)!!j == c then True else False

-- metaCheck function : returns 1 if the word XMAS is in the looked positions
metaCheck :: Int -> [Int] -> [(Char, Int, Int)] -> [String] -> Int
metaCheck lineIndex xPositions lookPositions lines = sum [if and [isPosEqualToChar c (lineIndex + lIndexOffset) (pos + posOffset) lines | (c, lIndexOffset, posOffset) <- lookPositions] then 1 else 0 | pos <- xPositions]

-- e02 function: exercise 02
e02 :: IO ()
e02 = do
  fileContent <- readFile "input.txt"
  let lines = processFile fileContent

  let allPositionByLineIndex = [(i,x) | (i, x) <- zip [0..] (map (\line -> findPosCharInLine 'A' line) lines)]

  print (sum [metaCheck2 i x lines | (i,x) <- allPositionByLineIndex])

checkMASWord :: String -> Int -> Int -> [String] -> Bool
checkMASWord start lineIndex posA lines | start == "leftTop" = (isPosEqualToChar 'M' (lineIndex - 1) (posA - 1) lines) && (isPosEqualToChar 'S' (lineIndex + 1) (posA + 1) lines)
                                        | start == "rightBottom" = (isPosEqualToChar 'M' (lineIndex + 1) (posA + 1) lines) && (isPosEqualToChar 'S' (lineIndex - 1) (posA - 1) lines)
                                        | start == "rightTop" = (isPosEqualToChar 'M' (lineIndex - 1) (posA + 1) lines) && (isPosEqualToChar 'S' (lineIndex + 1) (posA - 1) lines)
                                        | start == "leftBottom" = (isPosEqualToChar 'M' (lineIndex + 1) (posA - 1) lines) && (isPosEqualToChar 'S' (lineIndex - 1) (posA + 1) lines)
                                        | otherwise = False

-- metaCheck2 function : returns 1 if the word XMAS is in the looked positions
metaCheck2 :: Int -> [Int] -> [String] -> Int
metaCheck2 lineIndex aPositions lines = sum [if ((checkMASWord "leftTop" lineIndex posA lines) || (checkMASWord "rightBottom" lineIndex posA lines)) && ((checkMASWord "rightTop" lineIndex posA lines) || (checkMASWord "leftBottom" lineIndex posA lines)) then 1 else 0| posA <- aPositions]
