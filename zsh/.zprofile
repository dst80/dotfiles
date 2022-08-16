#!/bin/zsh

if [ -f "$HOME/.config/.paths" ]; then
  source "$HOME/.config/.paths"
fi

if [ -f "$HOME/.config/.env" ]; then
  source "$HOME/.config/.env"
fi

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/config/.zsh/.zshrc"]; then
    source "$HOME/config/.zsh/.zshrc"
  fi
fi
