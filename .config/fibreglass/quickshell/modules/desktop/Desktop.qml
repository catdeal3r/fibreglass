import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "root:/modules"
import "root:/modules/bar"
import "root:/config"

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
				bottom: true 
				left: true
				right: true
				top: true
			}

			aboveWindows: false 
			color: Colours.palette.surface
			
		}
	}
}
