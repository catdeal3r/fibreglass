
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	property var jsonSettings
	
	property string barLoc: jsonSettings.barLocation
	
	function loadBasicSession() {
		onJsonSettingsChanged: {
			console.log(`Bar loc: ${root.barLoc}`)
		}
	}
	
	FileView {
		id: jsonFileSink
		path: `${Quickshell.configDir}/settings/settings.json`
		
		watchChanges: true
		
		onTextChanged: {
			root.jsonSettings = JSON.parse(text())
		}
	}
}
