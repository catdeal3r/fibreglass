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
			
			/*margins {
				top: (Config.settings.bar.barLocation == "top") ? 0 : 0
				bottom: (Config.settings.bar.barLocation == "bottom") ? 0 : 0
				right: 0
			}*/
			
			aboveWindows: true
			color: "transparent"
			
			implicitHeight: 1070
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
			
			ScrollView {
				id: maskId
				implicitHeight: InternalLoader.isDashboardOpen ? 1070 : 0
				implicitWidth: 500
				
				anchors {
					bottom: parent.bottom
					top: undefined
					left: parent.left
					right: undefined
				}
				
				anchors.leftMargin: InternalLoader.isDashboardOpen ? 0 : 600
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
							left: parent.left
							right: undefined
						}
					}
				}
				
				clip: true
				
				Behavior on anchors.leftMargin {
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
