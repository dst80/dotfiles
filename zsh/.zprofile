export ZDOTDIR=~/.config/zsh
export GOPATH="$HOME/go"


if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.config/zsh/.zshrc"]; then
    . "$HOME/.config/zsh/.zshrc"
  fi
fi

if [ -f "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -f "$HOME/go/bin" ]; then
  export PATH="$HOME/go/bin:$PATH"
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx
fi

