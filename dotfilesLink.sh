#!/bin/bash

DOT_FILES=(.bashrc .bash_profile .bash_aliases .vimrc .gitconfig .git-completion.zsh .git-prompt.sh .tmux.conf .vim/rc .zshrc .gitignore_global .gemrc Brewfile .tigrc .pryrc .commit_template)

for file in ${DOT_FILES[@]}
do
  unlink $HOME/$file
done

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done
