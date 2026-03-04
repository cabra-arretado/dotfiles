#!/bin/bash

# Remove symlinks managed by Stow

links=(
  vim
  nvim
  tmux
  )

for i in "${links[@]}"
do
    stow -D $i
done
