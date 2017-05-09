import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Hooks.ManageHelpers
import qualified XMonad.Util.EZConfig as EZ

main = do
  xmonad $ gnomeConfig
    { terminal = "gnome-terminal"
    , modMask  = mod4Mask
    , layoutHook = unityLayout
    , startupHook = myStartupHook
    , keys = myKeys <+> keys gnomeConfig
    , manageHook  = unityManageHook <+> manageHook gnomeConfig
    }

myStartupHook = startupHook gnomeConfig >> setWMName "LG3D"

unityLayout = gaps [(U, 24)] (layoutHook gnomeConfig)
          ||| noBorders (fullscreenFull Full)

unityManageHook = composeAll . concat $
    [ [ className =? c --> doIgnore | c <- ignores ]
    , [ className =? c --> doCenterFloat | c <- floats ]
    , [ className =? c --> doShift "1" | c <- onWs1 ]
    , [ className =? c --> doShift "2" | c <- onWs2 ]
    , [ className =? c --> doShift "3" | c <- onWs3 ]
    , [ className =? c --> doShift "6" | c <- onWs6 ]
    , [ className =? c --> doShift "7" | c <- onWs7 ]
    , [ className =? c --> doShift "8" | c <- onWs8 ]
    , [ className =? c --> doShift "9" | c <- onWs9 ]
    ]
  where
    onWs1 = []
    onWs2 = web
    onWs3 = dev
    onWs6 = fileMgr
    onWs7 = chats
    onWs8 = slack
    onWs9 = passMgr
    -- classnames
    web = [ "Firefox", "Google-chrome" ]
    dev = [ "Atom", "jetbrains-idea-ce" ]
    fileMgr = [ "Nautilus" ]
    chats = [ "Telegram", "Skype" ]
    slack = [ ]
    passMgr = [ "KeePass2" ]
    ignores = [ "Unity-2d-panel" ]
    floats = [ "Vlc", "Downloads", "Xmessage" ]

myKeys = flip EZ.mkKeymap
    [ ("M-d", spawn "dmenu_run")
    , ("S-M-n", spawn "nautilus --no-desktop --browser")
    ]

