import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.oneb.dashboard
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
					left: true
				}
				
				aboveWindows: true
				color: "transparent"
				
				implicitHeight: 1080
				implicitWidth: 560
				
				exclusionMode: ExclusionMode.Ignore
				
				mask: Region {
					item: maskId
				}
				
				visible: true
				
				ScrollView {
					id: maskId
					implicitHeight: 1080
					implicitWidth: 550
					
					anchors {
						left: parent.left
					}
					
					anchors.leftMargin: -600
					
					Timer {
						running: root.ani
						repeat: false
						interval: 1
						onTriggered: {
							maskId.anchors.leftMargin = 40
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 1
						onTriggered: {
							maskId.anchors.leftMargin = -600
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
					
					Behavior on anchors.leftMargin {
						NumberAnimation {
							duration: 250
							easing.bezierCurve: Anim.standard
						}
					}
					
					
					Rectangle {
						anchors.fill: parent
						
						color: Colours.palette.surface
						
						radius: Config.settings.borderRadius
						
						ColumnLayout {
							
							spacing: 10
							
							Top {}
							
							Middle {}
							
							Bottom {}
						}
					}
				}
			}
		}
	}
}
