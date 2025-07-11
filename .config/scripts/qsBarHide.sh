#!/bin/bash

  bspc subscribe node_state | while read -r _ _ _ _ state flag; do
    if [ "$state" != "fullscreen" ]; then
      continue
    fi
    qs ipc call root toggleBar
  done

