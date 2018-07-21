#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\[\033[01;31m\]\u\[\033[00m\]@\[\033[01;34m\]\h\[\033[00m\]▶ \W]\$ '

export EDITOR=vim
source /usr/share/bash-completion/bash_completion

# Functions
exec_cmd_in_dir() {
    if [[ $# -eq 2 ]]; then
        (cd "$2"; $1)
    elif [[ $# -ge 3 ]]; then
        cmd=$1
        dir="$2"
        shift
        shift
        (cd $dir; $cmd "$@")
    fi
}

# Aliases
## Make aliases work with sudo (http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo)
alias sudo='sudo '
## cd.. == cd ..
alias cd..='cd ..'
## Color the ls output
alias ls='ls --color=auto'
## Color the diff output
alias diff='diff --color=auto'
## Color the grep output
alias grep='grep --color=auto'
## Show hidden files
alias la='ls -a'
## Use a listing format
alias l='ls -l'
## Use a long listing format
alias ll='ls -la'
## Run vim as sudo
alias svim='sudo vim'
## Git status
alias gits='git status'
## Tmux easy session attach
alias tmuxa='tmux attach -t'
## Always start tmux from $HOME/ directory
alias tmux='exec_cmd_in_dir tmux $HOME'
## Prevent some commands from temporary switching directory
alias evince='exec_cmd_in_dir evince .'
alias man='exec_cmd_in_dir man .'

