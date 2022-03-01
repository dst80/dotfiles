export ZDOTDIR=~/.config/zsh

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc"]; then
    . "$HOME/.bashrc"
  fi
fi

if [ -f "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi


if [ -f "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
