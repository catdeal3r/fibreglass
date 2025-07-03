
pragma Singleton

import Quickshell
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	readonly property int minutesBetweenHealthNotif: 5
}
