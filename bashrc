#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

export EDITOR=vim
# The Fuck!!!
eval $(thefuck --alias)

# Aliases
## Make aliases work with sudo (http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo)
alias sudo='sudo '
## cd.. == cd ..
alias cd..='cd ..'
## Color the ls output
alias ls='ls --color=auto'
## Show hidden files
alias la='ls -a'
## Use a listing format
alias l='ls -l'
## Use a long listing format
alias ll='ls -la'
## Color the grep output
alias grep='grep --color=auto'
## Run vim as sudo
alias svim='sudo vim'
## Git status
alias gits='git status'
## Tmux easy session attach
alias tmuxa='tmux attach -t'
