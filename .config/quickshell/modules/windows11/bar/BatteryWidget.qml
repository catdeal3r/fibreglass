import QtQuick
import QtQuick.Controls
import qs.config

Rectangle {
	id: root
	property bool showToolTip: false
	width: 50
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
		

	Text {
		text: "󱎕"
		color: Colours.palette.outline
		
		font.pixelSize: 9
		
		anchors.right: borderBatt.left
		anchors.top: parent.top
		
		anchors.topMargin: 8.5
	}
	
	
	// Three 'Rectangles' to create a border then the actual thing
	Rectangle {
		id: borderBatt
		anchors.centerIn: parent
		width: 32
		height: 16
		color: Colours.palette.outline
		
		radius: 4
		
		Rectangle {
			anchors.centerIn: parent
			
			
			width: parent.width - 3.5
			height: parent.height - 3.5
			color: Colours.palette.surface
		
			radius: 2
			
			Rectangle {
				anchors.right: parent.right
				anchors.top: parent.top
				
				anchors.rightMargin: 2.25
				anchors.topMargin: 2.25
				
				// Size the battery rectangle depending on the battery percent
				width: Math.max(0, (parent.width - 5) * (Battery.percent / 100))
				height: parent.height - 5
				color: Battery.getBatteryColour(Battery.percent)
				
				radius: 1
			}
		}
	}
	
	// This is to make the next 'Text' object more readable
	Text {
		text: "󱐋"
		color: Colours.palette.surface
		
		font.pixelSize: 30
		anchors.centerIn: parent
		
		topPadding: 0.75
		leftPadding: 0.5
		
		// Check whether the battery is plugged in to show
		visible: {Battery.charging ? true : false}
	}
	
	Text {
		text: "󱐋"
		color: Colours.palette.on_surface
		
		font.pixelSize: 20
		anchors.centerIn: parent
		
		// Check whether the battery is plugged in to show
		visible: {Battery.charging ? true : false}
	}
}
