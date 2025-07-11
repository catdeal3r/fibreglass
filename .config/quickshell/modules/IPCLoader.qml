import Quickshell
import Quickshell.Io

import QtQuick
import qs.modules.bar
import qs.modules.loadingscreen
import qs.modules.settings
import qs.modules.launcher
import qs.modules
import qs.services

Scope {
	id: root
	property bool isLoadingScreenOpen: false
	property bool isBarOpen: true
	property bool isSettingsOpen: false
	
	Loader {
		id: barLoader
		active: root.isBarOpen
		
		sourceComponent: Bar {
			onFinished: root.isBarOpen = false
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
		function toggleBar(): void { root.isBarOpen = !root.isBarOpen }
		function toggleSettings(): void { root.isSettingsOpen = !root.isSettingsOpen }
		function toggleLauncher(): void { InternalLoader.isLauncherOpen = !InternalLoader.isLauncherOpen }
		function toggleDashboard(): void { InternalLoader.isDashboardOpen = !InternalLoader.isDashboardOpen }

		function setWallpaper(path: string): void { Wallpaper.setNewWallpaper(path) } 
		function clearNotifs(): void { Notifications.discardAllNotifications() }
	}
}
