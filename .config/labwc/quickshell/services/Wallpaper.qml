
pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

Singleton {
	id: root
	
	function loadWallpaper() {
		Quickshell.execDetached(["feh", "--bg-fill", `${Config.settings.currentWallpaper}`]);
	}
	
	function setNewWallpaper(path) {
		Config.settings.currentWallpaper = `${path}`;
		Quickshell.execDetached(["matugen", "--type", `${Config.settings.colours.genType}`, "--mode", `${Config.settings.colours.mode}`, "image", `${path}`]);

		Quickshell.execDetached(["notify-send", "Wallpaper and theme set!", "Log out and in for the gtk4 theme to take effect."]);
		Quickshell.execDetached(["$HOME/.config/fibreglass/scripts/setBordersSway.sh"]);
	}
	
	function changeColourProp() {
		Quickshell.execDetached(["matugen", "--type", `${Config.settings.colours.genType}`, "--mode", `${Config.settings.colours.mode}`, "image", `${Config.settings.currentWallpaper}`]);
		Quickshell.execDetached(["$HOME/.config/fibreglass/scripts/setBordersSway.sh"]);
	}
}
