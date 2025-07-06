
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	property var jsonSettings
	
	property string barLocation: jsonSettings.barLocation
	
	function loadBasicSession() {
		onJsonSettingsChanged: {
			console.log(`Json settings: ${root.barLocation}`)
		}
	}
	
	FileView {
		id: jsonFileSink
		path: `${Quickshell.configDir}/settings/settings.json`
		
		watchChanges: true
		
		onTextChanged: root.jsonSettings = JSON.parse(text())
	}
}
