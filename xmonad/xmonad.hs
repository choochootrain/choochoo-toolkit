import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName

import Graphics.X11.ExtraTypes.XF86
import Data.Monoid
import System.IO
import System.Exit

main :: IO ()
main = do
    h <- spawnPipe "xmobar"
    xmonad $ ewmh defaultConfig
        { terminal           = "xterm"
        , modMask            = myModMask
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , handleEventHook    = handleEventHook defaultConfig <+> fullscreenEventHook
        , logHook            = composeAll
                                [ dynamicLogWithPP $ xmobarPP
                                                  { ppTitle  = const ""
                                                  , ppLayout = xmobarColor myFocusedBorderColor "" . myLayoutString
                                                  , ppSep    = " | "
                                                  , ppOutput = hPutStrLn h
                                                  }
                                , setWMName "LG3D"
                                ]
        } `removeKeys` myUnusedKeys `additionalKeys` myExtraKeys

-- Use alt key as mod
myModMask            = mod1Mask

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#888888"
myFocusedBorderColor = "#3388ff"

-- Be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
myLayout = avoidStruts . smartBorders $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- Behave nicely with fullscreened windows
myManageHook = isFullscreen --> doFullFloat

myUnusedKeys =
    [
    -- dmenu
      (mod, xK_p)

    -- gmrun
    , (mod .|. shift, xK_p)
    ] where mod   = myModMask
            shift = shiftMask

myExtraKeys =
    [
    -- launch dmenu with pretty params
      ((mod, xK_p),
        safeSpawn "dmenu_run"
          [ "-h", "15"
          , "-x", "80"
          , "-w", "500"
          , "-nb", myBarColor
          , "-nf", myBarFontColor
          , "-sb", myFocusedBorderColor
          , "-sf", myBarColor
          , "-p", ">"
          ]
      )

    -- lock screen
    , ((mod .|. shift, xK_l),
        safeSpawn "slimlock" []
      )

    -- toggle xmobar
    , ((mod, xK_b),
        sendMessage ToggleStruts
      )

    -- raise volume
    , ((0, xF86XK_AudioRaiseVolume),
        safeSpawn "amixer" ["set", "Master", "5%+", "unmute"]
      )

    -- lower volume
    , ((0, xF86XK_AudioLowerVolume),
        safeSpawn "amixer" ["set", "Master", "5%-", "unmute"]
      )

    -- mute volume
    , ((0, xF86XK_AudioMute),
        safeSpawn "amixer" ["set", "Master", "toggle"]
      )

    -- increase backlight brightness
    , ((0, xF86XK_MonBrightnessUp),
        safeSpawn "xbacklight" ["-inc", "15"]
      )

    -- decrease backlight brightness
    , ((0, xF86XK_MonBrightnessDown),
        safeSpawn "xbacklight" ["-dec", "15"]
      )

    -- take a screenshot of entire display
    , ((0, xK_Print),
        safeSpawn "scrot" ["screen_%Y-%m-%d-%H-%M-%S.png", "-d", "1"]
      )

    -- take a screenshot of focused window
    , ((mod, xK_Print),
        safeSpawn "scrot" ["window_%Y-%m-%d-%H-%M-%S.png", "-d", "1", "--select"]
      )

    -- rotate background
    , ((mod .|. shift, xK_b),
        safeSpawn "/home/hp/.fehbg" []
      )
    ] where mod            = myModMask
            shift          = shiftMask
            myBarColor     = "#0f0f0f"
            myBarFontColor = "#839496"

-- Show spectrwm layout symbols
myLayoutString x = case x of
              "Tall"        -> "[|]"
              "Mirror Tall" -> "[-]"
              "Full"        -> "[ ]"
              _             -> x
