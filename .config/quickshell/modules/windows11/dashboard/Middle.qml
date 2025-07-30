import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common
import qs.services
import qs.modules.windows11.dashboard.toggles
import qs.modules.windows11.dashboard.middle

ColumnLayout {
	Layout.alignment: Qt.AlignTop
	Layout.preferredWidth: 500
	Layout.preferredHeight: 400
	spacing: 20
	
	Text {
		id: label
		color: Colours.palette.on_surface
		text: "Toggles"
		font.family: Config.settings.font
		font.pixelSize: 15
			
		font.weight: 600
		Layout.alignment: Qt.AlignLeft
		Layout.leftMargin: 40
	}

	Rectangle {
		Layout.alignment: Qt.AlignTop
		Layout.preferredWidth: 500
		Layout.preferredHeight: 130
									
		color: "transparent"
		
		RowLayout {
			anchors.centerIn: parent
			spacing: 25
			
			ColumnLayout {
				spacing: 22
				
				QuickToggleButton {
					isToggled: Network.getBool()
					
					bigText: Network.textLabel
					iconCode: Network.getIcon()
					
					toRun: () => Quickshell.execDetached([ `${Quickshell.configDir}/scripts/network.out` ])
				}
				
				QuickToggleButton {
					isToggled: Nightmode.getBool()
					
					bigText: Nightmode.getText()
					iconCode: Nightmode.getIcon()
					
					toRun: () => Quickshell.execDetached([ `${Quickshell.configDir}/scripts/Nightmode` ])
				}
			}
			
			ColumnLayout {
				spacing: 22
				
				QuickToggleButton {
					isToggled: Bluetooth.getBool()
					
					bigText: Bluetooth.textLabel
					iconCode: Bluetooth.getIcon()
					
					
					toRun: () => Bluetooth.toggle() 
				}
				
				QuickToggleButton {
					isToggled: Notifications.popupInhibited
					
					bigText: Notifications.popupInhibited ? "Do Not Disturb" : "Disturb"
					iconCode: Notifications.popupInhibited ? "speaker_notes_off" : "speaker_notes"
					
					iconSize: 24
					
					toRun: () => Notifications.toggleDND()
				}
			}
		}
	}
	
	Rectangle {
		Layout.preferredWidth: 500
		Layout.preferredHeight: 240
		color: "transparent"
		
		PlayerControls {}
	}
}
