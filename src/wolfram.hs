--
-- EPITECH PROJECT, 2020
-- FUN_wolfram_2019
-- File description:
-- wolfram
--

import System.Environment
import System.Exit
import Text.Read

transArgs :: [Maybe Int] -> [Int] -> Int -> IO [Int]
transArgs xs res index
    | (index == 0) = case (xs !! index) of
                    Nothing -> (transArgs xs (-84:res) (index + 1))
                    Just n -> if (n == 30 || n == 90 || n == 110)
                                then transArgs xs (n:res) (index + 1)
                                else (transArgs xs (-84:res) (index + 1))
    | (index == 1) = case (xs !! index) of
                    Nothing -> (transArgs xs (-84:res) (index + 1))
                    Just n -> if (n >= 0)
                                then (transArgs xs (n:res) (index + 1))
                                else (transArgs xs (-84:res) (index + 1))
    | (index == 2) = case (xs !! index) of
                    Nothing -> (transArgs xs (-84:res) (index + 1))
                    Just n -> if (n == -100)
                                then (transArgs xs (-1:res) (index + 1))
                                else if (n >= 0)
                                    then (transArgs xs (n:res) (index + 1))
                                    else (transArgs xs (-84:res) (index + 1))
    | (index == 3) = case (xs !! index) of
                    Nothing -> (transArgs xs (-84:res) (index + 1))
                    Just n -> if (n >= 0)
                                then (transArgs xs (n:res) (index + 1))
                                else (transArgs xs (-84:res) (index + 1))
    | (index == 4) = case (xs !! index) of
                    Nothing -> (transArgs xs (-84:res) (index + 1))
                    Just n -> (transArgs xs (n:res) (index + 1))
    | (index == 5) = return (reverse res)
    | otherwise    = return [-84, -84, -84, -84, -84]

insertArgs :: String -> [Maybe Int] -> Int -> [Maybe Int]
insertArgs x xs index
    | index == 0 = [readMaybe (x)::Maybe Int, xs !! 1, xs !! 2, xs !! 3, xs !! 4]
    | index == 1 = [xs !! 0, readMaybe (x)::Maybe Int, xs !! 2, xs !! 3, xs !! 4]
    | index == 2 = [xs !! 0, xs !! 1, readMaybe (x)::Maybe Int, xs !! 3, xs !! 4]
    | index == 3 = [xs !! 0, xs !! 1, xs !! 2, readMaybe (x)::Maybe Int, xs !! 4]
    | index == 4 = [xs !! 0, xs !! 1, xs !! 2, xs !! 3, readMaybe (x)::Maybe Int]
    | otherwise = [Nothing, Nothing, Nothing, Nothing, Nothing]

isWrongArgs :: [String] -> [Maybe Int] -> IO [Maybe Int]
isWrongArgs xs res
    | length xs == 0        = return res
    | head xs == "--rule"   = isWrongArgs (tail (tail xs)) $ insertArgs (head (tail xs)) res 0
    | head xs == "--start"  = isWrongArgs (tail (tail xs)) $ insertArgs (head (tail xs)) res 1
    | head xs == "--lines"  = isWrongArgs (tail (tail xs)) $ insertArgs (head (tail xs)) res 2
    | head xs == "--window" = isWrongArgs (tail (tail xs)) $ insertArgs (head (tail xs)) res 3
    | head xs == "--move"   = isWrongArgs (tail (tail xs)) $ insertArgs (head (tail xs)) res 4
    | otherwise             = return ([Nothing, Nothing, Nothing, Nothing, Nothing])

ruleFirst :: [Char] -> Char
ruleFirst xs
    | (xs == "*  ") = '*'
    | (xs == " **") = '*'
    | (xs == " * ") = '*'
    | (xs == "  *") = '*'
    | otherwise     = ' '

ruleSecond :: [Char] -> Char
ruleSecond xs
    | (xs == "** ") = '*'
    | (xs == "*  ") = '*'
    | (xs == " **") = '*'
    | (xs == "  *") = '*'
    | otherwise     = ' '

ruleThird :: [Char] -> Char
ruleThird xs
    | (xs == "** ") = '*'
    | (xs == "* *") = '*'
    | (xs == " **") = '*'
    | (xs == " * ") = '*'
    | (xs == "  *") = '*'
    | otherwise     = ' '

applyRule :: Int -> [Char] -> Char
applyRule rule xs
    | rule == 30  = ruleFirst xs
    | rule == 90  = ruleSecond xs
    | rule == 110 = ruleThird xs
    | otherwise   = ' '

createLine :: [Char] -> [Char] -> Int -> [Char]
createLine lastLine res rule = do
    let tmp = (take 3 lastLine)
    if (((length tmp) /= 3))
        then ((res))
    else createLine (tail lastLine) ((applyRule rule tmp):res) rule

mainLoop :: [Int] -> Int -> [Char] -> Int -> IO ()
mainLoop xs count lastLine gene =
    if (count == 0)
        then return ()
    else if (gene > 0)
        then (mainLoop xs (count) (reverse ((createLine (' ':' ':lastLine ++ "  ") ([]) (xs !! 0)))) (gene - 1))
    else do
        displayLine (lastLine) (xs !! 3) (xs !! 4)
        mainLoop xs (count - 1) (reverse ((createLine (' ':' ':lastLine ++ "  ") ([]) (xs !! 0)))) (gene)

main :: IO ()
main = do
    args <- getArgs
    if ((length (args) == 0) || (((length (args)) `mod` 2) /= 0))
        then myLeave "Wrong Arguments." False
    else do
        tmp <- isWrongArgs args [readMaybe ("-84")::Maybe Int, readMaybe ("0")::Maybe Int, readMaybe ("-100")::Maybe Int, readMaybe ("80")::Maybe Int, readMaybe ("0")::Maybe Int]
        stockArgs <- transArgs tmp [] 0
        if (((stockArgs !! 0) == -84) || ((stockArgs !! 1) == -84) || ((stockArgs !! 2) == -84) || ((stockArgs !! 3) == -84) || ((stockArgs !! 4) == -84))
            then myLeave "Wrong arguments." False
        else do
            mainLoop stockArgs (stockArgs !! 2) "*" (stockArgs !! 1)
            return ()

startedIndex :: Int -> Int -> Int -> Int
startedIndex win seg move
    | (((mod (seg) 2) == 0) && ((mod win 2) /= 0)) = ((((div win 2) - (div seg 2) + 1)) + move)
    | otherwise                                    = (((div win 2) - (div seg 2)) + move)

initList :: Int -> [Char] -> [Char]
initList count res
    | count > 0 = (' ':(initList (count - 1) res))
    | otherwise = res

concatRight :: Int -> [Char] -> [Char] -> [Char] -> Int -> Int -> Int -> [Char]
concatRight size ini res line currentIndex startIndex endIndex
    | (size <= currentIndex)                                                            = res
    | ((currentIndex >= startIndex) && (currentIndex < endIndex) && (length line /= 0)) = concatRight (size) (tail ini) ((head line):res) (tail line) (currentIndex + 1) startIndex endIndex            --check le '<'
    | (length ini /= 0)                                                                 = concatRight (size) (tail ini) ((head ini):res) line (currentIndex + 1) startIndex endIndex
    | otherwise                                                                         = res

concatSpe :: Int -> [Char] -> [Char] -> [Char] -> Int -> Int -> Int -> [Char]
concatSpe size ini res line currentIndex startIndex endIndex
    | (size <= currentIndex)                            = res
    | ((currentIndex < endIndex) && (length line /= 0)) = concatRight (size) (tail ini) ((head line):res) (tail line) (currentIndex + 1) startIndex endIndex            --check le '<'
    | (length ini /= 0)                                 = concatRight (size) (tail ini) ((head ini):res) line (currentIndex + 1) startIndex endIndex
    | otherwise                                         = res
    
convertStart :: [Char] -> Int -> [Char]
convertStart start count
    | (count + 1 >= 1 || length start <= 0) = start
    | otherwise                             = convertStart (tail start) (count + 1)

displayLine :: [Char] -> Int -> Int -> IO ()
displayLine str win move = do
    let started = startedIndex win (length str) move
    if (started < 1)
        then putStrLn (reverse (concatSpe win (initList win []) [] ((convertStart str started)) 0 started (started + (length str))))
    else if (started < win)
        then putStrLn (reverse (concatRight win (initList win []) [] str 0 started (started + (length str))))
    else putStrLn (initList win [])

myLeave :: [Char] -> Bool -> IO ()
myLeave x xs
    | xs == False = do
        putStrLn x
        exitWith (ExitFailure 84)
    | otherwise = exitWith (ExitSuccess)
