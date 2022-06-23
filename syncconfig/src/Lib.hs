module Lib
    ( checkSync
    ) where

checkSync :: (String, String) -> IO ()
checkSync (repo, fs) = putStrLn $ repo ++ " <--?--> " ++ fs

