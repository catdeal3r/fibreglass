pragma Singleton


import Quickshell
import Quickshell.Io

import QtQuick
import "root:/modules/dashboard"
import "root:/services"


Singleton {
	id: root
	property bool isDashboardOpen: false
	property bool isLauncherOpen: false
	
	function toggleDashboard() {
		root.isDashboardOpen = !root.isDashboardOpen
	}
	
	function toggleLauncher() {
		root.isLauncherOpen = !root.isLauncherOpen
	}
}
