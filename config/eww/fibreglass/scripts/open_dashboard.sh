#!/bin/bash

if [[ "$($(which eww) active-windows)" == *"dashboard"* || "$($(which eww) active-windows)" == "" ]]; then

  if [[ "$($(which eww) active-windows)" == *"dashboard"* ]]; then
    $(which eww) close dashboard
  else
    killall eww

    eww_window_id=0
    
    $(which eww) daemon

    for eww_monitor in $(xrandr -q | grep " connected" | cut -d ' ' -f1); do
      $(which eww) bar --id "$eww_window_id" --screen $eww_monitor &
      disown
      eww_window_id+=1
    done
    if [[ $(xrandr -q | grep "HDMI-1 connected") ]]; then
      $(which eww) open currentnotificationsbox --screen HDMI-1 & disown
	else
      $(which eww) open currentnotificationsbox --screen eDP-1 & disown
    fi
    $(which eww) open keepopen
  fi
  eww update reveal_db=false
else
  if [[ $(xrandr -q | grep "HDMI-1 connected") ]]; then
    $(which eww) open dashboard --screen HDMI-1
  else
    $(which eww) open dashboard --screen eDP-1
  fi
  
  sleep 0.3
  eww update reveal_db=true
fi
