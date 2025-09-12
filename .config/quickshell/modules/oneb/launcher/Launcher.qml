import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.modules.oneb.launcher
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
						interval: 250
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

						property var actions: Actions.actions

						property bool isNormalSearch: {
							if (currentSearch[0] == ">")
								return false
							return true
						}

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

							Keys.onDownPressed: {
								if (launcher.currentSearch[0] != ">") {
									if (launcher.entryIndex != launcher.appList.length - 1)
										launcher.entryIndex += 1;
								} else {
									if (launcher.entryIndex != launcher.actions.length - 1)
										launcher.entryIndex += 1;
								}
							}

							Keys.onUpPressed: {
								if (launcher.entryIndex != 0)
									launcher.entryIndex -= 1;
							}
							Keys.onEscapePressed: {
								launcher.currentSearch = "";
								IPCLoader.toggleLauncher()
							}

							Keys.onPressed: event => {
								if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
									if (launcher.currentSearch[0] == ">") {
										let action = launcher.actions[launcher.entryIndex];

										if (action.execType == "external") {
											Quickshell.execDetached({
												command: action.execute,
											});
										} else {
											action.execute();
										}

										launcher.currentSearch = "";

										if (action.closeOnRun == true) {
											IPCLoader.toggleLauncher();
										}

									} else if (launcher.currentSearch != "") {
										
										launcher.appList[launcher.entryIndex].execute();
										launcher.currentSearch = "";
										IPCLoader.toggleLauncher();
									}
								} else if (event.key === Qt.Key_Backspace) {
									launcher.currentSearch = launcher.currentSearch.slice(0, -1);
								} else if (" abcdefghijklmnopqrstuvwxyz1234567890`~!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?".includes(event.text.toLowerCase())) {
									launcher.currentSearch += event.text;
								}

								if (launcher.currentSearch[0] != ">") {
									launcher.appList = Apps.fuzzyQuery(launcher.currentSearch);
								} else {
									console.log(Actions.fuzzyQuery(launcher.currentSearch));
								}
								
								launcher.entryIndex = 0;
							}
							
							Text {
								id: iconText
								anchors.left: parent.left
								anchors.leftMargin: 10
								font.family: Config.settings.iconFont
								color: (launcher.currentSearch != "") ? Colours.palette.on_surface : Colours.palette.outline
								text: "search"
								font.pixelSize: 15
								font.weight: 600
								anchors.top: parent.top
								anchors.topMargin: (parent.height / 2) - ((font.pixelSize + 5) / 2)
								opacity: 0.8

								Behavior on color {
									PropertyAnimation {
										duration: 250
										easing.bezierCurve: Easing.InSine
									}
								}
							}

							ListView {
								id: charList

								anchors.left: iconText.right
								anchors.leftMargin: 10
								
								anchors.top: parent.top
								anchors.topMargin: (searchBox.height / 2) - (height / 2)
								
								width: searchBox.width - 20
								height: 18
								
								clip: true

								orientation: Qt.Horizontal
								spacing: 1
								interactive: false

								model: ScriptModel {
									values: launcher.currentSearch.split("")
								}

								delegate: Text {
									required property int index
									id: ch
									color: Colours.palette.on_surface
									text: launcher.currentSearch[index]

									font.family: Config.settings.font
									font.pixelSize: 13

									opacity: 0
										
									Component.onCompleted: {
										opacity = 1
									}
										
									Behavior on opacity {
										PropertyAnimation {
											duration: 200
											easing.type: Easing.InSine
										}
									}
								}
							}

							Text {
								id: placeHolderText

								anchors.left: iconText.right
								anchors.leftMargin: 10
								font.family: Config.settings.font
								color: (launcher.currentSearch != "") ? Colours.palette.on_surface : Colours.palette.outline
								text: "Start typing to search ..."
								font.pixelSize: 13
								anchors.top: parent.top
								anchors.topMargin: (parent.height / 2) - ((font.pixelSize + 5) / 2)

								opacity: (launcher.currentSearch == "") ? 0.8 : 0

								Behavior on color {
									PropertyAnimation {
										duration: 250
										easing.bezierCurve: Easing.InSine
									}
								}

								Behavior on opacity {
									PropertyAnimation {
										duration: 100
										easing.bezierCurve: Easing.InSine
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
							opacity: {
								if (!launcher.isNormalSearch)
									return 0
								if (launcher.currentSearch == "") 
									return 0
								return 1
							}

							Behavior on opacity {
								NumberAnimation {
									duration: 250
									easing.bezierCurve: Anim.standard
								}
							}

							ListView {
								anchors.fill: parent
								spacing: 10

								model: launcher.appList
								currentIndex: launcher.entryIndex

								delegate: AppItem {
									required property int index
									required property DesktopEntry modelData
									selected: index === launcher.entryIndex
									isNormalItem: true
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

							opacity: {
								if (launcher.isNormalSearch)
									return 0
								if (launcher.currentSearch == "") 
									return 0
								return 1
							}

							Behavior on opacity {
								NumberAnimation {
									duration: 250
									easing.bezierCurve: Anim.standard
								}
							}

							ListView {
								anchors.fill: parent
								spacing: 10

								model: launcher.actions
								currentIndex: launcher.entryIndex

								delegate: AppItem {
									required property int index
									required property var modelData
									selected: index === launcher.entryIndex
									isNormalItem: false
								}
							}
						}

						Rectangle {
							anchors.top: searchBox.bottom
							anchors.topMargin: 10
							
							anchors.left: parent.left
							anchors.leftMargin: (parent.width / 2) - (width / 2)
							width: parent.width - 20
							height: parent.height - searchBox.height - 20
							color: "transparent"
							opacity: (launcher.appList.length == 0 && launcher.isNormalSearch) ? 1 : 0
							Behavior on opacity {
								NumberAnimation {
									duration: 250
									easing.bezierCurve: Anim.standard
								}
							}

							Text {
								anchors.centerIn: parent
								text: "No results found."
								color: Colours.palette.outline
								font.family: Config.settings.font
								font.pixelSize: 15
							}
						}

						Rectangle {
							id: asciiContainer
							property bool hovered
							anchors.top: searchBox.bottom
							anchors.topMargin: (launcher.currentSearch == "") ? 10 : 1000

							Behavior on anchors.topMargin {
								NumberAnimation {
									duration: 550
									easing.bezierCurve: Anim.standard
								}
							}

							anchors.left: parent.left
							anchors.leftMargin: (parent.width / 2 ) - (width / 2)
							width: parent.width - 20
							height: parent.height - searchBox.height - 20

							color: Colours.palette.surface
							
							opacity: (launcher.currentSearch == "") ? 1 : 0

							Behavior on opacity {
								NumberAnimation {
									duration: 850
									easing.bezierCurve: Anim.standard
								}
							}

							Image {
								id: asciiImage
								anchors.top: parent.top
								anchors.topMargin: 10

								anchors.left: parent.left
								anchors.leftMargin: (parent.width / 2) - (width / 2)

								property int size: 300
								width: size + 50
								height: size

								fillMode: Image.PreserveAspectCrop
								source: "file://" + Quickshell.shellDir + "/assets/ascii_art_wyvern.png"
							}

							MultiEffect {
								source: asciiImage
								anchors.fill: asciiImage
								colorizationColor: Colours.palette.outline
								colorization: 0.8
								opacity: asciiContainer.hovered ? 0 : 1

								Behavior on opacity {
									PropertyAnimation {
										duration: 250
										easing.bezierCurve: Easing.InSine
									}
								}
							}


							RowLayout {
								anchors.top: asciiImage.bottom
								anchors.topMargin: 10

								anchors.left: parent.left
								anchors.leftMargin: (parent.width / 2) - (width / 2)

								width: 100

								Text {
									Layout.alignment: Qt.AlignHCenter
									
									color: asciiContainer.hovered ? Qt.alpha(Colours.palette.primary, 0.6) : Qt.alpha(Colours.palette.on_surface, 0.8)
									font.family: Config.settings.font
									font.pixelSize: 15
									font.weight: 600
									text: "Wyvern"

									Behavior on color {
										PropertyAnimation {
											duration: 250
											easing.bezierCurve: Easing.InSine
										}
									}
								}

								Text {
									Layout.alignment: Qt.AlignHCenter

									color: Colours.palette.outline
									font.family: Config.settings.font
									font.pixelSize: 15
									font.weight: 600
									text: "v0.7"
								}
							}

							MouseArea {
								anchors.fill: parent
								hoverEnabled: true
								onEntered: parent.hovered = true
								onExited: parent.hovered = false
							}
						}
					}
				}
			}
		}
	}
}
