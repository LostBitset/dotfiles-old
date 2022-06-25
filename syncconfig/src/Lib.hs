module Lib
    ( checkSync
    ) where

checkSync :: (String, String) -> IO ()
checkSync (repo, fs) =
    let isDesync = liftM2 (/=) (readFile repo) (readFile fs) in
    isDesync >>= (\x ->
        if x then handleDesync (repo, fs) else handleSync fs
    )

handleDesync :: (String, String) -> IO ()
handleDesync (repo, fs) = do
    putStrLn "[DESYNC] repo:" ++ repo ++ " differs from fs:" ++ fs
    putStr "[DESYNC] Should I [i]gnore this, update (r)epo, or update (f)s? "
    resp <- getLine
    case bool resp "i" $ (==[]) resp of
        "i" -> putStrLn "[DESYNC] Ignored " ++ fs ++ "."
	"r" -> updateRepo (repo, fs)
        "f" -> updateFs (repo, fs)
	_ -> putStrLn "[DESYNC] Invalid option. Ignored " ++ fs ++ "."

