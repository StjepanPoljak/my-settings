import XMonad
import XRDB
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMobar
import XString

import qualified XMonad.StackSet as S
import XMonad.Util.NamedWindows (getName, NamedWindow)

import System.IO
import Control.Monad

maxTitleLength :: Int
maxTitleLength = 24

main = (\xrdb -> xmonad =<< xmobar' (myConfig xrdb) (customDzen xrdb) xrdb)
   =<< runProcessWithInput "xrdb" ["-query"] ""

customDzen :: String -> PP
customDzen xrdb = def
    { ppCurrent     = xmobarBox
                    . xmobarColor (fontColor xrdb) (fgColor xrdb ++ ":0")
                    . pad
    , ppHidden      = xmobarColor (fontColor xrdb) (bgColor xrdb)
                    . pad
    , ppHiddenNoWindows = const ""
    , ppSep         = " "
    , ppWsSep       = " "
    , ppLayout      = xmobarColor (fontColor xrdb) (bgColor xrdb)
                    . (\x -> wrap "[" "]" . pad $ case x of
                         "TilePrime Horizontal"  -> "TTT"
                         "TilePrime Vertical"    -> "[]="
                         "Hinted Full"           -> "[ ]"
                         _                       -> x)
    , ppOrder       = \[ws, l, curr ] -> [ws, curr, l]
    , ppTitle       = xmobarBox
                    . xmobarColor (fontColor xrdb) (fgColor xrdb ++ ":0")
                    . pad
                    . leftAlignString maxTitleLength
                    . cutString maxTitleLength
    , ppExtras      = [ ]
    }

myConfig xrdbout = def
      { terminal = "xterm"
      , borderWidth = 2
      , normalBorderColor = fgColor xrdbout
      , focusedBorderColor = fontColor xrdbout
      , modMask = mod4Mask
      }

