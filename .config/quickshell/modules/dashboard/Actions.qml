 
pragma Singleton
 
import Quickshell
import Quickshell.Io
import QtQuick

 
Singleton {
	id: root
	property bool runReload: false
	
	Process {
		id: reloadProc

		command: [ "bspc", "wm", "-r" ]
		running: runReload
	}
}
