
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root
	
	property string output
	
	function getBool() {
		if (root.output == "On") return true
		else return false
	}
	
	function getText() {
		if (root.output == "On") return "Nightmode On"
		else return "Nightmode Off"
	}
	
	function getIcon() {
		if (root.output == "On") return "lightbulb"
		else return "light_off"
	}
	
	Process {
		id: isConnectedProc

		command: [ Quickshell.shellDir + "/scripts/Nightmode", "--info" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.output = data
		}
	}

    Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: isConnectedProc.running = true
	}
}
