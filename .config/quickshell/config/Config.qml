
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config
import qs.services

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
			
			onCurrentWallpaperChanged: {
				Wallpaper.loadWallpaper()
			}
			
			property string font: "SF Pro Display"
			property string iconFont: "Material Symbols Rounded"
			property int borderRadius: 15
			
			onBorderRadiusChanged: {
				Quickshell.execDetached(["killall", "picom"])
				picomTimer.running = true
			}
		}
	}
	
	Timer {
		id: picomTimer
		interval: 100
		running: false
		onTriggered: Quickshell.execDetached(["sh", "-c", `picom --corner-radius ${root.settings.borderRadius} --config ${Quickshell.env("HOME")}/.config/picom/picom.conf > /dev/null 2>&1 & disown`])
	}
}
