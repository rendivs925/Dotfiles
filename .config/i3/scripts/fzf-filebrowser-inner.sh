#!/bin/bash

export FZF_DEFAULT_OPTS="\
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
    --scrollbar='│'"

tmpfile=$(mktemp)
trap "rm -f $tmpfile" EXIT

selected=$(find ~ \
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
    -name "target" -o \
    -name ".git" -o \
    -name ".cache" -o \
    -name ".local/share" -o \
    -name "Downloads" -o \
    -name ".npm" -o \
    -name ".cargo" -o \
    -name ".rustup" \
\) -prune -o \
-type f -print 2>/dev/null | \
    fzf \
        --preview 'bat --color=always --style=numbers --line-range :500 {}' \
        --preview-window=right:50%:wrap:border-left \
        --prompt='  ' \
        --header='╭─ Enter:open  Ctrl-O:nvim  Ctrl-Y:copy  Ctrl-T:preview  Ctrl-N:down  Ctrl-P:up  Ctrl-J:scroll-down  Ctrl-K:scroll-up ─╮' \
        --header-first \
        --bind 'ctrl-n:down' \
        --bind 'ctrl-p:up' \
        --bind 'ctrl-j:preview-down' \
        --bind 'ctrl-k:preview-up' \
        --bind 'ctrl-o:execute(alacritty -e nvim {+})' \
        --bind 'ctrl-y:execute-silent(echo -n {+} | xclip -selection clipboard)+abort' \
        --bind 'ctrl-t:toggle-preview' \
        --bind 'enter:accept')

echo "$selected" > "$tmpfile"
