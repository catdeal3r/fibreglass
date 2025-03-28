#!/bin/bash

time=$(date +%Y-%m-%d-%H-%M-%S)
geometry=$(xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')
file_loc="$(xdg-user-dir PICTURES)/Screenshots/"
file="Screenshot_${time}_${geometry}.png"
cache_dir="$HOME/.cache/$(whoami)/screenshot_cache/"

if [[ ! -d "$file_loc" ]]; then
  mkdir -p "$file_loc"
fi

if [[ ! -d "$cache_dir" ]]; then
  mkdir -p "$cache_dir"
fi

notify-screenshot() {
  if [[ $(cat "$file_loc/$file") != *"keystroke"* ]]; then
    cp "$file_loc/$file" "$cache_dir/$file"
    /usr/bin/notify-send --icon="$cache_dir/$file" "Screenshot Saved" "Copied to clipboard"
    echo "saved"
  else
    /usr/bin/notify-send "Screenshot cancelled" "Why???? :("
    rm "$file_loc/$file"
    echo "failed"
  fi
}

copy_shot() {
  tee "$file" | xclip -selection clipboard -t image/png
}

cd ${file_loc} && maim -u -f png -s -b 2 |& copy_shot
canberra-gtk-play -i "camera-shutter"

notify-screenshot
