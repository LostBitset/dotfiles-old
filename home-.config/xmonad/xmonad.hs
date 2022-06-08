import XMonad

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

customKeys =
	[ ( (0, 0xFFEB), spawn "dmenu_apps" )
	, ( (0, 0xFF61), spawn "scrot_kt" )
	]

main :: IO ()
main = do
    xmobarPipe <- spawnPipe "xmobar"
    xmonad $ def
    	{ terminal = "Terminal"
    	, manageHook = manageDocks <+> manageHook def
    	, layoutHook = avoidStruts $ layoutHook def
    	, handleEventHook = handleEventHook def <+> docksEventHook
        , logHook = dynamicLogWithPP $ xmobarPP
    		{ ppOutput = hPutStrLn xmobarPipe
    		}
    	} `additionalKeys` customKeys
