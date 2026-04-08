# Dotfiles alias
DOTPATH="$HOME/dotfiles"
alias dotfiles="cd $DOTPATH"

# Alias Git
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit -v"
alias gcm="git commit -v -m"
alias gcnm="git commit -v -n -m"
alias gca="git add --all && git commit -n -v -m"
alias gc!="git commit -v --amend"
alias gcob="git checkout"
alias gdm="git diff main"
alias gdca="git diff --cached"
alias gds="git diff --stat"
alias gf="git fetch"
alias gfetch="git fetch"
alias gl="git log --graph --decorate --oneline -15"
alias gnewb="git checkout -b"
alias gp="git pull"
alias gpush="git push"
alias gs="git status"
alias gcleanall="git reset && git checkout -- . && git clean -df"
alias gprune="git fetch --prune"
alias gsa="git stash"
alias gspop="git stash pop"
alias gsls="git stash list"
alias repo="gh repo view --web"
alias gconfig="vi ~/.gitconfig"
# alias gd="git diff"
alias gdt="git difftool"
# Git Scripts
alias gco="$DOTPATH/scripts/fzf-gco"
alias nukemybranch="$DOTPATH/scripts/nuke-my-branch"

# Alias Tmux
alias tns="$DOTPATH/scripts/tmux-sessionizer"
alias tks="$DOTPATH/scripts/tmux-kill-session"
alias ta="tmux a -t" # attach by name
alias tls="tmux ls"
alias tcs="clear && tmux clear-history"

# Alias General
alias zshconfig="vi ~/.zshrc; source ~/.zshrc;"
alias vimconfig="vi ~/.vimrc"
alias nvimconfig="vi ~/.config/nvim/init.vim"
alias tmuxconfig="vi ~/.tmux.conf"
# alias t="tree -L 1 -a --dirsfirst"
# alias tt="tree -L 2 -a --dirsfirst"
alias la="ls -a"
alias c="clear"


alias vsc="code $PWD"


# Vim related
alias v="nvim"
alias pv="pipenv run nvim"
alias vi="nvim"
alias pvi="pipenv run nvim"

# Docker
alias dc="docker-compose"

# Lazygit
alias lg="lazygit"

# Python related
alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"
alias ipy="ipython"
alias python="python3"
alias pip="pip3"

# General variables: to access C-x C-e
export EDITOR=/opt/homebrew/bin/nvim
export VISUAL=/opt/homebrew/bin/nvim

set_vim_mode()
{
# Sets Vim keybidings to shell
if [[ $ZSH_VERSION ]] ; then
  bindkey -v
  bindkey jk vi-cmd-mode
fi
if [[ $BASH_VERSION ]] ; then
  set -o vi
  bind '"jk":vi-movement-mode'
fi
}

## Functions ##
# Opens Git exclude file
git_exclude()
{
  if [ -d .git ] && echo .git || git rev-parse --git-dir > /dev/null 2>&1 ; then
    vi .git/info/exclude
  else
    echo "Not a Git repo, mate (:"
  fi
}

# Wrap the command in time and voice
vc()
{
  if [ $# -eq 0 ]; then
    echo "Usage: vc <command>"
  else
    time $@ && say "Done" || say "Error"
  fi
}

# Identifies and source the .<shell>rc file
szsh()
{
  if [[ $ZSH_VERSION ]] ; then
    source $HOME/.zshrc
  fi
  if [[ $BASH_VERSION ]] ; then
    source $HOME/.bashrc
  fi
}

# Opens alias.sh in the editor
aliasconfig()
{
  nvim $HOME/dotfiles/aliases.sh
  szsh
}

# Log into Bash in a dock container
# Argument: docker conatiner identifier
docker_terminal()
{
  docker exec -it $1 bash
}

# set_idb()
# {
# Set Python Breakpoint() to IPDB if available
# if [ -x "$(command -v ipdb)" ]; then
#   export PYTHONBREAKPOINT="ipdb.set_trace"
# fi
# }

# Create or attach to a tmux session on startup
create_tmux_session()
{
  if ! [[ $TMUX ]] ; then
    tmux new -s "main"
  fi
}

nopushbranch()
{
  current_branch=$(git branch --show-current)

  if [[ $1 -eq "-u" ]]; then
    echo "Unsetting pushRemote to '' for branch $current_branch"
    git config --unset branch.$currentbranch.pushRemote
  else
    echo "Setting pushRemote to '' for branch $current_branch"
    git config branch.$currentbranch.pushRemote ''
  fi
}

vf()
{
  fzf --print0 --height 40% --border | xargs -0 -o nvim
}

# source the helpers repo
source $DOTPATH/cli-helpers/helpers.sh
# calling some functions
# create_tmux_session
set_vim_mode

# fzf stuff
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
