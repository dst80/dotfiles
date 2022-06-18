if [ -f "$HOME/.config/.env"]; then
  . "$HOME/.config/.env"
fi

if [ -f "$HOME/.config/.paths" ]; then
  . "$HOME/.config/.paths"
fi

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc"]; then
    . "$HOME/.bashrc"
  fi
fi
