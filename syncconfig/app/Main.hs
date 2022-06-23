module Main where

import Lib

import Control.Arrow (second)
import Data.List (elemIndex)
import System.IO (hPutStrLn, stderr)

main :: IO ()
main =
  let items = parseLines <$> readFile "../reg.txt" in
  let ap = handleMaybe (hPutStrLn stderr "Parser error") in
  mapM_ checkSync `ap` items

parseLines :: String -> Maybe [(String, String)]
parseLines = sequence . (parseLine <$>) . lines

parseLine :: String -> Maybe (String, String)
parseLine x = second tail . flip splitAt x <$> elemIndex ' ' x

handleMaybe :: (Monad m) => m a -> (b -> m a) -> m (Maybe b) -> m a
handleMaybe n s x = do m <- x; case m of Just a -> s a; Nothing -> n

