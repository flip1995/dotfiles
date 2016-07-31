dotfiles
===================

I'm still modifying these files, but will only push stable versions here.

## Installation

Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone https://github.com/flip1995/dotfiles.git
```

Now you only have to run `./install`. It's tested on the latest Arch-Linux Version. If you're using another system, please check the script before running.

If you have root access on your machine and want the dotfiles to apply also when you're working as root, then run `sudo ./install_root`.

CAUTION: Read the `install_root` script carefully before running! It creates symlinks in your **root** directory and executes some other commands as root, that you may or may not want to be executed.

#### Custom Fonts
You'll may have to use a custom font for Airline to look nice. (Seeing weird symbols? This is why!). See here: https://github.com/Lokaltog/powerline-fonts. I'm currently using sourcecode pro.

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
#### Tmux
Tmux is a _terminal multiplexer_. On most systems you can install it with your
package manager. On Arch for example with:
```
$ sudo pacman -S tmux
```

#### Color schemes
I'm using color schemes for vim, tmux and the gnome terminal from different
sources:

Vim: http://www.vim.org/scripts/script.php?script_id=368

Tmux: http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/

Terminal: https://github.com/chriskempson/base16-gnome-terminal (Modified Color
Scheme)

To install the terminal color scheme execute the command `source
~/dotfiles/termColorScheme.sh` and restart your terminal.
With the settings of the dotfiles this three schemes will fit in each other
perfectly!
