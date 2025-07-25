 
pragma Singleton
 
import Quickshell
import Quickshell.Io
import QtQuick

import qs.config
 
 Singleton {
	id: root
	property string percent
	property bool charging
	
	function getBatteryColour(percent) {
		if (percent >= 40) return Accents.green
		return Accents.red
	}
	
    Process {
		id: batProc

		command: [ "cat", "/sys/class/power_supply/BAT0/capacity" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.percent = `${data}`
		}
	}
	
	Process {
		id: batProcStatus

		command: [ "cat", "/sys/class/power_supply/BAT0/status" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.charging = data === "Charging"
		}
	}

    Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: batProc.running = true
	}
	
	Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: batProcStatus.running = true
	}
}
