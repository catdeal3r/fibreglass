pragma Singleton


import Quickshell
import Quickshell.Io

import QtQuick

Singleton {
	id: root
	property bool isDashboardOpen: false
	property bool isLauncherOpen: false
	property bool isLockscreenOpen: false
	
	function toggleDashboard() {
		root.isDashboardOpen = !root.isDashboardOpen
	}
	
	function toggleLauncher() {
		root.isLauncherOpen = !root.isLauncherOpen
	}
}
