import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.resett.desktop
import qs.config
import qs.modules.common
import qs.modules


Loader {
	id: root
	required property bool isDesktopOpen
	
	property bool ani
	
	active: false
	
	onIsDesktopOpenChanged: {
		if (root.isDesktopOpen == true) {
			root.active = true
			root.ani = true
		} else {
			root.ani = false
		}
	}
	
	sourceComponent: Scope {
		signal finished();

		Component.onCompleted: {
			Quickshell.execDetached(["grim", "-l", "0", Quickshell.shellDir + "/cache/bg_image.png"]);
		}
		
		Variants {
			model: Quickshell.screens;
	  
			PanelWindow {
				id: desktopWindow
			
				property var modelData
				screen: modelData
				
				anchors {
					top: true
					bottom: true
					right: true
					left: true
				}

				aboveWindows: true
				color: "transparent"
				
				exclusionMode: ExclusionMode.Ignore
				
				mask: Region {
					item: maskId
				}
				
				visible: true
				
				Rectangle {
					id: maskId
					implicitHeight: desktopWindow.height
					implicitWidth: desktopWindow.width
					opacity: 0

					color: "transparent"

					anchors.top: parent.top
					//anchors.topMargin: desktopWindow.height
					
					Timer {
						running: root.ani
						repeat: false
						interval: 80
						onTriggered: {
							//maskId.anchors.topMargin = 0
							maskId.opacity = 1
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 1
						onTriggered: {
							//maskId.anchors.topMargin = desktopWindow.height
							maskId.opacity = 0
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

					Behavior on opacity {
						NumberAnimation {
							duration: 250
							easing.bezierCurve: Anim.standard
						}
					}

					Image {
						id: background
						anchors.fill: parent
						source: Quickshell.shellDir + "/cache/bg_image.png" //Config.settings.currentWallpaper
					}
					
					MultiEffect {
						id: darkenEffect
						source: background
						anchors.fill: background

						autoPaddingEnabled: false
						opacity: 1
						blurEnabled: true
   						blurMax: 64
    					blur: 1.0
						
						brightness: -0.1
					}
					
					
					Rectangle {
						anchors.fill: parent
						
						color: "transparent"
						
						Rectangle {
							anchors.left: parent.left
							anchors.bottom: parent.bottom

							anchors.leftMargin: 20
							anchors.bottomMargin: 20

							color: Colours.palette.surface

							width: 300
							height: 100

							radius: Config.settings.borderRadius

							
							Text {
								id: toggleButton
								anchors.left: parent.left
								anchors.leftMargin: 15

								anchors.top: parent.top
								anchors.topMargin: 30
								
								text: "discover_tune"

								opacity: 0

								color: Colours.palette.on_surface
								font.family: Config.settings.iconFont
								font.pixelSize: 30

								Behavior on opacity {
									NumberAnimation {
										duration: 250
										easing.bezierCurve: Anim.standard
									}
								}
							}

							Rectangle {
								id: timeBox
								anchors.left: parent.left
								anchors.leftMargin: 15

								color: "transparent"
								width: parent.width - 50
								height: parent.height

								Behavior on anchors.leftMargin {
									NumberAnimation {
										duration: 250
										easing.bezierCurve: Anim.standard
									}
								}

								Text {
									id: timeText
									property string time
									anchors.left: parent.left

									anchors.top: parent.top
									anchors.topMargin: 12

									text: time

									color: Colours.palette.on_surface
									font.family: Config.settings.font
									font.pixelSize: 40

									Process {
										id: timeProc

										command: [ "date", "+%I:%M %p" ]
										running: true

										stdout: SplitParser {
											onRead: data => timeText.time = data
										}
									}

									Timer {
										interval: 1000
										running: true
										repeat: true
										onTriggered: timeProc.running = true
									}
								}

								Text {
									id: dateText
									property string date
									anchors.left: parent.left
									anchors.leftMargin: 3

									anchors.top: timeText.bottom
									anchors.topMargin: 1

									text: date

									color: Colours.palette.primary
									font.family: Config.settings.font
									font.pixelSize: 15

									Process {
										id: dateProc

										command: [ "date", "+%A %d, %b" ]
										running: true

										stdout: SplitParser {
											onRead: data => dateText.date = data
										}
									}

									Timer {
										interval: 1000
										running: true
										repeat: true
										onTriggered: dateProc.running = true
									}
								}
							}

							HoverHandler {
								id: hoverHandler
								parent: parent
								
								acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
								
								onHoveredChanged: {
									if (hovered) {
										timeBox.anchors.leftMargin = 60
										toggleButton.opacity = 1
									} else {
										timeBox.anchors.leftMargin = 15
										toggleButton.opacity = 0
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
