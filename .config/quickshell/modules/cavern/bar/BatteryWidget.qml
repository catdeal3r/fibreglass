import QtQuick
import QtQuick.Controls
import qs.config

import Quickshell
import Quickshell.Widgets

Rectangle {
	id: root
	property bool showToolTip: false
	width: 20
	color: "transparent"
	
	ToolTip {
		visible: root.showToolTip
		delay: 1000
		timeout: 1000
		text: `Battery is at ${Battery.percent}%`
		
		Behavior on visible {
			PropertyAnimation {
				duration: 175
				easing.type: Easing.InSine
			}
		}
		
		Component.onCompleted: {
			root.showToolTip = false
		}
	}
	
	
	
	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onEntered: { parent.showToolTip = true }
		onExited: { parent.showToolTip = false }
	}
	
	ClippingRectangle {
		anchors.centerIn: parent
			
		width: 15
		height: 20
		color: Colours.palette.surface
		
		border.color: Colours.palette.outline
		border.width: 2
	
		radius: 4
		
		clip: true
		
		Text {
			text: "󱐋"
			color: Battery.getBatteryColour(Battery.percent)
			
			font.pixelSize: 15
			anchors.centerIn: parent
				
			// Check whether the battery is plugged in to show
			visible: Battery.charging ? true : false
		}
		
		Rectangle {
			anchors.bottom: parent.bottom
			
			// Size the battery rectangle depending on the battery percent
			width: parent.width
			height: Math.max(0, parent.height * (Battery.percent / 100))
			color: Battery.getBatteryColour(Battery.percent)
			
			bottomLeftRadius: parent.radius
			bottomRightRadius: parent.radius
			
			clip: true
			
			Text {
				text: "󱐋"
				color: Colours.palette.surface
				
				font.pixelSize: 15
				anchors.bottom: parent.top
				anchors.bottomMargin: -13
				
				anchors.left: parent.left
				anchors.leftMargin: (parent.width / 2) - ((font.pixelSize - 6) / 2)
				
				// Check whether the battery is plugged in to show
				visible: Battery.charging ? true : false
			}
		}
	}
}
