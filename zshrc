# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/pkrones/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt sharehistory
setopt appendhistory
setopt histignoredups
unsetopt autocd beep
unsetopt BASH_AUTO_LIST
bindkey -v
# End of lines configured by zsh-newuser-install

[[ $- != *i* ]] && return
PS1='[%B%F{red}%n%F{white}%b@%B%F{blue}%M%b%F{white}▶ %1~]$ '

export EDITOR=vim
export PATH=$HOME/local/bin:$PATH

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

if which tmux >/dev/null 2>&1; then
    # if no session is started, start a new session
    [[ -z "$TMUX" ]] && tmux

    # when quitting tmux, try to attach
    while test -z $TMUX; do
        tmux attach || break
    done
fi

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
## Git WIP commit
git() {
    if [[ $@ == "wip" ]]; then
        command git commit -a -m "WIP";
    elif [[ $@ == "unwip" ]]; then
        if [[ $(git reflog -1 | sed 's/^.*: //') == "WIP" ]]; then
            command git reset HEAD~1
        else
            (>&2 echo "No WIP commit to unwip")
        fi;
    else
        command git "$@";
    fi;
}
## Tmux easy session attach
alias tmuxa='tmux attach -t'
## Prevent some commands from temporary switching directory
alias evince='exec_cmd_in_dir evince .'
alias man='exec_cmd_in_dir man .'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
