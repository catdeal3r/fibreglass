
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
		console.log(`Json settings: ${root.jsonSettings}`)
	}
	
	Process {
		id: getJsonSettingsProc	
		command: [ "cat", Qt.resolvedUrl("root:/settings/settings.json") ]
		running: true
		
		stdout: SplitParser {
			onRead: data => console.log(data) //jsonSettings = JSON.parse(data)
		}
	}

    Timer {
	    interval: 100
	    running: true
	    repeat: true
	    onTriggered: {
			getJsonSettingsProc.running = true
			console.log(root.jsonSettings)
		}
	}
}
