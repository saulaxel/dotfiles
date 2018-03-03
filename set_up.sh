#!/bin/bash

function install_common_debian {
    sudo apt-get install git zsh vim vim-nox ruby tmux clang
    sudo apt-get install software-properties-common
    sudo apt-get install python-dev python-pip python3-dev python3-pip
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
    sudo pacman -S git zsh vim neovim ruby tmux clang
    sudo pacman -S python-pip
    sudo python2 -m pip install neovim
    sudo python3 -m pip install neovim
}

function install_fedora {
    sudo dnf -y install git zsh vim ruby tmux clang
    sudo dnf -y install neovim python2-neovim python3-neovim
    sudo dnf -y install python-pip python3-pip
    sudo python2 -m pip install neovim
    sudo python3 -m pip install neovim
}

function install_git_console {
    echo "¿Tienes instalado chocolately? (s/n)"
    read ans

    if [ "$ans" != "s" ]; then
        echo "La instalación continuará una vez instalado chocolately"
        exit
    fi

    choco install -y neovim
}

if [ $# -ne 1 ]; then
    echo "Debe proporcionar un argumento:"
    echo -e "\t a) debian" >&2
    echo -e "\t b) ubuntu" >&2
    echo -e "\t b) arch" >&2
    echo -e "\t b) fedora" >&2
    echo -e "\t b) git_console" >&2

    exit 1
fi

shell="~/.zshrc"
# Set the package manager
if [ "$1" == "debian" ]; then
    install_debian
elif [ "$1" == "ubuntu" ]; then
    install_debian
elif [ "$1" == "arch" ]; then
    install_arch
elif [ "$1" == "fedora" ]; then
    install_fedora
elif [ "$1" == "windows" ]; then
    install_git_console
    shell="~/.bashrc"
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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cat bashrc >> $shell

cp ./nanorc ~/.nanorc

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

if [ "$1" != "windows" ]; then
    nvim +PluginInstall +qall
else
    nvim-qt +PluginInstall +qall
fi

cp ./vim/snips/emmet.vim ~/.vim/bundle/emmet-vim/autoload
cp ./vim/jcommenter.vim ~/.vim/bundle/jcommenter.vim/plugin/
cp ./vim/snips/*.snip ~/.vim/bundle/neosnippet-snippets/neosnippets
cp ./vim/colors/solarized.vim ~/.vim/colors
cp ./vim/colors/tender.vim ~/.vim/bundle/awesome-vim-colorschemes/colors

vim +VimProcInstall +qall
if [ "$1" != "windows" ]; then
    nvim +UpdateRemotePlugins +qall
else
    nvim-qt +UpdateRemotePlugins +qall
fi

echo "La preparación del ambiente está lista"
exit 0
