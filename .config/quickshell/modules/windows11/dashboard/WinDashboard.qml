import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.windows11.dashboard
import qs.config
import qs.modules.common
import qs.modules

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
				top: (Config.settings.bar.barLocation == "top") ? 10 : 0
				bottom: (Config.settings.bar.barLocation == "bottom") ? 10 : 0
				right: 10
			}
			
			aboveWindows: true
			color: "transparent"
			
			implicitHeight: 1020
			implicitWidth: 500
			
			mask: Region {
				item: maskId
			}
			
			visible: {
				if (maskId.leftMargin == 600) return false;
				if (Config.settings.isInMinimalMode == true) return false;
				else return true;
			}
			
			ScrollView {
				id: maskId
				implicitHeight: 1020
				implicitWidth: 500
				
				
				anchors {
					bottom: undefined
					top: undefined
					left: parent.left
					right: undefined
				}
				
				anchors.leftMargin: IPCLoader.isDashboardOpen ? 0 : 600
				
				/*states: State {
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
				}*/
				
				clip: false
				
				Behavior on anchors.leftMargin {
					NumberAnimation {
						duration: 250
						easing.bezierCurve: Anim.standard
					}
				}
				
				
				Rectangle {
					anchors.centerIn: parent
					
					width: 500
					height: 1020
					
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
