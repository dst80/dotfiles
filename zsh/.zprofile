if [ -f "$HOME/.config/.env" ]; then
  . "$HOME/.config/.env"
fi

if [ -f "$HOME/.config/.paths" ]; then
  . "$HOME/.config/.paths"
fi

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.config/zsh/.zshrc"]; then
    . "$HOME/.config/zsh/.zshrc"
  fi
fi
