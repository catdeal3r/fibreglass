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

	required property string monitor

	Component.onCompleted: {
		Workspaces.setMonitor(monitor);
	}
	
	property int workspaceCount: 3

	ColumnLayout {
		anchors.fill: parent
		spacing: 1

		Repeater {
			model: workspaceCount

			Text {
				Layout.alignment: Qt.AlignHCenter
				Layout.rightMargin: 4
				text: index + 1
				color: (index + 1 == Workspaces.focusedWorkspace) ? Colours.palette.primary : Colours.palette.on_surface

				font.italic: (index + 1 == Workspaces.focusedWorkspace) ? false : true

				font.family: Config.settings.font
				font.pixelSize: 13
			}
		}
	}
}
