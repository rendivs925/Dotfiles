#!/bin/bash

# Simple file browser for testing - basic version
selected=$(find ~ -type f 2>/dev/null | head -1000 | rofi -dmenu -i -p "Files")

[ -n "$selected" ] && xdg-open "$selected"
