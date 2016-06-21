dotfiles
===================

These are the config files for vim. Initially they are copied from [@mscountermarsh](https://github.com/mscoutermarsh/dotfiles). I'm still modifying these files, but will only push stable versions here.

## Installation

Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone https://github.com/flip1995/dotfiles.git
```

Now you only have to run `./install`. It's tested on the latest Arch-Linux Version. If you're using another system, please check the script before running.

If you have root access on your machine and want the .vimrc and all plugins to apply also when you're editing as root, then run `sudo ./install_root`. 

CAUTION: Read the `install_root` script carefully before running! It creates symlinks in your **root** directory and executes some other commands as root, that you may or may not want to be executed.

A script to setup vim on Windows may follow.

If the script isn't working properly go through following steps.

### Installation steps
Create symlinks of vimrc, gvimrc and vimrc.bundles:
```
$ cd ~
$ ln -sf dotfiles/vimrc .vimrc
$ ln -sf dotfiles/gvimrc .gvimrc
$ ln -sf dotfiles/vimrc.bundles .vimrc.bundles
```
Now you have to create a symlink of the vim folder:
```
$ ln -sf dotfiles/vim .
$ mv -T vim .vim
```
Install the plugins and you're done.

If you want to run vim as root with the same configurations and plugins you have to symlink the files to your `/root/` directory and install the plugins as root.

#### Custom Fonts
You'll may have to use a custom font for Airline to look nice. (Seeing weird symbols? This is why!). See here: https://github.com/Lokaltog/powerline-fonts
I use sourcecode pro, as [@mscountermarsh](https://github.com/mscoutermarsh/dotfiles) recommended.

The scripts (`./install` and `./install_root`) will install the fonts automatically. You only have to select them through your terminal.

### Installing Plugins
Plugins are listed in `vimrc.bundles`.

To install them you'll need vundle. You can get vundle by cloning it into the `~/.vim/bundle` directory:
```
$ git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
```
To install the plugins with vundle open vim (`$ vim`) and type `:PluginInstall`. Running the command 
```
$ vim -u $HOME/.vimrc.bundles +PluginInstall +qa
```
will do the trick too. Don't forget to restart vim after installing plugins.

---
These are a heavily modified version of Thoughtbot's dotfiles. More detailed instructions are available here: http://github.com/thoughtbot/dotfiles.

#### Contributing
Did you have trouble installing this? Do you have an improved installing script? Maybe for another system? Please fork & create a pull request with your suggestions.
