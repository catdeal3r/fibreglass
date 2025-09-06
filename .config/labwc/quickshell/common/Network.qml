
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root
	
	property string textLabel
	
	function getBool() {
		if (root.textLabel == "Disconnected") return true
		if (root.textLabel == "Network Off") return false
		else return true
	}
	
	function getIcon() {
		if (root.textLabel == "Disconnected") return "signal_wifi_statusbar_not_connected"
		if (root.textLabel == "Network Off") return "signal_wifi_bad"
		else return "signal_wifi_4_bar"
	}
	
	Process {
		id: isConnectedProc

		command: [ Quickshell.shellDir + "/scripts/network.out", "--info" ]
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
