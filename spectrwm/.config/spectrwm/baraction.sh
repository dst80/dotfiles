#!/bin/bash
# baraction.sh for spectrwm status bar
## DISK

create_tile () {
  echo -e "+|T+@fg=$3;+@bg=$4;+@fn=1;+<$1+<$2+<"
}

add_spacer () {
  if [ $1 -eq 1 ]
  then
    echo -e "+<+<"
  elif [ $1 -eq 2 ]
  then
    echo -e "+<"
  else
    echo -e ""
  fi
}

hdd() {
  hdd=$(df -h | awk 'NR==4{printf "%.1fG %d %", $3, $5}')
  echo -e "$(create_tile " " "$hdd" $1 $2)" 

}

## RAM
mem() {
  mem=$(free | awk '/Mem/ {printf "%.2fG/%.2fG\n", $3 / 1048576.0, $2 / 1048576.0 }')
  echo -e "$(create_tile " " "$mem" $1 $2)" 
}

## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "$(create_tile " " "$(add_spacer ${#cpu})$cpu %" $1 $2)"
}

## VOLUME
vol() {
  vol=$(amixer get Master | awk -F'[][]' 'END{ print $4 }' | sed 's/on://g')
    echo -e "$(create_tile " " "$vol" $1 $2)" 
}
## Battery 0 Lenovo
bat0() {
  battery=$(acpi | awk '/Battery 0/ {printf "%d%", $4}');
  [ ${#battery} -gt 0 ] && echo -e "$(create_tile " " "$(add_spacer $battery)$battery" $1 $2)"
}

## Battery 1 Lenovo
bat1() {
  battery=$(acpi | awk '/Battery 1/ {printf "%d%", $4}')
  [ ${#battery} -gt 0 ] && echo -e "$(create_tile " " "$(add_spacer $battery)$battery" $1 $2)"
}

get_date () {
  time_string=$(date +'%H:%M +|T+@fn=1;%d %b. %Y')
  echo -e "$(create_tile " " "$time_string" $1 $2)"
}


SLEEP_SEC=1
while :; do
  echo "+@bg=0;$(cpu "0" "1")$(mem "0" "2")$(hdd "1" "3")$(vol "1" "4")$(bat0 "1" "5")$(bat1 "1" "5")$(get_date "0" "6")"
  sleep $SLEEP_SEC
done
