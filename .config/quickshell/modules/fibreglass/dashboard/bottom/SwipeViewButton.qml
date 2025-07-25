import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common

Rectangle {
	id: root
	property bool isSelected: false
	property string selectedText: "Placeholder"
	property string iconCode: "settings"
	property var toRun

	Layout.preferredWidth: isSelected ? 100 : 50
	Layout.preferredHeight: 15
	color: isSelected ? Colours.palette.primary : Colours.palette.surface_container
	radius: Config.settings.borderRadius
	
	Behavior on Layout.preferredWidth {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}
	
	RowLayout {
		anchors.centerIn: parent
		spacing: 2
		
		Text {
			text: iconCode
			font: Config.settings.iconFont
			
			color: isSelected ? Colours.palette.on_primary : Colours.palette.on_surface
			
			
			Behavior on color {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
			
			visible: false
		}
	
		Text {
			text: selectedText
			font: Config.settings.font
			
			
			visible: false //isSelected
			
			Behavior on visible {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
		}
	}
	
	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		
		onClicked: { parent.toRun() }
	}
}
