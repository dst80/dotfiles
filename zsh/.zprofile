#!/bin/zsh

if [ -f "$HOME/.config/.paths" ]; then
    source "$HOME/.config/.paths"
fi

if [ -f "$HOME/.config/.env" ]; then
    source "$HOME/.config/.env"
fi

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.config/zsh/.zshrc" ]; then
        source "$HOME/.config/zsh/.zshrc"
    fi
fi

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # loads completion
fi
