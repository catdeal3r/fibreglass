import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import "root:/config"
import "root:/modules/common"
import "root:/services"
import "root:/modules/dashboard/notifications"

Rectangle {
	id: root
	
	height: 370
	width: 400
	
	anchors.top: parent.top
	anchors.topMargin: 10
			
	radius: Config.settings.borderRadius
	color: Colours.palette.surface
	
	ColumnLayout {
	
		Text {
			Layout.topMargin: 15
			Layout.leftMargin: 15
			color: Colours.palette.on_surface
			text: "Bluetooth"
			font.family: Config.settings.font
			font.pixelSize: 15
			
			font.weight: 600
			
			Layout.preferredWidth: 290
		}
		
		ListView {
			model: ScriptModel {
				values: Bluetooth.devices
			}
			
			delegate: Text {
				required property var modelData
				text: modelData.name
				color: "#FFFFFF"
			}
		}
	}
}
