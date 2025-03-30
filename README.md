# dotfiles

My dotfiles. Made to work best on Arch Linux.

For ArchWSL2 on windows, see the [wsl](https://github.com/flip1995/dotfiles/tree/wsl) branch.

## Installation

Clone this repo (or your own fork!) to your **home** directory (`/home/username`).
```
$ cd ~
$ git clone https://github.com/flip1995/dotfiles.git
```

Now you only have to run `./install`. It's tested on the latest Arch-Linux Version. If you're using another system, please check the script before running.

---
### Spotify
In order to use the Spotify integration, make sure to install `spotifyd` and
then log in with:

```
secret-tool store --label="spotify-keyring" application rust-keyring service spotifyd username <username>
```

Also run `make install` in `spotify-cli-linux`.
