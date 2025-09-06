import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs.config
import qs.common
import qs.services

Rectangle {
	id: root
	color: "transparent"
	
	function isRealPlayer(player) {
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
    }

	
	readonly property var realPlayers: Mpris.players.values.filter(player => isRealPlayer(player))
    readonly property var meaningfulPlayers: filterDuplicatePlayers(realPlayers)

    Layout.preferredWidth: meaningfulPlayers.length == 0 ? 0 : 210

    TextMetrics {
        id: titleMetrics

        text: root.meaningfulPlayers[0].trackTitle + " - " + root.meaningfulPlayers[0].trackArtist
        
        font.family: Config.settings.font
        
        elide: Qt.ElideRight
        elideWidth: 130
    }

    Text {
	    color: Colours.palette.on_surface
	    text: {
            if (root.meaningfulPlayers.length == 0)
                return ""
            
            if (root.meaningfulPlayers[0].isPlaying)
                return titleMetrics.elidedText + " (Playing)"
            else
                return titleMetrics.elidedText + " (Paused)"
        }
	    font.family: Config.settings.font
	    font.pixelSize: 12
	    anchors.centerIn: parent

	    MouseArea {
	        id: mouse
	        cursorShape: Qt.PointingHandCursor
	        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
	        anchors.fill: parent

	        onClicked: (mouse) => {
	            if (mouse.button == Qt.LeftButton) {
	                root.meaningfulPlayers[0].previous();
	                return;
	            } else if (mouse.button == Qt.RightButton) {
	                root.meaningfulPlayers[0].next();
	                return;
	            } else if (mouse.button == Qt.MiddleButton) {
	                root.meaningfulPlayers[0].togglePlaying();
	                return;
	            }
	        }
	    }
  	}
}
