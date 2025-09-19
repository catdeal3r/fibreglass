import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common
import qs.modules.oneb.bar.dashboard
import qs.modules.oneb.bar.dashboard.toggles

Rectangle {
	id: base
	property bool isPowermenuOpen: false
	Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
	Layout.preferredWidth: 415
	Layout.preferredHeight: 100
								
	color: "transparent"
	
	Rectangle {
		visible: base.isPowermenuOpen
			
		/*Behavior on visible {
			PropertyAnimation {
				duration: 400
				easing.type: Easing.InSine
			}
		}*/
					
		anchors.fill: parent
		color: "transparent"
				
				
		HoverHandler {
			id: hoverHandler
			parent: parent
					
			acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
					
			onHoveredChanged: {
				base.isPowermenuOpen = hovered
			}
		}
			
			
		RowLayout {
			anchors.centerIn: parent
					
			width: parent.width - 50
			height: parent.height
					
			PowerButton {
				Layout.alignment: Qt.AlignCenter
						
				iconName: "lock"
						
				toRun: () => Quickshell.execDetached([ "qs", "ipc", "call", "lock", "lock" ])
			}
					
			PowerButton {
				Layout.alignment: Qt.AlignCenter
						
				iconName: "sleep"
						
				toRun: () => Quickshell.execDetached([ "systemctl", "suspend" ])
			}
					
			PowerButton {
				Layout.alignment: Qt.AlignCenter
				
				iconName: "replay"
						
				colourHovered: Accents.red
						
				toRun: () => Quickshell.execDetached(["reboot"])
			}
					
			PowerButton {
				Layout.alignment: Qt.AlignCenter
						
				iconName: "schedule"
						
				colourHovered: Accents.red
			}
						
			PowerButton {
				Layout.alignment: Qt.AlignCenter
					
				iconName: "mode_off_on"
						
				colourHovered: Accents.red
						
				toRun: () => Quickshell.execDetached(["shutdown"])
			}	
		}
	}
			
	RowLayout {
		height: 200
		width: 400
				
		visible: !base.isPowermenuOpen
				
		Behavior on implicitHeight {
			PropertyAnimation {
				duration: 400
				easing.type: Easing.InSine
			}
		}
				
		clip: true
				
		anchors.left: parent.left
		anchors.top: parent.top
		spacing: 5
						
		RowLayout {
			Layout.alignment: Qt.AlignLeft | Qt.AlignTop
			Layout.leftMargin: 20
			Layout.topMargin: 20
			Layout.preferredWidth: 320
												
			spacing: 0

			Text {
				Layout.alignment: Qt.AlignLeft
				text: ""
				color: Colours.palette.on_surface
				font.pixelSize: 30
			}
						
			ColumnLayout {
				Layout.alignment: Qt.AlignLeft
				Layout.preferredWidth: 110
				spacing: 5
												
				Text {
					Layout.alignment: Qt.AlignLeft
														
					text: "Feather"
					font.family: Config.settings.font
					font.pixelSize: 20
															
					font.weight: 600
														
					color: Colours.palette.on_surface
				}
													
				Text {
					Layout.alignment: Qt.AlignLeft
														
					text: "v0.3"
					font.family: Config.settings.font
					font.pixelSize: 13
																											
					color: Colours.palette.outline
				}
			}
		}
				
		RowLayout {
			Layout.alignment: Qt.AlignRight | Qt.AlignTop
			Layout.rightMargin: 20
			Layout.topMargin: 30
					
			spacing: 8
					
			QuickActionButton {
				iconName: "replay"
				toRun: () => Quickshell.execDetached(["bspc", "wm", "-r"])
			}
					
			QuickActionButton {
				iconName: "settings"
			}
						
			QuickActionButton {
				iconName: "mode_off_on"
				
				bgColour: Colours.palette.tertiary
				colour: Colours.palette.on_tertiary
						
				bgColourHovered: Colours.palette.tertiary_container
				colourHovered: Colours.palette.on_tertiary_container
						
				toRun: () => base.isPowermenuOpen = true
			}
		}
	}
}
