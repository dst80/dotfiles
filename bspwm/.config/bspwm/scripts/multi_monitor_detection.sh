#!/bin/bash

if [[ $(xrandr -q | grep "eDP connected") ]]; then
  # notebook
  if [[ $(xrandr -q | grep "HDMI-A-0 connected") ]]; then
    # travel and use hdmi
    xrandr --output eDP --primary --mode 1920x1080 --rotate normal --output HDMI-A-0 --mode 1920x1080 --rotate normal --left-of eDP
  fi
  if [[ $(xrandr -q | grep "DisplyPort-0 connected") ]]; then
    if [[ $(xrandr -q | grep "DisplayPort-1 connected") ]]; then
      # docking station
      xrandr --output DisplayPort-0 --primary --mode 1920x1080 --rotate normal --output DisplayPort-1 --mode 1920x1080 --rotate normal --left-of DisplayPort-0
    fi
  else
    # travel and use display port 
    xrandr --output eDP --primary --mode 1920x1080 --rotate normal --output DisplayPort-0 --mode 1920x1080 --rotate normal --left-of eDP
  fi
else
  #home pc
    xrandr --output DP-0 --primary --mode 1920x1080 --rotate normal --output DP-2 --mode 1920x1080 --rotate normal --left-of DP-0
fi
