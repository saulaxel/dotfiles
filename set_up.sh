#!/bin/bash
if ! hash vim 2>/dev/null; then
    sudo apt-get install vim;
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
cp ./vim/snips/*.snip ~/.vim/bundle/neosnippet-snippets/neosnippets;
cp ./vim/colors/solarized.vim ~/.vim/colors;

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi;

vim +PluginInstall +PluginClean +qall

exit 0;
