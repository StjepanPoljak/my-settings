module XRDB ( getXRDBKey ) where

import qualified Data.Map as M

getXRDBKey :: String -> String -> String
getXRDBKey xrdbout key = (createMap $ splitString xrdbout '\n') M.! key

createMap :: [String] -> M.Map String String
createMap strl = M.fromList
               $ map (\x -> case x of
                              Just (k, v) -> (pruneKey k, v))
               . filter (\x -> case x of
                                 Nothing -> False
                                 Just _ -> True)
               . map (\str -> let res = splitString str '\t'
                              in case res of
                                 [x, y] -> Just (x, y)
                                 _ -> Nothing)
               $ strl

pruneKey :: String -> String
pruneKey "" = ""
pruneKey [x] = [x]
pruneKey [x, y] = [x, y]
pruneKey (x:y:xs)
   | last xs == ':' = pruneKey $ x:y:init xs
   | (x == '*') && (y == '.') = pruneKey xs
   | otherwise = x:y:xs

splitString :: String -> Char -> [String]
splitString str char = splitStringStep str char ""

splitStringStep :: String -> Char -> String -> [String]
splitStringStep "" _ tmp = [tmp]
splitStringStep (x:xs) char tmp
    | x == char = [tmp] ++ splitStringStep xs char ""
    | otherwise = splitStringStep xs char (tmp ++ [x])
