#!/bin/bash

FOCUSED=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

if [[ $1 == "next" ]]; then
  if [[ "$FOCUSED" == "8" ]]; then
    swaymsg workspace 1
  else
    swaymsg workspace $(($FOCUSED+1))
  fi
elif [[ $1 == "prev" ]]; then
  if [[ "$FOCUSED" == "1" ]]; then
    swaymsg workspace 8
  else
    swaymsg workspace $(($FOCUSED-1))
  fi
else
  echo "banger"
  exit 1
fi
