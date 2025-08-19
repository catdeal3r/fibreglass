import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.modules.fibreglass.launcher
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Loader {
	id: root
	required property bool isLauncherOpen
	
	property bool ani
	
	active: false
	
	onIsLauncherOpenChanged: {
		if (root.isLauncherOpen == true) {
			root.active = true
			root.ani = true
		} else {
			root.ani = false
		}
	}
	
	sourceComponent: Scope {
		signal finished();
		
		Variants {
			model: Quickshell.screens;
	  
			PanelWindow {
				id: launcherWindow
			
				property var modelData
				screen: modelData
				
				aboveWindows: true
				color: "transparent"
				
				anchors {
					top: true
					bottom: true
					left: true
					right: true
				}
				
				exclusionMode: ExclusionMode.Ignore
				
				mask: Region {
					item: maskId
				}
				
				visible: true;
				focusable: true;
				WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
				
				ScrollView {
					id: maskId
					property int topMarginPadding: (parent.height / 2) - (implicitHeight / 2)

					implicitHeight: 500
					implicitWidth: 500
					
					anchors.top: parent.top
					anchors.left: parent.left

					anchors.leftMargin: (parent.width / 2) - (implicitWidth / 2)

					visible: true
					focus: true
					
					anchors.topMargin: 2000
					
					Timer {
						running: root.ani
						repeat: false
						interval: 5
						onTriggered: {
							maskId.anchors.topMargin = maskId.topMarginPadding
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 1
						onTriggered: {
							maskId.anchors.topMargin = 2000
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 1250
						onTriggered: {
							root.active = false
						}
					}
					
					clip: true
					
					Behavior on anchors.topMargin {
						NumberAnimation {
							duration: 250
							easing.bezierCurve: Anim.standard
						}
					}
					
					Rectangle {
						id: launcher
						property string currentSearch: ""
						property int entryIndex: 0
						property list<DesktopEntry> appList: Apps.list

						anchors.fill: parent
						
						color: Colours.palette.surface
						
						radius: Config.settings.borderRadius
						
						Rectangle {
							id: searchBox
							anchors.top: parent.top
							anchors.topMargin: 10
							color: Qt.alpha(Colours.palette.surface_container_low, 0.5)
							width: parent.width - 20
							anchors.left: parent.left
							anchors.leftMargin: (parent.width / 2) - (width / 2)
							height: 40
							radius: Config.settings.borderRadius

							focus: true

							Keys.onDownPressed: launcher.entryIndex += 1
							Keys.onUpPressed: {
								if (launcher.entryIndex != 0)
									launcher.entryIndex -= 1
							}
							Keys.onEscapePressed: IPCLoader.toggleLauncher()

							Keys.onPressed: event => {
								if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
									launcher.appList[launcher.entryIndex].execute()
									IPCLoader.toggleLauncher()
								} else if (event.key === Qt.Key_Backspace) {
									launcher.currentSearch = launcher.currentSearch.slice(0, -1);
								} else if (" abcdefghijklmnopqrstuvwxyz1234567890`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?".includes(event.text.toLowerCase())) {
									launcher.currentSearch += event.text;
								}
								launcher.appList = Apps.fuzzyQuery(launcher.currentSearch);
								launcher.entryIndex = 0
							}
							
							Text {
								id: iconText
								anchors.left: parent.left
								anchors.leftMargin: 10
								font.family: Config.settings.iconFont
								color: Colours.palette.on_surface
								text: "search"
								font.pixelSize: 15
								font.weight: 600
								anchors.top: parent.top
								anchors.topMargin: (parent.height / 2) - ((font.pixelSize + 5) / 2)
								opacity: 0.8
							}

							Text {
								id: placeHolderText
								anchors.left: iconText.right
								anchors.leftMargin: 10
								font.family: Config.settings.font
								color: (launcher.currentSearch != "") ? Colours.palette.on_surface : Colours.palette.outline
								text: (launcher.currentSearch != "") ? launcher.currentSearch : "Start typing to search ..."
								font.pixelSize: 13
								anchors.top: parent.top
								anchors.topMargin: (parent.height / 2) - ((font.pixelSize + 5) / 2)

								opacity: 0.8

								Behavior on opacity {
									NumberAnimation {
										duration: 250
										easing.bezierCurve: Anim.standard
									}
								}
							}
						}

						ScrollView {
							anchors.top: searchBox.bottom
							anchors.topMargin: 10
							
							anchors.left: parent.left
							anchors.leftMargin: (parent.width / 2) - (width / 2)
							width: parent.width - 20
							height: parent.height - searchBox.height - 20

							ListView {
								anchors.fill: parent
								spacing: 10

								model: launcher.appList
								currentIndex: launcher.entryIndex

								delegate: AppItem {
									required property int index
									required property DesktopEntry modelData
									selected: index === launcher.entryIndex
								}
							}
						}
					}
				}
			}
		}
	}
}
