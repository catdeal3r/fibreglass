import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "root:/modules"
import "root:/modules/bar"
import "root:/config"
import "root:/modules/common"

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
				bottom: true 
				left: true
				right: true
			}

			color: "transparent"
			
			implicitHeight: 55
			
			visible: true
			
			Rectangle {
				id: cornerThingy
				anchors.top: parent.top
				width: parent.width
				height: parent.height
				
				color: "transparent"
				
				RRCorner {
					anchors.top: parent.top
					anchors.left: parent.left
					color: Colours.palette.surface
					corner: cornerEnum.bottomLeft
					
					size: Appearance.borderRadius
				}
				
				RRCorner {
					anchors.top: parent.top
					anchors.right: parent.right
					color: Colours.palette.surface
					corner: cornerEnum.bottomRight
					
					size: Appearance.borderRadius
				}
			}
			
			Rectangle {
				anchors.top: parent.top
				anchors.topMargin: 15
				height: 40
				width: parent.width
				color: Colours.palette.surface
				
				RowLayout {
					height: 10
					spacing: 10
					anchors.left: parent.left
					anchors.top: parent.top
					
					
					anchors.topMargin: 5
					anchors.leftMargin: 10
					
					Rectangle {
						Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
						
						Layout.preferredWidth: 30
						Layout.preferredHeight: 30
						
						radius: Appearance.borderRadius - 5
						color: Colours.palette.surface_container_high
						
						Text {
							anchors.centerIn: parent
							text: "construction"
							font.family: Appearance.iconFont
							
							color: Colours.palette.on_surface
							font.pixelSize: 20
						}
						
						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor
							
							onEntered: parent.color = Colours.palette.surface_container_highest
							onExited: parent.color = Colours.palette.surface_container_high
							//onClicked: banging
						}
					}
				
					WorkspacesWidget {
						id: workspaces
						Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
					
						Layout.preferredWidth: 300
						Layout.preferredHeight: 30
						radius: Appearance.borderRadius - 3
					}
					
				}
						
				RowLayout {
					spacing: 10
					anchors.right: parent.right
					anchors.rightMargin: 20
					anchors.top: parent.top
					anchors.topMargin: 5
					
					Rectangle {
						Layout.preferredWidth: 105
						color: Colours.palette.surface_container
						Layout.preferredHeight: 30
						
						radius: Appearance.borderRadius - 3
					
						RowLayout {
							spacing: 6
							anchors.fill: parent
							anchors.leftMargin: 10
							
							BluetoothWidget {
								color: { Bluetooth.getBool() ? Colours.palette.on_surface : Colours.palette.outline }
							
								font.family: Appearance.iconFont
								font.weight: 600

								Layout.preferredWidth: 15
						
								font.pixelSize: 17
						
							}
						
							NetworkWidget {
								color: { Network.getBool() ? Colours.palette.on_surface : Colours.palette.outline }
							
								font.family: Appearance.iconFont
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
							
							onEntered: parent.color = Colours.palette.surface_container_high
							onExited: parent.color = Colours.palette.surface_container
							onClicked: InternalLoader.toggleDashboard()
						}
					}
					
					TimeWidget {

						color: Colours.palette.on_surface
	
						font.family: Appearance.font
						font.weight: 600

						Layout.preferredWidth: 110
						
						font.pixelSize: 13

					}
				}
			}
		}
		
	}

}
