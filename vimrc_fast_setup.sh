#!/bin/bash

# Starts real set-up
if [ ! -d ~/.vim/bundle ]; then
    mkdir -p ~/.vim/bundle
fi

cp ./vimrc_fast ~/.vimrc

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall
