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
    echo "What system are you in?"
    echo -e "\\t - debian" >&2
    echo -e "\\t - ubuntu" >&2
    echo -e "\\t - arch" >&2
    echo -e "\\t - fedora" >&2
    echo -e "\\t - git_console" >&2

    exit 1
fi

echo ¿Instalar zsh?
read -n 1 -p "¿Instalar zsh? (S/n)" zsh

if [[ "$zsh" -ne 'n' ]] && [[ "$zsh" -ne 'N' ]]; then
    shell="$HOME/.zshrc"
else
    shell="$HOME/.bashrc"
fi

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
    echo -e "Invalid argument" >&2
    exit 1
fi

if [ "$(grep "BASH_CONFIG_INCLUDED" < "$shell")" == "" ]; then
    cat bashrc >> "$shell"
fi

echo "The applications are ready"
