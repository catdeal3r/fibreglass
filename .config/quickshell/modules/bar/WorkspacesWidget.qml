import QtQuick
import Quickshell
import QtQuick.Layouts

import "../../config"

Rectangle {
    id: root
    width: layoutThingy.width + 25
    height: 40
    color: Colours.palette.surface

    RowLayout {
        id: layoutThingy
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: Workspaces.workspaceCount

            Rectangle {
                property int index
                color: Workspaces.getWorkspaceColour(Workspaces.workspacesState[index])
                width: 50
                height: 9

                Layout.preferredWidth: Workspaces.getWorkspaceSize(Workspaces.workspacesState[index])

                radius: 10

                Behavior on Layout.preferredWidth {
                    PropertyAnimation {
                        duration: 200
                        easing.type: Easing.InSine
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: Quickshell.execDetached(["bspc", "desktop", "-f", `${index + 1}`])
                }
            }
        }
    }
}
