import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.cavern.bar
import qs.modules.cavern.dashboard
import qs.modules.cavern.launcher
import qs.modules.cavern.lockscreen
import qs.modules.cavern.notificationslist

Scope {

	LazyLoader {
		active: IPCLoader.isDashboardOpen
		
		onActiveChanged: console.log(`Is dashboard loader active: ${active}`)
		
		CaveDashboard {}
	}
	
	CaveNotificationList {}
	
	Loader {
		active: IPCLoader.isBarOpen
		
		sourceComponent: CaveBar {
			onFinished: IPCLoader.toggleBar()
		}
	}
	
	CaveLockscreen {}
}
