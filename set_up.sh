#!/bin/bash

function install_common_debian {
    sudo apt-get install git zsh ruby tmux clang figlet cowsay fortune oneko
    sudo apt-get install software-properties-common
    sudo apt-get install python-dev python-pip python3-dev python3-pip
    sudo apt-get install fonts-powerline
    sudo python2 -m pip install neovim
    sudo python3 -m pip install neovim
}

function install_debian {
    install_common_debian
    sudo apt-get install neovim python-neovim python3-neovim
}

function install_ubuntu {
    install_common_debian
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
}

function install_arch {
    sudo pacman -S git zsh neovim ruby tmux clang figlet cowsay fortune-mod
    sudo pacman -S python-pip
    sudo python2 -m pip install neovim
    sudo python3 -m pip install neovim
    yaourt -S oneko
}

function install_fedora {
    sudo dnf -y install git zsh ruby tmux clang figlet cowsay fortune-mod oneko
    sudo dnf -y install neovim python2-neovim python3-neovim
    sudo dnf -y install python-pip python3-pip
    sudo python2 -m pip install neovim
    sudo python3 -m pip install neovim
}

function install_git_console {
    choco install -y neovim
}

if [ $# -ne 1 ]; then
    echo "Debe proporcionar un argumento:"
    echo -e "\\t a) debian" >&2
    echo -e "\\t b) ubuntu" >&2
    echo -e "\\t b) arch" >&2
    echo -e "\\t b) fedora" >&2
    echo -e "\\t b) git_console" >&2

    exit 1
fi

shell="$HOME/.zshrc"
if [ "$1" == "debian" ]; then
    install_debian
elif [ "$1" == "ubuntu" ]; then
    install_ubuntu
elif [ "$1" == "arch" ]; then
    install_arch
elif [ "$1" == "fedora" ]; then
    install_fedora
elif [ "$1" == "windows" ]; then
    install_git_console
    shell="$HOME/.bashrc"
else
    echo -e "Argumento inválido" >&2
    exit 1
fi

# Starts real set-up
if [ ! -d ~/.vim/bundle ] || [ ! -d ~/.vim/colors ]; then
    mkdir -p ~/.vim/bundle
    mkdir ~/.vim/colors
fi

cp ./vimrc ~/.vimrc

if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim
fi
ln -n ~/.vimrc ~/.config/nvim/init.vim

if [ "$(grep "BASH_CONFIG_INCLUDED" < "$shell")" == "" ]; then
    cat bashrc >> "$shell"
fi

cp ./nanorc ~/.nanorc

nvim +qall # Just run config to install plugins and exit

cp ./vim/snips/emmet.vim ~/.vim/plugged/emmet-vim/autoload
cp ./vim/snips/*.snip ~/.vim/plugged/neosnippet-snippets/neosnippets
cp ./vim/colors/tender.vim ~/.vim/plugged/awesome-vim-colorschemes/colors
cp ./vim/other_scripts/c_conceal.vim ~/.vim/plugged/c-conceal/after/syntax/c.vim
cp ./vim/other_scripts/clang_tidy_sangria_correcta.sh ~/.vim
cp ./clang-format1 ~/.clang-format
gcc ./vim/other_scripts/quitar_espacios.c -o ~/.vim/cortar
gcc ./vim/other_scripts/aniadir_espacios.c -o ~/.vim/pegar

echo "La preparación del ambiente está lista"
