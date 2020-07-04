#!/bin/zsh

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

LS_COLORS='no=00;37:fi=00;94:di=00;33:ln=00;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS

source ~/.zprofile

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# Basic auto/tab complete:
autoload -U compinit bashcompinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
bashcompinit

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^f' 'clear\n'
bindkey '^[[P' delete-char
bindkey -s '^o' 'lfcd\n'
source $ZDOTDIR/aliases
source $ZDOTDIR/compleat_setup
source $ZDOTDIR/promptless/promptless.sh
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh