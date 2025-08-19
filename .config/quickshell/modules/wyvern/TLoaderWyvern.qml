import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.wyvern.bar
import qs.modules.wyvern.dashboard
import qs.modules.wyvern.launcher
import qs.modules.wyvern.lockscreen
import qs.modules.wyvern.notificationslist

Scope {
	
	Dashboard {
		isDashboardOpen: IPCLoader.isDashboardOpen
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
