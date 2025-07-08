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
            root.artDominantColor = Appearance.m3colors.m3secondaryContainer
            return;
        }
        // console.log("PlayerControl: Art URL changed to", root.artUrl)
        // console.log("Download cmd:", coverArtDownloader.command.join(" "))
        root.downloaded = false
        coverArtDownloader.running = true
    }

    Process { // Cover art downloader
        id: coverArtDownloader
        property string targetFile: root.artUrl?
        command: [ "bash", "-c", `[ -f ${artFilePath} ] || curl -sSL '${targetFile}' -o '${artFilePath}'` ]
        onExited: (exitCode, exitStatus) => {
            root.downloaded = true
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
					text: root.cleanMusicTitle(root.player?.trackTitle) || "Untitled"
					
					
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
