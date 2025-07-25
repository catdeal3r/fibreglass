
pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

Singleton {
	id: root
	
	function getCurrentBar() {
		Config.settings.currentRice 
	}
}
