import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.modules.fibreglass.bar
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
			
			implicitHeight: barBase.height + (Config.settings.borderRadius * 2)
			
			margins.top: (Config.settings.bar.barLocation == "top") ? -1 * Config.settings.borderRadius : 0
			margins.bottom: (Config.settings.bar.barLocation == "bottom") ? -1 * Config.settings.borderRadius : 0
			
			visible: true
			
			exclusiveZone: barBase.height + Config.settings.borderRadius + 2
			
			
			
			Rectangle {
				id: cornerThingy
				visible: Config.settings.bar.smoothEdgesShown
				anchors.top: parent.top
				width: parent.width
				height: parent.height
				
				Behavior on visible {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}
				
				color: "transparent"
				
				RRCorner {
					anchors.top: parent.top
					anchors.left: parent.left
					color: Colours.palette.surface
					corner: RRCorner.CornerEnum.BottomLeft
					
					size: Config.settings.borderRadius
				}
				
				RRCorner {
					anchors.top: parent.top
					anchors.right: parent.right
					color: Colours.palette.surface
					corner: RRCorner.CornerEnum.BottomRight
					
					size: Config.settings.borderRadius
				}
			}
			
			Rectangle {
				id: cornerThingyBottom
				visible: Config.settings.bar.smoothEdgesShown
				anchors.bottom: parent.bottom
				width: parent.width
				height: parent.height
				
				color: "transparent"
				
				Behavior on visible {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}
				
				RRCorner {
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					color: Colours.palette.surface
					corner: RRCorner.CornerEnum.TopLeft
					
					size: Config.settings.borderRadius
				}
				
				RRCorner {
					anchors.bottom: parent.bottom
					anchors.right: parent.right
					color: Colours.palette.surface
					corner: RRCorner.CornerEnum.TopRight
					
					size: Config.settings.borderRadius
				}
			}
			
			Rectangle {
				id: barBase
				anchors.top: parent.top
				anchors.topMargin: Config.settings.borderRadius
				height: 40
				width: parent.width
				color: Colours.palette.surface
				
				Rectangle {
					visible: !Config.settings.bar.smoothEdgesShown
					anchors.top: ( Config.settings.bar.barLocation == "top" ) ? parent.bottom : parent.top
					width: parent.width
					height: 2
					color: Colours.palette.surface_container_high
				}
				
				RowLayout {
					height: 10
					spacing: 10
					anchors.left: parent.left
					anchors.top: parent.top
					
					
					anchors.topMargin: 5
					anchors.leftMargin: 10
					
				
					WorkspacesWidget {
						id: workspaces
						Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
					
						Layout.preferredWidth: 300
						Layout.preferredHeight: 30
						radius: Config.settings.borderRadius - 3
					}
					
				}
				
				TextMetrics {
					id: currentWindowTextMetrics
					property string windowName
				
					text: {
						if (windowName == "\"1\"" || windowName == "\"2\"" || windowName == "\"3\"" || windowName == "\"4\"" || windowName == "\"5\"" || windowName == "\"6\"" || windowName == "\"7\"" || windowName == "\"8\"")
								return "Desktop";
						
						let windowNameChanged = windowName.replace(/\\+/g, (match) => {
							let slash = '\\';
							return slash.repeat(match.length / 2);	
						});

						return windowNameChanged.slice(1, -1);
					}
					
					font.family: Config.settings.font
										
					elide: Qt.ElideRight
					elideWidth: 410
					
				}
				
				Process {
					id: getCurrentWindowProc
						
					running: true
					command: [ "sh", "-c", "swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).name'" ]
					
					stdout: SplitParser {
						onRead: data => currentWindowTextMetrics.windowName = data
					}
				}
					
				Timer {
					running: true
					repeat: true
					interval: 100
					onTriggered: getCurrentWindowProc.running = true
				}
				
				Text {
					id: currentWindowText
					text: currentWindowTextMetrics.elidedText
					anchors.centerIn: parent
					
					font.family: Config.settings.font
					color: Colours.palette.on_surface
					font.pixelSize: 13
					font.weight: 600
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
							onClicked: IPCLoader.toggleDashboard()
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
