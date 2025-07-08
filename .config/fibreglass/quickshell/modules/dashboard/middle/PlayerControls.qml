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
	
	function isRealPlayer(player) {
        // return true
        return (
            // Remove unecessary native buses from browsers if there's plasma integration
            !(hasPlasmaIntegration && player.dbusName.startsWith('org.mpris.MediaPlayer2.firefox')) &&
            !(hasPlasmaIntegration && player.dbusName.startsWith('org.mpris.MediaPlayer2.chromium')) &&
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
    
    readonly property MprisPlayer player: MprisController.activePlayer
    
    property var artUrl: player?.trackArtUrl
    property string artDownloadLocation: Directories.coverArt
    property string artFileName: Qt.md5(artUrl) + ".jpg"
    property string artFilePath: `${artDownloadLocation}/${artFileName}`
    property bool downloaded: false
	
	function cleanMusicTitle(title) {
		if (!title) return "";
		// Brackets
		title = title.replace(/^ *\([^)]*\) */g, " "); // Round brackets
		title = title.replace(/^ *\[[^\]]*\] */g, " "); // Square brackets
		title = title.replace(/^ *\{[^\}]*\} */g, " "); // Curly brackets
		// Japenis brackets
		title = title.replace(/^ *【[^】]*】/, "") // Touhou
		title = title.replace(/^ *《[^》]*》/, "") // ??
		title = title.replace(/^ *「[^」]*」/, "") // OP/ED thingie
		title = title.replace(/^ *『[^』]*』/, "") // OP/ED thingie

		return title.trim();
	}
	
    Timer { // Force update for prevision
        running: root.player?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: {
            root.player.positionChanged()
        }
    }
    
    onArtUrlChanged: {
        if (root.artUrl.length == 0) {
			return;
        }
        console.log("PlayerControl: Art URL changed to", root.artUrl)
        console.log("Download cmd:", coverArtDownloader.command.join(" "))
        root.downloaded = false
        coverArtDownloader.running = true
    }

    Process { // Cover art downloader
        id: coverArtDownloader
        property string targetFile: root.artUrl
        command: [ "bash", "-c", `[ -f ${root.artFilePath} ] || curl -sSL '${targetFile}' -o '${root.artFilePath}'` ]
        onExited: (exitCode, exitStatus) => {
            root.downloaded = true
        }
    }
    
    Repeater {
		model: ScriptModel {
			values: root.meaningfulPlayers
		}
		delegate: PlayerControl {
			required property MprisPlayer modelData
            player: modelData
        }
    }
	
	ColumnLayout {
		anchors.fill: parent
		
		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			
			Image { // Art image
				width: 50
				height: 50
				source: root.downloaded ? Qt.resolvedUrl(root.artFilePath) : ""
				fillMode: Image.PreserveAspectCrop
				cache: false
				antialiasing: true
				asynchronous: true
            }
			
			ColumnLayout {
				Layout.alignment: Qt.AlignHCenter
				
				Text {
					Layout.alignment: Qt.AlignLeft
					font.pixelSize: 20
					font.family: Config.settings.font
					font.weight: 600
					
					color: Colours.palette.on_surface
					text: bodyMetrics.elidedText
					
				}
				
				TextMetrics {
					id: bodyMetrics
										
					text: root.cleanMusicTitle(root.player?.trackTitle) || "Untitled"
					font.family: Config.settings.font
										
					elide: Qt.ElideRight
					elideWidth: 170
				}
				
				Text {
					Layout.alignment: Qt.AlignLeft
					color: Colours.palette.on_surface
					font.pixelSize: 18
					font.family: Config.settings.font
					
					text: root.cleanMusicTitle(root.player?.trackArtist) || "Unknown Artist"
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
