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
	id: root
	anchors.centerIn: parent
	width: 500
	height: 200
	color: "transparent"
	
	//readonly property var realPlayers: Mpris.players.values.filter(player => isRealPlayer(player))
	//readonly property var meaningfulPlayers: filterDuplicatePlayers(realPlayers)
    
    
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    
    property var artUrl: activePlayer?.trackArtUrl
	
	/*function isRealPlayer(player) {
        // return true
        return (
            // Remove unecessary native buses from browsers if there's plasma integration
            !(false && player.dbusName.startsWith('org.mpris.MediaPlayer2.firefox')) &&
            !(false && player.dbusName.startsWith('org.mpris.MediaPlayer2.chromium')) &&
            // playerctld just copies other buses and we don't need duplicates
            !player.dbusName?.startsWith('org.mpris.MediaPlayer2.playerctld') &&
            // Non-instance mpd bus
            !(player.dbusName?.endsWith('.mpd') && !player.dbusName.endsWith('MediaPlayer2.mpd'))
        );
    }
    function filterDuplicatePlayers(players) {
        let filtered = [];
        let used = new Set();

        for (let i = 0; i < players.length; ++i) {
            if (used.has(i)) continue;
            let p1 = players[i];
            let group = [i];

            // Find duplicates by trackTitle prefix
            for (let j = i + 1; j < players.length; ++j) {
                let p2 = players[j];
                if (p1.trackTitle && p2.trackTitle &&
                    (p1.trackTitle.includes(p2.trackTitle) 
                        || p2.trackTitle.includes(p1.trackTitle))
                        || (p1.position - p2.position <= 2 && p1.length - p2.length <= 2)) {
                    group.push(j);
                }
            }

            // Pick the one with non-empty trackArtUrl, or fallback to the first
            let chosenIdx = group.find(idx => players[idx].trackArtUrl && players[idx].trackArtUrl.length > 0);
            if (chosenIdx === undefined) chosenIdx = group[0];

            filtered.push(players[chosenIdx]);
            group.forEach(idx => used.add(idx));
        }
        return filtered;
    }*/
	
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
