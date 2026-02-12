#!/bin/bash

# Lazy loading file browser using fzf inside Alacritty
# Window size and position handled by i3 (NOT here)

tmpfile=$(mktemp)
trap "rm -f $tmpfile" EXIT

# Temporary Alacritty theme config
alacritty_config=$(mktemp)

cat > "$alacritty_config" << 'EOF'
[window]
opacity = 0.85
padding = { x = 10, y = 10 }
dynamic_padding = true

[colors.primary]
background = '#011423'
foreground = '#CBE0F0'

[colors.cursor]
text = "#011423"
cursor = "#47FF9C"

[colors.normal]
black = "#214969"
red = "#E52E2E"
green = "#44FFB1"
yellow = "#FFE073"
blue = "#0FC5ED"
magenta = "#a277ff"
cyan = "#24EAF7"
white = "#24EAF7"

[colors.bright]
black = "#214969"
red = "#E52E2E"
green = "#44FFB1"
yellow = "#FFE073"
blue = "#A277FF"
magenta = "#a277ff"
cyan = "#24EAF7"
white = "#24EAF7"
EOF

alacritty --config-file "$alacritty_config" \
    --class fzf-filebrowser \
    --title fzf-filebrowser \
    -e bash -c "
    export FZF_DEFAULT_OPTS=\"\
        --color=bg:#011423,bg+:#0A2A3F,fg:#CBE0F0,fg+:#CBE0F0 \
        --color=hl:#0FC5ED,hl+:#0FC5ED,info:#FFE073,prompt:#0FC5ED \
        --color=pointer:#47FF9C,marker:#44FFB1,spinner:#24EAF7,header:#214969 \
        --color=border:#0A2A3F,gutter:#011423,query:#CBE0F0 \
        --border=rounded \
        --prompt='  ' \
        --pointer='>' \
        --marker='✓' \
        --header='' \
        --height=100% \
        --layout=reverse \
        --info=inline-right \
        --separator='─' \
        --scrollbar='│'\"

    selected=\$(find ~ \
    -type d \( \
        -path '*/.*' -o \
        -name "node_modules" -o \
        -name "dist" -o \
        -name "venv" -o \
        -name "build" -o \
        -name "llama.cpp" -o \
        -name "qmk_firmware" -o \
        -name "go" -o \
        -name "cvat" -o \
        -name "venv*" -o \
        -name "axolotl*" -o \
        -name "yay" -o \
        -name "target" \
    \) -prune -o \
    -type f -print 2>/dev/null | \
        fzf \
            --preview 'bat --color=always --style=numbers --line-range :500 {}' \
            --preview-window=right:50%:wrap:border-left \
            --prompt='  ' \
            --header='╭─ Enter:open  Ctrl-O:nvim  Ctrl-Y:copy  Ctrl-T:preview  Ctrl-N:down  Ctrl-P:up ─╮' \
            --header-first \
            --bind 'ctrl-n:down' \
            --bind 'ctrl-p:up' \
            --bind 'ctrl-o:execute(alacritty -e nvim {+})' \
            --bind 'ctrl-y:execute-silent(echo -n {+} | xclip -selection clipboard)+abort' \
            --bind 'ctrl-t:toggle-preview' \
            --bind 'enter:accept')

    echo \"\$selected\" > $tmpfile
"

rm -f "$alacritty_config"

selected=$(cat "$tmpfile")
if [ -n "$selected" ]; then
    xdg-open "$selected"
fi
