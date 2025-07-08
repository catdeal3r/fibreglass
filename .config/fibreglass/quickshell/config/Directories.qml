
pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root
	
	property string notificationsPath: "root:/cache/notifications.json"
	property string coverArt: "root:/cache/coverArt"
	
}
