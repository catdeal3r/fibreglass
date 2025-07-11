#!/bin/bash

time=$(date +%Y-%m-%d-%H-%M-%S)
geometry=$(xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')
file="Screenshot_${time}_${geometry}.png"
file_loc="$(xdg-user-dir PICTURES)/Screenshots/"
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
    action=$(/usr/bin/notify-send --action="View" --action="Open Folder" --icon="$cache_dir/$file" "Screenshot Saved" "Copied to clipboard")
    echo "saved"
    if [[ "$action" == "0" ]]; then
      xdg-open "$file_loc/$file"
    elif [[ "$action" == "1" ]]; then
      xdg-open "$file_loc"
    fi
  else
    /usr/bin/notify-send "Screenshot cancelled" ""
    rm "$file_loc/$file"
    echo "failed"
  fi
}

copy_shot() {
  tee "$file" | xclip -selection clipboard -t image/png
}

screenshot_select() {
  cd ${file_loc} && maim -u -f png -s -b 2 |& copy_shot
  canberra-gtk-play -i "camera-shutter"
  notify-screenshot
}

screenshot_all() {
  cd ${file_loc} && maim -u -f png |& copy_shot
  canberra-gtk-play -i "camera-shutter"
  notify-screenshot
}

case $1 in
--select) screenshot_select ;;
--all) screenshot_all ;;
esac

