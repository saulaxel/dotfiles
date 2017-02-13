#!/bin/bash

if [ ! -d ~/.vim/bundle ] || [ ! -d ~/.vim/colors ]; then
    mkdir -p ~/.vim/bundle;
    mkdir ~/.vim/colors;
fi;

cp ./vim/colors/solarized.vim ~/.vim/colors;

cp ./vimrc ~/.vimrc;
cp ./bashrc ~/.bashrc;
cp ./nanorc ~/.nanorc;

exit 0;
