import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.cavern.dashboard
import qs.config
import qs.modules.common
import qs.modules


Loader {
	id: root
	required property bool isDashboardOpen
	
	property bool ani
	
	active: false
	
	onIsDashboardOpenChanged: {
		if (root.isDashboardOpen == true) {
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
				id: dashboardWindow
			
				property var modelData
				screen: modelData
				
				anchors {
					top: (Config.settings.bar.barLocation == "top")
					bottom: (Config.settings.bar.barLocation == "bottom")
					right: true
				}
				
				margins {
					top: (Config.settings.bar.barLocation == "top") ? 20 : 0
					bottom: (Config.settings.bar.barLocation == "bottom") ? 20 : 0
					right: 15
				}
				
				aboveWindows: true
				color: "transparent"
				
				implicitHeight: 670
				implicitWidth: 510
				
				exclusionMode: ExclusionMode.Ignore
				
				mask: Region {
					item: maskId
				}
				
				visible: {
					if (maskId.leftMargin == 600) return false;
					if (Config.settings.isInMinimalMode == true) return false;
					else return true;
				}
				
				ClippingRectangle {
					id: maskId
					implicitHeight: 0
					implicitWidth: 0
					
					radius: Config.settings.borderRadius
					
					anchors {
						bottom: parent.bottom
						top: undefined
						left: undefined
						right: parent.right
					}
					
					anchors.rightMargin: 10
					color: "transparent"
					
					Timer {
						running: root.ani
						repeat: false
						interval: 1
						onTriggered: {
							maskId.implicitWidth = 500
							maskId.implicitHeight = 670
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 1
						onTriggered: {
							maskId.implicitWidth = 0
							maskId.implicitHeight = 0
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
					
					anchors.topMargin: (Config.settings.bar.barLocation == "top") ? 50 : 0
					anchors.bottomMargin: (Config.settings.bar.barLocation == "bottom") ? 40 : 0
					
					states: State {
						name: "anchorTop"
						when: (Config.settings.bar.barLocation == "top")
							
						AnchorChanges {
							target: maskId
							anchors {
								bottom: undefined
								top: parent.top
								left: undefined
								right: parent.right
							}
						}
					}
					
					clip: true
					
					Behavior on implicitWidth {
						NumberAnimation {
							duration: 250
							easing.bezierCurve: Anim.standard
						}
					}
					
					
					Behavior on implicitHeight {
						NumberAnimation {
							duration: 250
							easing.bezierCurve: Anim.standard
						}
					}
					
					
					children: Rectangle {
						//anchors.top: parent.top
						//width: parent.implicitWidth
						//height: parent.implicitHeight - 10
						anchors.fill: parent
						
						color: Colours.palette.surface
						
						radius: Config.settings.borderRadius
						
						ColumnLayout {
							
							spacing: 10
							
							Top {}
							
							Middle {}
						}
					}
				}
			}
		}
	}
}
