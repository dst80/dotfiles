#!/bin/bash
# baraction.sh for spectrwm status bar
## DISK

create_tile () {
  echo -e "+< +@bg=1; +@fn=1;$1 +@fn=0;$2 +@fg=0;+@bg=0;"
}

add_spacer () {
  if [${#1} -eq 1]
  then
    echo -e "   "
  elif [${#1} -eq 2]
  then
    echo -e "  "
  else
    echo -e ""
  fi
}

hdd() {
  hdd="$(df -h | awk 'NR==4{printf "%.2fG %d %", $3, $5}')"
  echo -e "$(create_tile " " "$1$hdd")" 

}

## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%.3fG/%.3fG\n", $3 / 1024.0 / 1024.0, $2 / 1024.0 / 1024.0 }'`
  echo -e "$(create_tile " " "$1$mem")" 
}

## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "$(create_tile " " "$1$(add_spacer "$cpu")$cpu %")"
}

## VOLUME
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    echo -e "$(create_tile " " "$1$vol")" 
}
## Battery 0 Lenovo
bat0() {
  battery=`acpi | awk '/Battery 0/ {printf "%d%", $4}'`
  if [-n $battery]
    then
      echo -e "$(create_tile " " "$1$battery")"
  fi
}

## Battery 1 Lenovo
bat1() {
  battery=`acpi | awk '/Battery 1/ {printf "%d%", $4}'`
  if [-n $battery]
    then
      echo -e "$(create_tile " " "$1$battery")"
  fi
}

get_date () {
  time_string=`date +'%d %b %Y [%H:%M]'`
  echo -e "$(create_tile " " "$1$time_string")"
}


SLEEP_SEC=1
while :; do
  echo "$(cpu "+@fg=1;")$(mem "+@fg=2;")$(hdd "+@fg=3;")$(vol "+@fg=4;")$(bat0 "+@fg=5;")$(bat1 "+@fg=6;")$(get_date "+@fg=5;")"
  sleep $SLEEP_SEC
done
