
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	function loadWallpaper() {
		
	}
	
	function setNewWallpaper(path) {
		Quickshell.execDetached(["matugen", "image", `${path}`])
		Quickshell.execDetached(["$HOME/.config/fibreglass/scripts/setBorders.sh"])
		Quickshell.execDetached(["lockbspwm", "--bg", `\"${path}\"`])
		
		Config.settings.currentWallpaper = `${path}`
		
		Quickshell.execDetached(["notify-send", "Wallpaper and theme set!", "Log out and in for the gtk theme to take effect."])
	}
}
