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
import qs.modules.fibreglass.dashboard.middle

ColumnLayout {
	id: root
	
	required property MprisPlayer player
    
    property var artUrl: player?.trackArtUrl
    
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
		
		PlayerButton {
			Layout.alignment: Qt.AlignHCenter	
			colour: {
				switch(root.player.loopState) {
					case MprisLoopState.Track: return Colours.palette.on_surface;
					case MprisLoopState.Playlist: return Colours.palette.on_surface;
					case MprisLoopState.None: return Colours.palette.outline;
				}
			}
			
			iconName: {
				switch(root.player.loopState) {
					case MprisLoopState.Track: return "repeat_one";
					case MprisLoopState.Playlist: return "repeat";
					case MprisLoopState.None: return "repeat";
				}
			}
			
			toRun: {
				switch (root.player.loopState) {
					case MprisLoopState.None: return () => root.player.loopState = MprisLoopState.Playlist;
					case MprisLoopState.Playlist: return () => root.player.loopState = MprisLoopState.Track;
					case MprisLoopState.Track: return () => root.player.loopState = MprisLoopState.None;
				}
			}
		}
	}
}
