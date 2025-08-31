import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common
import qs.modules.resett.desktop
import qs.modules.resett.desktop.toggles

Rectangle {
	Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
	Layout.preferredWidth: 480
	Layout.preferredHeight: 150
								
	color: Colours.palette.surface
	radius: Config.settings.borderRadius
	
	Rectangle {
		anchors.centerIn: parent
		width: parent.Layout.preferredWidth - 20
		height: parent.Layout.preferredHeight - 35
		radius: Config.settings.borderRadius
		color: Colours.palette.surface_container
		
		
		ClippingWrapperRectangle {
			radius: Config.settings.borderRadius
																
			anchors.fill: parent
										
			color: "transparent"
			
																				
			Image {
				source: Config.settings.currentWallpaper
			}
		}
		
		
		
		Rectangle {
			id: base
			property bool isPowermenuOpen: false
		
			anchors.centerIn: parent
			width: parent.width - 35
			height: parent.height - 40
			radius: Config.settings.borderRadius
			color: Colours.palette.surface
			
			
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
				implicitHeight: 150
				
				visible: !base.isPowermenuOpen
				
				Behavior on implicitHeight {
					PropertyAnimation {
						duration: 400
						easing.type: Easing.InSine
					}
				}
				
				clip: true
				
				anchors.fill: parent
				spacing: 5
						
				RowLayout {
					Layout.alignment: Qt.AlignLeft
					Layout.preferredHeight: 150
					Layout.preferredWidth: 220
												
					spacing: 0
												
					ClippingWrapperRectangle {
						radius: Config.settings.borderRadius
																
						Layout.alignment: Qt.AlignLeft
						Layout.preferredWidth: 50
						Layout.preferredHeight: 50
						Layout.leftMargin: 15
												
						color: "transparent"
						border.width: 2
						border.color: Colours.palette.outline_variant
																				
						IconImage {
							source: `file:/${Quickshell.shellDir}/assets/pfp.png`
							asynchronous: true
						}
					}
												
					ColumnLayout {
						Layout.alignment: Qt.AlignLeft
						Layout.preferredWidth: 110
						spacing: 5
												
						Text {
							Layout.alignment: Qt.AlignLeft
														
							text: User.username
							font.family: Config.settings.font
							font.pixelSize: 17
															
							font.weight: 600
															
							color: Colours.palette.on_surface
						}
													
						Text {
							Layout.alignment: Qt.AlignLeft
														
							text: `Up: ${User.uptime}`
							font.family: Config.settings.font
							font.pixelSize: 9
														
															
							color: Colours.palette.primary
						}
					}
				}
				
				RowLayout {
					Layout.alignment: Qt.AlignRight
					Layout.rightMargin: 20
					
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
	}
}
