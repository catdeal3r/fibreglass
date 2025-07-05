import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import "root:/config"
import "root:/modules/common"
import "root:/modules/dashboard"
import "root:/modules/dashboard/toggles"
import "root:/modules"

Rectangle {
	Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
	Layout.preferredWidth: 480
	Layout.preferredHeight: 150
								
	color: Colours.palette.surface
	radius: Appearance.borderRadius
	
	Rectangle {
		anchors.centerIn: parent
		width: parent.Layout.preferredWidth - 20
		height: parent.Layout.preferredHeight - 35
		radius: Appearance.borderRadius
		color: Colours.palette.surface_container
		
		
		ClippingWrapperRectangle {
			radius: Appearance.borderRadius
																
			anchors.fill: parent
										
			color: "transparent"
																				
			Image {
				source: "../../../wall.png"
			}
		}
		
		
		
		Rectangle {
			id: base
			property bool isPowermenuOpen: false
		
			anchors.centerIn: parent
			width: parent.width - 35
			height: parent.height - 40
			radius: Appearance.borderRadius
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
			
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
						
					onExited: base.isPowermenuOpen = false
				}
			
				RowLayout {
					anchors.centerIn: parent
					
					width: parent.width - 50
					height: parent.height
					
					QuickActionButton {
						Layout.alignment: Qt.AlignCenter
						
						iconName: "replay"
						
						toRun: () => Quickshell.execDetached(["reboot"])
					}
					
					QuickActionButton {
						Layout.alignment: Qt.AlignCenter
						
						iconName: "settings"
					}
					
					QuickActionButton {
						Layout.alignment: Qt.AlignCenter
						
						iconName: "settings"
					}
					
					QuickActionButton {
						Layout.alignment: Qt.AlignCenter
						
						iconName: "settings"
					}
						
					QuickActionButton {
						Layout.alignment: Qt.AlignCenter
						
						iconName: "mode_off_on"
						
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
						radius: Appearance.borderRadius
																
						Layout.alignment: Qt.AlignLeft
						Layout.preferredWidth: 50
						Layout.preferredHeight: 50
						Layout.leftMargin: 15
												
						color: "transparent"
																				
						IconImage {
							source: "root:/assets/pfp.png"
						}
					}
												
					ColumnLayout {
						Layout.alignment: Qt.AlignLeft
						Layout.preferredWidth: 110
						spacing: 5
												
						Text {
							Layout.alignment: Qt.AlignLeft
														
							text: "catdeal3r"
							font.family: Appearance.font
							font.pixelSize: 17
															
							font.weight: 600
															
							color: Colours.palette.on_surface
						}
													
						Text {
							Layout.alignment: Qt.AlignLeft
														
							text: `Up: ${Uptime.uptime}`
							font.family: Appearance.font
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
				
			Item {}
		}
	}
}
