module Lib
    ( run
    ) where

import System.Environment (getArgs)
import Control.Monad (foldM_)

run :: IO ()
run = do
  args <- getArgs
  content <- readFile $ head args
  executeProgram content

executeProgram :: [Char] -> IO ()
executeProgram program = foldM_ go 0 program
  where
    go accum 'H' = do putStr "Hello, world!"; return accum;
    go accum 'h' = do putStr "Hello, world!"; return accum;
    go accum 'Q' = do putStr program; return accum;
    go accum 'q' = do putStr program; return accum;
    go accum '9' = do print99; return accum;
    go accum '+' = return $ accum + 1
    go accum _ = return accum

print99 :: IO ()
print99 = mapM_ go [99,98..0]
  where
    go 1 = do
          putStrLn "1 bottle of beer on the wall, 1 bottle of beer."
          putStrLn "Take one down and pass it around, no more bottles of beer on the wall."
          putStrLn ""
    go 0 = do
          putStrLn "No more bottles of beer on the wall, no more bottles of beer."
          putStrLn "Go to the store and buy some more, 99 bottles of beer on the wall."
    go val = do
          putStrLn $ (show val) ++ " bottles of beer on the wall, " ++ (show val) ++ " bottles of beer."
          putStrLn $ "Take one down and pass it around, " ++ (show $ val - 1) ++ " bottles of beer on the wall."
          putStrLn ""
