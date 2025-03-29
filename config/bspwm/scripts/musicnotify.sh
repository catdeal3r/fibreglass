#!/bin/bash

while true; do
  before_title="$(~/.config/eww/fibreglass/scripts/music --title)"
  sleep 1
  artist="$(~/.config/eww/fibreglass/scripts/music --artist)"
  title="$(~/.config/eww/fibreglass/scripts/music --title)"
  cover="$(~/.config/eww/fibreglass/scripts/music --cover)"

  sleep 0.5

  if [[ "$before_title" != "$title" ]]; then
    notify-send --icon="$cover" "$title" "$artist"
  fi

done
