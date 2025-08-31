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
		command: [ "sh", "-c", "swaymsg -t get_workspaces | jq '.[] | select(.focus == []).num'" ]

		stdout: SplitParser {
			onRead: data => {
				if (data.trim() == "") {
					root.isCurrentWorkspaceEmpty = false
					console.log('false');
				} else {
					root.isCurrentWorkspaceEmpty = true
					console.log('true');
				}
			}
		}
	}

	Timer {
		running: true
		repeat: true
		interval: 100
		onTriggered: isCurrentWorkspaceEmptyProc.running = true
	}
	
	Desktop {
		isDesktopOpen: IPCLoader.isDashboardOpen//root.isCurrentWorkspaceEmpty
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
