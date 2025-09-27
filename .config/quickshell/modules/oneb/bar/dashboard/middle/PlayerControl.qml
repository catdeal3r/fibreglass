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

RowLayout {
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
		// Japenese brackets
		title = title.replace(/^ *【[^】]*】/, "") // Touhou
		title = title.replace(/^ *《[^》]*》/, "") // ??
		title = title.replace(/^ *「[^」]*」/, "") // OP/ED thingie
		title = title.replace(/^ *『[^』]*』/, "") // OP/ED thingie

		return title.trim();
	}
    
	anchors.top: parent.top
	anchors.topMargin: 40
	
	anchors.left: parent.left
	anchors.leftMargin: (parent.width / 2) - (430 / 2)
	
	height: 180
	
	Rectangle {
		Layout.alignment: Qt.AlignLeft
		Layout.preferredWidth: 320
		Layout.preferredHeight: 180

		color: "transparent"
		
		ClippingWrapperRectangle { //image
			id: art
			
			radius: Config.settings.borderRadius
			width: 300
			height: 140
			
			Layout.alignment: Qt.AlignLeft
								
			color: Colours.palette.surface_container
			
			Rectangle {
				anchors.fill: parent
				color: "transparent"
			
				Loader {
					anchors.fill: parent
					active: ( root.artUrl != "" )
				
					sourceComponent: Item {
						anchors.fill: parent

						Image {
							id: backgroundImage
							anchors.fill: parent
							source: root.artUrl
							fillMode: Image.PreserveAspectCrop
						}

						Rectangle {
							anchors.fill: parent

							gradient: Gradient {
								orientation: Gradient.Horizontal
								GradientStop { position: 0.0; color: Qt.alpha(Colours.palette.surface, 0.8) }
								GradientStop { position: 1.0; color: "transparent" }
							}
						}
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
						font.pixelSize: art.width / 7
					}
				}
			}
        }
        
        Rectangle {
			anchors.top: parent.top
			anchors.topMargin: (parent.height / 2) - (height / 2)
			anchors.left: parent.left
			anchors.leftMargin: 20

			height: parent.height / 2
			
			radius: Config.settings.borderRadius
			color: Colours.palette.surface
		
			ColumnLayout {
				anchors.left: parent.left
				
				anchors.top: parent.top
				

				TextMetrics {
					id: titleMetrics
										
					text: root.cleanMusicTitle(root.player?.trackTitle) || "Untitled"
					font.family: Config.settings.font
										
					elide: Qt.ElideRight
					elideWidth: 150
				}

				Text {
					Layout.alignment: Qt.AlignLeft
					font.pixelSize: 20
					font.family: Config.settings.font
					font.weight: 600
					
					color: Colours.palette.on_surface
					text: titleMetrics.elidedText
					
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
					elideWidth: 150
				}
			}
		}
	}
		
	ColumnLayout {
		Layout.alignment: Qt.AlignTop
		Layout.topMargin: 6

		spacing: 18

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
	}
}
