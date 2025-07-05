import Quickshell
import Quickshell.Io
import QtQuick

import "root:/config"

Scope {
	signal finished();
	id: root
	
	FloatingWindow {
		id: settingsWindow
			
		minimumSize: "100x100"
		maximumSize: "101x101"
		
		color: Colours.palette.surface
	}
}
