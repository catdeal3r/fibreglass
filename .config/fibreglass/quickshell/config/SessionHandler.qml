
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	property var jsonSettings
	
	property string barLoc: jsonSettings.barLocation
	
	onJsonSettingsChanged: {
		console.log(`Bar loc: ${root.barLoc}`)
	}
	
	function loadBasicSession() {
		
	}
	
	FileView {
		id: jsonFileSink
		path: `${Quickshell.configDir}/settings/settings.json`
		
		watchChanges: true
		onFileChanged: reload()
		
		onTextChanged: {
			root.jsonSettings = JSON.parse(text())
		}
	}
}
