import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Controls

import qs.config
import qs.services
import qs.common


Rectangle {
	id: singleNotif
	property real currentTime: 5000

	radius: Config.settings.borderRadius
	color: Colours.palette.surface
	implicitHeight:	80
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
			
		onClicked: Notifications.discardNotification(modelData.id)
	}
	
	Timer {
		id: dismissTimer
		interval: 100
		running: (singleNotif.currentTime > 0)
		repeat: false
		onTriggered: singleNotif.currentTime -= 100
	}
	
	ClippingRectangle {
		anchors.fill: parent
		color: "transparent"
		radius: parent.radius
		
		Rectangle {
			anchors.bottom: parent.bottom
			width: (singleNotif.currentTime / singleNotif.modelData.timer.interval) * parent.width
			height: 4
			color: Colours.palette.primary
			
			Behavior on width {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
		}
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
						
			Layout.alignment: Qt.AlignLeft
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
			Layout.preferredWidth: 280
			Layout.leftMargin: 10
			
			
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
				font.pixelSize: 13
			}
			
			TextMetrics {
				id: summaryPreviewMetrics
									
				text: modelData.summary
				font.family: Config.settings.font
									
				elide: Qt.ElideRight
				elideWidth: 270
			}
								
			Text {
				id: bodyPreview
				Layout.alignment: Qt.AlignLeft
								
				text: bodyPreviewMetrics.elidedText
									
				color: Colours.palette.primary
								
				font.family: Config.settings.font
				font.pixelSize: 13
			}
							
			TextMetrics {
				id: bodyPreviewMetrics
									
				text: modelData.body
				font.family: Config.settings.font
									
				elide: Qt.ElideRight
				elideWidth: 270
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
					width: 240
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
	}
}
