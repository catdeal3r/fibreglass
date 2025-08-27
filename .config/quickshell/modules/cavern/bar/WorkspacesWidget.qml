import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: layoutThingy.width + 25
	height: 40
	color: Colours.palette.surface
	
	
	RowLayout {
		id: layoutThingy
		anchors.centerIn: parent
		spacing: 8
	
		Repeater {
			model: Workspaces.workspaceCount
		
			Rectangle {
				color: Workspaces.getWorkspaceColour(Workspaces.workspacesState[index])
			
				Layout.preferredWidth: Workspaces.getWorkspaceSize(Workspaces.workspacesState[index])
				Layout.preferredHeight: Workspaces.getWorkspaceSize(Workspaces.workspacesState[index])
			
				radius: 5
				
				rotation: ( color == Colours.palette.on_surface ) ? 45 : 0
				transformOrigin: Item.Center
			
				Behavior on Layout.preferredWidth {
					PropertyAnimation {
						duration: 150
						easing.type: Easing.InSine
					}
				}
				
				Behavior on Layout.preferredHeight {
					PropertyAnimation {
						duration: 150
						easing.type: Easing.InSine
					}
				}
				
				Behavior on rotation {
					PropertyAnimation {
						duration: 100
						easing.type: Easing.InSine
					}
				}
				
				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					
					onClicked: Quickshell.execDetached(["swaymsg", "workspace", `${index + 1}`])
				}
			}
		}
	}
}
