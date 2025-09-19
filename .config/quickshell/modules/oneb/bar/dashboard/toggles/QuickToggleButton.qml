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
	property bool isToggled: false
	
	property var toRun

	property string bgColour: Colours.palette.primary
	property string colour: Colours.palette.on_primary
	
	property string bgColourHovered: Colours.palette.primary
	property string colourHovered: Colours.palette.on_primary
	
	property string bgColourUntoggled: Colours.palette.surface_container
	property string colourUntoggled: Colours.palette.on_surface_variant
	
	property string bgColourHoveredUntoggled: Colours.palette.primary_container
	property string colourHoveredUntoggled: Colours.palette.on_primary_container
	
	property string bigText: "Placeholder"
	property string iconCode: "settings"
	property real iconSize: 22
	
	function doToggle() {
		//root.isToggled = !root.isToggled
		root.toRun()
	}

	width: 200
	height: 60
	
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
	
	color: root.getColourBg()
	
	Behavior on color {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}
	
	radius: Config.settings.borderRadius
	
	RowLayout {
		anchors.fill: parent
		spacing: 0
		
		width: 200
		height: 60
		
		Rectangle {
			Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
			Layout.leftMargin: 15
			
			width: 20
			height: 30
			color: "transparent"
		
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
		}
		
		Rectangle {
			Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
			Layout.leftMargin: 10
			
			width: 140
			height: 30
			color: "transparent"
			
			Text {
				anchors.left: parent.left
				anchors.top: parent.top
				
				anchors.topMargin: parent.height / 5 
				text: bigText
				font.family: Config.settings.font
			
				font.pixelSize: 15
				font.weight: 600
				
				color: root.getColour()
				
				Behavior on color {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}
			}
		}
	}
	
	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		
		cursorShape: Qt.PointingHandCursor
		
		onEntered: parent.isHovered = true
		onExited: parent.isHovered = false
		onClicked: parent.doToggle()
	}
}
