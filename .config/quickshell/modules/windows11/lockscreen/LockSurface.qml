import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import QtQuick.Effects
import Quickshell.Wayland

import qs.modules.windows11.lockscreen
import qs.modules.windows11.lockscreen.surface
import qs.config

Rectangle {
	id: root
	required property LockContext context
	
	color: "transparent"
	
	property bool clockOpen: true
	
	// background stuff
	Image {
		id: blurBarBackground
		source: Config.settings.currentWallpaper
		fillMode: Image.PreserveAspectCrop
			
		anchors.fill: parent
	}
				
	MultiEffect {
		source: blurBarBackground
		anchors.fill: blurBarBackground
						
		blurEnabled: true
		autoPaddingEnabled: false
		blur: 1.0
		blurMultiplier: 2
	}
	
	ClockPage {
		opacity: clockOpen ? 1 : 0
	}
	
	MouseArea {
		anchors.fill: parent
		onClicked: root.clockOpen = false
	}
	
	UnlockPage {
		lockcontext: context
		opacity: clockOpen ? 0 : 1
	}
	
	Button {
		text: "Its not working, let me out"
		onClicked: context.unlocked();
	}
}
