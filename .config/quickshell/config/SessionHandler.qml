
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

Singleton {
	id: root
	
	function loadBasicSession() {
		Quickshell.execDetached(["bspc", "config", "left_padding", "20"])
		Quickshell.execDetached(["bspc", "config", "right_padding", "20"])
		Quickshell.execDetached(["bspc", "config", "top_padding", "20"])
		Quickshell.execDetached(["bspc", "config", "bottom_padding", "20"])
		Quickshell.execDetached(["bspc", "config", "window_gap", "10"])
		
		Quickshell.execDetached(["$HOME/.config/scripts/wallset_script"])
        Quickshell.execDetached(["$HOME/.config/scripts/setBorders.sh"])
        Quickshell.execDetached(["sh", "-c", `picom --corner-radius 20 --config ${Quickshell.env("HOME")}/.config/picom/picom.conf > /dev/null 2>&1 & disown`])
	}
	
	function toggleMinimalMode() {
		Config.settings.isInMinimalMode = !Config.settings.isInMinimalMode;
	}
}
