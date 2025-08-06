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
		id: background
		source: Config.settings.currentWallpaper
		fillMode: Image.PreserveAspectCrop
			
		anchors.fill: parent
	}
	
	MultiEffect {
		id: darkenEffect
		source: background
		anchors.fill: background
		
		brightness: -0.2
	}
	
				
	MultiEffect {
		id: blurEffect
		source: background
		anchors.fill: background
						
		blurEnabled: true
		autoPaddingEnabled: true
		blur: 1.0
		blurMultiplier: 4
		opacity: clockOpen ? 0 : 1
		
		Behavior on opacity {
			PropertyAnimation {
				duration: 200
				easing.type: Easing.InSine
			}
		}
	}
	
	
	// content
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
	
	//Button {
		//text: "Its not working, let me out"
		//onClicked: context.unlocked();
	//}
}
