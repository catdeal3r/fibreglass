 
pragma Singleton
 
import Quickshell
import Quickshell.Io
import QtQuick
 
 Singleton {
	id: root
	property string uptime
	property string username
	
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
	
	Process {
		id: usernameProc

		command: [ "whoami" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.username = `${data}`
		}
	}
	
	Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: usernameProc.running = true
	}
}
