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
    property bool isNormalItem: true
    property string iconCode: (modelData.iconCode) ? modelData.iconCode : "image"

	width: parent.width
    height: selected ? 50 : 40
    color: hovered ? Qt.alpha(Colours.palette.surface_container_low, 0.4) : Qt.alpha(Colours.palette.surface_container_low, 0.2)
    radius: Config.settings.borderRadius

    Behavior on color {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}

    Behavior on height {
		PropertyAnimation {
			duration: 50
			easing.type: Easing.InSine
		}
	}

    border.width: selected ? 2 : 0
    border.color: Qt.alpha(Colours.palette.primary, 0.6)


    ClippingRectangle {
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

        Text {
            anchors.centerIn: parent
            visible: !root.isNormalItem
            text: root.iconCode
            font.family: Config.settings.iconFont
            font.pixelSize: entryIcon.size - 5
            color: Colours.palette.outline
        }

        Loader {
            active: root.isNormalItem
            sourceComponent: IconImage {
                width: entryIcon.width
                height: entryIcon.height
                source: Quickshell.iconPath(modelData.icon, "application-x-executable")
            }
        }
    }

    Text {
        id: baseName
        anchors.left: entryIcon.right
        anchors.leftMargin: 10
        anchors.top: parent.top
		anchors.topMargin: {
            if (root.selected) {
                if (modelData.comment) {
                    return (parent.height / 2) - ((font.pixelSize + 5) / 2) - 5
                } else {
                    return (parent.height / 2) - ((font.pixelSize + 5) / 2)
                }
            } else {
                return (parent.height / 2) - ((font.pixelSize + 5) / 2)
            }
        }
        font.family: Config.settings.font
        font.weight: 400
        text: modelData.name
        font.pixelSize: 14
        color: {
            if (root.hovered || root.selected) {
                return Colours.palette.on_surface
            } else {
                Colours.palette.outline 
            }
        }

        Behavior on color {
			PropertyAnimation {
				duration: 200
				easing.type: Easing.InSine
			}
		}
    }

    Text {
        anchors.left: entryIcon.right
        anchors.leftMargin: 10
        anchors.top: baseName.top
		anchors.topMargin: 18
        font.family: Config.settings.font
        font.weight: 400
        text: modelData.comment
        font.pixelSize: 10
        color: Qt.alpha(Colours.palette.outline, 0.8)
        opacity: root.selected ? 1 : 0

        Behavior on opacity {
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
