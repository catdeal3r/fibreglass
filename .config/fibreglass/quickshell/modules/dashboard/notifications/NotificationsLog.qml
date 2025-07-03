import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import "root:/config"
import "root:/modules/common"
import "root:/services"
import "root:/modules/dashboard/notifications"

Rectangle {
	id: root
	
	height: 370
	width: 400
	
	anchors.top: parent.top
	anchors.topMargin: 10
			
	radius: Appearance.borderRadius
	color: "transparent"
	
	property int notificationCount: Notifications.list.length
	
	ColumnLayout {
		anchors.left: parent.left
		anchors.leftMargin: (parent.width - 400) / 2
	
		/*Rectangle {
			width: 400
			height: 20
			
			Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
		}*/

		ListView {
			id: notifList
			model: ScriptModel {
				values: [...Notifications.list].reverse()
			}
							
			implicitHeight: 370
			implicitWidth: (root.notificationCount > 0) ? 400 : 0
			clip: true
			
			Behavior on implicitWidth {
				PropertyAnimation {
					duration: 400
					easing.type: Easing.InSine
				}
			}
					
			Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
			visible: (implicitWidth == 0) ? false : true
						
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
		
		Rectangle {
			Layout.preferredHeight: root.height
			Layout.preferredWidth: root.width
			
			visible: (notifList.visible) ? false : true
			color: "transparent"
			
			Behavior on visible {
				PropertyAnimation {
					duration: 400
					easing.type: Easing.InSine
				}
			}
		
			Text {
				anchors.top: parent.top
				anchors.topMargin: parent.Layout.preferredHeight / 2
			
				anchors.right: parent.right
				anchors.rightMargin: (parent.Layout.preferredWidth / 2) - 60
				
				text: "No notifications."
				font.pixelSize: 20
				font.family: Appearance.font
				
				visible: (notifList.visible) ? false : true
				
				Behavior on visible {
					PropertyAnimation {
						duration: 400
						easing.type: Easing.InSine
					}
				}
					
				color: Colours.palette.on_surface
			}
		}
	}
}
