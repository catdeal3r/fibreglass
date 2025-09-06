import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.config
import qs.common

Rectangle {
	id: root
	property var bar
	
	visible: SystemTray.items.values.length
	height: 10
	color: "transparent"
	
	RowLayout {
		anchors.centerIn: parent
		spacing: 10
		
		Repeater {
			model: SystemTray.items
			
			Rectangle {
				id: sysItem
				required property var modelData
				Layout.alignment: Qt.AlignCenter
				height: 21
				width: 21
				color: "transparent"

				IconImage {
					anchors.centerIn: parent
					width: 20
					height: 20
					source: modelData.icon
				}
				
				QsMenuAnchor {
					id: menu

					menu: sysItem.modelData.menu
					anchor.window: root.bar
					anchor.rect.x: 1200
					anchor.rect.y: 3000
					anchor.rect.height: sysItem.height
				}

				MouseArea {
					anchors.fill: parent
					
					acceptedButtons: Qt.LeftButton | Qt.RightButton
					
					onClicked: event => {
						if (event.button === Qt.LeftButton)
							modelData.activate();
						else if (modelData.hasMenu)
							menu.open();
					}
				}
			}
		}
	}
}
