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

	property bool isShown: false
	property bool isAlwaysShown: true
	
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
			
			implicitWidth: barBase.width
			
			visible: true
			
			exclusiveZone: {
				if (isAlwaysShown)
					return barBase.width + Config.settings.borderRadius
				if (isShown)
					return barBase.width + Config.settings.borderRadius
				else
					return 0
			}

			MouseArea {
				anchors.fill: parent
				hoverEnabled: true
				onEntered: root.isShown = true
				acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
				onExited: {
					root.isShown = false
					root.smoothPadding = barBase.width
				}

				onClicked: (mouse) => {
					if (mouse.button == Qt.MiddleButton)
						root.isAlwaysShown = !root.isAlwaysShown
				}
			}
			
			Rectangle {
				id: barBase
				anchors.left: parent.left
				anchors.leftMargin: {
					if (isAlwaysShown)
						return 0
					if (isShown)
						return 0
					else
						-1 * width
				}

				width: 40
				height: parent.height
				color: Colours.palette.surface
				
				Behavior on anchors.leftMargin {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}

				WorkspacesWidget {}

				Text {
					anchors.top: parent.top
					anchors.left: parent.left
					anchors.leftMargin: (parent.width / 2) - ((font.pixelSize - 2) / 2)
					anchors.topMargin: 5

					text: ""
					color: Colours.palette.on_surface
					font.pixelSize: 18
				}

				/*IconImage {
					anchors.top: parent.top
					anchors.left: parent.left
					anchors.leftMargin: (parent.width / 2) - (size / 2) - 1
					anchors.topMargin: 5

					source: `file:/${Quickshell.shellDir}/assets/feather_logo.png`
					asynchronous: true

					property int size: 24
					
					width: size
					height: size
				}*/
						
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
					}
						
					NetworkWidget {
						color: Network.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
					
						font.family: Config.settings.iconFont
						font.weight: 600

						Layout.preferredHeight: 15
						
						font.pixelSize: 17
						Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
						Layout.leftMargin: 1
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
	}
}
