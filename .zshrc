
# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle :compinstall filename '/home/kue/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

PROMPT='%4~ %#'
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
zstyle ':completion:*' menu select

alias ls='ls --color=auto'
alias clang90=clang -std=90 -Wpedantic -Wextra -Werror 

phone(){
    ssh u0_518@192.168.2.$1 -p 8022
}

# SALO
SALO="$HOME/.salo_last"
salo(){
    touch $SALO
    current_dir=$(pwd)
    if [[ "$current_dir" == "$HOME" ]]; then
        cd "${$(< $SALO):-$HOME}/$1"
    else
        echo "$current_dir" > "$SALO"
    fi
}

fastfetch --disable-linewrap
