#!/usr/bin/env bash
selected=`cat ~/.config/cheatsheet/languages ~/.config/cheatsheet/commands | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if [ "$TMUX" ]; then
      

    run()
    {
      tmux neww "eval $1" 
    }
else
    run()
    {
      eval $1
    }
fi


if grep -qs "$selected" ~/.config/cheatsheet/languages; then
    query=`echo $query | tr ' ' '+'`
    run "curl -s cht.sh/$selected/$query | less -r"
  else
    run "curl -s cht.sh/$selected~$query | less -r"
fi
