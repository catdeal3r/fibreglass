import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick.Layouts
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

import "root:/config"
import "root:/services"
import "root:/scripts/notification_utils.js" as NotificationUtils
import "root:/modules/common"


AniRectangle {
	id: singleNotif
	property bool expanded
	property bool popup: false
	
	property real notifSize: {
		if (modelData.body == bodyPreviewMetrics.elidedText && expanded) return 100
		if (modelData.body != bodyPreviewMetrics.elidedText && expanded) return 120
		else return 80
	}
					
	radius: Config.settings.borderRadius + 5
	color: Colours.palette.surface
	implicitHeight:	notifSize
	implicitWidth: 400
	
	border.width: 2
	border.color: Colours.palette.surface_container
	
	anchors.topMargin: 20
	
	Behavior on implicitHeight {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}
					
	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
			
		onClicked: singleNotif.popup ? Notifications.timeoutNotification(modelData.id) : Notifications.discardNotification(modelData.id)
	}
			
	RowLayout {
		anchors.centerIn: parent
						
		anchors.topMargin: 13
		anchors.bottomMargin: 13
		anchors.leftMargin: 5
		anchors.rightMargin: 10
						
		implicitWidth: 400
		spacing: 2
						
		ClippingWrapperRectangle { //image
			visible: (modelData.appIcon == "") ? false : true
			radius: Config.settings.borderRadius
						
			Layout.alignment: root.expanded ? Qt.AlignLeft | Qt.AlignTop : Qt.AlignLeft
			Layout.leftMargin: 0
			Layout.preferredWidth: 50
			Layout.preferredHeight: 50
			
			Behavior on Layout.alignment {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
							
			color: "transparent"
			
			IconImage {				
				visible: (modelData.appIcon == "") ? false : true
				source: Qt.resolvedUrl(modelData.appIcon)
			}
		}
		
		Text { //backup image			
			Layout.alignment: root.expanded ? Qt.AlignLeft | Qt.AlignTop : Qt.AlignLeft
			Layout.leftMargin: 5
			Layout.rightMargin: 10
			
			Behavior on Layout.alignment {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
			
			visible: (modelData.appIcon == "") ? true : false
			text: "chat"
				
			color: Colours.palette.on_surface
									
			font.family: Config.settings.iconFont
			font.pixelSize: 35
		}
					
		ColumnLayout { //content
			id: textWrapper
						
			Layout.alignment: Qt.AlignLeft
			Layout.preferredWidth: 240
			Layout.leftMargin: 10
			
			RowLayout { //expanded bit
				Layout.alignment: Qt.AlignLeft
				spacing: 4
				
				visible: expanded
				
				Behavior on visible {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}
				
				Text {
					text: modelData.appName
					color: Colours.palette.primary
										
					font.family: Config.settings.font
					font.weight: 600
					font.pixelSize: 11
					
					visible: parent.visible
					
					Behavior on visible {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}
					
				}
				Text {
					text: "·"
					color: Colours.palette.on_surface
									
					font.family: Config.settings.font
					font.weight: 600
					font.pixelSize: 11
					
					visible: parent.visible
					
					Behavior on visible {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}
				}
				Text {
					color: Accents.disab
									
					text: NotificationUtils.getFriendlyNotifTimeString(modelData.time)
									
					font.family: Config.settings.font
					font.weight: 600
					font.pixelSize: 11
					
					visible: parent.visible
					
					Behavior on visible {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}
				}
			
			}
			
			// Text content
				
			Text {
				Layout.alignment: Qt.AlignLeft
								
				text: summaryPreviewMetrics.elidedText
				
				visible: {
					if (modelData.summary == "") return false
					else return true
				}
				
				Behavior on visible {
					PropertyAnimation {
						duration: 150
						easing.type: Easing.InSine
					}
				}
									
				color: Colours.palette.on_surface
									
				font.family: Config.settings.font
				font.weight: 600
				font.pixelSize: 15
			}
			
			TextMetrics {
				id: summaryPreviewMetrics
									
				text: modelData.summary
				font.family: Config.settings.font
									
				elide: Qt.ElideRight
				elideWidth: 210
			}
								
			Text {
				id: bodyPreview
				Layout.alignment: Qt.AlignLeft
								
				text: bodyPreviewMetrics.elidedText
									
				color: Colours.palette.primary
								
				font.family: Config.settings.font
				font.pixelSize: 13
									
				visible: {
					if (singleNotif.notifSize == 100) return true
					if (singleNotif.notifSize == 120) return false
					if (modelData.body == "") return false
					else return true
				}
				
				Behavior on visible {
					PropertyAnimation {
						duration: 150
						easing.type: Easing.InSine
					}
				}
			}
							
			TextMetrics {
				id: bodyPreviewMetrics
									
				text: modelData.body
				font.family: Config.settings.font
									
				elide: Qt.ElideRight
				elideWidth: 240
			}
			
			ScrollView {
				visible:  {
					if (singleNotif.notifSize == 100) return false
					if (singleNotif.notifSize == 120) return true
					else return false
				}
				Layout.alignment: Qt.AlignLeft
				
				implicitWidth: 240
				implicitHeight: 35
				
				ScrollBar.horizontal: ScrollBar {
					policy: ScrollBar.AlwaysOff
				}
				
				ScrollBar.vertical: ScrollBar {
					policy: ScrollBar.AlwaysOff
				}
				
				Text {
					width: 265
					height: 50
					text: modelData.body
					
					font.family: Config.settings.font
					font.pixelSize: 13
					color: Colours.palette.primary
					
					visible: singleNotif.expanded
					
					wrapMode: Text.Wrap
				}
				
				Behavior on visible {
					PropertyAnimation {
						duration: 150
						easing.type: Easing.InSine
					}
				}
			}
		}
		
		// Expand button				
		ColumnLayout {
			Layout.alignment: Qt.AlignRight
			Layout.preferredWidth: 20
			Layout.leftMargin: 20
								
			Rectangle {	
				Layout.alignment: Qt.AlignBottom
				id: expandBtn
				width: 25
				height: 25
				color: Colours.palette.surface
				radius: 50
				visible: true 
				
				Behavior on color {
					PropertyAnimation {
						duration: 150
						easing.type: Easing.InSine
					}
				}
									
				Text {
					anchors.centerIn: parent
										
					color: Colours.palette.on_surface
					text: singleNotif.expanded ? "expand_less" : "expand_more"
										
					font.family: Config.settings.iconFont
					font.pixelSize: 24
									
				}
									
				MouseArea {
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
											
					hoverEnabled: true
										
					onClicked: singleNotif.expanded = !singleNotif.expanded
					onEntered: parent.color = Colours.palette.surface_container
					onExited: parent.color = Colours.palette.surface
				}
			}
		}
	}
}
