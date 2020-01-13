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

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH

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
        if [[ $(git log -1 --pretty=oneline | sed 's/^[a-f0-9]*\s//') == "WIP" ]]; then
            command git reset HEAD~1
        else
            (>&2 echo "No WIP commit to unwip")
        fi;
    elif [[ $@ == "push --fwl" ]]; then
        command git push --force-with-lease
    else
        command git "$@";
    fi;
}
## Tmux easy session attach
alias tmuxa='tmux attach -t'
# watch a list of files/dirs and execute a command on change
# usage: `watch -f dir_name -c cmd`
watch() {
    while [[ "$#" -gt 0 ]]
    do
        case $1 in
            -h|--help)
                echo "usage: watch -f dir_name -c cmd"
                return
                ;;
            -f|--file)
                local FILE="$2"
                ;;
            -c|--command)
                shift
                break
                ;;
        esac
        shift
    done

    while inotifywait -e modify -r $FILE; do
        $@
    done
}
if command -v nvim 2>/dev/null; then
    alias vim=nvim
fi

autoload zkbd
function zkbd_file() {
[[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
[[ -f ~/.zkbd/${TERM}-${DISPLAY} ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}" && return 0
return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
zkbd
keyfile=$(zkbd_file)
ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
source "${keyfile}"
else
printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

source $HOME/.zkbd/xterm-256color-:0

[[ -n "$key[Home]" ]] && bindkey "$key[Home]" beginning-of-line
[[ -n "$key[End]" ]] && bindkey "$key[End]" end-of-line
[[ -n "$key[Insert]" ]] && bindkey "$key[Insert]" overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]" ]] && bindkey "$key[Delete]" delete-char

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
