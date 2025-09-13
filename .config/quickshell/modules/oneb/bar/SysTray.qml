import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.config
import qs.modules.common

Rectangle {
	id: root
	property var bar
	
	visible: SystemTray.items.values.length
	color: "transparent"
	
	ColumnLayout {
		anchors.centerIn: parent
		spacing: 10
		
		Repeater {
			model: SystemTray.items
			
			delegate: Rectangle {
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
					anchor.rect.y: sysItem.height + 700
					anchor.rect.x: 40
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
