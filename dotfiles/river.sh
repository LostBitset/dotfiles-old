#!/bin/sh

riverctl map normal Mod4+Shift Q spawn "xterm -fg green -bg black"
riverctl map normal Mod4 Q spawn "$WEZTERM_INSTALL"
riverctl map normal Mod4 W spawn firefox

riverctl map normal Mod4 U close

riverctl map normal Mod4+Shift V exit

riverctl background-color 0x252525
riverctl border-color-focused 0xDC7633
riverctl border-color-unfocused 0x252525

riverctl set-repeat 50 300

riverctl default-layout rivertile
rivertile -view-padding 6 -outer-padding 6

