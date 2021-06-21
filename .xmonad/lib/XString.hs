module XString (splitString, cutString, centerString) where

splitString :: String -> Char -> [String]
splitString str char = splitStringStep str char ""
    where splitStringStep :: String -> Char -> String -> [String]
          splitStringStep "" _ tmp = [tmp]
          splitStringStep (x:xs) char tmp
            | x == char = [tmp] ++ splitStringStep xs char ""
            | otherwise = splitStringStep xs char (tmp ++ [x])

cutString :: Int -> String -> String
cutString n str
    | n <= 3            = str
    | length str > n    = take (n - 3) str ++ "..."
    | otherwise         = str

repeatChar :: Int -> Char -> String
repeatChar 0 _ = ""
repeatChar n c = c:repeatChar (n - 1) c

centerString :: Int -> String -> String
centerString n str
    | strlen == 0       = ""
    | wspace <= 0       = str
    | otherwise         = (repeatChar startp ' ') ++ str
                       ++ (repeatChar (n - startp - strlen) ' ')
    where strlen = length str
          wspace = n - strlen
          hspace = wspace `div` 2
          startp = hspace
