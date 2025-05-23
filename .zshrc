# zsh instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load zsh-defer 
source ~/.config/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

# environment variables
export LEPTOS_TAILWIND_VERSION='v4.0.0'
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:$PKG_CONFIG_PATH
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH="$JAVA_HOME/bin:$PATH"
export SUDO_EDITOR="nvim"
export EDITOR="nvim"
export VISUAL="nvim"
export MAKEFLAGS="-j$(nproc)"
export PATH="$HOME/.cargo/bin:/opt/nvim-linux64/bin:/home/rendi/.local/bin:$PATH"
export PATH="$HOME/.espressif/tools/xtensa-esp32-elf/bin:$PATH"
export PYTHONPATH="/home/rendi/Downloads/pwndbg-2024.08.29/.venv/lib/python3.13/site-packages"
export FZF_CTRL_T_COMMAND=""
export FZF_CTRL_T_OPTS=""
export FZF_CTRL_R_OPTS=""
export ANDROID_HOME=/opt/android-sdk
export NDK_HOME=/opt/android-ndk
export PATH="/home/rendi/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/rendi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/rendi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"/home/rendi/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/rendi/perl5"
export PATH="/home/rendi/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/rendi/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
zsh-defer '[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"'
zsh-defer '[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"'
zsh-defer source /usr/share/nvm/init-nvm.sh
export PATH=$PATH:/usr/local/go/bin

# FZF completion and key bindings
zsh-defer source ~/.config/zsh/plugins/fzf/shell/completion.zsh
zsh-defer source ~/.config/zsh/plugins/fzf/shell/key-bindings.zsh

# FZF widgets keybindings
autoload -Uz fzf-file-widget fzf-history-widget
zle     -N  fzf-file-widget
zle     -N  fzf-history-widget

# fzf bindings
bindkey '^[a' fzf-file-widget
bindkey '^[z' fzf-history-widget

# zsh history
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

# Lazy load fzf-tab 
zsh-defer source ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# Lazy load autosuggestions and syntax highlighting
zsh-defer source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide 
zsh-defer eval "$(zoxide init zsh)"

# theme
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# aliases
alias ls="eza --icons=always"
alias tree="tree -L 3 -a -I '.git' --charset X"
alias dtree="tree -L 3 -a -d -I '.git' --charset X"
alias e="exit"
alias c="clear"
alias j="just"
alias jsb="just sb"
alias jsf="just sf"
alias jsa="just sa"
alias t="tmux"
alias tl="tmux list-session"
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias n="nvim"
alias r="ranger"
alias sn="sudoedit"
alias nn="nvim ~/.config/nvim"
alias na="nvim ~/.config/alacritty/alacritty.toml"
alias ni="nvim ~/.config/i3/config"
alias nz="nvim ~/.zshrc"
alias nt="nvim ~/.tmux.conf"
alias nb="nvim ~/.bashrc"
alias nx="nvim ~/.xinitrc"
alias cd="z"
alias ..='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias cd5='cd ../../../../..'
alias cd6='cd ../../../../../..'
alias cd7='cd ../../../../../../..'
alias cd8='cd ../../../../../../../..'
alias cd9='cd ../../../../../../../../..'
alias cdf="cd ~/Dotfiles/"
alias cn="cd ~/.config/nvim"
alias ca="cd ~/.config/alacritty"
alias ci="cd ~/.config/i3"
alias cq="cd ~/.config/qutebrowser/"
alias nq="n ~/.config/qutebrowser/config.py"
alias sot="tmux source ~/.tmux.conf"
alias soz="source ~/.zshrc"
alias ga="git add"
alias gra="git remote add"
alias grv="git remote -v"
alias grr="git remote remove"
alias gs="git status"
alias gcm="git commit -m"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias gl="git log --graph --oneline --decorate --all"
alias gd="git diff"
alias gds="git diff --staged"
alias gb="git branch"
alias gba="git branch -a"
alias gco="git commit"
alias gca="git commit --amend"
alias gpl="git pull"
alias gcl="git clone"
alias gpo="git push origin"
alias gpf="git push --force-with-lease"
alias gr="git reset"
alias grs="git restore"
alias grss="git restore --staged"
alias gst="git stash"
alias gstp="git stash pop"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gsts="git stash show --patch"
alias gclean="git clean -fd"
alias gundo="git reset --soft HEAD~1"
alias gtags="git tag"
alias gtl="git tag -l"
alias dcu="docker compose up"
alias dcw="docker compose watch"
alias cw='cargo watch -q -c -w src/ -x "run -q"'

# custom command editor
edit_and_execute_command() {
  local temp_file=$(mktemp /tmp/zsh_command.XXXXXX)
  [[ -z "$temp_file" ]] && { echo "[ERROR] Failed to create a temporary file."; return; }

  nvim "$temp_file"

  if [[ $? -eq 0 ]]; then
    local last_command=$(cat "$temp_file")
    echo "[COMMAND]"
    echo "$last_command"

    echo -n "$last_command" | xclip -selection clipboard
    echo "$last_command" >> ~/.zsh_history
    fc -A

    local response=$(eval "$last_command" 2>&1)

    if [[ $? -eq 0 ]]; then
      [[ -n "$response" ]] && echo -e "\n[OUTPUT]\n$response"
    else
      [[ -n "$response" ]] && echo -e "\n[ERROR]\n$response"
    fi

    rm "$temp_file"
  else
    echo "[ERROR] Failed to edit the file in Neovim."
    rm "$temp_file"
  fi
}

bindkey -s '^e' "edit_and_execute_command^M"

# final setup
autoload -U compinit; compinit
bindkey -v
bindkey -M vicmd 'p' paste
bindkey -M vicmd 'y' copy
zle -N paste
zle -N copy
