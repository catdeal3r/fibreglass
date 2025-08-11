import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.modules
import qs.modules.common.desktop
import qs.config
import qs.modules.common

Scope {
	signal finished();
	id: root
	
	Variants {
		model: Quickshell.screens;
  
		PanelWindow {
			id: desktopWindow
			
			property var modelData
			screen: modelData
			
			anchors {
				top: true
				bottom: true
				left: true
				right: true
			}

			color: "transparent"
			
			visible: true
			aboveWindows: false
			
			exclusionMode: ExclusionMode.Ignore
			exclusiveZone: 0
			
			Image {
				id: background
				anchors.fill: parent
				source: Config.settings.currentWallpaper
			}
			
			MultiEffect {
				id: darkenEffect
				source: background
				anchors.fill: background
				opacity: {
					if (Config.settings.currentRice == "cavern") {
						if (colorQuantizer.colors[0].hslLightness > 0.5)
							return 1
					}
					return 0
				}
				
				brightness: -0.5
			}
			
			ColorQuantizer {
				id: colorQuantizer
				source: Qt.resolvedUrl(Config.settings.currentWallpaper)
				depth: 0 
				rescaleSize: 128
			}
		}
	}
}
