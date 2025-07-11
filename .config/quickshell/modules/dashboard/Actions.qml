 
pragma Singleton
 
import Quickshell
import Quickshell.Io
import QtQuick

import "root:/config"
 
Singleton {
	id: root
	property bool runReload: false
	
	Process {
		id: reloadProc

		command: [ "bspc", "wm", "-r" ]
		running: runReload
	}
}
