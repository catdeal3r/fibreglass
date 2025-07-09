
pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root
	
	property string notificationsPath: "root:/cache/notifications.json"
	property string coverArt: `${Quickshell.rootDir}/cache/coverArt`
}
