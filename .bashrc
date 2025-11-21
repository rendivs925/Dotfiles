#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export TERM=xterm-256color
export COLORTERM=truecolor
PS1='[\u@\h \W]\$ '
