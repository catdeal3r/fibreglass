import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.wyvern.launcher
import qs.config
import qs.modules.common
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
				
				ScrollView {
					id: maskId
					property int topMarginPadding: (parent.height / 2) - (implicitHeight / 2)

					implicitHeight: 500
					implicitWidth: 500
					
					anchors.top: parent.top
					anchors.left: parent.left

					anchors.leftMargin: (parent.width / 2) - (implicitWidth / 2)

					visible: true
					
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
								color: Colours.palette.outline
								text: "Start typing to search ..."
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

								delegate: AppItem {
									required property DesktopEntry modelData
								}
							}
						}
					}
				}
			}
		}
	}
}
