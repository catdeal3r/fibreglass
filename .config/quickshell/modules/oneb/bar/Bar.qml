import Quickshell
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.modules.oneb.bar
import qs.config
import qs.modules.common
import qs.modules.oneb.bar.dashboard

Scope {
	signal finished();
	id: root

	property int sliderValue: 45
	property int barWidth: 40
	property int dashWidth: 450
	property bool isBar: true
	
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
			
			implicitWidth: root.dashWidth + 35
			
			visible: true
			
			exclusiveZone: root.sliderValue

			mask: Region {
				item: maskId
			}

			Rectangle {
				id: maskId
				width: root.barWidth + root.sliderValue
				height: parent.height
				color: "transparent"

				Loader {
					active: root.isBar
					
					sourceComponent: Rectangle {
						id: barBase
						anchors.left: parent.left
						anchors.leftMargin: {
							if (root.sliderValue > width + 5) {
								return 0
							} else {
								return root.sliderValue - width - 5
							}
						}

						width: root.barWidth
						height: barWindow.height
						color: Colours.palette.surface

						Text {
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.leftMargin: (parent.width / 2) - ((font.pixelSize + 2) / 2)
							anchors.topMargin: 5

							text: ""
							color: Colours.palette.on_surface
							font.pixelSize: 18
						}

						WorkspacesWidget {
							monitor: modelData.name
						}
						
						ColumnLayout {
							spacing: 15
							anchors.left: parent.left

							width: parent.width - 5
							anchors.bottom: parent.bottom
							
							SysTray {
								Layout.preferredHeight: (SystemTray.items.values.length * 25)
								Layout.preferredWidth: 20
								Layout.alignment: Qt.AlignHCenter
								bar: barWindow
							}
							
							BluetoothWidget {
								color: Bluetooth.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
									
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredHeight: 15
								
								font.pixelSize: 17
								Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
								Layout.leftMargin: 1

								MouseArea {
									anchors.fill: parent
									cursorShape: Qt.PointingHandCursor

									onClicked: Bluetooth.toggle()
								}
							}
								
							NetworkWidget {
								color: Network.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
							
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredHeight: 15
								
								font.pixelSize: 17
								Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
								Layout.leftMargin: 1

								MouseArea {
									anchors.fill: parent
									cursorShape: Qt.PointingHandCursor

									onClicked: Quickshell.execDetached([ Quickshell.shellDir + "/scripts/network.out" ])
								}
							}
							
							BatteryWidget {
								Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
							
								color: Qt.alpha(Colours.palette.on_surface, 0.8)

								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.preferredHeight: 19
								Layout.leftMargin: 1
								font.pixelSize: 21
							}
							
							TimeWidget {
								color: Qt.alpha(Colours.palette.on_surface, 0.8)
			
								font.family: Config.settings.font
								font.weight: 600

								Layout.preferredHeight: 60
								
								Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
								
								font.pixelSize: 13
								Layout.leftMargin: 2
							}
						}
					}
				}

				Dashboard {
					isDashboardOpen: !root.isBar
					dash_width: root.sliderValue - 5
				}

				Slider {
					id: slider
					property bool isHovered: false
					anchors.top: parent.top
					anchors.topMargin: (parent.height / 2) - (height / 2)
					width: root.dashWidth + 5
					
					height: 50
					
					background: Rectangle {
						color: "transparent"

						HoverHandler {
							parent: parent
							cursorShape: Qt.DragMoveCursor
							
							acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
							
							onHoveredChanged: {
								slider.isHovered = hovered
							}
						}
					}
					
					enabled: true
					
					from: 5
					value: root.sliderValue
					to: width

					onMoved: {
						let snapAmount = 105;
						root.sliderValue = value;
						if (value > root.barWidth + snapAmount) {
							root.isBar = false;
							root.sliderValue = root.dashWidth;
						}
						
						if (value > root.barWidth + 5 && value < root.barWidth + snapAmount) {
							root.sliderValue = root.barWidth + 5;
						}
						
						if (value < root.barWidth + snapAmount + 1) {
							root.isBar = true;
						}

						//console.log(value);
					}
					
					handle: Rectangle {
						height: parent.height
						anchors.left: parent.left
						anchors.leftMargin: (slider.value / slider.to) * slider.width
						color: "#FFFFFF"

						opacity: slider.isHovered ? 1 : 0

						Behavior on opacity {
							PropertyAnimation {
								duration: 200
								easing.type: Easing.InSine
							}
						}

						width: 5
						radius: 10
					}
				}
			}
		}
	}
}
