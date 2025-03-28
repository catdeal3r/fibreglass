#!/bin/sh
# Shitty i3lock-colors script by github.com/mehedirm6244

declare -i SUSPEND
declare BG_PATH
BG_CACHED_PATH="${HOME}/lockscreen.png"

help() {
  echo "i3lock-color script by github/mehedirm6244"
  echo ""
  echo "Options:"
  echo "--help        Show this message"
  echo "--suspend     Suspend after locking"
  echo "--bg          Use the following image passed as argument as background"
  exit 0
}

create_cache() {
  size=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')

  echo "Caching background"
  eval convert "$BG_PATH" \
    -resize "$size""^" \
    -gravity center \
    -extent "$size" \
    -brightness-contrast -15x0 \
    -filter Gaussian \
    -blur 0x5 \
    "$BG_CACHED_PATH"
}

lock() {

  trans='00'
  semitrans='88'

  font='Product Sans Bold'

  i3lock \
    --insidever-color=#ffffff$trans \
    --insidewrong-color=#ffffff$trans \
    --inside-color=#ffffff$trans \
    --ringver-color=#ffffff \
    --ringwrong-color=#880000 \
    --ring-color=#ffffff$semitrans \
    --line-uses-inside \
    --keyhl-color=#ffffff \
    --bshl-color=#ffffff \
    --separator-color=#ffffff \
    --verif-color=#ffffff \
    --wrong-color=#880000 \
    --layout-color=#ffffff \
    --date-color=#ffffff \
    --time-color=#ffffff \
    --clock \
    --indicator \
    --time-str="%I:%M %p" \
    --time-size=56 \
    --date-str="%a, %b %e %Y" \
    --date-size=24 \
    --verif-text="" \
    --wrong-text="" \
    --noinput="" \
    --lock-text="Locking..." \
    --lockfailed="Lock Failed" \
    --time-font=$font \
    --date-font=$font \
    --layout-font=$font \
    --verif-font=$font \
    --wrong-font=$font \
    --radius=15 \
    --ring-width=15 \
    --ind-pos="w/2:h/2+60" \
    --time-pos="w/2:h/2-100" \
    --date-pos="w/2:h/2-66" \
    --layout-pos="w/2:h-66" \
    --greeter-pos="w/2:h/2" \
    --pass-media-keys \
    --pass-screen-keys \
    --pass-volume-keys \
    --blur 5 &
  disown

  if [[ ${SUSPEND} == 1 ]]; then
    dunstctl set-paused true
    systemctl suspend
  fi
}

locktwo() {
  betterlockscreen -l dim --time-format "%I:%M %p" -- time-font="Product Sans Regular" & disown
  
  if [[ ${SUSPEND} == 1 ]]; then
    systemctl suspend
  fi
}

# Read arguements provided
case "$1" in
--bg)
  BG_PATH="$2"
  create_cache
  shift
  ;;
--help)
  help
  ;;
--suspend) SUSPEND=1 ;;
esac

locktwo
