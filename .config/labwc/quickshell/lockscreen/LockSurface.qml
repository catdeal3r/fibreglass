import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import QtQuick.Effects

import Quickshell.Wayland
import Quickshell
import Quickshell.Widgets

import qs.config
import qs.common

Rectangle {
	id: root
	required property LockContext context
	
	// background stuff
	Image {
		id: background
		source: Config.settings.currentWallpaper
		fillMode: Image.PreserveAspectCrop
			
		anchors.fill: parent
	}
	
	MultiEffect {
		id: darkenEffect
		source: background
		anchors.fill: background
		
		brightness: -0.2
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
				source: `file:/${Quickshell.shellDir}/assets/pfp.png`
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
					radius: Config.settings.borderRadius
					color: Colours.palette.surface
					
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
					
					border.width: 2
					border.color: (root.context.currentText != "" ) ? Colours.palette.primary : Colours.palette.on_surface
					
					Keys.onPressed: event => {
						if (root.context.unlockInProgress)
							return;

						if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
							root.context.tryUnlock();
						} else if (event.key === Qt.Key_Backspace) {
							root.context.currentText = root.context.currentText.slice(0, -1);
						} else if (" abcdefghijklmnopqrstuvwxyz1234567890`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?".includes(event.text.toLowerCase())) {
							root.context.currentText += event.text;
						}
					}
					
					
					MouseArea {
						anchors.fill: parent
						
						onEntered: parent.opacity = 0.4
						onExited: parent.opacity = 0.2
					}
				}
				
				Text {
					anchors.left: passwordBox.left
					anchors.leftMargin: 15
					
					anchors.top: passwordBox.top
					anchors.topMargin: (passwordBox.implicitHeight / 2) - (height / 2)

					height: 22
					
					font.family: Config.settings.font
					font.pointSize: 13
					
					color: Colours.palette.on_surface
					
					text: "Password"
					
					opacity: ( root.context.currentText == "" ) ? 1 : 0
					
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
					anchors.leftMargin: 15
						
					anchors.top: passwordBox.top
					anchors.topMargin: (passwordBox.implicitHeight / 2) - (implicitHeight / 2)

					implicitWidth: passwordBox.implicitWidth - 20
					implicitHeight: 11
					
					clip: true

					orientation: Qt.Horizontal
					spacing: 5
					interactive: false
					opacity: 1

					model: ScriptModel {
						values: root.context.currentText.split("")
					}

					delegate: Rectangle {
						id: ch
						implicitWidth: 10
						implicitHeight: 10
						color: Colours.palette.on_surface
						radius: 1000

						opacity: 0.6
							
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
			visible: root.context.showFailure
			text: "Incorrect password"
		}
	}
}
