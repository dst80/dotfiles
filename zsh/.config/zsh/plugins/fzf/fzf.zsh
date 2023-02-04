#!/bin/sh

# arcticicestudio/nord-vim
export FZF_DEFAULT_OPTS="
--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#ebcb8b,fg:#c2c8d2,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#ebcb8b
--height 40% --layout=reverse"

export FZF_DEFAULT_COMMAND='fd -t f -L -H -E .git'

export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window down:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'CTRL-Y: copy to clipboard'"

if [ -f "/usr/share/fzf/shell/key-bindings.zsh" ]; then
    source "/usr/share/fzf/shell/key-bindings.zsh"
fi
