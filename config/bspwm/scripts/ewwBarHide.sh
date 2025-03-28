#!/bin/bash

bspc subscribe node_state | while read -r _ _ _ _ state flag; do
  if [ "$state" != "fullscreen" ]; then
    continue
  fi
  if [ "$flag" == on ]; then
    xdotool search --name "Eww - bar_top" windowunmap %@
    xdotool search --name "Eww - fakecornerstop" windowunmap %@
    xdotool search --name "Eww - bar" windowunmap %@
  else
    xdotool search --name "Eww - bar_top" windowmap %@
    xdotool search --name "Eww - fakecornerstop" windowmap %@
    xdotool search --name "Eww - bar" windowmap %@
  fi
done
