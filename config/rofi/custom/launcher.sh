#!/bin/bash

launch_drun() {
  rofi -disable-history -config ~/.config/rofi/custom/drun_rofi.rasi -show drun
}

case $1 in
--drun) launch_drun ;;
esac
