dotfiles
===================

These are the config files for vim. Initially they are copied from [@mscountermarsh](https://github.com/mscoutermarsh/dotfiles). I'm still modifying these files, but will only release stable versions here.

## Installation

Clone this repo (or your own fork!) to your **home** directory (`/Users/username`).
```
$ cd ~
$ git clone https://github.com/mscoutermarsh/dotfiles
```

Now you only have to run the install.sh script. It's tested on the latest Arch-Linux Version. If you're using another system, please check the script before running. A script to setup vim on Windows may follow.

If the script isn't working properly go through following steps.

### Installation steps
Install rcm

```
$ brew tap thoughtbot/formulae
$ brew install rcm
```

If you're missing brew you can get it here https://github.com/Linuxbrew/linuxbrew.

Run rcm (this command expects that you cloned your dotfiles to `~/dotfiles/`)
```
$ env RCRC=$HOME/dotfiles/rcrc rcup
```
RCM creates dotfile symlinks (`.vimrc` -> `/dotfiles/vimrc`) from your home directory to your `/dotfiles/` directory.

#### Custom Fonts
You'll may have to use a custom font for Airline to look nice. (Seeing weird symbols? This is why!). See here: https://github.com/Lokaltog/powerline-fonts
I use sourcecode pro, as [@mscountermarsh](https://github.com/mscoutermarsh/dotfiles) recommended.

The script will install the fonts automatically. You only have to select them through your terminal.

### Installing Plugins
Plugins are listed in `vimrc.bundles`.

To install them you'll need vundle. Installation directions are here: https://github.com/gmarik/Vundle.vim.
Once vundle is installed. Open vim (`$ vim`) and type `:BundleInstall`. And then restart vim. You'll need to do this for all the plugins to work.

---
These are a heavily modified version of Thoughtbot's dotfiles. More detailed instructions are available here: http://github.com/thoughtbot/dotfiles.

#### Contributing
Did you have trouble installing this? Do you have an improved installing script? Maybe for another system? Please fork & create a pull request with your suggestions.
