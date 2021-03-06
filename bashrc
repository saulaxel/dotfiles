# BASH_CONFIG_INCLUDED

alias ls='ls --color=auto'
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'
alias cls='clear'
alias tmux="TERM=screen-256color-bce tmux"
alias nshell='nvim term://szh +"setlocal nonu nospell"'
alias rm=trash
export VTE_VERSION="100"
export PATH=$PATH:$HOME/local_bin

editor=$(whereis nvim)
editor=${editor#*: }
if [[ "$editor" = "" ]]; then
    editor=$(whereis vim)
    editor=${editor#*: }
fi
export EDITOR=${editor}

# Alias for cheat.sh curl-based tldr pages
cheat() {
    curl cheat.sh/$@
}
cht() {
    curl cht.sh/$@
}

xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
xmodmap -e 'clear Lock' -e 'keycode 0x09 = Caps_Lock'

figlet -f lean "Bonjourn"

fortune -c | cowsay -f "$(find /usr/share/cowsay/cows/ -type f | shuf -n 1)"
