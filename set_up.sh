#!/bin/bash

# Set the package manager

if [ "$(uname -a | grep -i 'ubuntu')" ]; then
    pkg_man="apt-get install"
elif [ "$(uname -a | grep -i 'arch')" ]; then
    pkg_man="pacman -S"
elif [ "$(uname -a | grep -i 'fedora')" ]; then
    pkg_man="yum install"
fi

# Set the shell config file

if [ $(echo $SHELL | grep -i bash) ]; then
    shell=$HOME"/.bashrc"
elif [ $(echo $SHELL | grep -i zsh ) ]; then
    shell=$HOME"/.zshrc"
fi

# Install dependencies
if ! hash vim 2>/dev/null; then
    sudo $pkg_man vim
    sudo $pkg_man vim-nox
fi;


if ! hash nano 2>/dev/null; then
    sudo $pkg_man nano
fi;

#sudo apt-get install tmux;

# Make a back-up
if [ ! -d ~/.dotfiles_backup ]; then
    mkdir ~/.dotfiles_backup

    cp ~/.vimrc ~/.dotfiles_backup
    cp ~/.nanorc ~/.dotfiles_backup
    cp ~/.bashrc ~/.dotfiles_backup
fi

# Starts real set-up
if [ ! -d ~/.vim/bundle ] || [ ! -d ~/.vim/colors ]; then
    mkdir -p ~/.vim/bundle
    mkdir ~/.vim/colors
fi;

cp ./vimrc ~/.vimrc;

if [ "$(cat $shell | grep "BASH_CONFIG_INCLUDED")" == "" ]; then
    cat bashrc >> $shell
fi

cp ./nanorc ~/.nanorc;

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi;

vim +PluginInstall +PluginClean +qall

cp ./vim/snips/emmet.vim ~/.vim/bundle/emmet-vim/autoload
cp ./vim/snips/NERD_commenter.vim ~/.vim/bundle/The-NERD-Commenter/plugin
cp ./vim/snips/*.snip ~/.vim/bundle/neosnippet-snippets/neosnippets
cp ./vim/colors/solarized.vim ~/.vim/colors

exit 0;
