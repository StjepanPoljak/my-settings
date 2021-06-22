{-# LANGUAGE FlexibleContexts #-}

module XMobar (xmobar', xmobarBox) where

import XMonad
import XMonad.Layout.LayoutModifier
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

import XRDB

xmobarBox :: String -> String
xmobarBox str = "<box>" ++ str ++ "</box>"

toggleXMobarKey (XConfig {modMask = modKey}) = (modKey, xK_b)

fontSettings :: Bool -> Bool -> String -> String
fontSettings compact xft xrdb = " -f '" ++ (if xft then "xft:" else "")
                         ++ (fontName xrdb) ++ ":pixelsize="
                         ++ (if compact then "12" else (fontSize xrdb))
                         ++ "'"

xmobar' :: LayoutClass l Window => XConfig l -> PP -> String
        -> IO (XConfig (ModifiedLayout AvoidStruts l))
xmobar' conf pp xrdb = statusBar ("xmobar" ++ flags)
                       pp toggleXMobarKey conf
    where flags = " -B '" ++ (bgColor xrdb) ++ "'"
               ++ " -F '" ++ (fontColor xrdb) ++ "'"
               ++ fontSettings True True xrdb
               ++ " -p Top"
               ++ " -d -r -v"
               ++ " -t '%UnsafeStdinReader%"
                   ++ " }{ [ %accuweather% ] %dynnetwork% %battery% %date%'"
               ++ " -c '[ "
                   ++ " Run UnsafeStdinReader"
                   ++ " , Run Date "
                           ++ "\"%H:%M:%S (W%V) %d.%m.%Y.\""
                           ++ " \"date\" 50"
                   ++ " , Run Battery ["
                           ++ "  \"-x\", \"\""
                           ++ ", \"-t\", \"[ <acstatus> <left> ]\""
                           ++ ", \"-l\", \"" ++ (errColor xrdb) ++ "\""
                           ++ ", \"-h\", \"" ++ (okColor xrdb) ++ "\""
                           ++ ", \"--\""
                           ++ ", \"-O\", \"POW\""
                           ++ ", \"-i\", \"IDL\""
                           ++ ", \"-o\", \"BAT\""
                           ++ ", \"-P\""
                   ++ " ] 150"
                   ++ " , Run DynNetwork [ "
                           ++ "  \"-x\", \"[ <fc=" ++ (errColor xrdb)
                           ++ ">Offline</fc> ]\""
                           ++ ", \"-t\", \"[ <fc=" ++ (okColor xrdb)
                           ++ "><dev> <rx>KB/<tx>KB</fc> ]\""
                   ++ " ] 150"
                   ++ " , Run ComX \"accuweather\" ["
                           ++ "  \"Osijek\" "
                           ++ ", \"" ++ (lowColor xrdb) ++ "\""
                           ++ ", \"" ++ (okColor xrdb) ++ "\""
                           ++ ", \"" ++ (warnColor xrdb) ++ "\""
                           ++ ", \"" ++ (errColor xrdb) ++ "\""
                           ++ "] \"N/A\" \"accuweather\" 36000"
               ++ " ]' "
