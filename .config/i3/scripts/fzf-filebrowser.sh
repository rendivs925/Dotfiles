#!/bin/bash

# Lazy loading file browser using fzf inside terminal
# Features: fuzzy search, preview, edit in nvim, copy path

tmpfile=$(mktemp)
trap "rm -f $tmpfile" EXIT

alacritty -e bash -c "
    selected=\$(find ~ -type f 2>/dev/null | \
        fzf --preview 'bat --color=always --style=numbers --line-range :500 {}' \
            --preview-window=right:50%:wrap \
            --height=100% \
            --layout=reverse \
            --border=rounded \
            --prompt='Files> ' \
            --header='Enter: open | Ctrl-O: nvim | Ctrl-Y: copy | Ctrl-P: preview' \
            --bind 'ctrl-o:execute(alacritty -e nvim {+})' \
            --bind 'ctrl-y:execute-silent(echo -n {+} | xclip -selection clipboard)+abort' \
            --bind 'ctrl-p:toggle-preview' \
            --bind 'enter:accept' \
            --color='fg:#a9b1d6,bg:#1a1b26,hl:#7aa2f7,fg+:#c0caf5,bg+:#24283b,hl+:#7aa2f7,info:#e0af68,prompt:#7aa2f7,pointer:#f7768e,marker:#9ece6a,spinner:#9ece6a,header:#565f89,border:#414868')
    
    echo \"\$selected\" > $tmpfile
"

selected=$(cat "$tmpfile")
if [ -n "$selected" ]; then
    xdg-open "$selected"
fi
