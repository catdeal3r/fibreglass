import QtQuick
import Quickshell.Io
import QtQuick.Effects
import Quickshell.Wayland

import qs.modules.windows11.lockscreen
import qs.modules.windows11.lockscreen.surface
import qs.config

Rectangle {
	id: root
	color: "transparent"
	anchors.fill: parent
	
	property string time
	property string date
	
	visible: (opacity == 0) ? false : true
	
	Behavior on opacity {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}
 
    Process {
		id: timeProc

		command: [ "date", "+%-I:%M" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.time = `${data}`
		}
	}

    Timer {
	    interval: 500
	    running: true
	    repeat: true
	    onTriggered: timeProc.running = true
	}
	
	Process {
		id: dateProc

		command: [ "date", "+%A, %B %-d" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.date = `${data}`
		}
	}

    Timer {
	    interval: 500
	    running: true
	    repeat: true
	    onTriggered: dateProc.running = true
	}

	Text {
		id: timeText
		color: Colours.palette.on_surface
	
		font.family: Config.settings.font
		font.weight: 700
		
		font.pointSize: 76

		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 250

		text: root.time
	}
	
	Text {
		color: Colours.palette.on_surface
	
		font.family: Config.settings.font
		font.weight: 400
		
		font.pointSize: 21

		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: timeText.bottom
		anchors.topMargin: 5

		text: root.date
	}
}
