#!/bin/bash

if [[ "$(~/eww-source/target/release/eww active-windows)" == *"notificationcenter"* || "$(/home/catdealer/eww-source/target/release/eww active-windows)" == "" ]]; then

  if [[ "$(~/eww-source/target/release/eww active-windows)" == *"notificationcenter"* ]]; then
    ~/eww-source/target/release/eww close notificationcenter
  else
    killall eww

    eww_window_id=0

    for eww_monitor in $(xrandr -q | grep " connected" | cut -d ' ' -f1); do
      ~/eww-source/target/release/eww -c ~/.config/eww/ open --toggle bar --id "$eww_window_id" --screen $eww_monitor &
      disown
      eww_window_id+=1
    done
    if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
      eww open currentnotificationsbox --screen ${EXTERNAL_MONITOR} & disown
	else
      eww open currentnotificationsbox --screen ${INTERNAL_MONITOR} & disown
    fi
  fi
  eww update reveal_nc=false
else
  if [[ $(xrandr -q | grep "HDMI-1 connected") ]]; then
    ~/eww-source/target/release/eww open notificationcenter --screen HDMI-1
  else
    ~/eww-source/target/release/eww open notificationcenter --screen eDP-1
  fi
  
  sleep 0.3
  eww update reveal_nc=true
fi
