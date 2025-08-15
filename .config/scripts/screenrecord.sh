#!/bin/sh

CACHE_FILE=$HOME/.cache/$(whoami)/recording_state

mkdir -p "$(dirname "$CACHE_FILE")"
[[ -f "$CACHE_FILE" ]] || echo off >"$CACHE_FILE"

OUTPUT_DIR="$(xdg-user-dir VIDEOS)/Captures"
OUTPUT_FILE="Screencapture_$(date +%Y-%m-%d-%H-%M-%S).mp4"

mkdir -p "$OUTPUT_DIR"

get_state() {
  cat "$CACHE_FILE"
}

if [[ $(get_state) == "off" ]]; then
  cd $OUTPUT_DIR

  echo on >"$CACHE_FILE"

  ffmpeg -f x11grab -s hd1080 -r 25 \
    -v:b 23000 -i :0.0 \
    -f alsa -i hw:0 -g 1 -q:v 0.1 -vcodec libxvid $OUTPUT_FILE &

  notify-send "Recording has started"

else
  killall ffmpeg

  notify-send "Recording has finished" "Check your Videos/Captures folder for output"

  echo off >"$CACHE_FILE"
fi
