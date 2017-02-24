#!/bin/bash

if ! hash vim 2>/dev/null; then
    sudo apt-get install vim;
fi;

if ! hash vim-nox 2>/dev/null; then
    sudo apt-get install vim-nox;
fi;

if ! hash nano 2>/dev/null; then
    sudo apt-get install nano;
fi;

if [ ! -d ~/.vim/bundle ] || [ ! -d ~/.vim/colors ]; then

    mkdir -p ~/.vim/bundle;
    mkdir ~/.vim/colors;
fi;

cp ./vimrc ~/.vimrc;
cp ./bashrc ~/.bashrc;
cp ./nanorc ~/.nanorc;

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi;

vim +PluginInstall +PluginClean +qall

cp ./vim/snips/emmet.vim ~/.vim/bundle/emmet-vim/autoload
cp ./vim/snips/NERD_commenter.vim ~/.vim/bundle/The-NERD-Commenter/plugin
cp ./vim/snips/*.snip ~/.vim/bundle/neosnippet-snippets/neosnippets;
cp ./vim/colors/solarized.vim ~/.vim/colors;

exit 0;
