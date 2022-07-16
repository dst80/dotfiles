#!/bin/sh
battery_percent=100

if ! [[ -f "/bin/acpi" ]]; then
  exit 0
fi


ac_status=$(acpi -b | awk ' { print ($3)}')
if [[ $? != 0 ]]; then
  exit 0;
fi


battery_percent=$(acpi -b | grep -P -o '[0-9]+(?=%)')
if [[ $? != 0 ]]; then
  notify-send -u critical "Battery monitor can't read battery status" -i battery-low
  exit 0;
fi

while true; do
  export DISPLAY=:0.0
  ac_status=$(acpi -b | awk ' { print ($3)}')
  battery_percent=$(acpi -b | grep -P -o '[0-9]+(?=%)')
  if [ "$ac_status"  == "Discharging," ]; then 
    if [ "$battery_percent" -lt 8 ]; then
      poweroff
    elif [ "$battery_percent" -lt 10 ]; then
      notify-send -u critical "$(echo -e "Battery below 10%.\nDropping below 8 will automatically shutdown the pc")" -i battery-low  #critical notification to show even in fullscreen
    elif [ "$battery_percent" -lt 15 ]; then
      notify-send -u critical "$(echo -e "Battery below 15%.\nPlease plug your AC adapter in.")" -i battery-low  #critical notification to show even in fullscreen
    fi
  fi
  
  sleep 60 # wait for 60 secs to notify again
done
