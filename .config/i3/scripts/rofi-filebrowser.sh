#!/bin/bash

# Recursive file browser with unlimited depth using rofi
# Shows ALL nested files from home directory

selected=$(find ~ -type f 2>/dev/null | rofi -dmenu -i -p "Files" -theme-str 'window {width: 80%; height: 60%;}')

if [ -n "$selected" ]; then
    xdg-open "$selected"
fi
