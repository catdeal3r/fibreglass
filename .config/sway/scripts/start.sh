#!/bin/sh
#
# Starts other thingys .

# turn off wifi and bluetooth
nmcli n off
bluetoothctl power off

# mount drive
~/.config/sway/scripts/mount.sh

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

# cursor
swaymsg seat seat0 xcursor_theme GoogleDot-Black 24

