
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root
	
	property string textLabel
	
	function getBool() {
		if (root.textLabel == "Not connected") return true
		if (root.textLabel == "Bluetooth Off") return false
		else return true
	}
	
	function getIcon() {
		if (root.textLabel == "Not connected") return "bluetooth_searching"
		if (root.textLabel == "Bluetooth Off") return "bluetooth_disabled"
		else return "bluetooth"
	}
	
	Process {
		id: isConnectedProc

		command: [ Qt.resolvedUrl("root:/scripts/bluetooth.out"), "--info" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.textLabel = data
		}
	}

    Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: isConnectedProc.running = true
	}
}
