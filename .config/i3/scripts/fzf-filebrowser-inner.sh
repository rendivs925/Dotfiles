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

selected=$(fd -t f -E '.*' -E 'venv*' -E 'node_modules' -E 'dist' -E '*/go' -E 'go' -E 'build' -E 'target' -E 'llama.cpp' -E 'qmk_firmware' -E 'cvat' -E 'axolotl*' -E 'yay' -E 'Downloads' . $HOME 2>/dev/null | \
    fzf \
        --preview 'bat --color=always --style=numbers --line-range :500 {}' \
        --preview-window=right:50%:wrap:border-left \
        --prompt='  ' \
        --header='╭─ Enter:open  Ctrl-O:nvim  Ctrl-Y:copy  Ctrl-T:preview  Ctrl-N/P:move  Ctrl-J/K:scroll  Ctrl-D/U:preview-page ─╮' \
        --header-first \
        --bind 'ctrl-n:down' \
        --bind 'ctrl-p:up' \
        --bind 'ctrl-j:preview-down' \
        --bind 'ctrl-k:preview-up' \
        --bind 'ctrl-d:preview-page-down' \
        --bind 'ctrl-u:preview-page-up' \
        --bind 'ctrl-o:execute(alacritty -e nvim {+})' \
        --bind 'ctrl-y:execute-silent(echo -n {+} | xclip -selection clipboard)+abort' \
        --bind 'ctrl-t:toggle-preview' \
        --bind 'enter:accept')

file="$selected"
if [[ -n "$file" ]]; then
    ext="${file##*.}"
    case "${ext,,}" in
        jpg|jpeg|png|gif|bmp|webp|svg|ico|tiff)
            setsid -f feh "$file" &
            ;;
        mp4|mkv|avi|mov|wmv|flv|webm)
            setsid -f mpv "$file" &
            ;;
        pdf|doc|docx|xls|xlsx|ppt|pptx|odt|ods|odp)
            setsid -f libreoffice "$file" &
            ;;
        *)
            alacritty -e nvim "$file" &
            ;;
    esac
fi

echo "$selected" > "$tmpfile"
