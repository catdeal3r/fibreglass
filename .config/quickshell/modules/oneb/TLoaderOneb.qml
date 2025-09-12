import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.oneb.bar
import qs.modules.oneb.dashboard
import qs.modules.oneb.launcher
import qs.modules.oneb.lockscreen
import qs.modules.oneb.notificationslist

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
