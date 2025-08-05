import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import QtQuick.Effects

import Quickshell.Wayland
import Quickshell
import Quickshell.Widgets

import qs.modules.windows11.lockscreen
import qs.modules.windows11.lockscreen.surface
import qs.config
import qs.modules.common

Rectangle {
	id: root
	required property LockContext lockcontext
	readonly property ColorGroup colors: Window.active ? palette.active : palette.inactive

	color: "transparent"
	anchors.fill: parent
	
	visible: (opacity == 0) ? false : true
	
	Behavior on opacity {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}

	ColumnLayout {
		spacing: 10

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: 350
		}
		
		ClippingWrapperRectangle {
				radius: 1000
												
				Layout.preferredWidth: 200
				Layout.preferredHeight: 200
				Layout.alignment: Qt.AlignHCenter
																		
				IconImage {
					source: `file:/${Quickshell.shellPath("assets/pfp.png")}`
				}
			}
			
		Text {
			font.family: Config.settings.font
			font.weight: 600
			
			color: Colours.palette.on_surface
			Layout.alignment: Qt.AlignHCenter
			
			font.pointSize: 25
			
			text: User.username
		}

		RowLayout {
		
			Layout.topMargin: 10
			
			Rectangle {
				id: passwordBox

				implicitWidth: 400
				implicitHeight: 40
				radius: 8
				color: Colours.palette.surface 

				focus: true
				
				opacity: 0.6
				
				Behavior on opacity {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}
				
				Keys.onPressed: event => {
					if (root.lockcontext.unlockInProgress)
						return;

					if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
						root.lockcontext.tryUnlock();
					} else if (event.key === Qt.Key_Backspace) {
						root.lockcontext.currentText = root.lockcontext.currentText.slice(0, -1);
					} else if (" abcdefghijklmnopqrstuvwxyz1234567890`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?".includes(event.text.toLowerCase())) {
						root.lockcontext.currentText += event.text;
					}
					
					passwordBox.opacity = 0.8
				}
				
				ListView {
					id: charList

					anchors.left: parent.left
					anchors.leftMargin: 10
					
					anchors.top: parent.top
					anchors.topMargin: (parent.implicitHeight / 2) - (implicitHeight / 2)

					implicitWidth: 380
					implicitHeight: 10

					orientation: Qt.Horizontal
					spacing: 5
					interactive: false

					model: ScriptModel {
						values: root.lockcontext.currentText.split("")
					}

					delegate: Rectangle {
						id: ch

						implicitWidth: 10
						implicitHeight: 10

						color: Colours.palette.on_surface
						radius: 1000

						opacity: 0.7
						
						Component.onCompleted: {
							opacity = 1
						}
						
						Behavior on opacity {
							PropertyAnimation {
								duration: 200
								easing.type: Easing.InSine
							}
						}
					}
				}
				
				Rectangle {
					width: parent.implicitWidth - 6
					height: 2
					anchors.top: parent.bottom
					anchors.topMargin: -3
					
					anchors.left: parent.left
					anchors.leftMargin: (parent.implicitWidth / 2) - (width / 2)
					
					color: ( parent.opacity == 0.8 ) ? Colours.palette.primary : Colours.palette.outline
					
					Behavior on color {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}
				}
				
				MouseArea {
					anchors.fill: parent
					
					onEntered: parent.opacity = 0.8
					onExited: parent.opacity = 0.6
				}
			}
		}

		Label {
			visible: root.lockcontext.showFailure
			text: "Incorrect password"
		}
	}
}
