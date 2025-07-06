
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	
	function loadBasicSession() {
		console.log(`Bar location: ${Config.settings.barLocation}`)
	}
}
