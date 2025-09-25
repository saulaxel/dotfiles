#!/bin/bash

# VIM_LIKE_APP is the binary to be used. It is vim by default but can also
# be nvim or nvim-qt
VIM_LIKE_APP=vim

if [ $# -eq 1 ]; then
    if [ "$1" == "-n" ]; then
        VIM_LIKE_APP=nvim
    elif [ "$1" == "-w" ]; then
        VIM_LIKE_APP=nvim-qt
    fi
fi


cp ./vimrc ~/.vimrc

# Neovim specific
if [ "$VIM_LIKE_APP" == '-n' ]; then
    if [ ! -d ~/.config/nvim ]; then
        mkdir -p ~/.config/nvim
    fi
    ln -n ~/.vimrc ~/.config/nvim/init.vim
fi

$VIM_LIKE_APP +qall # Just run config to install plugins and exit

cp ./snips/emmet.vim ~/.vim/plugged/emmet-vim/autoload
cp ./snips/*.snip ~/.vim/plugged/neosnippet-snippets/neosnippets
cp ./colors/tender.vim ~/.vim/plugged/awesome-vim-colorschemes/colors
cp ./other_scripts/c_conceal.vim ~/.vim/plugged/c-conceal/after/syntax/c.vim
cp ./other_scripts/clang_tidy_sangria_correcta.sh ~/.vim
cp ../clang-format1 ~/.clang-format
gcc ./other_scripts/quitar_espacios.c -o ~/.vim/cortar
gcc ./other_scripts/aniadir_espacios.c -o ~/.vim/pegar

