
import Quickshell
import QtQuick


import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.config
import qs.services
import qs.modules

Scope {
	signal finished();
	id: root
	
	Variants {
		model: Quickshell.screens;
  
		PanelWindow {
			id: launcherWindow
		
			property var modelData
			screen: modelData
			
			color: "transparent"
			
			anchors {
				top: (Config.settings.bar.barLocation == "top")
				bottom: (Config.settings.bar.barLocation == "bottom")
			}
			
			margins {
				top: (Config.settings.bar.barLocation == "top") ? 50 : 0
				bottom: (Config.settings.bar.barLocation == "bottom") ? 50 : 0
			}
			
			implicitWidth: 500
			implicitHeight: 400
			
			exclusiveZone: 0
			exclusionMode: ExclusionMode.Ignore
			
			mask: Region {
				item: maskId
			}
			
			visible: (maskId.implicitHeight == 0) ? false : true 
			
			ScrollView {
				id: maskId
				implicitHeight: InternalLoader.isLauncherOpen ? 400 : 0
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
					height: 400
					
					color: Colours.palette.surface
					radius: Config.settings.borderRadius
					
					Text {
						anchors.centerIn: parent
						text: "testing"
						
						font.family: Config.settings.font
						color: Colours.palette.on_surface
					}
				}
			}
		}
	}
}
