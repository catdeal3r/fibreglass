#!/bin/sh

isHDMIConnected=false
swaymsg output eDP-1 disable

while (true); do
  if [[ "$(swaymsg -t get_outputs)" == *"HDMI-A-1"* ]]; then
    printf "HDMI connected\n"
    if [[ $isHDMIConnect != true ]]; then
      swaymsg unbindswitch lid:on
      swaymsg bindswitch lid:on output eDP-1 disable
      swaymsg bindswitch lid:off output eDP-1 enable
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
