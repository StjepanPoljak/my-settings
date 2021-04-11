import XMonad
import XRDB
import XMonad.Util.Run

main = (\x -> xmonad (myConfig x)) =<< runProcessWithInput "xrdb" ["-query"] ""

myConfig xrdbout = def
      { terminal = "xterm"
      , borderWidth = 2
      , normalBorderColor = getXRDBKey xrdbout "color0"
      , focusedBorderColor = getXRDBKey xrdbout "color8"
      , modMask = mod4Mask
      }
