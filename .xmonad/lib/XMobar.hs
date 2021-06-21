{-# LANGUAGE FlexibleContexts #-}

module XMobar (xmobar') where

import XMonad
import XMonad.Core
import XMonad.Layout.LayoutModifier
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog

import qualified Data.Map as M
import Control.Monad (liftM2)

import XRDB

toggleXMobarKey (XConfig {modMask = modKey}) = (modKey, xK_b)

xmobar' :: LayoutClass l Window => XConfig l -> PP -> String
        -> IO (XConfig (ModifiedLayout AvoidStruts l))
xmobar' conf pp xrdb = statusBar ("xmobar" ++ flags)
                       pp toggleXMobarKey conf
    where flags = " -B '" ++ (bgColor xrdb) ++ "'"
               ++ " -F '" ++ (fontColor xrdb) ++ "'"
               ++ " -f '" ++ (fontName xrdb) ++ "'"
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
                   ++ " ] 50"
                   ++ " , Run ComX \"accuweather\" ["
                           ++ "  \"Osijek\" "
                           ++ ", \"" ++ (lowColor xrdb) ++ "\""
                           ++ ", \"" ++ (errColor xrdb) ++ "\""
                           ++ "] \"N/A\" \"accuweather\" 36000"
               ++ " ]' "
