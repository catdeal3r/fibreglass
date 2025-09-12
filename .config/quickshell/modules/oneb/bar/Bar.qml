import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.modules.oneb.bar
import qs.config
import qs.modules.common

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
				top: true
				bottom: true
				left: true
				right: false
			}

			color: "transparent"
			
			implicitWidth: barBase.width + (Config.settings.borderRadius * 2)
			
			visible: true
			
			exclusiveZone: barBase.width + Config.settings.borderRadius
			
			Rectangle {
				id: barBase
				anchors.left: parent.left
				width: 40
				height: parent.height
				color: Colours.palette.surface
				
				/*WorkspacesWidget {
					id: workspaces
					anchors.left: parent.left
					anchors.top: parent.top
				}*/
				
						
				ColumnLayout {
					spacing: 10
					anchors.left: parent.left
					anchors.bottom: parent.bottom
					
					SysTray {
						Layout.preferredHeight: (SystemTray.items.values.length * 25)
						
						bar: barWindow
					}
					
					Rectangle {
						Layout.preferredWidth: 28
						color: Colours.palette.surface
						Layout.preferredHeight: 115
						Layout.leftMargin: 5
						
						radius: Config.settings.borderRadius - 3
						
						Behavior on color {
							PropertyAnimation {
								duration: 200
								easing.type: Easing.InSine
							}
						}
					
						ColumnLayout {
							spacing: 10
							anchors.fill: parent
							
							BluetoothWidget {
								color: Bluetooth.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
							
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredHeight: 15
						
								font.pixelSize: 17
								Layout.leftMargin: 4
							}
						
							NetworkWidget {
								color: Network.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
							
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredHeight: 15
						
								font.pixelSize: 17
								Layout.leftMargin: 4
							}
					
							BatteryWidget {
								Layout.fillWidth: true
								Layout.preferredHeight: 30
							}
					
						}
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor
							
							onEntered: parent.color = Colours.palette.surface_container
							onExited: parent.color = Colours.palette.surface
							onClicked: IPCLoader.toggleDashboard()
						}
					}
					
					TimeWidget {
						color: Qt.alpha(Colours.palette.on_surface, 0.8)
	
						font.family: Config.settings.font
						font.weight: 600

						Layout.preferredHeight: 60
						
						Layout.leftMargin: 9
						
						font.pixelSize: 13

					}
				}
			}
		}
	}
}
