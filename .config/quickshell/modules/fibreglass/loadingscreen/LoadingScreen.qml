import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config

Scope {
	signal finished();
	id: root

	Variants {
		model: Quickshell.screens;
			
		PanelWindow {
			property var modelData
			screen: modelData
			
			anchors {
				bottom: true 
				left: true
				right: true
				top: true
			}
			
			aboveWindows: true 
			color: Colours.palette.surface
			
			ColumnLayout {
				anchors.centerIn: parent
				
				spacing: 15
				
				IconImage {
					Layout.alignment: Qt.AlignHCenter
					
					source: Quickshell.shellDir("/assets/icon.png")
					Layout.preferredWidth: 170
					Layout.preferredHeight: 170
				}
			
				AnimatedImage {
					Layout.alignment: Qt.AlignHCenter
					
					source: Quickshell.shellDir("/assets/loading.gif")
					fillMode: Image.PreserveAspectFit
					playing: true
					Layout.preferredWidth: 40
					Layout.preferredHeight: 40
				}
				
				
			}
			
			MouseArea {
				anchors.fill: parent
				enabled: false
				cursorShape: Qt.BlankCursor
			}
		}
	}
}
  
