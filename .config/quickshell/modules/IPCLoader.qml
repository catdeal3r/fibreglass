import Quickshell
import Quickshell.Io

import QtQuick
import qs.modules.fibreglass.bar
import qs.modules.fibreglass.loadingscreen
import qs.modules.fibreglass.launcher
import qs.modules.fibreglass.dashboard
import qs.modules.fibreglass.notificationslist
import qs.modules.fibreglass.lockscreen

import qs.modules.cavern.bar
import qs.modules.cavern.loadingscreen
import qs.modules.cavern.launcher
import qs.modules.cavern.dashboard
import qs.modules.cavern.notificationslist
import qs.modules.cavern.lockscreen

import qs.modules.windows11.bar
import qs.modules.windows11.launcher
import qs.modules.windows11.dashboard
import qs.modules.windows11.notificationslist
import qs.modules.windows11.lockscreen

import qs.modules.settings
import qs.modules
import qs.config
import qs.services

Scope {
	id: root
	property bool isLoadingScreenOpen: false
	property bool isBarOpen: true
	property bool isSettingsOpen: false
	
	property bool isDashboardLoaded: true
	property bool isNotifLogLoaded: true
	
	Loader {
		id: dashboardLoader
		active: root.isDashboardLoaded 
		
		sourceComponent: {
			if (Config.settings.currentRice == "fibreglass") {
				return dashboardFibreglass
			} else if (Config.settings.currentRice == "windows") {
				return dashboardWindows
			} else {
				return dashboardCavern
			}
		}
		
		Component {
			id: dashboardFibreglass

			Dashboard {
				onFinished: root.isDashboardLoaded = false
			}
		}
		
		Component {
			id: dashboardWindows

			WinDashboard {
				onFinished: root.isDashboardLoaded = false
			}
		}
		
		Component {
			id: dashboardCavern

			CaveDashboard {
				onFinished: root.isDashboardLoaded = false
			}
		}
	}
	
	Loader {
		id: notifLogLoader
		active: root.isNotifLogLoaded 
		
		sourceComponent: {
			if (Config.settings.currentRice == "fibreglass") {
				return notifLogFibreglass
			} else if (Config.settings.currentRice == "windows") {
				return notifLogWindows
			} else {
				return notifLogCavern
			}
		}
		
		Component {
			id: notifLogFibreglass

			NotificationList {
				onFinished: root.isNotifLogLoaded = false
			}
		}
		
		Component {
			id: notifLogWindows

			WinNotificationList {
				onFinished: root.isNotifLogLoaded = false
			}
		}
		
		Component {
			id: notifLogCavern

			CaveNotificationList {
				onFinished: root.isNotifLogLoaded = false
			}
		}
	}
	
	Loader {
		id: barLoader
		active: root.isBarOpen

		sourceComponent: {
			if (Config.settings.currentRice == "fibreglass") {
				return barFibreglass
			} else if (Config.settings.currentRice == "windows") {
				return barWindows
			} else {
				return barCavern
			}
		}
		
		Component {
			id: barFibreglass

			Bar {
				onFinished: root.isBarOpen = false
			}
		}
		
		Component {
			id: barWindows

			WinBar {
				onFinished: root.isBarOpen = false
			}
		}
		
		Component {
			id: barCavern

			CaveBar {
				onFinished: root.isBarOpen = false
			}
		}
	}
	
	Loader {
		id: lockscreenLoader
		active: true
		
		sourceComponent: {
			if (Config.settings.currentRice == "fibreglass") {
				return lockFibreglass
			} else if (Config.settings.currentRice == "windows") {
				return lockWindows
			} else {
				return lockCavern
			}
		}
		
		Component {
			id: lockFibreglass
			
			Lockscreen {}
		}
		
		Component {
			id: lockWindows
			
			WinLockscreen {}
		}
		
		Component {
			id: lockCavern
			
			CaveLockscreen {}
		}
	}
	
	Loader {
		id: loadingScreenLoader
		active: root.isLoadingScreenOpen
		
		sourceComponent: LoadingScreen {
			onFinished: root.isLoadingScreenOpen = false
		}
	}
	
	Loader {
		id: settingsLoader
		active: root.isSettingsOpen
		
		sourceComponent: SettingsWindow {
			onFinished: root.isSettingsOpen = false
		}
	}
	
	
	IpcHandler {
		target: "root"
				
		function toggleLoadingScreen(): void { root.isLoadingScreenOpen = !root.isLoadingScreenOpen }
		
		function toggleBar(): void { root.isBarOpen = !root.isBarOpen; }
		
		function toggleSettings(): void { root.isSettingsOpen = !root.isSettingsOpen }
		function toggleLauncher(): void { InternalLoader.isLauncherOpen = !InternalLoader.isLauncherOpen }
		function toggleDashboard(): void { InternalLoader.isDashboardOpen = !InternalLoader.isDashboardOpen }
		
		function toggleMinimalMode(): void {
			root.isBarOpen = !root.isBarOpen;
			SessionHandler.toggleMinimalMode();
			Notifications.toggleDND();
		}

		function setWallpaper(path: string): void { Wallpaper.setNewWallpaper(path) } 
		function clearNotifs(): void { Notifications.discardAllNotifications() }
	}
}
