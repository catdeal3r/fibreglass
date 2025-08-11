pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config
import qs.services

Singleton {
	id: root
	property bool isLoadingScreenOpen: false
	property bool isBarOpen: true
	property bool isSettingsOpen: false
	
	property bool isDashboardOpen: false
	
	property bool isLauncherOpen: false
	property bool isLockscreenOpen: false
	
	function toggleLoadingScreen() {
		root.isLoadingScreenOpen = !root.isLoadingScreenOpen
	}
	
	function toggleBar() {
		root.isBarOpen = !root.isBarOpen
	}
	
	function toggleSettings() {
		root.isSettingsOpen = !root.isSettingsOpen
	}
	
	function toggleDashboard() {
		root.isDashboardOpen = !root.isDashboardOpen
	}
	
	function toggleLauncher() {
		root.isLauncherOpen = !root.isLauncherOpen
	}
	
	function toggleLockscreen() {
		root.isLockscreenOpen = !root.isLockscreenOpen
	}
	
	IpcHandler {
		target: "root"
		
		function toggleLoadingScreen(): void { root.toggleLoadingScreen() }
		
		function toggleBar(): void { root.toggleBar() }
		
		function toggleSettings(): void { root.toggleSettings() }
		
		function toggleDashboard(): void { root.toggleDashboard() }
		
		function toggleLauncher(): void { root.toggleLauncher() }
		
		function toggleLockscreen(): void { root.toggleLockscreen() }

		function setWallpaper(path: string): void { Wallpaper.setNewWallpaper(path) } 
		function clearNotifs(): void { Notifications.discardAllNotifications() }
	}
}
