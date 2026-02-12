#!/bin/bash

# Fast recursive file browser with unlimited depth
# Excludes common large directories to improve speed

selected=$(find ~ -type f \
    ! -path "*/\.*" \
    ! -path "*/node_modules/*" \
    ! -path "*/.git/*" \
    ! -path "*/.cache/*" \
    ! -path "*/vendor/*" \
    ! -path "*/target/*" \
    ! -path "*/build/*" \
    ! -path "*/dist/*" \
    2>/dev/null | \
    rofi -dmenu -i -p "Files" \
    -theme ~/.config/rofi/aura-dark.rasi \
    -theme-str 'window {width: 80%; height: 60%;}' \
    -kb-custom-1 "Ctrl+o" \
    -kb-custom-2 "Ctrl+y" \
    -mesg "Enter: open | Ctrl+O: edit in nvim | Ctrl+Y: copy path")

exit_code=$?

if [ -n "$selected" ]; then
    case $exit_code in
        0)
            xdg-open "$selected"
            ;;
        10)
            alacritty -e nvim "$selected"
            ;;
        11)
            echo "$selected" | xclip -selection clipboard
            notify-send "Path copied" "$selected"
            ;;
    esac
fi
