
pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

Singleton {
	id: root
	
	function getCurrentPartPath(part) {
		if (part == "bar") {
			if (Config.settings.currentRice == "fibreglass") {
				return 0
			}
		}
	}
}
