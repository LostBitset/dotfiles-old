module Lib
    ( checkSyncRaw
    ) where

import Control.Monad (liftM2, (<=<))
import Data.Bool (bool)
import System.Directory (copyFile)
import System.Environment (getEnv)
import System.IO (hFlush, stdout)
import System.Process (callProcess)

checkSyncRaw :: (String, String) -> IO ()
checkSyncRaw = checkSync <=< fixRawPaths

fixRawPaths :: (String, String) -> IO (FilePath, FilePath)
fixRawPaths (repoRaw, fsRaw) =
    let givenHome = \home -> ("../" ++ repoRaw, replHome fsRaw home) in
    givenHome <$> getEnv "HOME"

replHome :: FilePath -> FilePath -> FilePath
replHome ('~':xs) = (++xs)
replHome s@_ = const s

checkSync :: (FilePath, FilePath) -> IO ()
checkSync (repo, fs) =
    let isDesync = liftM2 (/=) (readFile repo) (readFile fs) in
    isDesync >>= (\x ->
        if x then handleDesync (repo, fs) else handleSync repo
    )

handleDesync :: (FilePath, FilePath) -> IO ()
handleDesync (repo, fs) = do
    putStrLn $ "[DESYNC] repo:" ++ repo ++ " differs from fs:" ++ fs
    putStr $ "[DESYNC] Should I [i]gnore this, update (r)epo, or update (f)s? "
    hFlush stdout
    resp <- getLine
    case bool resp "i" $ null resp of
        "i" -> putStrLn $ "[DESYNC] Ignored " ++ fs ++ "."
        "r" -> updateRepo (repo, fs)
        "destroy" -> (repo `copyFile` fs)
        "f" -> updateFs (repo, fs)
        _ -> putStrLn $ "[DESYNC] Invalid option. Ignored " ++ fs ++ "."

handleSync :: FilePath -> IO ()
handleSync repo =
    let name = "{repo}" ++ drop 2 repo in
    let padding = flip replicate ' ' $ 30 - length name in
    putStrLn $ "[OK]    File " ++ name ++ padding ++ " is synchronized."

updateRepo :: (FilePath, FilePath) -> IO ()
updateRepo (repo, fs) = (fs `copyFile` repo) *> syncRepo

syncRepo :: IO ()
syncRepo = (++"/bin/gitw") <$> getEnv "HOME" >>= flip callProcess ["auto"]

updateFs :: (FilePath, FilePath) -> IO ()
updateFs (repo, fs) = do
    putStrLn $ "[DESYNC] Warning: This will overwrite " ++ fs ++ " forever!"
    putStr "[DESYNC] Are you sure about this? ([no]/destroy): "
    hFlush stdout
    resp <- getLine
    if resp == "destroy" then repo `copyFile` fs else return ()

