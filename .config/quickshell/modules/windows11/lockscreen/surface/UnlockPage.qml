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
			id: pfpImage
			radius: 1000
												
			Layout.preferredWidth: 210
			Layout.preferredHeight: 210
			Layout.alignment: Qt.AlignHCenter
																		
			IconImage {
				source: `file:/${Quickshell.shellDir("assets/pfp.png")}`
			}
		}
			
		Text {
			Layout.topMargin: 10
			
			font.family: Config.settings.font
			font.weight: 600
			
			color: Colours.palette.on_surface
			Layout.alignment: Qt.AlignHCenter
			
			font.pointSize: 25
			
			text: User.username
		}

		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			implicitWidth: (pfpImage.Layout.preferredWidth * 2) - 60
		
			Layout.topMargin: 25
			
			Rectangle {
				color: "transparent"
				implicitWidth: (pfpImage.Layout.preferredWidth * 2) - 60
				implicitHeight: 43
				
				Layout.alignment: Qt.AlignHCenter
			
				Rectangle {
					id: passwordBox

					implicitWidth: (pfpImage.Layout.preferredWidth * 2) - 80
					implicitHeight: parent.implicitHeight
					radius: 6
					color: (border.color != "transparent" ) ? Qt.alpha(Colours.palette.surface, 0.3) : Qt.alpha(Colours.palette.surface, 0.8)
					
					anchors.left: parent.left
					anchors.leftMargin: (parent.implicitWidth / 2) - (implicitWidth / 2)

					focus: true
					
					clip: true
					
					Behavior on color {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}
					
					border.width: 2.5
					border.color: Qt.alpha(Colours.palette.on_surface, 0.4)
					
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
						
						passwordBox.border.color = "transparent";
					}
					
					
					MouseArea {
						anchors.fill: parent
						
						onEntered: parent.opacity = 0.4
						onExited: parent.opacity = 0.2
					}
				}
				
				ClippingWrapperRectangle {
					anchors.centerIn: passwordBox
					
					width: passwordBox.implicitWidth + 1
					height: passwordBox.implicitHeight + 1
					
					radius: passwordBox.radius
					
					clip: true
					
					color: "transparent"
					
					Rectangle {
						id: underColour
							
						radius: 5
								
						width: passwordBox.implicitWidth
						anchors.top: parent.bottom
						anchors.topMargin: -3
								
						anchors.left: parent.left
						height: 2
								
						color: ( passwordBox.color == Qt.alpha(Colours.palette.surface, 0.8) ) ? Colours.palette.primary : Colours.palette.on_surface
						
						Behavior on color {
							PropertyAnimation {
								duration: 200
								easing.type: Easing.InSine
							}
						}
					}
				}
				
				Text {
					anchors.left: passwordBox.left
					anchors.leftMargin: 10
					
					anchors.top: passwordBox.top
					anchors.topMargin: (passwordBox.implicitHeight / 2) - (height / 2)

					height: 25
					
					font.family: Config.settings.font
					font.pointSize: 13
					
					color: Colours.palette.on_surface
					
					text: "Password"
					
					opacity: ( root.lockcontext.currentText == "" ) ? 1 : 0
					
					Behavior on opacity {
						PropertyAnimation {
							duration: 10
							easing.type: Easing.InSine
						}
					}
					
				}
					
				
				ListView {
					id: charList

					anchors.left: passwordBox.left
					anchors.leftMargin: 10
						
					anchors.top: passwordBox.top
					anchors.topMargin: (passwordBox.implicitHeight / 2) - (implicitHeight / 2)

					implicitWidth: passwordBox.implicitWidth - 20
					implicitHeight: 12
					
					clip: true

					orientation: Qt.Horizontal
					spacing: 5
					interactive: false
					opacity: 1

					model: ScriptModel {
						values: root.lockcontext.currentText.split("")
					}

					delegate: Rectangle {
						id: ch
						implicitWidth: 10
						implicitHeight: 10
						color: Colours.palette.on_surface
						radius: 1000

						opacity: 0.8
							
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
			}
		}

		Label {
			visible: root.lockcontext.showFailure
			text: "Incorrect password"
		}
	}
}
