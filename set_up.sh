#!/bin/bash

# Set the package manager

if [ $(uname -r | grep -i 'ubuntu') ]; then
    pkg_man=apt-get install
elif [ $(uname -r | grep -i 'arch') ]; then
    pkg_man=pacman -S
elif [ $(uname -r | grep -i 'fedora') ]; then
    pkg_man=yum install
fi

# Install dependencies
if ! hash vim 2>/dev/null; then
    sudo $pkg_man install vim;
    sudo $pkg_man install vim-nox;
fi;


if ! hash nano 2>/dev/null; then
    sudo $pkg_man install nano;
fi;

#sudo apt-get install tmux;

# Make a back-up
mkdir ~/.dotfiles_backup
mv ~./.vimrc ~/.dotfiles_backup
mv ~./.vim ~/.dotfiles_backup
mv ~./.nanorc ~/.dotfiles_backup
mv ~./.bashrc ~/.dotfiles_backup

# Starts real set-up
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
