#!/bin/bash
xrdb -merge ~/.Xresources
xinput set-prop "ASUE1301:00 04F3:3128 Touchpad" "libinput Tapping Enabled" 1
xmodmap -e "add mod3 = Scroll_Lock"
unclutter -idle 1 -root
