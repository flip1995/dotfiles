#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\[\033[01;31m\]\u\[\033[00m\]@\[\033[01;34m\]\h \[\033[00m\]\W]\$ '

export EDITOR=vim

# Functions
prevent_dir_change_tmux() {
    (cd .; $1 "$2")
}

# Aliases
## Make aliases work with sudo (http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo)
alias sudo='sudo '
## cd.. == cd ..
alias cd..='cd ..'
## Go to previous directory
alias cb='cd $OLDPWD'
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
## Always start tmux from $HOME/ directory
alias tmux='(cd $HOME; tmux)'
## If you have evince running in a pane and open a new pane,
## the new pane will be opened in the same directory as the evince-pane
alias evince='prevent_dir_change_tmux evince'

