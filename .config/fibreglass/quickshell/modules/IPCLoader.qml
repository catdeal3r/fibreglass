import Quickshell
import Quickshell.Io

import QtQuick
import "root:/modules/bar"
import "root:/modules/loadingscreen"
import "root:/modules/settings"
import "root:/modules/launcher"
import "root:/modules"
import "root:/services"

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

		function setWallpaper(path: string): void { Wallpaper.setNewWallpaper(path) } 
		function clearNotif(): void { Notifications.discardAllNotifications() }
	}
}
