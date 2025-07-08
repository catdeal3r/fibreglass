import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris

import "root:/config"
import "root:/modules/common"
import "root:/services"
import "root:/modules/dashboard"

Rectangle {
	anchors.centerIn: parent
	width: 500
	height: 200
	color: "transparent"
	
	ColumnLayout {
		anchors.fill: parent
		
		RowLayout {
			Layout.alignment: Qt.AlignLeft
			
			Text {
				Layout.alignment: Qt.AlignLeft
				font.pixelSize: 20
				color: Colours.palette.on_surface
				text: "Image"
			}
			
			ColumnLayout {
				Layout.alignment: Qt.AlignHCenter
				
				Text {
					Layout.alignment: Qt.AlignLeft
					font.pixelSize: 20
					color: Colours.palette.on_surface
					text: "Title"
				}
				
				Text {
					Layout.alignment: Qt.AlignLeft
					font.pixelSize: 20
					color: Colours.palette.on_surface
					text: "Artist"
				}
			}
		}
		
		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			
			Text {
				Layout.alignment: Qt.AlignHCenter
				font.pixelSize: 20
				color: Colours.palette.on_surface
				text: "Shuffle"
			}
			
			Text {
				Layout.alignment: Qt.AlignHCenter			
				font.pixelSize: 20
				color: Colours.palette.on_surface
				text: "Previous"
			}
			
			Text {
				Layout.alignment: Qt.AlignHCenter	
				font.pixelSize: 20
				color: Colours.palette.on_surface
				text: "Play"
			}
			
			Text {
				Layout.alignment: Qt.AlignHCenter	
				font.pixelSize: 20
				color: Colours.palette.on_surface
				text: "Next"
			}
			
			Text {
				Layout.alignment: Qt.AlignHCenter	
				font.pixelSize: 20
				color: Colours.palette.on_surface
				text: "Repeat"
			}
		}
	}
}
