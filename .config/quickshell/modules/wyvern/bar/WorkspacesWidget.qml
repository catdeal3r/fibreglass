import QtQuick
import Quickshell
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: layoutThingy.width
	height: 30
	color: Colours.palette.surface

	Rectangle {
		anchors.left: parent.left
		anchors.leftMargin: (Workspaces.focusedWorkspace - 1) * root.height

		width: root.height
		height: root.height

		color: Colours.palette.primary

		Behavior on anchors.leftMargin {
			PropertyAnimation {
				duration: 100
				easing.type: Easing.BezierSpline
				easing.bezierCurve: Anim.standard
			}
		}	
	}	
	
	RowLayout {
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
