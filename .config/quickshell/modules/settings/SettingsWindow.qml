import Quickshell
import QtQuick

import "../../config"

Scope {
    id: root
    signal finished

    FloatingWindow {
        id: settingsWindow

        minimumSize: Qt.size(400, 100)
        maximumSize: Qt.size(101, 101)

        color: Colours.palette.surface
    }
}
