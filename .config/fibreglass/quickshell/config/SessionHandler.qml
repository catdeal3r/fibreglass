
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	property var jsonSettings: JSON.parse(jsonFileSink.text())
	
	property string barLocation: jsonSettings.barLocation
	
	function loadBasicSession() {
		console.log(`Json settings: ${root.jsonSettings}`)
	}
	
	FileView {
		id: jsonFileSink
		path: `${Quickshell.configDir}/settings/settings.json`
		
		watchChanges: true
	}
}
