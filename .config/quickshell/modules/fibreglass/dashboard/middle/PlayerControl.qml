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
	property list<real> visualizerPoints: []
    
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
    
    Process {
        id: cavaProc
        running: true
        onRunningChanged: {
            if (!cavaProc.running) {
                root.visualizerPoints = [];
            }
        }
        command: ["cava", "-p", `${Quickshell.configDir}/scripts/raw_output_cava.txt`]
        stdout: SplitParser {
            onRead: data => {
                // Parse `;`-separated values into the visualizerPoints array
                let points = data.split(";").map(p => parseFloat(p.trim())).filter(p => !isNaN(p));
                root.visualizerPoints = points;
            }
        }
    }
    
	anchors.top: parent.top
	anchors.topMargin: 20
	
	anchors.left: parent.left
	anchors.leftMargin: (parent.width / 2) - (400 / 2)
	
	height: 180
	
	Rectangle {
		Layout.preferredWidth: 400
		Layout.preferredHeight: 2
		
		color: "transparent"
		
		Rectangle {
			anchors.top: parent.top
			height: 180
			width: 400
			
			color: "transparent"
			
			WaveVisualizer {
				anchors.fill: parent
				live: root.player?.isPlaying
				points: root.visualizerPoints
				maxVisualizerValue: 1000
				smoothing: 2
				color: Colours.palette.surface_container_low
			}
		}
	}
	
	RowLayout {
		Layout.alignment: Qt.AlignHCenter
		Layout.preferredWidth: 400
		Layout.preferredHeight: 100
		
		ClippingWrapperRectangle { //image
			id: art
			
			radius: Config.settings.borderRadius
			Layout.preferredWidth: 80
			Layout.preferredHeight: 80
			
			Layout.alignment: Qt.AlignLeft
								
			color: Colours.palette.surface_container
			
			Rectangle {
				anchors.fill: parent
				color: "transparent"
			
				Loader {
					anchors.fill: parent
					active: ( root.artUrl != "" )
				
					sourceComponent: Image {
						anchors.fill: parent
						source: root.artUrl
						fillMode: Image.PreserveAspectCrop
					}
				}
				
				Loader {
					anchors.centerIn: parent
					active: ( root.artUrl == "" )
				
					sourceComponent: Text {
						anchors.centerIn: parent
						
						color: Colours.palette.outline
						text: "music_note"
						font.family: Config.settings.iconFont
						font.pixelSize: art.Layout.preferredWidth * (35 / 90)
					}
				}
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
	
	Rectangle {
		Layout.preferredWidth: 400
		Layout.preferredHeight: 15
		
		color: "transparent"
		
		Slider {
			id: slider
			anchors.left: parent.left
			width: parent.Layout.preferredWidth
			
			height: 10
			
			Behavior on height {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}
			
			background: Item {
				width: parent.width
				height: parent.height
				
				
				Rectangle {
					id: bgRec
					anchors.fill: parent
					radius: Config.settings.borderRadius

					color: Colours.palette.surface_container
					
				}
				
				ClippingRectangle {
					anchors.fill: parent

					color: "transparent"
					
					radius: Config.settings.borderRadius
					
					children: Rectangle {
						anchors.top: parent.top
						anchors.bottom: parent.bottom
						anchors.left: parent.left

						implicitWidth: (slider.value / slider.to) * parent.parent.width

						color: (slider.height == 12) ? Colours.palette.tertiary : Colours.palette.outline
					}
				}
				
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
					cursorShape: Qt.PointingHandCursor
					
					onEntered: slider.height = 12
					onExited: slider.height = 10
				}
			}
			
			enabled: root.player?.canSeek
			
			from: 0
			value: root.player?.position
			to: root.player?.length
			
			handle: Item {}
			
			onMoved: root.player.positionSupported ? root.player.position = value : 0

			Connections {
				property var tPlayer: root.player
				target: tPlayer
				
				function onTrackChanged() {
					tPlayer.position = 0 // break binding on track change as some dumbass players don't
					// do this themselves
				}
				
				// idk bro
				//function onIsPlayingChanged() {
				//	tPlayer.position = tPlayer.position // same thing
				//}
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
