if [ -f "$HOME/.config/.env" ]; then
  source "$HOME/.config/.env"
fi

if [ -f "$HOME/.config/.paths" ]; then
  source "$HOME/.config/.paths"
fi

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.config/zsh/.zshrc"]; then
    . "$HOME/.config/zsh/.zshrc"
  fi
fi
