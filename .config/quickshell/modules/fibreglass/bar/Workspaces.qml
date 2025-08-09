
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.config

Singleton {
	id: root
	
	property int workspaceCount: 8
	property var workspacesState
	
	function getWorkspaceColour(state) {
		if (state == "ws") return Colours.palette.outline
		if (state == "wso") return Colours.palette.primary
		return Colours.palette.on_surface
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
}
