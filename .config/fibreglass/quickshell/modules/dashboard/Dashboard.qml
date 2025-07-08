import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import "root:/modules/dashboard"
import "root:/config"
import "root:/modules/common"
import "root:/modules"

Scope {
	signal finished();
	id: root
	
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
				top: (Config.settings.bar.barLocation == "top") ? 50 : 0
				bottom: (Config.settings.bar.barLocation == "bottom") ? 50 : 0
				right: 10
			}
			
			aboveWindows: true
			color: "transparent"
			
			implicitHeight: 750
			implicitWidth: 500
			
			mask: Region {
				item: maskId
			}
			
			visible: (maskId.implicitHeight == 0) ? false : true 
			
			ScrollView {
				id: maskId
				implicitHeight: InternalLoader.isDashboardOpen ? 750 : 0
				implicitWidth: 500
				
				anchors {
					bottom: parent.bottom
					top: undefined
					left: undefined
					right: undefined
				}
				
				states: State {
					name: "anchorTop"
					when: (Config.settings.bar.barLocation == "top")
						
					AnchorChanges {
						target: maskId
						anchors {
							bottom: undefined
							top: parent.top
							left: undefined
							right: undefined
						}
					}
				}
				
				clip: false
				
				Behavior on implicitHeight {
					NumberAnimation {
						duration: 200
						easing.bezierCurve: Anim.standard
					}
				}
				
				Rectangle {
					anchors.centerIn: parent
					
					width: 500
					height: 750
					
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
