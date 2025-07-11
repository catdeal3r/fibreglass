import Quickshell
import Quickshell.Io
import QtQuick

import qs.config

Scope {
	signal finished();
	id: root
	
	FloatingWindow {
		id: settingsWindow
			
		minimumSize: "400x100"
		maximumSize: "101x101"
		
		color: Colours.palette.surface
	}
}
