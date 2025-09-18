
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.config

Singleton {
	id: root
	
	property int workspaceCount: 8
	property var workspacesState
	property int focusedWorkspace: 1
	property string monitor: "eDP-1"

	function setMonitor(m) {
		root.monitor = m;
	}
	
	function getWorkspaceColour(state) {
		if (state == "ws") return Colours.palette.outline
		if (state == "wso") return Qt.alpha(Colours.palette.on_surface, 0.8)
		return Colours.palette.on_primary
	}
	
	function getWorkspaceSize(state) {
		if (state == "ws") return 15
		if (state == "wso") return 20
		return 40
	}
	
	function getWorkspaceHeight(state) {
		return 10
	}
	
	Process {
		command: [ Quickshell.shellDir + "/scripts/workspaces.out" ]
		running: true
		
		stdout: SplitParser {
			onRead: data => workspacesState = JSON.parse(data)
		}
	}


	Process {
		id: focusedProc
		running: true

		command: {
			if (root.monitor == "eDP-1")
				return [ Quickshell.shellDir + "/scripts/python/exe.sh", "i", "1" ];
			else
				return [ Quickshell.shellDir + "/scripts/python/exe.sh", "i", "2" ];
		}
		
		stdout: SplitParser {
			onRead: data => focusedWorkspace = data
		}
	}

	Timer {
		running: true
		interval: 100
		repeat: true
		onTriggered: {
			focusedProc.running = true
		}
	}
}
