
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
			
			property int minutesBetweenHealthNotif: 30
			
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
			
			property string currentWallpaper: Quickshell.shellPath("assets/default_blank.png")
			
			onCurrentWallpaperChanged: {
				Wallpaper.loadWallpaper()
			}
			
			property string currentRice: "fibreglass"
			
			onCurrentRiceChanged: {
				if (currentRice == "fibreglass" || currentRice == "windows") {
					console.log(`New rice selected: ${currentRice}`)
					if (currentRice == "windows") {
						Quickshell.execDetached(["bspc", "config", "bottom_padding", "80"])
					} else {
						Quickshell.execDetached(["bspc", "config", "bottom_padding", "55"])
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
				Quickshell.execDetached(["killall", "picom"])
				picomTimer.running = true
			}
			
			property bool isInMinimalMode: false
			
			property string weatherLocation: "REPLACE"
			
			onWeatherLocationChanged: {
				Weather.reload()
			}
			
			onIsInMinimalModeChanged: {
				if (isInMinimalMode == true) {
					Quickshell.execDetached(["bspc", "config", "left_padding", "0"])
					Quickshell.execDetached(["bspc", "config", "right_padding", "0"])
					Quickshell.execDetached(["bspc", "config", "bottom_padding", "0"])
					Quickshell.execDetached(["bspc", "config", "top_padding", "0"])
					Quickshell.execDetached(["bspc", "config", "window_gap", "0"])
					
					Quickshell.execDetached(["pkill", "qsBarHide"])
					Quickshell.execDetached(["pkill", "picom"])
					
					Wallpaper.setBlankWall();
					Quickshell.execDetached(["$HOME/.config/scripts/setBordersDefault.sh"])
					
				} else {
					Quickshell.execDetached(["bspc", "config", "left_padding", "20"])
					Quickshell.execDetached(["bspc", "config", "right_padding", "20"])
					Quickshell.execDetached(["bspc", "config", "window_gap", "10"])
					
					Quickshell.execDetached(["sh", "-c", "$HOME/.config/scripts/qsBarHide.sh > /dev/null 2>&1 & disown"])
					picomTimer.running = true
					
					Wallpaper.loadWallpaper();
					Quickshell.execDetached(["$HOME/.config/scripts/setBorders.sh"])
				}
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
