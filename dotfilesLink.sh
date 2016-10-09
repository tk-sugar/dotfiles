#!/bin/bash

DOT_FILES=(.bashrc .bash_profile .bash_aliases .vimrc .gitconfig)

for file in ${DOT_FILES[@]}
do
  unlink $HOME/$file
done

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done
