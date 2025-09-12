import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 30
	height: width * Workspaces.workspaceCount
	color: Colours.palette.surface

	Rectangle {
		anchors.top: parent.top
		anchors.topMargin: (Workspaces.focusedWorkspace - 1) * root.height

		width: root.height
		height: root.height

		color: Qt.alpha(Colours.palette.primary, 0.8)

		Behavior on anchors.leftMargin {
			PropertyAnimation {
				duration: 100
				easing.type: Easing.BezierSpline
				easing.bezierCurve: Anim.standard
			}
		}	
	}	
	
	ColumnLayout {
		id: layoutThingy
		anchors.fill: parent
		spacing: 0	
	
		Repeater {
			model: Workspaces.workspaceCount
		
			Rectangle {
				color: "transparent"
				Layout.preferredWidth: root.height
				Layout.preferredHeight: root.height
			
				Text {
					anchors.centerIn: parent
					text: `${index + 1}`
					color: Workspaces.getWorkspaceColour(Workspaces.workspacesState[index])
					font.family: Config.settings.font
					font.pixelSize: 12
					font.weight: 600


					Behavior on color {
						PropertyAnimation {
							duration: 100
							easing.type: Easing.BezierSpline
							easing.bezierCurve: Anim.standard
						}
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
