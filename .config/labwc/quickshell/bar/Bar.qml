import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.bar
import qs.config
import qs.common

Scope {
	signal finished();
	id: root
	
	Variants {
		model: Quickshell.screens;
  
		PanelWindow {
			id: barWindow
		
			property var modelData
			screen: modelData
			
			anchors {
				top: (Config.settings.barLocation == "top")
				bottom: (Config.settings.barLocation == "bottom")
				right: true
			}

			color: "transparent"
			
			implicitHeight: barBase.height
			implicitWidth: 550
			
			margins.top: (Config.settings.barLocation == "top") ? 20 : 0
			margins.bottom: (Config.settings.barLocation == "bottom") ? 20 : 0
			margins.right: 20
			
			visible: true
			
			exclusiveZone: barBase.height + 10
									
			Rectangle {
				id: barBase
				anchors.top: parent.top
				anchors.right: parent.right
				height: 50
				width: playerControls.Layout.preferredWidth == 0 ? parent.width - 200 : parent.width
				color: Colours.palette.surface

				Rectangle {
					id: time
					anchors.right: parent.right
					width: 140
					height: barBase.height
					color: Colours.palette.primary
					
					TimeWidget {
						anchors.centerIn: parent

						color: Colours.palette.surface	
						font.family: Config.settings.font
						
						font.pixelSize: 13

					}
				}
									
				RowLayout {
					spacing: 10
					anchors.right: time.right
					anchors.rightMargin: time.width + 10
					anchors.top: parent.top
					anchors.topMargin: 11
					
					SysTray {
						Layout.preferredWidth: (SystemTray.items.values.length * 25)
						
						bar: barWindow
					}
					
					Rectangle {
						Layout.preferredWidth: 90
						color: Colours.palette.surface
						Layout.preferredHeight: 30
						
						radius: Config.settings.borderRadius - 3
																	
						RowLayout {
							spacing: 10
							anchors.fill: parent
							anchors.leftMargin: 10
							
							BluetoothWidget {
								color: Bluetooth.getBool() ? Colours.palette.on_surface : Colours.palette.outline
							
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredWidth: 15
						
								font.pixelSize: 13

								
								MouseArea {
									anchors.fill: parent
									cursorShape: Qt.PointingHandCursor
							
									onClicked: Bluetooth.toggle()
								}
						
							}
						
							NetworkWidget {
								color: Network.getBool() ? Colours.palette.on_surface : Colours.palette.outline
							
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredWidth: 15
						
								font.pixelSize: 13

								MouseArea {
									anchors.fill: parent
									cursorShape: Qt.PointingHandCursor
							
									onClicked: Quickshell.execDetached([ Quickshell.shellDir + "/scripts/network.out" ])
								}
						
							}
					
							BatteryWidget {
								color: {
									if (Battery.percent > 90) return Accents.green
									if (Battery.percent < 40) return Accents.red
									return Colours.palette.on_surface
								}
								font.family: Config.settings.font
								font.pixelSize: 13
							}
						}
					}

					PlayerControls {
						id: playerControls
					}
				}
			}
		}
	}
}
