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
	color: Colours.palette.surface
	
	property int notificationCount: Notifications.list.length
	
	ColumnLayout {
		anchors.left: parent.left
		anchors.leftMargin: (parent.width - 400) / 2
		
		RowLayout {
			Layout.topMargin: 15
			
			Text {
				color: Colours.palette.on_surface
				text: "Notifications"
				font.family: Appearance.font
				font.pixelSize: 15
				
				font.weight: 600
				
				Layout.preferredWidth: 290
			}
		
			Rectangle {
				width: 90
				height: 30
				
				radius: Appearance.borderRadius
				color: Colours.palette.surface_container
				
				Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
				
				Behavior on color {
					PropertyAnimation {
						duration: 150
						easing.type: Easing.InSine
					}
				}
				
				RowLayout {
					anchors.centerIn: parent
					
					Text {
						color: Colours.palette.on_surface
						text: "clear_all"
						font.family: Appearance.iconFont
						font.pixelSize: 20
					}
				
					Text {
						color: Colours.palette.on_surface
						text: "Clear"
						font.family: Appearance.font
						font.pixelSize: 14
					}
				}
				
				MouseArea {
					anchors.fill: parent
					
					cursorShape: Qt.PointingHandCursor
											
					hoverEnabled: true
										
					onClicked: Notifications.discardAllNotifications()
					onEntered: parent.color = Colours.palette.surface_container_high
					onExited: parent.color = Colours.palette.surface_container
				}
			}
		}

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
			Layout.topMargin: 10
			
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
				anchors.topMargin: (parent.Layout.preferredHeight / 2) - 50
			
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
