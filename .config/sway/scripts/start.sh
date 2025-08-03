#!/bin/bash
#
# Starts other thingys .

export ELECTRON_OZONE_PLATFORM_HINT=wayland

# keyboard handler
pkill fcitx5
fcitx5 -d & disown

# open tablet driver
~/scripts/tools/restart-otd & disown


# borders
~/.config/scripts/setBordersSway.sh


# quickshell
~/.config/scripts/fibreglass --start
