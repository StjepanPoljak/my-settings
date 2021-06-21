module XRandr (findRes) where

import Control.Monad (mapM, foldM, (<$!>), (<=<))
import Data.Maybe (catMaybes, listToMaybe)
import XString (splitString)

getCurrRes :: String -> Maybe String
getCurrRes str = getCurrResStep str "" True

    where getCurrResStep :: String -> String -> Bool -> Maybe String
          getCurrResStep [] part _ = Nothing
          getCurrResStep (x:xs) part state = case x of
            ' '     -> getCurrResStep xs part (null part)
            '*'     -> Just part
            _       -> case state of
                            True    -> getCurrResStep xs (part ++ [x]) state
                            False   -> getCurrResStep xs part state

readToInt :: String -> Maybe Int
readToInt str = case reads str :: [(Int, String)] of
                    [(val, "")]     -> Just val
                    _               -> Nothing

findRes :: String -> Maybe (Int, Int)
findRes str = (\x -> if length x == 2
                     then Just (x !! 0, x !! 1)
                     else Nothing)
          <=< (\x -> sequence
                   . map readToInt
                   $ splitString x 'x')
          <=< listToMaybe
            . catMaybes
            . map getCurrRes
            $ splitString str '\n'
