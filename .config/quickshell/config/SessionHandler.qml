
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	
	function loadBasicSession() {
		Quickshell.execDetached(["bspc", "config", "left_padding", "20"])
		Quickshell.execDetached(["bspc", "config", "right_padding", "20"])
		Quickshell.execDetached(["bspc", "config", "window_gap", "10"])
		
		Quickshell.execDetached(["$HOME/.config/fibreglass/scripts/wallset_script"])
        Quickshell.execDetached(["$HOME/.config/fibreglass/scripts/setBorders.sh"])
	}
}
