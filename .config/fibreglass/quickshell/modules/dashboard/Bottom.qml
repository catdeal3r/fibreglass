import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import "root:/config"
import "root:/modules/common"
import "root:/services"
import "root:/modules/dashboard/notifications"
import "root:/modules/dashboard/bottom"

Rectangle {
	Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
	Layout.preferredWidth: 480
	Layout.preferredHeight: 450
								
	radius: Config.settings.borderRadius
	color: Colours.palette.surface
	
	Rectangle {
		id: container
		anchors.top: parent.top
		anchors.topMargin: 20
		
		anchors.left: parent.left
		anchors.leftMargin: (parent.Layout.preferredWidth - (parent.Layout.preferredWidth - 40)) / 2
		
		width: parent.Layout.preferredWidth - 40
		height: parent.Layout.preferredHeight - 40
		color: Colours.palette.surface
		
		property int currentFocused: 0
		
		RowLayout {
			id: buttons
			width: (spacing * 3) + (3 * 50) + 100
			height: 20
			
			spacing: 10
			
			anchors.top: parent.top
			
			anchors.left: parent.left
			anchors.leftMargin: (parent.width - width) / 2
			
			
			function setFocused(id) {
				container.currentFocused = id
			}
			
			SwipeViewButton {
				isSelected: {
					if (container.currentFocused == 0) return true
					else return false
				}
				selectedText: "Notifications"
				iconCode: "message"
				toRun: () => parent.setFocused(0)
			}
			
			SwipeViewButton {
				isSelected: {
					if (container.currentFocused == 1) return true
					else return false
				}
				toRun: () => parent.setFocused(1)
			}
			
			SwipeViewButton {
				isSelected: {
					if (container.currentFocused == 2) return true
					else return false
				}
				toRun: () => parent.setFocused(2)
			}
			
			SwipeViewButton {
				isSelected: {
					if (container.currentFocused == 3) return true
					else return false
				}
				toRun: () => parent.setFocused(3)
			}
			
		}
		
		SwipeView {
			id: view
			interactive: false

			currentIndex: parent.currentFocused
			anchors.top: buttons.bottom
			width: 440
			height: 370
			
			anchors.centerIn: parent

			NotificationsLog {
				width: 400
			}
			
			Item {
			}
			
			Item {
			}
			
			Item {
			}
		}
	}
}
