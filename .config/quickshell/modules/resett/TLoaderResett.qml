import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.resett.bar
import qs.modules.resett.desktop
import qs.modules.resett.launcher
import qs.modules.resett.lockscreen
import qs.modules.resett.notificationslist

Scope {
	id: root
	property bool isCurrentWorkspaceEmpty: false

	Process {
		id: isCurrentWorkspaceEmptyProc
		running: true
		// why tf does qs logic not work :( ?!?!?!
		command: [ "sh", "-c", "if [[ \"$(swaymsg -t get_workspaces | jq -r '.[] | select(.focus == []).num')\" == \"\" ]]; then echo occupied; else echo unoccupied; fi" ]

		stdout: SplitParser {
			onRead: data => {
				if (data == "occupied") {
					root.isCurrentWorkspaceEmpty = false
				} else {
					root.isCurrentWorkspaceEmpty = true
				}
			}
		}
	}

	Timer {
		running: true
		repeat: true
		interval: 10
		onTriggered: isCurrentWorkspaceEmptyProc.running = true
	}
	
	Desktop {
		isDesktopOpen: {
			if (root.isCurrentWorkspaceEmpty) {
				return true;
			} else if (IPCLoader.isDashboardOpen) {
				return IPCLoader.isDashboardOpen;
			} else {
				return false;
			}
		}
	}
	
	NotificationList {}
	
	Loader {
		active: IPCLoader.isBarOpen
		
		sourceComponent: Bar {
			onFinished: IPCLoader.toggleBar()
		}
	}

	Launcher {
		isLauncherOpen: IPCLoader.isLauncherOpen
	}
	
	Lockscreen {}
}
