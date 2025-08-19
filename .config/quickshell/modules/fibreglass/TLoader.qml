import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.fibreglass.bar
import qs.modules.fibreglass.dashboard
import qs.modules.fibreglass.launcher
import qs.modules.fibreglass.lockscreen
import qs.modules.fibreglass.notificationslist

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
