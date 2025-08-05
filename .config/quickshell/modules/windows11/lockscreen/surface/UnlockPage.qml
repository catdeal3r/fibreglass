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
		// Uncommenting this will make the password entry invisible except on the active monitor.
		// visible: Window.active
		
		spacing: 10

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: 300
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
			TextField {
				id: passwordBox

				implicitWidth: 400
				padding: 10
				

				focus: true
				enabled: !root.lockcontext.unlockInProgress
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhSensitiveData

				// Update the text in the lockcontext when the text in the box changes.
				onTextChanged: root.lockcontext.currentText = this.text;

				// Try to unlock when enter is pressed.
				onAccepted: root.lockcontext.tryUnlock();

				// Update the text in the box to match the text in the lockcontext.
				// This makes sure multiple monitors have the same text.
				Connections {
					target: root.lockcontext

					function onCurrentTextChanged() {
						passwordBox.text = root.lockcontext.currentText;
					}
				}
			}

			Button {
				text: "Unlock"
				padding: 10

				// don't steal focus from the text box
				focusPolicy: Qt.NoFocus

				enabled: !root.lockcontext.unlockInProgress && root.lockcontext.currentText !== "";
				onClicked: root.lockcontext.tryUnlock();
			}
		}

		Label {
			visible: root.lockcontext.showFailure
			text: "Incorrect password"
		}
	}
}
