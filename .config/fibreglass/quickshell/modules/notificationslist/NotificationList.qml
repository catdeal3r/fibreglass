import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick.Layouts
import Quickshell.Widgets

import "root:/config"
import "root:/services"
import "root:/modules/common"

Scope {
	Variants {
		model: Quickshell.screens;
 
		PanelWindow {
			id: root
		
			property var modelData
			screen: modelData
		
			anchors {
				top: true
				right: true
			}
			
			margins {
				top: (Config.settings.bar.barLocation == "top") ? 50 : 0
			}
		
			aboveWindows: true
			exclusionMode: ExclusionMode.Ignore
			
			implicitHeight: 400
			implicitWidth: 450
			
			color: "transparent"
	
			property int notificationCount: Notifications.popupList.length
		
			visible: true
			
			mask: Region {
				item: maskId.contentItem
			}

			ListView {
				id: maskId
				model: ScriptModel {
					values: [...Notifications.popupList].reverse()
				}
				
				implicitHeight: 400
				implicitWidth: 400//(notificationCount > 0) ? 400 : 1
				
				anchors.top: parent.top
				anchors.topMargin: 20
				
				anchors.right: parent.right
				anchors.rightMargin: 20
				
				Behavior on implicitWidth {
					NumberAnimation {
						duration: 200
						easing.bezierCurve: Anim.standard
					}
				}
				
				spacing: 20
				
				add: Transition {
					NumberAnimation {
						duration: 500
						easing.bezierCurve: Anim.standard
						from: 400
						property: "x"
					}
				}
				
				addDisplaced: Transition {
					NumberAnimation {
						duration: 500
						easing.bezierCurve: Anim.standard
						properties: "x,y"
					}
				}
				
				delegate: SingleNotification {
					popup: true
					required property Notifications.Notif modelData
				}
				
				remove: Transition {
					NumberAnimation {
						duration: 500
						easing.bezierCurve: Anim.standard
						property: "x"
						to: 400
					}
				}
			}
		}
	}
}
