import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs.config
import qs.modules.common
import qs.services
import qs.modules.oneb.bar.dashboard.middle

Rectangle {
	id: root
	anchors.centerIn: parent
	width: 400
	height: 200
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
    
	
	SwipeView {
		id: view
		interactive: true
		currentIndex: 0
		orientation: Qt.Vertical
		anchors.centerIn: parent
	
		Repeater {
			model: ScriptModel {
				values: root.meaningfulPlayers
			}
			delegate: PlayerControl {
				required property MprisPlayer modelData
				player: modelData
			}
		}
	}
    
	Rectangle {
		width: 40
		height: 40
		
		color: Colours.palette.surface_container
		radius: 10
   
		anchors.left: parent.left
		anchors.leftMargin: (parent.width / 2) - (width / 2)
			
		anchors.top: parent.top
		anchors.topMargin: (parent.height / 2) - (height / 2) - 20
		
		visible: (root.meaningfulPlayers.length == 0) ? true : false
		
		Behavior on visible {
			PropertyAnimation {
				duration: 200
				easing.type: Easing.InSine
			}
		}
    
		Text {
			color: Colours.palette.outline
			text: "music_note"
			font.family: Config.settings.iconFont
			font.pixelSize: 30
			
			visible: (root.meaningfulPlayers.length == 0) ? true : false
				
			anchors.centerIn: parent
			
			Behavior on visible {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
		}
	}
    
    Text {
		color: Colours.palette.on_surface
		text: "No media playing."
		font.family: Config.settings.font
		font.pixelSize: 20
		
		visible: (root.meaningfulPlayers.length == 0) ? true : false
			
		anchors.left: parent.left
		anchors.leftMargin: (parent.width / 2) - (150 / 2)
		
		anchors.top: parent.top
		anchors.topMargin: (parent.height / 2) - (20 / 2) + 20
		
		Behavior on visible {
			PropertyAnimation {
				duration: 200
				easing.type: Easing.InSine
			}
		}
	}
}
