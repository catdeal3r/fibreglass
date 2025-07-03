#!/bin/bash

  bspc subscribe node_state | while read -r _ _ _ _ state flag; do
    if [ "$state" != "fullscreen" ]; then
      continue
    fi
    if [ "$flag" == on ]; then
      qs ipc call root toggleBar
    else
      qs ipc call root toggleBar
    fi
  done

