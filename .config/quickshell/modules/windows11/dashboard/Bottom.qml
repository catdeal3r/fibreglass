import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common
import qs.services
import qs.modules.windows11.dashboard.notifications
import qs.modules.windows11.dashboard.bottom

Rectangle {
	id: root
	Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
	Layout.preferredWidth: 480
	Layout.preferredHeight: 440
								
	radius: Config.settings.borderRadius
	color: Colours.palette.surface
	
	property int currentFocused: 0
	
	function setFocused(id) {
		root.currentFocused = id
	}
				
	RowLayout {
		id: buttons
		width: (spacing * 3) + (3 * 50) + 100
		height: 20
		
		spacing: 10
		
		anchors.top: parent.top
		
		anchors.left: parent.left
		anchors.leftMargin: (parent.width - width) / 2
		
		
			
		SwipeViewButton {
			isSelected: {
				if (root.currentFocused == 0) return true
				else return false
			}
			selectedText: "Notifications"
			iconCode: "message"
			toRun: () => root.setFocused(0)
		}
		
		SwipeViewButton {
			isSelected: {
				if (root.currentFocused == 1) return true
				else return false
			}
			toRun: () => root.setFocused(1)
		}
		
		SwipeViewButton {
			isSelected: {
				if (root.currentFocused == 2) return true
				else return false
			}
			toRun: () => root.setFocused(2)
		}
		
		SwipeViewButton {
			isSelected: {
				if (root.currentFocused == 3) return true
				else return false
			}
			toRun: () => root.setFocused(3)
		}
		
	}
		
	SwipeView {
		id: view
		interactive: false
		currentIndex: root.currentFocused
		anchors.top: buttons.bottom
		anchors.left: parent.left
		anchors.leftMargin: (parent.width- width) / 2
		width: 480
		height: 370
		
		anchors.centerIn: parent
		NotificationsLog {
			width: 400
		}
		
		BluetoothMenu {
			width: 400
		}
		
		Item {
		}
		
		Item {
		}
	}
}
