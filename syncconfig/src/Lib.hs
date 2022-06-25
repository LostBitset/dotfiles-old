module Lib
    ( checkSync
    ) where

import Control.Monad (liftM2)
import Data.Bool (bool)

checkSync :: (String, String) -> IO ()
checkSync (repo, fs) =
    let isDesync = liftM2 (/=) (readFile repo) (readFile fs) in
    isDesync >>= (\x ->
        if x then handleDesync (repo, fs) else handleSync fs
    )

handleDesync :: (String, String) -> IO ()
handleDesync (repo, fs) = do
    putStrLn $ "[DESYNC] repo:" ++ repo ++ " differs from fs:" ++ fs
    putStr $ "[DESYNC] Should I [i]gnore this, update (r)epo, or update (f)s? "
    resp <- getLine
    case bool resp "i" $ (==[]) resp of
        "i" -> putStrLn $ "[DESYNC] Ignored " ++ fs ++ "."
	"r" -> updateRepo (repo, fs)
        "f" -> updateFs (repo, fs)
	_ -> putStrLn $ "[DESYNC] Invalid option. Ignored " ++ fs ++ "."

handleSync :: String -> IO ()
handleSync fs = putStrLn $ "[OK]    File " ++ fs ++ " is synchronized."

updateRepo :: (String, String) -> IO ()
updateRepo (repo, fs) = putStrLn $ "!! <dbg> repo:" ++ repo ++ " <- fs:" ++ fs

updateFs :: (String, String) -> IO ()
updateFs (repo, fs) = putStrLn $ "!! <dbg> fs:" ++ fs ++ " <- repo:" ++ repo

