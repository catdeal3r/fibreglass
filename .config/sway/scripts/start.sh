#!/bin/sh
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

# cursor and stuff theme
gsettings set org.gnome.desktop.interface gtk-theme 'Awesthetic-dark'
swaymsg seat seat0 xcursor_theme GoogleDot-Black 24

# lxpolkit
lxpolkit & disown
