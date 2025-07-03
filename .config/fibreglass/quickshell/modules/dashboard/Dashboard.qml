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
				bottom: true 
				right: true
			}
			
			margins {
				bottom: 50
				right: 10
			}
			
			aboveWindows: false 
			color: "transparent"
			
			implicitHeight: 750
			implicitWidth: 500
			
			
			mask: Region {
				x: maskId.x
				y: maskId.y
				width: maskId.implicitWidth
				height: InternalLoader.isDashboardOpen ? 750 : 0
			}
			
			visible: (maskId.implicitHeight == 0) ? false : true 
			
			ScrollView {
				id: maskId
				implicitHeight: InternalLoader.isDashboardOpen ? 750 : 0
				implicitWidth: 500
				anchors.bottom: parent.bottom
				
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
					
					radius: Appearance.borderRadius
					
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
