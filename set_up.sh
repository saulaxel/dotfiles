#!/bin/bash

# Process args
while [[ $# -gt 0 ]]; do
    case "$1" in
        -v|--vim)
            IVIM=1
            ;;

        -nv|--neovim)
            INVIM=1
            ;;

        -r|--ruby)
            IRUBY=1
            ;;

        -t|--tmux)
            ITMUX=1
            ;;

        -c|--clang)
            ICLANG=1
            ;;

        -b|--backup)
            BACKUP=1
            ;;

        -a|--all)
            IVIM=1
            INVIM=1
            IRUBY=1
            ITMUX=1
            ICLANG=1
            BACKUP=1
            ;;
        *)
    esac
    shift
done

# Set the package manager
if [ "$(uname -a | grep -i 'ubuntu')" ]; then
    pkg_man="apt-get install"
elif [ "$(uname -a | grep -i 'arch')" ]; then
    pkg_man="pacman -S"
elif [ "$(uname -a | grep -i 'fedora')" ]; then
    pkg_man="yum install"
else
    pkg_man="choco install"
fi

# Set the shell config file

if [ $(echo $SHELL | grep -i bash) ]; then
    shell=$HOME"/.bashrc"
elif [ $(echo $SHELL | grep -i zsh ) ]; then
    shell=$HOME"/.zshrc"
fi

if ! hash git 2>/dev/null; then
    $pkg_man git
fi

# Install dependencies
if [ -n "$IVIM" ]; then
    $pkg_man vim
    $pkg_man vim-nox
fi

if [ -n "$IRUBY" ]; then
    $pkg_man ruby
fi

if [ -n "$ITMUX" ]; then
    $pkg_man tmux
fi

# Make a back-up
if [ -n "$BACKUP" ]; then
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

cp ./vimrc ~/.vimrc

if [ -n "$INVIM" ]; then
    if [ ! -d ~/.config/nvim ]; then
        mkdir -p ~/.config/nvim
    fi
    ln -n .vimrc ~/.config/nvim/init.vim
fi

if [ "$(cat $shell | grep "BASH_CONFIG_INCLUDED")" == "" ]; then
    cat bashrc >> $shell
fi

cp ./nanorc ~/.nanorc

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi;

if [ -n "$IVIM" ]; then
    vim +PluginInstall +qall
fi

if [ -n "$INVIM" ]; then
    nvim +PluginInstall +qall
fi

cp ./vim/snips/emmet.vim ~/.vim/bundle/emmet-vim/autoload
cp ./vim/snips/*.snip ~/.vim/bundle/neosnippet-snippets/neosnippets
cp ./vim/colors/solarized.vim ~/.vim/colors

if [ -n "$ICLANG" ]; then
    $pkg_man clang

    if [ -n "$INVIM" ]; then
        vim +VimProcInstall +qall
    fi
fi

exit 0
