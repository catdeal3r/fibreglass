
pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root
	
	property string notificationsPath: Quickshell.configPath("/cache/notifications.json")
	property string coverArt: Quickshell.configPath("/cache/coverArt")
}
