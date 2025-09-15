import QtQuick
import QtQuick.Controls
import qs.config

/*Rectangle {
	id: root
	property bool showToolTip: false
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
		
	
	// Three 'Rectangles' to create a border then the actual thing
	Rectangle {
		id: borderBatt
		anchors.centerIn: parent
		height: parent.height - 10
		width: 16
		color: Colours.palette.outline
		
		radius: 5
		
		Rectangle {
			anchors.centerIn: parent
			
			width: parent.width - 2.5
			height: parent.height - 2.5
			color: Colours.palette.surface
		
			radius: 3
			
			Rectangle {
				anchors.right: parent.right
				anchors.bottom: parent.bottom
				
				anchors.rightMargin: 1
				anchors.topMargin: 1
				
				bottomLeftRadius: parent.radius
				bottomRightRadius: parent.radius
				
				topLeftRadius: (Battery.percent == 100) ? parent.radius : 0
				topRightRadius: (Battery.percent == 100) ? parent.radius : 0
				
				// Size the battery rectangle depending on the battery percent
				height: Math.max(0, (parent.height - 2) * (Battery.percent / 100))
				width: parent.width - 2
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
}*/

Text {
	text: {
		if (Battery.charging == false) {
			if (Battery.percent <= 10)
				return "battery_0_bar"
			else if (Battery.percent <= 20)
				return "battery_1_bar"
			else if (Battery.percent <= 30)
				return "battery_2_bar"
			else if (Battery.percent <= 40)
				return "battery_3_bar"
			else if (Battery.percent <= 60)
				return "battery_4_bar"
			else if (Battery.percent <= 80)
				return "battery_5_bar"
			else if (Battery.percent <= 90)
				return "battery_6_bar"
			else 
				return "battery_full"
		} else {
			if (Battery.percent <= 10)
				return "battery_charging_full"
			else if (Battery.percent <= 20)
				return "battery_charging_20"
			else if (Battery.percent <= 30)
				return "battery_charging_30"
			else if (Battery.percent <= 40)
				return "battery_charging_50"
			else if (Battery.percent <= 60)
				return "battery_charging_60"
			else if (Battery.percent <= 80)
				return "battery_charging_80"
			else if (Battery.percent <= 90)
				return "battery_charging_90"
			else 
				return "battery_full"
		}
	}
}
