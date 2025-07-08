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
import "root:/modules/dashboard/toggles"

ColumnLayout {
	Layout.alignment: Qt.AlignTop
	Layout.preferredWidth: 500
	Layout.preferredHeight: 330
	spacing: 10

	Rectangle {
		Layout.alignment: Qt.AlignTop
		Layout.preferredWidth: 500
		Layout.preferredHeight: 130
									
		color: Colours.palette.surface
		
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
					
					
					toRun: () => Quickshell.execDetached([ `${Quickshell.configDir}/scripts/bluetooth.out` ])
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
		Layout.preferredHeight: 200
		color: "transparent"
		
		Text {
			anchors.centerIn: parent
			font.pixelSize: 20
			color: Colours.palette.on_surface
			text: "Hello"
		}
	}
}
