
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
		path: Quickshell.shellDir + "/settings/settings.json"
		
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
			
			property int minutesBetweenHealthNotif: 30
			
			property JsonObject bar: JsonObject {
				property string barLocation: "bottom"
				property bool smoothEdgesShown: false
			}
			
			property string currentWallpaper: Quickshell.shellDir + "/assets/default_blank.png"
			
			onCurrentWallpaperChanged: {
				Wallpaper.loadWallpaper()
			}
			
			property string currentRice: "fibreglass"
			
			onCurrentRiceChanged: {
				if (currentRice == "fibreglass" || currentRice == "windows" || currentRice == "cavern" || currentRice == "wyvern" || currentRice == "resett" || currentRice == "oneb") {
					console.log(`Switched to rice: ${currentRice}`)
					if (currentRice == "wyvern") {
						Quickshell.execDetached(["swaymsg", "default_border", "none"])
					} 
				} else {
					console.log(`Can't handle rice selection: ${currentRice}`)
				}
			}
			
			property string font: "SF Pro Display"
			property string iconFont: "Material Symbols Rounded"
			property int borderRadius: 20
			
			property JsonObject colours: JsonObject {
				property string genType: "scheme-expressive"
				property string mode: "dark"
				
				onGenTypeChanged: {
					Wallpaper.changeColourProp()
				}
				
				onModeChanged: {
					Wallpaper.changeColourProp()
				}
			}
			
			onBorderRadiusChanged: {
				Quickshell.execDetached(["swaymsg", "corner_radius", `${root.settings.borderRadius}`])
			}
			
			property bool isInMinimalMode: false
			
			property string weatherLocation: "REPLACE"
			
			onWeatherLocationChanged: {
				Weather.reload()
			}
			
			onIsInMinimalModeChanged: {
				if (isInMinimalMode == true) {
					Quickshell.execDetached(["swaymsg", "gaps", "outer", "0"])
					Quickshell.execDetached(["swaymsg", "gaps", "inner", "0"])
					Quickshell.execDetached(["swaymsg", "corner_radius", "0"])
					
					Wallpaper.setBlankWall();
					Quickshell.execDetached(["$HOME/.config/scripts/setBordersDefault.sh"])
					
				} else {
					Quickshell.execDetached(["swaymsg", "gaps", "outer", "0"])
					Quickshell.execDetached(["swaymsg", "gaps", "inner", "0"])
					Quickshell.execDetached(["swaymsg", "corner_radius", `${root.settings.borderRadius}`])
					
					
					Wallpaper.loadWallpaper();
					Quickshell.execDetached(["$HOME/.config/scripts/setBorders.sh"])
				}
			}
		}
	}
}
