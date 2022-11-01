# BASH_CONFIG_INCLUDED

#alias vim='nvim'
alias cls='clear'
alias ec="$EDITOR $HOME/.${SHELL##*/}rc"
alias src="source $HOME/.${SHELL##*/}rc"

# zsh specific
alias -s txt=vim
alias -s {c,cpp,python}=vim
alias -g cflg='-g -std=c11 -Wall -Wextra -fsanitize=address,undefined'

## Replacement of commands
#alias ls='exa'
#alias ll='exa -lh'
#alias cat='bat'
#alias rm='trash'
#alias cd='z'
#eval "$(zoxide init zsh)"

# Tmux
alias tmux="TERM=screen-256color-bce tmux"
export VTE_VERSION="100"

editors=($(whereis nvim))
if [[ "${editors[1]}" = "" ]]; then
    editors=($(whereis vim))
fi
if [[ ${editors[1]} = "" ]]; then
    editors=($(whereis vi))
fi
editor=${editors[1]}
export EDITOR=${editor}

# Alias for cheat.sh curl-based tldr pages
cheat() {
    curl cheat.sh/$@
}
cht() {
    curl cht.sh/$@
}

# Remap esc and caps
capsmap() {
    xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
    xmodmap -e 'clear Lock' -e 'keycode 0x09 = Caps_Lock'
}
#capsmap

## Flux screen filter
#if pgrep xflux > /dev/null; then
#    echo running
#else
#    /home/saul/.config/flux/xflux -l 19.64 -g -99.16
#fi

# Utilities
trim_min3() {
    for f in *-min.???; do
        mv $f ${f%-min.???}.${f: -3}
    done
}

resize_jpg() {
    for i in *.jpg; do
        magick convert $i -resize 20% ${i::-4}-minimizado.jpg
        jpegoptim $i
    done
}

# export PATH=
# export PYTHONPATH=
