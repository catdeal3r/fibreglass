#!/bin/bash

if [[ "$($(which eww) active-windows)" == *"notificationcenter"* || "$($(which eww) active-windows)" == "" ]]; then

  if [[ "$($(which eww) active-windows)" == *"notificationcenter"* ]]; then
    $(which eww) close notificationcenter
  else
    killall eww

    eww_window_id=0

    $(which eww) daemon

    for eww_monitor in $(xrandr -q | grep " connected" | cut -d ' ' -f1); do
      $(which eww) -c ~/.config/eww/ open --toggle bar --id "$eww_window_id" --screen $eww_monitor &
      disown
      eww_window_id+=1
    done
    if [[ $(xrandr -q | grep "HDMI-1 connected") ]]; then
      $(which eww) open currentnotificationsbox --screen HDMI-1
	else
      $(which eww) open currentnotificationsbox --screen eDP-1
    fi
    $(which eww) open keepopen
  fi
  $(which eww) update reveal_nc=false
else
  if [[ $(xrandr -q | grep "HDMI-1 connected") ]]; then
    $(which eww)  open notificationcenter --screen HDMI-1
  else
    $(which eww) open notificationcenter --screen eDP-1
  fi
  
  sleep 0.3
  $(which eww) update reveal_nc=true
fi
