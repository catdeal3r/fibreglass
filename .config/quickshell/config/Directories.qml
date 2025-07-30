
pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root
	
	property string notificationsPath: Quickshell.shellPath("/cache/notifications.json")
	property string coverArt: Quickshell.shellPath("/cache/coverArt")
}
