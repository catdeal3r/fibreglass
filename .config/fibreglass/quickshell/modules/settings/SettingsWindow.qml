import Quickshell
import Quickshell.Io
import QtQuick

import "root:/config"

Scope {
	signal finished();
	id: root
	
	Variants {
		model: Quickshell.screens;
  
		FloatingWindow {
			id: settingsWindow
		}
	}
}
