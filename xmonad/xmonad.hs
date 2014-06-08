import XMonad
import XMonad.Actions.PhysicalScreens
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.NoBorders
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run
import XMonad.Util.EZConfig

import Data.List
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.IO

import qualified XMonad.StackSet as W

main :: IO ()
main = do
  h <- spawnPipe "xmobar"
  xmonad $ ewmh $ withUrgencyHook NoUrgencyHook $ defaultConfig
    { terminal           = myTerminal
    , modMask            = myModMask
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , handleEventHook    = myEventHook
    , logHook            = myLogHooks h
    } `removeKeys` myUnusedKeys `additionalKeys` myExtraKeys

-- Use user's bin directory for scripts
myScriptDir          = "/home/hp/bin/"

-- Use alt key as mod
myModMask            = mod1Mask

-- Use xterm as terminal
myTerminal           = "xterm"

-- Xmobar configuration values and color
myNormalBorderColor  = "#888888"
myFocusedBorderColor = "#3388ff"
myBarColor           = "#0f0f0f"
myBarFontColor       = "#839496"
myBarHeight          = 15



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
myManageHook = isFullscreen --> myDoFullFloat
  where
    myDoFullFloat :: ManageHook
    myDoFullFloat = doFullFloat
myEventHook = handleEventHook defaultConfig  <+> fullscreenEventHook


myLogHooks = \h -> composeAll
              [ myXmobarPP h
              , setWMName "LG3D"
              ]

myXmobarPP = \h -> dynamicLogWithPP $ xmobarPP
               { ppTitle  = const ""
               , ppLayout = xmobarColor myFocusedBorderColor "" . myLayoutString
               , ppUrgent = xmobarColor myNormalBorderColor myFocusedBorderColor
               , ppSep    = " | "
               , ppOutput = hPutStrLn h
               }


myUnusedKeys =
    [
    -- dmenu
      (mod, xK_p)

    -- gmrun
    , (mod .|. shift, xK_p)

    -- remove screen keybindings
    , (mod, xK_w)
    , (mod, xK_e)
    , (mod, xK_r)
    ] where mod   = myModMask
            shift = shiftMask

myExtraKeys =
    [
    -- launch shell prompt
      ((mod, xK_p),
        shellPrompt dmenuXPConfig
      )

    -- launch network prompt
    , ((mod, xK_n),
        networkPrompt "/etc/network.d" "wlan0-" dmenuXPConfig
      )

    -- launch password prompt
    , ((mod .|. shift, xK_p),
        passwordPrompt "/home/hp/.password-store/" ".gpg" dmenuXPConfig
      )

    -- launch firefox
    , ((mod, xK_f),
        safeSpawn "firefox" []
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
        safeSpawnScript "volume.sh" ["up"]
      )

    -- lower volume
    , ((0, xF86XK_AudioLowerVolume),
        safeSpawnScript "volume.sh" ["down"]
      )

    -- toggle volume
    , ((0, xF86XK_AudioMute),
        safeSpawnScript "volume.sh" ["toggle"]
      )

    -- increase backlight brightness
    , ((0, xF86XK_MonBrightnessUp),
        safeSpawn "xbacklight" ["-inc", "5"]
      )

    -- decrease backlight brightness
    , ((0, xF86XK_MonBrightnessDown),
        safeSpawn "xbacklight" ["-dec", "5"]
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
        safeSpawnScript "fehbg" []
      )

    -- turn external monitor on
    , ((mod, xK_m),
        safeSpawnScript "monitor.sh" ["vga"]
      )

    -- turn external monitor off
    , ((mod .|. shift, xK_m),
        safeSpawnScript "monitor.sh" ["off"]
      )
    ]

    ++

    [
      ((mod .|. mask, key), f sc)
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, mask) <- [(viewScreen, 0), (sendToScreen, shift)]
    ]

    where mod                       = myModMask
          shift                     = shiftMask
          safeSpawnScript name args = safeSpawn (myScriptDir ++ name) args

-- Show spectrwm layout symbols
myLayoutString x = case x of
              "Tall"        -> "[|]"
              "Mirror Tall" -> "[-]"
              "Full"        -> "[ ]"
              _             -> x

-- Use dmenu-style shell prompt
dmenuXPConfig = defaultXPConfig
                { bgColor           = myBarColor
                , fgColor           = myBarFontColor
                , fgHLight          = myBarColor
                , bgHLight          = myFocusedBorderColor
                , promptBorderWidth = 0
                , position          = Top
                , height            = myBarHeight
                }

data Network = Network

instance XPrompt Network where
  showXPrompt Network = "Connect: "

networkPrompt dir prefix c = mkXPrompt Network c (getNetworkComplFromDirIgnoring dir prefix) connect
  where
    getNetworkComplFromDirIgnoring :: String -> String -> String -> IO [String]
    getNetworkComplFromDirIgnoring dir prefix s = do
      networks <- getNetworks dir prefix
      return $ [ network | network <- networks, isPrefixOf s network]
    getNetworks :: String -> String -> IO [String]
    getNetworks dir prefix = do
      networkFiles <- fmap lines $ runProcessWithInput "bash" [] ("ls " ++ dir)
      return $ map (removePrefix prefix) $ filter (isPrefixOf prefix) networkFiles
    removePrefix :: String -> String -> String
    removePrefix prefix s
      | length s < length prefix || take (length prefix) s /= prefix = s
      | otherwise                                                    = drop (length prefix) s
    connect :: String -> X()
    connect network = safeSpawn "xterm" ["-e", "sudo", "netcfg", prefix++network]


data Password= Password

instance XPrompt Password where
  showXPrompt Password = "Password: "

passwordPrompt dir suffix c = mkXPrompt Password c (getPasswordComplFromDirSelecting dir suffix) copyPassword
  where
    getPasswordComplFromDirSelecting :: String -> String -> String -> IO [String]
    getPasswordComplFromDirSelecting dir suffix s = do
      passwords <- getPasswords dir suffix
      return $ [ password | password <- passwords, isPrefixOf s password]
    getPasswords :: String -> String -> IO [String]
    getPasswords dir suffix = do
      passwordFiles <- fmap lines $ runProcessWithInput "bash" [] ("find " ++ dir ++ " -type f | grep -v .gpg-id | grep " ++ suffix)
      return $ map ((\x -> take (length x - length suffix) x) . (drop $ length dir)) passwordFiles
    copyPassword :: String -> X()
    copyPassword pass = safeSpawn "pass" ["-c", pass]
