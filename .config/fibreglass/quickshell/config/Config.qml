
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	// Load settings from json
	property var settings: jsonAdapterConfig
	
	FileView {
		id: jsonFileSink
		path: `${Quickshell.configDir}/settings/settings.json`
		
		watchChanges: true
		onFileChanged: reload()
		
		onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }
        
        JsonAdapter {
			id: jsonAdapterConfig
			
			property string barLocation: "bottom"
			property int minutesBetweenHealthNotif: 15
			
			
			// Change things depending on the config's setup
			
			onBarLocationChanged: {
				if (barLocation == "top") {
					Quickshell.execDetached(["bspc", "config", "top_padding", "55"])
					Quickshell.execDetached(["bspc", "config", "bottom_padding", "20"])
				} else if (barLocation == "bottom") {
					Quickshell.execDetached(["bspc", "config", "top_padding", "20"])
					Quickshell.execDetached(["bspc", "config", "bottom_padding", "55"])
				} else {
					console.log(`Don't have support for bar position: ${barLocation}`)
				}
			}
		}
	}
}
