import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.oneb.bar.dashboard
import qs.config
import qs.modules.common
import qs.modules


Loader {
	id: root
	required property bool isDashboardOpen
	required property int dash_width
	
	property bool ani
	
	active: false
	
	onIsDashboardOpenChanged: {
		if (root.isDashboardOpen == true) {
			root.active = true
		} else {
			root.active = false
		}
	}
	
	sourceComponent: ScrollView {
		id: maskId
		implicitHeight: 1080
		implicitWidth: root.dash_width
					
		anchors {
			left: parent.left
		}
										
		clip: true
					
		Rectangle {
			anchors.fill: parent
					
			color: Colours.palette.surface
									
			ColumnLayout {
				spacing: 20
							
				Top {}
							
				Middle {}
							
				Bottom {}
			}
		}
	}
}
