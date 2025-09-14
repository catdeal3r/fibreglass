import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 40
	height: 40 * workspaceCount
	color: Colours.palette.surface

	anchors.top: parent.top
	anchors.topMargin: (parent.height / 2) - (height / 2)

	anchors.left: parent.left
	
	property int workspaceCount: 3

	Rectangle {
		anchors.top: parent.top
		anchors.topMargin: (Workspaces.focusedWorkspace - 1) * parent.width
		width: parent.width
		height: parent.width
		color: Colours.palette.primary

		Behavior on anchors.topMargin {
			PropertyAnimation {
				duration: 100
				easing.type: Easing.BezierSpline
				easing.bezierCurve: Anim.standard
			}
		}
	}

	ColumnLayout {
		anchors.top: parent.top
		anchors.topMargin: 12
		spacing: 23

		Repeater {
			model: workspaceCount

			Text {
				text: index + 1
				color: (index + 1 == Workspaces.focusedWorkspace) ? Colours.palette.surface : Colours.palette.on_surface

				font.family: Config.settings.font
				font.pixelSize: 14

				anchors.left: parent.left
				anchors.leftMargin: 15
			}
		}
	}
}
