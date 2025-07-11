 
pragma Singleton
 
import Quickshell
import Quickshell.Io
import QtQuick

import "root:/config"
 
 Singleton {
	id: root
	property string uptime
	
    Process {
		id: uptimeProc

		command: [ "bash", "-c", "$HOME/.config/quickshell/scripts/uptime" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.uptime = `${data}`
		}
	}
	
	Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: uptimeProc.running = true
	}
}
