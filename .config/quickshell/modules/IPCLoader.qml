import Quickshell
import Quickshell.Io

import QtQuick
import qs.modules.fibreglass.bar
import qs.modules.fibreglass.loadingscreen
import qs.modules.fibreglass.launcher
import qs.modules.fibreglass.dashboard
import qs.modules.fibreglass.notificationslist

import qs.modules.windows11.bar
import qs.modules.windows11.launcher
import qs.modules.windows11.dashboard
import qs.modules.fibreglass.notificationslist

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
		
		sourceComponent: Config.settings.currentRice == "fibreglass" ? dashboardFibreglass : dashboardWindows
		
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
	}
	
	Loader {
		id: notifLogLoader
		active: root.isNotifLogLoaded 
		
		sourceComponent: Config.settings.currentRice == "fibreglass" ? notifLogFibreglass : notifLogWindows
		
		Component {
			id: notifLogFibreglass

			Dashboard {
				onFinished: root.isNotifLogLoaded = false
			}
		}
		
		Component {
			id: notifLogWindows

			WinDashboard {
				onFinished: root.isNotifLogLoaded = false
			}
		}
	}
	
	Loader {
		id: barLoader
		active: root.isBarOpen

		sourceComponent: Config.settings.currentRice == "fibreglass" ? barFibreglass : barWindows
		
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
		
		function toggleBar(): void { 
			root.isBarOpen = !root.isBarOpen;
			Quickshell.execDetached(["pkill", "qsBarHide"]);
			Quickshell.execDetached(["sh", "-c", "$HOME/.config/scripts/qsBarHide.sh > /dev/null 2>&1 & disown"])
		}
		
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
