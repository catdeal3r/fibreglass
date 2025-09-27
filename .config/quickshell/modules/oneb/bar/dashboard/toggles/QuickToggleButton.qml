import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common

ColumnLayout {
	id: root
	
	property bool isHovered: false
	property bool isToggled: false
	
	property var toRun

	property string bgColour: Colours.palette.primary
	property string colour: Colours.palette.on_primary
	property string colourText: Colours.palette.on_surface
	
	property string bgColourHovered: Colours.palette.primary
	property string colourHovered: Colours.palette.on_primary
	property string colourTextHovered: Colours.palette.on_surface
	
	property string bgColourUntoggled: Colours.palette.surface_container
	property string colourUntoggled: Colours.palette.on_surface_variant
	property string colourTextUntoggled: Colours.palette.outline
	
	property string bgColourHoveredUntoggled: Colours.palette.primary_container
	property string colourHoveredUntoggled: Colours.palette.on_primary_container
	property string colourTextHoveredUntoggled: Colours.palette.on_surface_variant
	
	
	property string bigText: "Placeholder"
	property string iconCode: "settings"
	property real iconSize: 22
	
	function doToggle() {
		root.toRun()
	}

	width: 100
	height: 100
	
	function getColourBg() {
		if (root.isToggled) {
			if (root.isHovered) {
				return root.bgColourHovered
			}
			return root.bgColour
		}
		if (root.isHovered) {
			return root.bgColourHoveredUntoggled
		}
		return root.bgColourUntoggled
	}
	
	function getColour() {
		if (root.isToggled) {
			if (root.isHovered) {
				return root.colourHovered
			}
			return root.colour
		}
		if (root.isHovered) {
			return root.colourHoveredUntoggled
		}
		return root.colourUntoggled
	}

	function getColourText() {
		if (root.isToggled) {
			if (root.isHovered) {
				return root.colourTextHovered
			}
			return root.colourText
		}
		if (root.isHovered) {
			return root.colourTextHoveredUntoggled
		}
		return root.colourTextUntoggled
	}
	
	
	Rectangle {
		Layout.alignment: Qt.AlignHCenter
			
		width: 75
		height: 55
		color: root.getColourBg()

		radius: Config.settings.borderRadius

		Behavior on color {
			PropertyAnimation {
				duration: 200
				easing.type: Easing.InSine
			}
		}
		
		Text {
			anchors.centerIn: parent
				
			text: iconCode
			font.family: Config.settings.iconFont
				
			font.pixelSize: root.iconSize
			font.weight: 500
			color: root.getColour()
				
			Behavior on color {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
		}

		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			
			cursorShape: Qt.PointingHandCursor
			
			onEntered: root.isHovered = true
			onExited: root.isHovered = false
			onClicked: root.doToggle()
		}
	}
		
	Rectangle {
		Layout.alignment: Qt.AlignHCenter
			
		width: 80
		height: 30
		color: "transparent"
			
		Text {
			anchors.centerIn: parent
			text: bigText
			font.family: Config.settings.font
			
			font.pixelSize: 15
			font.weight: 600
				
			color: root.getColourText()
				
			Behavior on color {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
		}
	}
}
