
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	// Load settings from json
	property var settings: jsonAdapterConfig
	property bool isLoaded: false
	
	FileView {
		id: jsonFileSink
		path: `${Quickshell.configDir}/settings/settings.json`
		
		watchChanges: true
		onFileChanged: {
			root.isLoaded = false
			reload()
		}
		
		onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }
        
        onLoaded: {
			root.isLoaded = true
		}
		
        JsonAdapter {
			id: jsonAdapterConfig
			
			property int minutesBetweenHealthNotif: 15
			
			property JsonObject bar: JsonObject {
				property string barLocation: "bottom"
				property bool smoothEdgesShown: false
			
				onBarLocationChanged: {
					if (barLocation == "top") {
						Quickshell.execDetached(["bspc", "config", "top_padding", "55"])
						Quickshell.execDetached(["bspc", "config", "bottom_padding", "20"])
						
					} else if (barLocation == "bottom") {
						Quickshell.execDetached(["bspc", "config", "top_padding", "20"])
						Quickshell.execDetached(["bspc", "config", "bottom_padding", "55"])
						
					} else {
						console.log(`Can't handle bar position: ${barLocation}`)
					}
				}
			}
			
			property string currentWallpaper: ""
		}
	}
}
