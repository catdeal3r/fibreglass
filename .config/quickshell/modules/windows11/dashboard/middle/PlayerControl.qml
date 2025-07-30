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
import qs.modules.windows11.dashboard.middle

ColumnLayout {
	id: root
	
	required property MprisPlayer player
    
    property var artUrl: player?.trackArtUrl
    
    /*property string artDownloadLocation: `${Quickshell.configDir}/cache/coverArt`//Directories.coverArt
    property string artFileName: Qt.md5(artUrl) + ".jpg"
    property string artFilePath: `${artDownloadLocation}/${artFileName}`
    property bool downloaded: false*/
    
    Timer { // Force update for prevision
        running: root.player?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: {
            root.player.positionChanged()
        }
    }
    
     
	
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
    
    /*onArtUrlChanged: {
        if (root.artUrl.length == 0) {
			return;
        }
        console.log("PlayerControl: Art URL changed to", root.artUrl)
        console.log("Download cmd:", coverArtDownloader.command.join(" "))
        
        console.log(root.artFileName)
		console.log(root.artDownloadLocation)
		console.log(root.artFilePath)
		
        root.downloaded = false
        coverArtDownloader.running = true
    }
    

    Process { // Cover art downloader
        id: coverArtDownloader
        property string targetFile: root.artUrl
        command: [ "bash", "-c", `[ -f '${root.artFilePath}' ] || curl -sSL '${targetFile}' -o '${root.artFilePath}'` ]
        onExited: (exitCode, exitStatus) => {
            root.downloaded = true
        }
    }*/
    
	anchors.top: parent.top
	anchors.topMargin: 20
	
	anchors.left: parent.left
	anchors.leftMargin: (parent.width / 2) - (400 / 2)
	
	height: 190
	
	
	Rectangle {
		Layout.alignment: Qt.AlignHCenter
		Layout.preferredWidth: 400
		Layout.preferredHeight: 130
		color: "transparent"
		
		ClippingWrapperRectangle { //image
			id: art
			anchors.left: parent.left
			anchors.leftMargin: 20
			
			radius: Config.settings.borderRadius
			width: 240
			height: 130
								
			color: Colours.palette.surface_container
		
			Image {
				source: root.artUrl
				fillMode: Image.PreserveAspectCrop
			}
        }
        
        Rectangle {
			anchors.left: parent.left
			anchors.leftMargin: art.width - 60
			
			anchors.top: parent.top
			anchors.topMargin: (parent.height / 2) - (height / 2)
			
			width: 300
			height: 80
			
			radius: Config.settings.borderRadius
			color: Colours.palette.surface
		
			ColumnLayout {
				anchors.left: parent.left
				anchors.leftMargin: 20
				
				anchors.top: parent.top
				anchors.topMargin: (parent.height / 2) - 25
				
				Text {
					Layout.alignment: Qt.AlignLeft
					font.pixelSize: 20
					font.family: Config.settings.font
					font.weight: 600
					
					color: Colours.palette.on_surface
					text: titleMetrics.elidedText
					
				}
				
				TextMetrics {
					id: titleMetrics
										
					text: root.cleanMusicTitle(root.player?.trackTitle) || "Untitled"
					font.family: Config.settings.font
										
					elide: Qt.ElideRight
					elideWidth: 130
				}
					
				Text {
					Layout.alignment: Qt.AlignLeft
					color: Colours.palette.primary
					font.pixelSize: 18
					font.family: Config.settings.font
						
					text: artistMetrics.elidedText
				}
				
				TextMetrics {
					id: artistMetrics
										
					text: root.cleanMusicTitle(root.player?.trackArtist) || "Unknown Artist"
					font.family: Config.settings.font
										
					elide: Qt.ElideRight
					elideWidth: 130
				}
			}
		}
	}
		
	RowLayout {
		Layout.alignment: Qt.AlignHCenter
		spacing: 30
		
		Text {
			Layout.alignment: Qt.AlignHCenter
			font.pixelSize: 20
			color: Colours.palette.on_surface
			text: "shuffle"
			
			font.family: Config.settings.iconFont
		}
		
		PlayerButton {
			Layout.alignment: Qt.AlignHCenter
			iconName: "skip_previous"
			toRun: () => root.player?.previous()
		}
		
		PlayerButton {
			Layout.alignment: Qt.AlignHCenter
			iconName: root.player?.isPlaying ? "pause" : "play_arrow"
			
			colourHovered: Colours.palette.tertiary
			toRun: () => root.player.togglePlaying()
		}
		
		PlayerButton {
			Layout.alignment: Qt.AlignHCenter
			iconName: "skip_next"
			toRun: () => root.player?.next()
		}
		
		Text {
			Layout.alignment: Qt.AlignHCenter	
			font.pixelSize: 20
			color: Colours.palette.on_surface
			text: "repeat"
			font.family: Config.settings.iconFont
		}
	}
}
