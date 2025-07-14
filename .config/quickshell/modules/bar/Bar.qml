import Quickshell
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import "../../modules"
import "../../config"
import "../common"

Scope {
    id: root
    signal finished

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            property var modelData
            screen: modelData

            anchors {
                top: (Config.settings.bar.barLocation == "top")
                bottom: (Config.settings.bar.barLocation == "bottom")
                left: true
                right: true
            }

            color: "transparent"

            implicitHeight: barBase.height + (Config.settings.borderRadius * 2)

            margins.top: (Config.settings.bar.barLocation == "top") ? Config.settings.borderRadius - (Config.settings.borderRadius * 2) : 0
            margins.bottom: (Config.settings.bar.barLocation == "bottom") ? Config.settings.borderRadius - (Config.settings.borderRadius * 2) : 0

            visible: true

            Rectangle {
                id: cornerThingy
                visible: Config.settings.bar.smoothEdgesShown
                anchors.top: parent.top
                width: parent.width
                height: parent.height

                Behavior on visible {
                    PropertyAnimation {
                        duration: 200
                        easing.type: Easing.InSine
                    }
                }

                color: "transparent"

                RRCorner {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    color: Colours.palette.surface
                    corner: cornerEnum.bottomLeft

                    size: Config.settings.borderRadius
                }

                RRCorner {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    color: Colours.palette.surface
                    corner: cornerEnum.bottomRight

                    size: Config.settings.borderRadius
                }
            }

            Rectangle {
                id: cornerThingyBottom
                visible: Config.settings.bar.smoothEdgesShown
                anchors.bottom: parent.bottom
                width: parent.width
                height: parent.height

                color: "transparent"

                Behavior on visible {
                    PropertyAnimation {
                        duration: 200
                        easing.type: Easing.InSine
                    }
                }

                RRCorner {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    color: Colours.palette.surface
                    corner: cornerEnum.topLeft

                    size: Config.settings.borderRadius
                }

                RRCorner {
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    color: Colours.palette.surface
                    corner: cornerEnum.topRight

                    size: Config.settings.borderRadius
                }
            }

            Rectangle {
                id: barBase
                anchors.top: parent.top
                anchors.topMargin: Config.settings.borderRadius
                height: 40
                width: parent.width
                color: Colours.palette.surface

                RowLayout {
                    height: 10
                    spacing: 10
                    anchors.left: parent.left
                    anchors.top: parent.top

                    anchors.topMargin: 5
                    anchors.leftMargin: 10

                    Rectangle {
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30

                        radius: Config.settings.borderRadius - 5
                        color: Colours.palette.surface

                        Behavior on color {
                            PropertyAnimation {
                                duration: 200
                                easing.type: Easing.InSine
                            }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "layers"
                            font.family: Config.settings.iconFont

                            color: Colours.palette.on_surface
                            font.pixelSize: 22
                            font.weight: 600
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onEntered: parent.color = Colours.palette.surface_container
                            onExited: parent.color = Colours.palette.surface
                            //onClicked: banging
                        }
                    }

                    WorkspacesWidget {
                        id: workspaces
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

                        Layout.preferredWidth: 300
                        Layout.preferredHeight: 30
                        radius: Config.settings.borderRadius - 3
                    }
                }

                RowLayout {
                    spacing: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 5

                    SysTray {
                        Layout.preferredWidth: (SystemTray.items.values.length * 25)

                        bar: barWindow
                    }

                    Rectangle {
                        Layout.preferredWidth: 115
                        color: Colours.palette.surface
                        Layout.preferredHeight: 30

                        radius: Config.settings.borderRadius - 3

                        Behavior on color {
                            PropertyAnimation {
                                duration: 200
                                easing.type: Easing.InSine
                            }
                        }

                        RowLayout {
                            spacing: 10
                            anchors.fill: parent
                            anchors.leftMargin: 10

                            BluetoothWidget {
                                color: {
                                    Bluetooth.getBool() ? Colours.palette.on_surface : Colours.palette.outline;
                                }

                                font.family: Config.settings.iconFont
                                font.weight: 600

                                Layout.preferredWidth: 15

                                font.pixelSize: 17
                            }

                            NetworkWidget {
                                color: {
                                    Network.getBool() ? Colours.palette.on_surface : Colours.palette.outline;
                                }

                                font.family: Config.settings.iconFont
                                font.weight: 600

                                Layout.preferredWidth: 15

                                font.pixelSize: 17
                            }

                            BatteryWidget {
                                Layout.fillHeight: true
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onEntered: parent.color = Colours.palette.surface_container
                            onExited: parent.color = Colours.palette.surface
                            onClicked: InternalLoader.toggleDashboard()
                        }
                    }

                    TimeWidget {

                        color: Colours.palette.on_surface

                        font.family: Config.settings.font
                        font.weight: 600

                        Layout.preferredWidth: 110

                        font.pixelSize: 13
                    }
                }
            }
        }
    }
}
