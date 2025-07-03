import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/modules"
import "root:/modules/bar"
import "root:/config"

Scope {
	id: root
	function runNotify() {
		Quickshell.execDetached(["notify-send", "Protect your eyes.", "Look around and take a break."])
	}
	
	 Timer {
	    interval: Config.minutesBetweenHealthNotif * 60000
	    running: true
	    repeat: true
	    onTriggered: root.runNotify()
	}
}
