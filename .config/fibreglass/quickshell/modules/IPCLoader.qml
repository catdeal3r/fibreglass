import Quickshell
import Quickshell.Io

import QtQuick
import "root:/modules/bar"
import "root:/modules/loadingscreen"
import "root:/modules/desktop"
import "root:/services"

Scope {
	id: root
	property bool isLoadingScreenOpen: false
	property bool isBarOpen: true
	property bool isDesktopOpen: false
	
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
		id: desktopLoader
		active: root.isDesktopOpen
		
		sourceComponent: Desktop {
			onFinished: root.isDesktopOpen = false
		}
	}
	
	IpcHandler {
		target: "root"
				
		function toggleLoadingScreen(): void { root.isLoadingScreenOpen = !root.isLoadingScreenOpen }
		function toggleBar(): void { root.isBarOpen = !root.isBarOpen }
		function toggleDesktop(): void { root.isDesktopOpen = !root.isDesktopOpen }
		function clearNotif(): void { Notifications.discardAllNotifications() }
	}
}
