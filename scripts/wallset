#!/bin/bash

# vars
wallpaper=$1
EWW_ACCENT="$HOME/.config/eww/accent.scss"
ROFI_ACCENT="$HOME/.config/rofi/custom/accent_rofi.rasi"

# check whether wallpaper exists
if [[ -f "$wallpaper" ]]; then
  echo "[i] Wallpaper exists, continuing .... "
else
  echo "Failed to stat wallpaper."
  exit
fi

# set wallpaper
feh --bg-fill "$wallpaper"
echo "[i] Set wallpaper"

# update eww's accent colour
wal -q -s -l -t -i $wallpaper

linenum="$(cat ~/.cache/wal/colors.css | grep -no "\--color6" | tr -d ':colr-' | head -c-2)"
accent_color=$(cat ~/.cache/wal/colors.css | sed -n $linenum'p' | tail -c+15)

echo "\$accent: $accent_color" >"$EWW_ACCENT"
echo "[i] Updated eww accent colour"

# update rofi's accent colour
#echo "* { accent: $accent_color }" >"$ROFI_ACCENT"
#echo "[i] Updated rofi accent colour"

# update lockscreen
betterlockscreen -u "$wallpaper"

# update rofi
rm $HOME/.config/rofi/image.jpg
cp "$wallpaper" $HOME/.config/rofi/image.jpg

# update startup wallpaper script
echo "feh --bg-fill '$wallpaper' & disown" >~/.config/bspwm/scripts/wallset_script
echo "[i] Updated wallpaper startup script"
