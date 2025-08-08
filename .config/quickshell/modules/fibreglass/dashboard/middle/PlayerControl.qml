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
	
	Timer {
	  // only emit the signal when the position is actually changing.
	  running: root.player.playbackState == MprisPlaybackState.Playing
	  // Make sure the position updates at least once per second.
	  interval: 1000
	  repeat: true
	  // emit the positionChanged signal every second.
	  onTriggered: root.player.positionChanged()
	}
    
	anchors.top: parent.top
	anchors.topMargin: 20
	
	anchors.left: parent.left
	anchors.leftMargin: (parent.width / 2) - (400 / 2)
	
	height: 180
	
	
	RowLayout {
		Layout.alignment: Qt.AlignHCenter
		Layout.preferredWidth: 400
		Layout.preferredHeight: 100
		
		ClippingWrapperRectangle { //image
			id: art
			
			radius: Config.settings.borderRadius
			Layout.preferredWidth: 90
			Layout.preferredHeight: 90
			
			Layout.alignment: Qt.AlignLeft
								
			color: Colours.palette.surface_container
		
			Image {
				source: root.artUrl
				fillMode: Image.PreserveAspectCrop
			}
        }
        
        Rectangle {
			Layout.preferredWidth: 220
			Layout.preferredHeight: 80
			
			Layout.alignment: Qt.AlignLeft
			
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
					elideWidth: parent.parent.width - 170
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
					elideWidth: parent.parent.width - 170
				}
			}
		}
	}
	
	Slider {
		id: slider
		Layout.preferredWidth: 400
		Layout.preferredHeight: 10
		//color: Colours.palette.surface_container
		//radius: Config.settings.borderRadius
		
		//clip: true
		
		/*Rectangle {
			anchors.left: parent.left
			height: parent.Layout.preferredHeight
			
			radius: Config.settings.borderRadius
			topRightRadius: 0
			bottomRightRadius: 0
			
			color: Colours.palette.tertiary
			
			width: Math.max(0, (parent.width - 5) * (root.player?.position / root.player?.length))
		}*/
		
		background: Item {
			Rectangle {
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				anchors.right: parent.right
				anchors.topMargin: parent.implicitHeight / 3
				anchors.bottomMargin: parent.implicitHeight / 3

				implicitWidth: parent.width

				color: Colours.palette.surface_container
				radius: Config.settings.borderRadius
				topLeftRadius: parent.implicitHeight / 15
				bottomLeftRadius: parent.implicitHeight / 15
			}
			
			Rectangle {
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.topMargin: parent.implicitHeight / 3
				anchors.bottomMargin: parent.implicitHeight / 3

				implicitWidth: (slider.value / parent.parent.to) * parent.width

				color: Colours.palette.tertiary
				radius: Config.settings.borderRadius
				topRightRadius: parent.implicitHeight / 15
				bottomRightRadius: parent.implicitHeight / 15
			}
		}
		
		enabled: root.player?.canSeek
		
		from: 0
		value: root.player?.position
		to: root.player?.length
		
		handle: Item {}
		
		onMoved: root.player.canSeek ? root.player.position = value : 0

		property var player: root.player
		
		Connections {
			target: player
			
			function onPositionChanged() {
				slider.value = player.position;
				slider.to = player.length;
			}
		}
	}
		
	RowLayout {
		Layout.alignment: Qt.AlignHCenter
		spacing: 30
		
		Loader {
			active: root.player.shuffleSupported
		
			sourceComponent: PlayerButton {
				Layout.alignment: Qt.AlignHCenter
				colour: {
					switch (root.player.shuffle) {
						case true: return Colours.palette.on_surface;
						case false: Colours.palette.outline;
					}
				}
				
				iconName: "shuffle"
				
				toRun: {
					switch (root.player.shuffle) {
						case true: return () => root.player.shuffle = false;
						case false: return () => root.player.shuffle = true;
					}
				}
			}
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
		
		Loader {
			active: root.player.loopSupported
		
			sourceComponent: PlayerButton {
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
}
