#!/usr/bin/env bash

time=$(date +%Y-%m-%d-%H-%M-%S)
file="Screenshot_${time}.png"
file_loc="$(xdg-user-dir PICTURES)/Screenshots/"
cache_dir="$HOME/.cache/$(whoami)/screenshot_cache/"

if [[ ! -d "$file_loc" ]]; then
  mkdir -p "$file_loc"
fi

if [[ ! -d "$cache_dir" ]]; then
  mkdir -p "$cache_dir"
fi


notify-screenshot() {
   cp "$file_loc/$file" "$cache_dir/$file"
   action=$(notify-send --action="View" --action="Open Folder" --icon="$cache_dir/$file" "Screenshot Saved" "Copied to clipboard")
   echo "saved"
   if [[ "$action" == "0" ]]; then
     xdg-open "$file_loc/$file"
   elif [[ "$action" == "1" ]]; then
     xdg-open "$file_loc"
  fi
}

copy_shot() {
  tee "$file" | wl-copy --type image/png
}

screenshot_select() {
  cd ${file_loc}
  if [[ $? == 0 ]]; then
    selection="$(slurp)"
    if [[ $? == 0 ]]; then
      grim -l 0 -g "$selection" - | copy_shot
      canberra-gtk-play -i "camera-shutter"
      notify-screenshot
    else
      notify-send "Screenshot cancelled"
      rm "$file_loc/$file"
      echo "failed"
    fi
  fi
}

screenshot_all() {
  cd ${file_loc}
  if [[ $? == 0 ]]; then
    grim -l 0 | copy_shot
    canberra-gtk-play -i "camera-shutter"
    notify-screenshot
  fi
}

case $1 in
--select) screenshot_select ;;
--all) screenshot_all ;;
esac

