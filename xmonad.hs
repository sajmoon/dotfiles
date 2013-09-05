import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig()
import XMonad.Config.Gnome
import System.IO

-- main = xmonad gnomeConfig
--  { modMask = mod4Mask
--  }

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig 
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook    = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle  = xmobarColor "green" "" . shorten 50
      }
    , modMask = mod4Mask --rebind Mod to winKey
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    , ((mod4Mask, xK_p), spawn "dmenu_run -b -nb black") 
    ]
