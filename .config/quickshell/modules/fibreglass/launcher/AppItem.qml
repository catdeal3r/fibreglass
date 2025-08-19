import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.config
import qs.modules

Rectangle {
    id: root
    property bool hovered: false
    property bool selected: false

	width: parent.width
    height: 40
    color: hovered ? Qt.alpha(Colours.palette.surface_container_low, 0.4) : Qt.alpha(Colours.palette.surface_container_low, 0.2)
    radius: Config.settings.borderRadius

    Behavior on color {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}

    border.width: selected ? 2 : 0
    border.color: Colours.palette.surface_container

    ClippingWrapperRectangle {
        id: entryIcon
        anchors.left: parent.left
        anchors.leftMargin: 10

        anchors.top: parent.top
        anchors.topMargin: (parent.height / 2) - (size / 2)

        property int size: 22
        height: size
        width: size
        radius: Config.settings.borderRadius

        color: Colours.palette.surface_container

        IconImage {
            source: Quickshell.iconPath(modelData.icon, "application-x-executable")
        }
    }

    Text {
        anchors.left: entryIcon.right
        anchors.leftMargin: 10
        anchors.top: parent.top
		anchors.topMargin: (parent.height / 2) - ((font.pixelSize + 5) / 2)
        font.family: Config.settings.font
        font.weight: 400
        text: modelData.name
        font.pixelSize: 15
        color: root.hovered ? Colours.palette.on_surface : Colours.palette.outline 

        Behavior on color {
			PropertyAnimation {
				duration: 200
				easing.type: Easing.InSine
			}
		}
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: {
            modelData.execute()
            IPCLoader.toggleLauncher()
        }
    }
}
