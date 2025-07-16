
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
		Quickshell.execDetached(["matugen", "--type", `${Config.settings.colours.genType}`, "--mode", `${Config.settings.colours.mode}`, "image", `${path}`]);
		Quickshell.execDetached(["$HOME/.config/fibreglass/scripts/setBorders.sh"]);
		Quickshell.execDetached(["lockbspwm", "--bg", `\"${path}\"`]);
		
		Config.settings.currentWallpaper = `${path}`;
		
		Quickshell.execDetached(["notify-send", "Wallpaper and theme set!", "Log out and in for the gtk4 theme to take effect."]);
	}
	
	function changeColourProp() {
		Quickshell.execDetached(["matugen", "--type", `${Config.settings.colours.genType}`, "--mode", `${Config.settings.colours.mode}`, "image", `${Config.settings.currentWallpaper}`]);
		Quickshell.execDetached(["$HOME/.config/fibreglass/scripts/setBorders.sh"]);
	}
	
	function setBlankWall() {
		Quickshell.execDetached(["feh", "--bg-fill", `${Quickshell.configPath("assets/default_blank.png")}`]);
	}
}
