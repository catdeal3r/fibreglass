import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.windows11.bar
import qs.modules.windows11.dashboard
import qs.modules.windows11.launcher
import qs.modules.windows11.lockscreen
import qs.modules.windows11.notificationslist

Scope {
	
	WinDashboard {}
	WinNotificationList {}
	
	Loader {
		active: IPCLoader.isBarOpen
		
		sourceComponent: WinBar {
			onFinished: IPCLoader.toggleBar()
		}
	}

	Launcher {
		isLauncherOpen: IPCLoader.isLauncherOpen
	}
	
	WinLockscreen {}
}
