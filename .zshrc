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
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg+:#0A2A3F,fg:#CBE0F0,fg+:#CBE0F0 \
  --color=hl:#0FC5ED,hl+:#0FC5ED,info:#FFE073,prompt:#0FC5ED \
  --color=pointer:#47FF9C,marker:#44FFB1,spinner:#24EAF7,header:#214969 \
  --color=border:#0A2A3F,gutter:#011423,query:#CBE0F0 \
  --layout=reverse \
  --info=inline-right
zsh-defer source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# ──[ FZF Global Theme ]────────────────────────────────────────────
export FZF_DEFAULT_OPTS="\
--color=bg+:#0A2A3F,fg:#CBE0F0,fg+:#CBE0F0 \
--color=hl:#0FC5ED,hl+:#0FC5ED,info:#FFE073,prompt:#0FC5ED \
--color=pointer:#47FF9C,marker:#44FFB1,spinner:#24EAF7,header:#214969 \
--color=border:#0A2A3F,gutter:#011423,query:#CBE0F0 \
--layout=reverse \
--info=inline-right \
--separator='─' \
--scrollbar='│' \
--pointer='>' \
--marker='✓' \
--preview-window=right:50%:wrap:border-left \
--bind 'ctrl-j:preview-down,ctrl-k:preview-up,ctrl-n:down,ctrl-p:up,ctrl-d:preview-page-down,ctrl-u:preview-page-up'"

export FZF_CTRL_T_COMMAND="fd -t f -E '.*' -E 'venv*' -E 'node_modules' -E 'dist' -E 'go' -E 'build' -E 'target' -E 'llama.cpp' -E 'qmk_firmware' -E 'cvat' -E 'axolotl*' -E 'yay' -E 'Downloads' . 2>/dev/null"

export FZF_CTRL_T_OPTS="--height=100% --border=none --preview 'bat --color=always --style=numbers --line-range :500 {}' --preview-window=right:50%:wrap:border-left"

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

# ──[ Command Editor ]──────────────────────────────────────────────────────────
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

export PATH=$HOME/.local/bin:$PATH

# opencode
export PATH=/home/rendi/.opencode/bin:$PATH

# ──[ Aliases & Functions ]───────────────────────────────────────────────
alias ls="eza --icons=always"
alias o="opencode"
source ~/.aliases
