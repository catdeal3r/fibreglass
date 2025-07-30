import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.modules
import qs.modules.windows11.bar
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
				top: (Config.settings.bar.barLocation == "top")
				bottom: (Config.settings.bar.barLocation == "bottom")
				left: true
				right: true
			}

			color: "transparent"
			
			implicitHeight: 60
			
			visible: true
			
			
			Rectangle {
				id: barBase
				anchors.top: parent.top
				height: 60
				width: parent.width
				color: Colours.palette.surface
				
				Image {
					id: blurBarBackground
					source: Config.settings.currentWallpaper
					fillMode: Image.PreserveAspectCrop
					
					anchors.fill: parent
				}
				
				MultiEffect {
					source: blurBarBackground
					anchors.fill: blurBarBackground
					
					contrast: 1.0
					
					blurEnabled: true
					autoPaddingEnabled: false
					blur: 1.0
					blurMultiplier: 2
					
					saturation: 1.0
					
				}
				
				Rectangle {
					anchors.fill: parent
					color: Colours.palette.surface
					opacity: 0.85
				}
				
				Rectangle {
					anchors.top: parent.top
					width: parent.width
					height: 1
					color: Colours.palette.surface_container
					
				}
				
				RowLayout {
					height: 10
					spacing: 10
					anchors.left: parent.left
					anchors.top: parent.top
					
					
					anchors.topMargin: 5
					anchors.leftMargin: 10
					anchors.rightMargin: 10
					
					Rectangle {
						Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
						
						Layout.preferredWidth: 200
						Layout.preferredHeight: 50
						
						radius: 10
						color: "transparent"
						
						Rectangle {
							id: hoverRec
							anchors.fill: parent
							radius: 10
							color: Colours.palette.surface_container
							opacity: 0
							
							Behavior on opacity {
								PropertyAnimation {
									duration: 200
									easing.type: Easing.InSine
								}
							}
							
							border.color: Colours.palette.outline
							border.width: 0.2
						}
						
						RowLayout {
							anchors.centerIn: parent
							spacing: 10
						
							Text {
								text: "🌦"
								font.family: Config.settings.font
								
								color: Colours.palette.on_surface
								font.pixelSize: 28
							}
							
							ColumnLayout {
								spacing: 0
								Text {
									text: "13°C"
									font.family: Config.settings.font
									
									color: Colours.palette.on_surface
									font.pixelSize: 14
								}
								Text {
									text: "Patchy rain nearby"
									font.family: Config.settings.font
									
									color: Colours.palette.on_surface
									font.pixelSize: 14
								}
							}
						}
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor
							
							onEntered: hoverRec.opacity = 0.5
							onExited: hoverRec.opacity = 0
							//onClicked: banging
						}
					}
					
				}
						
				RowLayout {
					spacing: 10
					anchors.right: parent.right
					anchors.rightMargin: 20
					anchors.top: parent.top
					anchors.topMargin: 5
					
					SysTray {
						Layout.preferredWidth: (SystemTray.items.values.length * 25)
						
						bar: barWindow
					}
					
					Rectangle {
						Layout.preferredWidth: 115
						color: Colours.palette.surface
						Layout.preferredHeight: 30
						
						radius: Config.settings.borderRadius - 3
						
						Behavior on color {
							PropertyAnimation {
								duration: 200
								easing.type: Easing.InSine
							}
						}
					
						RowLayout {
							spacing: 10
							anchors.fill: parent
							anchors.leftMargin: 10
							
							BluetoothWidget {
								color: { Bluetooth.getBool() ? Colours.palette.on_surface : Colours.palette.outline }
							
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredWidth: 15
						
								font.pixelSize: 17
						
							}
						
							NetworkWidget {
								color: { Network.getBool() ? Colours.palette.on_surface : Colours.palette.outline }
							
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredWidth: 15
						
								font.pixelSize: 17
						
							}
					
							BatteryWidget {
								Layout.fillHeight: true
							}
					
						}
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor
							
							onEntered: parent.color = Colours.palette.surface_container
							onExited: parent.color = Colours.palette.surface
							onClicked: InternalLoader.toggleDashboard()
						}
					}
					
					TimeWidget {

						color: Colours.palette.on_surface
	
						font.family: Config.settings.font
						font.weight: 600

						Layout.preferredWidth: 110
						
						font.pixelSize: 13

					}
				}
			}
		}
	}
}
