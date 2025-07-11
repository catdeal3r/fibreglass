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
	property bool isHovered: false
	property var toRun
	property string iconName
	
	property string bgColour: Colours.palette.surface
	property string colour: Colours.palette.on_surface
	
	property string bgColourHovered: Colours.palette.surface_container
	property string colourHovered: Colours.palette.outline
	
	Layout.preferredHeight: 35
	Layout.preferredWidth: 35
	
	radius: Config.settings.borderRadius
	
	color: isHovered ? bgColourHovered : bgColour
	
	Behavior on color {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}
	

	Text {
		anchors.centerIn: parent

		color: isHovered ? colourHovered : colour
		
		Behavior on color {
			PropertyAnimation {
				duration: 200
				easing.type: Easing.InSine
			}
		}
											
		font.family: Config.settings.iconFont
		font.pixelSize: 18
		font.weight: 600
		
		text: iconName
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
			
			onEntered: root.isHovered = true
			onExited: root.isHovered = false
			onClicked: root.toRun()
		}
	}

}
