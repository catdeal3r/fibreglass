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

	CaveDashboard {
		isDashboardOpen: IPCLoader.isDashboardOpen
	}
	
	
	CaveNotificationList {}
	
	Loader {
		active: IPCLoader.isBarOpen
		
		sourceComponent: CaveBar {
			onFinished: IPCLoader.toggleBar()
		}
	}

	Launcher {
		isLauncherOpen: IPCLoader.isLauncherOpen
	}
	
	CaveLockscreen {}
}
