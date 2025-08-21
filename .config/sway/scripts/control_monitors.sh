#!/bin/sh

isHDMIConnected=false

while (true); do
  if [[ "$(swaymsg -t get_outputs)" == *"HDMI-A-1"* ]]; then
    printf "HDMI connected\n"
    if [[ $isHDMIConnect != true ]]; then
      swaymsg output eDP-1 disable
      swaymsg unbindswitch lid:on
    fi
    isHDMIConnected=true
  else
    isHDMIConnected=false
    printf "Only eDP connected\n"
    swaymsg output eDP-1 enable
    swaymsg bindswitch lid:on exec 'systemctl suspend'
  fi
  sleep 1
done
