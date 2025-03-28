#!/bin/bash

while true; do
  before_title="$(~/.config/eww/dashboard/scripts/music --title)"
  sleep 1
  artist="$(~/.config/eww/dashboard/scripts/music --artist)"
  title="$(~/.config/eww/dashboard/scripts/music --title)"
  cover="$(~/.config/eww/dashboard/scripts/music --cover)"

  sleep 0.5

  if [[ "$before_title" != "$title" ]]; then
    notify-send --icon="$cover" "$title" "$artist"
  fi

done
