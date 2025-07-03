
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/config"

Singleton {
	id: root
	
	property int workspaceCount
	property var workspacesState
	
	function getWorkspaceColour(state) {
		if (state == "ws") return Colours.palette.outline
		if (state == "wso") return Colours.palette.tertiary
		return Colours.palette.primary
	}
	
	function getWorkspaceSize(state) {
		if (state == "ws") return 15
		if (state == "wso") return 40
		return 60
	}

	Process {
		id: countWorkspaceProc

		command: [ "bspc", "query", "-D", "--names"]
		running: true

		stdout: SplitParser {
			onRead: data => root.workspaceCount = `${data}`
		}
	}

    Timer {
	    interval: 250
	    running: true
	    repeat: true
	    onTriggered: countWorkspaceProc.running = true
	}
	
	Process {
		
		command: [ Qt.resolvedUrl("root:/scripts/workspaces.out") ]
		running: true
		
		stdout: SplitParser {
			onRead: data => workspacesState = JSON.parse(data)
		}
	}
}
