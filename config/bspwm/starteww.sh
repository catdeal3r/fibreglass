#!/bin/bash

$(which eww) daemon & disown

eww_window_id=1

for eww_monitor in $(xrandr -q | grep " connected" | cut -d ' ' -f1); do
	$(which eww) open --toggle bar --id "$eww_window_id" --screen $eww_monitor & disown
	eww_window_id+=1
done

if [[ "$(xrandr -q | grep 'HDMI-1 connected')" != "" ]]; then
	$(which eww) open currentnotificationsbox --screen 1 & disown
else
	$(which eww) open currentnotificationsbox --screen 0 & disown
fi

$(which eww) open keepopen & disown

echo "done"
