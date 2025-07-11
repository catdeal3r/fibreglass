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
	width: 30
	height: 30
	
	property string bgColour: Colours.palette.surface
	property string colour: Colours.palette.on_surface
	
	property string bgColourHovered: Colours.palette.surface_container
	property string colourHovered: Colours.palette.outline
	
	color: root.isHovered ? root.bgColourHovered : root.bgColour
	radius: Config.settings.borderRadius
	
	Text {
		id: icon
		anchors.centerIn: parent
		font.pixelSize: 20
		color: root.isHovered ? root.colourHovered : root.colour
		text: root.iconName
		font.family: Config.settings.iconFont
	}
	
	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		cursorShape: Qt.PointingHandCursor
		
		onEntered: {
			root.isHovered = true
		}
				
		onExited: {
			root.isHovered = false
		}
				
		onClicked: root.toRun();
	}
}
