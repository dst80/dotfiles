if [ -f "$HOME/.config/.env" ]; then
  source "$HOME/.config/.env"
fi

if [ -f "$HOME/.config/.paths" ]; then
  source "$HOME/.config/.paths"
fi

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
  fi
fi
