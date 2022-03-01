export ZDOTDIR=~/.config/zsh

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.config/zsh/.zshrc"]; then
    . "$HOME/.config/zsh/.zshrc"
  if
if

if [ -f "$HOME/bin"]; then
  PATH="$HOME/bin:$PATH"
if


if [ -f "$HOME/.local/bin"]; then
  PATH="$HOME/.local/bin:$PATH"
if

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
startx
fi
