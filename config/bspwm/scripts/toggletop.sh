#!/bin/bash

shown=~/.cache/top_toggle

[[ ! -f "$shown" ]] && echo true >"$shown"

if [[ "$(cat $shown)" == "true" ]]; then
  xdotool search --name "Eww - bar_top" windowunmap %@
  echo false >"$shown"
  bspc config top_padding 15
else
  xdotool search --name "Eww - bar_top" windowmap %@
  echo true >"$shown"
  bspc config top_padding 58
fi
