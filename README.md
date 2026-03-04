# Cabra-arretado Dotfiles
This dotifles contain the MacOS configurations for:
* Vim
* [Neovim](https://neovim.io)
* [Tmux](https://github.com/tmux/tmux/wiki)
* [Wezterm](https://wezfurlong.org/wezterm/index.html)
* Shell aliases (Bash or Zsh required)

## Setup
You will need [Brew](https://brew.sh) to manage all the packages we will need to start. I could use `brew bundle` command, but I rather not.

With Brew we will install:

* Stow
* Neovim
* Tmux

With that done, we will use [Stow](https://dbeley.ovh/en/post/2021/01/09/easily-manage-your-linux-config-files-with-stow/) to manage the symlinks. To do that we will use the `setup.sh`.

### Git global ignore setup
Configure Git once to use the global ignore file from this repo:
```sh
git config --global core.excludesfile ~/.dotfiles/git/.gitignore_global
```

### Shell aliases setup
As there is some machine specific configurations in the `.zshrc` or `.bashrc` I rather only create an aliases file and source them manually.
To do that we will just need go to the `rc` file and paste that there:
``` source dotfiles/aliases.sh ```
(Assuming we cloned the repo in the root directory)
