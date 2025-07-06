
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	// Load settings from json
	property var settings: jsonAdapterConfig
	
	property SettingsDerived derivedSettings: SettingsDerived {}
	component SettingsDerived: QtObject {
		property var dashboardAnchorsTop: undefined
		property var dashboardAnchorsBottom: undefined
	}
	
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
			
			property int minutesBetweenHealthNotif: 15
			property string barLocation: "bottom"
			
			// Change things depending on the config's setup
			
			onBarLocationChanged: {
				if (barLocation == "top") {
					Quickshell.execDetached(["bspc", "config", "top_padding", "55"])
					Quickshell.execDetached(["bspc", "config", "bottom_padding", "20"])
					
					root.derivedSettings.dashboardAnchorsTop = parent.top
					root.derivedSettings.dashboardAnchorsBottom = undefined
					
				} else if (barLocation == "bottom") {
					Quickshell.execDetached(["bspc", "config", "top_padding", "20"])
					Quickshell.execDetached(["bspc", "config", "bottom_padding", "55"])
					
					root.derivedSettings.dashboardAnchorsTop = undefined
					root.derivedSettings.dashboardAnchorsBottom = parent.bottom
					
				} else {
					console.log(`Can't handle bar position: ${barLocation}`)
				}
			}
		}
	}
}
