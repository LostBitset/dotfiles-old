#!/bin/sh

# DOTFILE: $XDG_CONFIG_HOME/river/init
# >>>>>>>> #!/bin/bash
# >>>>>>>> source <repo>/dotfiles/river.sh

riverctl map normal Mod4+Shift Q spawn "xterm -fg green -bg black"
riverctl map normal Mod4 Q spawn wezterm
riverctl map normal Mod4 W spawn firefox

riverctl map normal Mod4 U close
riverctl map normal Mod4 H focus-view previous
riverctl map normal Mod4 L focus-view next
riverctl map normal Mod4 B zoom

riverctl map normal Mod4 F toggle-fullscreen

riverctl declare-mode layout-ctrl
riverctl map normal Mod4 Y enter-mode layout-ctrl
riverctl map layout-ctrl Mod4 Y enter-mode normal

riverctl map layout-ctrl None H send-layout-cmd rivertile "main-ratio -0.05"
riverctl map layout-ctrl None J send-layout-cmd rivertile "main-count -1"
riverctl map layout-ctrl None K send-layout-cmd rivertile "main-count +1"
riverctl map layout-ctrl None L send-layout-cmd rivertile "main-ratio +0.05"

riverctl map layout-ctrl None Up send-layout-cmd rivertile "main-location top"
riverctl map layout-ctrl None Down send-layout-cmd rivertile "main-location bottom"
riverctl map layout-ctrl None Left send-layout-cmd rivertile "main-location left"
riverctl map layout-ctrl None Right send-layout-cmd rivertile "main-location right"

riverctl declare-mode passthrough
riverctl map normal Mod4 A enter-mode passthrough
riverctl map passthrough Mod4 A enter-mode normal

riverctl map normal Mod4+Shift V exit

for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1)))

    # Super+[1-9] to tag focused view with tag [0-8]
    riverctl map normal Mod4+Shift $i set-view-tags $tags

    # Super+Shift+[1-9] to toggle focus of tag [0-8]
    riverctl map normal Mod4 $i toggle-focused-tags $tags
done

for mode in normal locked; do
	riverctl map $mode None XF86AudioRaiseVolume spawn 'pamixer -i 5'
	riverctl map $mode None XF86AudioLowerVolume spawn 'pamixer -d 5'
	riverctl map $mode None XF86AudioMute spawn 'pamixer --toggle-mute'
done

riverctl background-color 0x252525
riverctl border-color-focused 0xDC7633
riverctl border-color-unfocused 0x252525

riverctl set-repeat 50 300

# For some lame reason, I have to start and then stop pulseaudio once, and then start it again
# Then it works *sigh*
timeout 3 pulseaudio --start

riverctl spawn '(sleep 4; pulseaudio --start)'

# swww for wallpaper
riverctl spawn 'swww init'
riverctl spawn 'swww img $BG_INTENT'

# I use yambar
riverctl spawn 'yambar'

riverctl default-layout rivertile
rivertile -view-padding 0 -outer-padding 0

