#!/bin/bash

hash git 2>/dev/null || { echo >&2 "Make sure, that 'git' is installed. Aborting."; exit 1; }

if ! hash brew 2>/dev/null; then
    if [ ! -d "$HOME/.linuxbrew" ] ||  [ ! "$(ls -A $HOME/.linuxbrew)" ]; then
        git clone https://github.com/Linuxbrew/linuxbrew.git $HOME/.linuxbrew
    fi
    if ! grep 'export PATH="$HOME/.linuxbrew/bin:$PATH' $HOME/.bashrc >/dev/null && ! grep 'export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH' $HOME/.bashrc >/dev/null && ! grep 'export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH' $HOME/.bashrc >/dev/null; then
        echo "export PATH=\"\$HOME/.linuxbrew/bin:\$PATH\"" >> $HOME/.bashrc
        echo "export MANPATH=\"\$HOME/.linuxbrew/share/man:\$MANPATH\"" >> $HOME/.bashrc
        echo "export INFOPATH=\"\$HOME/.linuxbrew/share/info:\$INFOPATH\"" >> $HOME/.bashrc
        echo "The Script hasn't finished yet. Please rerun it."
        exec bash
    fi
fi

if ! hash rcup 2>/dev/null; then
    brew tap thoughtbot/formulae
    brew install rcm
fi

env RCRC=$HOME/dotfiles/rcrc rcup
echo "Symlinks successfully created for ~/dotfiles."

if ! fc-list | grep -i Sauce\ Code\ Powerline\ Regular.otf >/dev/null; then
    git clone https://github.com/powerline/fonts.git $HOME/fonts
    sh $HOME/fonts/install.sh
    echo "Set your terminal font to 'Source Code Pro'."
    rm -rf $HOME/fonts
fi

exit 0
