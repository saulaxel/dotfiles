# BASH_CONFIG_INCLUDED

alias ls='ls --color=auto'
alias vi='vim'
alias nv='nvim'
alias cls='clear'
alias tmux="TERM=screen-256color-bce tmux"
export VTE_VERSION="100"

xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
xmodmap -e 'clear Lock' -e 'keycode 0x09 = Caps_Lock'

figlet -f lean "Bonjourn"

fortune -c | cowsay -f "$(find /usr/share/cowsay/cows/ -type f | shuf -n 1)"
