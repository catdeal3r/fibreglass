#!/bin/bash

toggle_func() {
  if [[ $(pgrep mocp) ]]; then
    mocp -G
  else
    playerctl play-pause
  fi
}

next_func() {
  if [[ $(pgrep mocp) ]]; then
    mocp -f
  else
    playerctl next
  fi
}

previous_func() {
  if [[ $(pgrep mocp) ]]; then
    mocp -r
  else
    playerctl previous
  fi
}

case $1 in
--toggle) toggle_func ;;
--next) next_func ;;
--previous) previous_func ;;
esac
