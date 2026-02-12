# ──[ Instant Prompt ]──────────────────────────────────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ──[ Plugin Manager ]──────────────────────────────────────────────────────────
source ~/.config/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

# ──[ Completion & fzf-tab ]────────────────────────────────────────────────────
autoload -U compinit; compinit
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg:#011423,bg+:#0A2A3F,fg:#CBE0F0,fg+:#CBE0F0 \
  --color=hl:#0FC5ED,hl+:#0FC5ED,info:#FFE073,prompt:#0FC5ED \
  --color=pointer:#47FF9C,marker:#44FFB1,spinner:#24EAF7,header:#214969 \
  --border=rounded \
  --layout=reverse \
  --info=inline-right
zsh-defer source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# source ~/.config/vibe_cli/vibe_cli.zsh

# ──[ FZF Global Theme ]────────────────────────────────────────────
export FZF_DEFAULT_OPTS="\
--color=bg:#011423,bg+:#0A2A3F,fg:#CBE0F0,fg+:#CBE0F0 \
--color=hl:#0FC5ED,hl+:#0FC5ED,info:#FFE073,prompt:#0FC5ED \
--color=pointer:#47FF9C,marker:#44FFB1,spinner:#24EAF7,header:#214969 \
--color=border:#0A2A3F,gutter:#011423,query:#CBE0F0 \
--border=rounded \
--layout=reverse \
--info=inline-right \
--separator='─' \
--scrollbar='│' \
--pointer='>' \
--marker='✓' \
--height=40% \
--preview-window=right:50%:wrap:border-left \
--bind 'ctrl-j:preview-down,ctrl-k:preview-up,ctrl-n:down,ctrl-p:up'"

export FZF_CTRL_T_COMMAND="find ~ \
-type d \( \
    -path '*/.*' -o \
    -name node_modules -o \
    -name dist -o \
    -name venv -o \
    -name build -o \
    -name llama.cpp -o \
    -name qmk_firmware -o \
    -name go -o \
    -name cvat -o \
    -name 'venv*' -o \
    -name 'axolotl*' -o \
    -name yay -o \
    -name target -o \
    -name .git -o \
    -name .cache -o \
    -name '.local/share' -o \
    -name Downloads -o \
    -name .npm -o \
    -name .cargo -o \
    -name .rustup \
\) -prune -o -type f -print 2>/dev/null"

export FZF_CTRL_T_OPTS="\
--preview 'bat --color=always --style=numbers --line-range :500 {}' \
--preview-window=right:50%:wrap:border-left"

export FZF_CTRL_R_OPTS="\
--preview 'echo {}' \
--preview-window=down:3:hidden:wrap \
--bind 'ctrl-t:toggle-preview'"

# ──[ Environment Variables ]────────────────────────────────────────────────────
export W3MIMGDISPLAY=/usr/lib/w3m/w3mimgdisplay
export COLORTERM=truecolor
export TERM=xterm-256color
export SHELL="$(which zsh)"
export OPENSSL_DIR="/usr" # export LEPTOS_TAILWIND_VERSION=v4.1.11
export DOCKER_BUILDKIT=1
export BROWSER="/usr/bin/qutebrowser"
export LEPTOS_TAILWIND_VERSION="v4.0.0"
export PKG_CONFIG_PATH="/usr/lib/pkgconfig:$PKG_CONFIG_PATH"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export VISUAL="nvim"
export MAKEFLAGS="-j$(nproc)"
export PATH="$HOME/.cargo/bin:/opt/nvim-linux64/bin:/home/rendi/.local/bin:$PATH"
export PATH="$HOME/.espressif/tools/xtensa-esp-elf/bin:$PATH"
export PATH="$HOME/.espressif/xtensa-esp32-elf/bin:$PATH"
export PYTHONPATH="/home/rendi/Downloads/pwndbg-2024.08.29/.venv/lib/python3.13/site-packages"
# Android SDK
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=/opt/android-sdk

# Android NDK
export ANDROID_NDK_HOME=/opt/android-ndk

# export CARGO_BUILD_JOBS=4
# export RUSTFLAGS="-Ccodegen-units=1"

# Add tools to PATH
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH="/home/rendi/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/rendi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/rendi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/rendi/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/rendi/perl5"
export PATH="/home/rendi/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/rendi/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
export PATH="$PATH:/usr/local/go/bin"

# ──[ NVM Lazy Init ]───────────────────────────────────────────────────────────
zsh-defer '[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"'
zsh-defer source /usr/share/nvm/init-nvm.sh

# ──[ FZF Bindings & Widgets ]──────────────────────────────────────────────────
zsh-defer source /usr/share/fzf/completion.zsh
zsh-defer source /usr/share/fzf/key-bindings.zsh
autoload -Uz fzf-file-widget fzf-history-widget
zle -N fzf-file-widget
zle -N fzf-history-widget
bindkey '^[F' fzf-file-widget
bindkey '^[z' fzf-history-widget

fzf_alias_widget() {
  local selected=$(alias | sed -E "s/^alias //; s/='?([^']*)'?$/ \1/" \
    | awk '{printf "%-15s %s\n", $1, substr($0, index($0,$2))}' \
    | fzf --no-preview \
          --prompt="Alias > " \
          --header="Alias          Command")
  if [[ -n "$selected" ]]; then
    local alias_name=$(echo "$selected" | awk '{print $1}')
    LBUFFER+="$alias_name "
    zle reset-prompt
  fi
}
zle -N fzf_alias_widget
bindkey '^[a' fzf_alias_widget

# ──[ Zoxide ]───────────────────────────────────────────────────────────────────
zsh-defer eval "$(zoxide init zsh)"

# ──[ Suggestions & Syntax Highlighting ]───────────────────────────────────────
zsh-defer source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ──[ History Settings ]────────────────────────────────────────────────────────
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=50000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_no_store
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

qwen_cli_widget() {
  BUFFER="vibe_cli --chat"
  zle accept-line
}
zle -N qwen_cli_widget
bindkey '^G' qwen_cli_widget

autoload -Uz add-zsh-hook
# ──[ Vi Keybindings ]──────────────────────────────────────────────────────────
bindkey -v

# --- Paste widget
paste() {
  zle insert-string "$(xclip -selection clipboard -o)"
}
zle -N paste

# --- Copy widget 
copy() {
  zle vi-yank
  print -rn -- "$CUTBUFFER" | xclip -selection clipboard
}
zle -N copy

# --- Bindings 
bindkey -M vicmd 'p' paste
bindkey -M vicmd 'y' copy

# ──[ Theme ]────────────────────────────────────────────────────────────────────
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ──[ Aliases: Navigation ]─────────────────────────────────────────────────────
alias cd="z"
alias ai="vibe_cli"
alias cdf="cd ~/Dotfiles/"
alias cn="cd ~/.config/nvim"
alias ca="cd ~/.config/alacritty"
alias ci="cd ~/.config/i3"
alias cq="cd ~/.config/qutebrowser/"

# ──[ Aliases: Dotfile Editing ]────────────────────────────────────────────────
alias nn="nvim ~/.config/nvim"
alias np="nvim ~/.config/picom/picom.conf"
alias na="nvim ~/.config/alacritty/alacritty.toml"
alias ni="nvim ~/.config/i3/config"
alias nq="nvim ~/.config/qutebrowser/config.py"
alias nz="nvim ~/.zshrc"
alias nt="nvim ~/.tmux.conf"
alias nb="nvim ~/.bashrc"
alias nx="nvim ~/.xinitrc"

# ──[ Aliases: Shell Utils ]────────────────────────────────────────────────────
alias e="exit"
alias c='
if [ -n "$TMUX" ]; then
  tmux list-panes -a -F "#{pane_id} #{pane_current_command} #{pane_in_mode}" \
  | awk '"'"'$2 ~ /^(bash|zsh|fish|sh)$/ && $3 == 0 { print $1 }'"'"' \
  | grep -v "$TMUX_PANE" \
  | xargs -I {} tmux send-keys -t {} C-l
fi
command clear
'

# alias clear='
# if [ -n "$TMUX" ]; then
#   tmux list-panes -a -F "#{pane_id} #{pane_current_command} #{pane_in_mode}" \
#   | awk '"'"'$2 ~ /^(bash|zsh|fish|sh)$/ && $3 == 0 { print $1 }'"'"' \
#   | grep -v "$TMUX_PANE" \
#   | xargs -I {} tmux send-keys -t {} C-l
# fi
# command clear
# '
alias n="nvim"
alias nano="nvim"
alias r="ranger"
alias sn="sudoedit"
alias skey='screenkey --position fixed --geometry 240x60+1660+980 --font "Fira Mono Bold 20" --opacity 0.9 --bg-color "#000000" --font-color "#CBE0F0" --mods-mode emacs --persist --no-systray --bak-mode full --timeout 0.3"'
alias nowrap='echo -e "\e[?7l"'
alias wrap='echo -e "\e[?7h"'
alias fps_60="xrandr --output eDP --mode 2560x1600 --rate 60"

# Dual monitor – laptop left 300 Hz + external right 100 Hz
alias dual_monitor='
  xrandr --output eDP --primary --mode 2560x1600 --rate 300 --pos 0x0 --rotate normal \
         --output HDMI-1-0 --rate 99.95 --right-of eDP --rotate normal &&
  echo "Dual monitor active – laptop 300 Hz + external 100 Hz"
'

# External monitor only – 100 Hz
alias external_only='
  xrandr --output eDP --off \
         --output HDMI-1-0 --primary --mode 2560x1440 --rate 99.95 --pos 0x0 --rotate normal &&
  i3-msg "workspace 1; move workspace to output HDMI-1-0" &&
  echo "External-only @ 100 Hz active"
'

# Laptop screen only – 300 Hz
alias internal_only='
  xrandr --output HDMI-1-0 --off \
         --output eDP --primary --mode 2560x1600 --rate 300 --pos 0x0 --rotate normal &&
  i3-msg "workspace 1; move workspace to output eDP" &&
  echo "Laptop-only @ 300 Hz active"
'

brightness() {
  xrandr --output eDP-1-0 --brightness "$1" \
         --output HDMI-0 --brightness "$1"
}

# ──[ Aliases: Shell Reload ]───────────────────────────────────────────────────
alias soz="source ~/.zshrc"
alias sob="source ~/.bashrc"
alias sot="tmux source ~/.tmux.conf"

# ──[ Aliases: Tools ]──────────────────────────────────────────────────────────
alias t="tmux"
alias tl="tmux list-session"
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tree="tree -L 3 -a -I '.git' --charset X"
alias dtree="tree -L 3 -a -d -I '.git' --charset X"
alias ls="eza --icons=always"
alias j="just"
alias jsb="just sb"
alias jsf="just sf"
alias jcf="just cf"
alias jsa="just sa"
alias dcu="docker compose up"
alias dcw="docker compose watch"
alias cw='cargo watch -q -c -w src/ -x "run -q"'
# alias vibe='cd /home/rendi/Workspace/Programs/apps/vibespeak; cargo run'
alias cr="cargo remote -c -r remote --"

# ──[ Aliases: Git Basics ]─────────────────────────────────────────────────────
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gba="git branch -a"
alias gl="git log --graph --oneline --decorate --all"
alias gcl="git clone"
alias gpl="git pull"
alias gp="git push"
alias gpo="git push origin"
alias gpf="git push --force-with-lease"

# ──[ Aliases: Git Commit ]─────────────────────────────────────────────────────
alias gco="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gundo="git reset --soft HEAD~1"

# ──[ Aliases: Git Rebase ]─────────────────────────────────────────────────────
alias grb="git rebase"
alias grbi="git rebase -i"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias grbs="git rebase --skip"
alias grbm="git rebase origin/main"
alias grbmf="git fetch origin && git rebase origin/main"

# ──[ Aliases: Git Remote ]─────────────────────────────────────────────────────
alias gra="git remote add"
alias grv="git remote -v"
alias grr="git remote remove"

# ──[ Aliases: Git Reset/Restore ]──────────────────────────────────────────────
alias gr="git reset"
alias grh="git reset --hard"
alias grs="git restore"
alias grss="git restore --staged"

# ──[ Aliases: Git Stash ]──────────────────────────────────────────────────────
alias gst="git stash"
alias gsta="git stash apply"
alias gstp="git stash pop"
alias gstd="git stash drop"
alias gsts="git stash show --patch"

# ──[ Aliases: Git Tags ]───────────────────────────────────────────────────────
alias gtags="git tag"
alias gtl="git tag -l"

# ──[ Aliases: Git Cherry-pick ]────────────────────────────────────────────────
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"

# ──[ Aliases: Git Bisect ]─────────────────────────────────────────────────────
alias gbs="git bisect"
alias gbss="git bisect start"
alias gbsg="git bisect good"
alias gbsb="git bisect bad"
alias gbse="git bisect reset"

# ──[ Aliases: Git Submodule ]──────────────────────────────────────────────────
alias gsmu="git submodule update --init --recursive"
alias gsma="git submodule add"
alias gsms="git submodule status"
alias gsmsync="git submodule sync"

# ──[ Aliases: Git Misc ]───────────────────────────────────────────────────────
alias grfl="git reflog"
alias gsw="git switch"
alias gswc="git switch -c"
alias gclean="git clean -fd"
alias gprune="git fetch -p && git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d"

# ──[ Command Editor ]──────────────────────────────────────────────────────────
# Load the edit-command-line widget
autoload -Uz edit-command-line
zle -N edit-command-line

# Remap Ctrl+E to open the current command in $EDITOR (Neovim)
bindkey '^E' edit-command-line

export PATH=$HOME/.local/bin:$PATH

# opencode
export PATH=/home/rendi/.opencode/bin:$PATH
