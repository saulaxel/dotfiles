#!/bin/bash

# Make a back-up
if [ ! -d "~/.dotfiles_backup" ]; then
    mkdir ~/.dotfiles_backup
    cp ~/.vimrc ~/.dotfiles_backup
fi

# Starts real set-up
if [ ! -d ~/.vim/bundle ] || [ ! -d ~/.vim/colors ]; then
    mkdir -p ~/.vim/bundle
    mkdir ~/.vim/colors
fi;

cp ./vimrc_fast ~/.vimrc

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi;

vim +PluginInstall +qall
