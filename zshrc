# The following lines were added by compinstall
fpath=($HOME/.zcomp $fpath)

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

# Setup editor command editing
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

[[ $- != *i* ]] && return
PS1='[%B%F{red}%n%F{white}%b@%B%F{blue}%M%b%F{white}▶ %1~]$ '

export EDITOR=nvim

if command -v tmux >/dev/null 2>&1; then
    # when quitting tmux, try to attach
    while test -z $TMUX; do
        tmux attach || break
    done

    # if no session is started, start a new session
    [[ -z "$TMUX" ]] && tmux
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
## Run nvim as sudo
command -v nvim >/dev/null 2>&1 && alias svim='sudo nvim' || alias svim='sudo vim'
## Run nvim in pipenv
command -v nvim >/dev/null 2>&1 && alias pvim='pipenv run nvim' || alias pvim='pipenv run vim'
## Git status
alias gits='git status'
## Git commands
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
    elif [[ $@ == "corig" ]]; then
        command git clean **/*.orig -f
    elif [[ $1 == "rad" ]]; then
        if [[ -n $2 ]]; then
            REPO=$(basename $(git config --get remote.origin.url))
            command git remote add $2 git@github.com:$2/$REPO --fetch
        else
            echo "usage: git rad <name>"
        fi
    elif [[ $1 == "gone" ]]; then
        command git remote prune ${2:-origin}
        command git branch -v | grep '\[gone\]' | awk '{print $1}' | xargs -I {} git branch -D {}
    elif [[ $1 == "drop" ]]; then
        command git reset --keep HEAD~${2:-1}
    else
        command git "$@";
    fi;
}
## Tmux easy session attach
command -v tmux >/dev/null 2>&1 && alias tmuxa='tmux attach -t'
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
command -v nvim >/dev/null 2>&1 && alias vim=nvim
command -v fuck >/dev/null 2>&1 && eval $(thefuck --alias)
alias rustdown='for tc in $(rustup toolchain list | grep "nightly-20*"); do rustup toolchain uninstall $tc; done'

command -v pyenv >/dev/null 2>&1 && export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null 2>&1 && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

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

[[ -n "$key[Home]" ]] && bindkey "$key[Home]" beginning-of-line
[[ -n "$key[End]" ]] && bindkey "$key[End]" end-of-line
[[ -n "$key[Insert]" ]] && bindkey "$key[Insert]" overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]" ]] && bindkey "$key[Delete]" delete-char

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
