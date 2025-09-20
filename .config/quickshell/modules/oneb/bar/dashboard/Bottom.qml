import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common
import qs.services
import qs.modules.oneb.bar.dashboard.notifications
import qs.modules.oneb.bar.dashboard.bottom

Rectangle {
	id: root
	property int sliderValue: 0
	property int maxHeight: 200

	Layout.alignment: Qt.AlignBottom
	Layout.topMargin: 340
	width: 450
	height: maxHeight
	color: "transparent"

	Rectangle {
		id: drawer
		width: root.width - 10
		height: root.height
		anchors.top: parent.top
		anchors.topMargin: {
			if (root.sliderValue == root.maxHeight)
				return 5
			else
				return root.maxHeight - root.sliderValue + 5
		}

		anchors.left: parent.left
		anchors.leftMargin: 3
		
		color: "transparent"
		border.width: 2
		border.color: Qt.alpha(Colours.palette.outline_variant, 0.2)

		topLeftRadius: Config.settings.borderRadius
		topRightRadius: Config.settings.borderRadius
		
		ColumnLayout {
			anchors.fill: parent
			spacing: 10

			RowLayout {
				Layout.alignment: Qt.AlignTop
				Layout.topMargin: 25
				Layout.leftMargin: 25
				height: 100
				width: drawer.width - 10

				spacing: 10

				ClippingWrapperRectangle {
					radius: Config.settings.borderRadius + 10
																
					Layout.alignment: Qt.AlignLeft
					Layout.preferredWidth: 50
					Layout.preferredHeight: 50
												
					color: "transparent"
																				
					IconImage {
						source: `file:/${Quickshell.shellDir}/assets/pfp.png`
						asynchronous: true
					}
				}
												
				ColumnLayout {
					Layout.alignment: Qt.AlignLeft | Qt.AlignTop
					Layout.topMargin: 4
					Layout.preferredWidth: 110
					spacing: 5
												
					Text {
						Layout.alignment: Qt.AlignLeft | Qt.AlignTop
														
						text: User.username
						font.family: Config.settings.font
						font.pixelSize: 17
															
						font.weight: 600
														
						color: Colours.palette.on_surface
					}
													
					Text {
						Layout.alignment: Qt.AlignLeft | Qt.AlignTop
														
						text: `Up: ${User.uptime}`
						font.family: Config.settings.font
						font.pixelSize: 9										
															
						color: Colours.palette.primary
					}
				}
			}
		}
	}

	Slider {
		id: slider
		property bool isHovered: false
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.leftMargin: (parent.width / 2) - (width / 2)
		width: 50
				
		height: root.maxHeight
		orientation: Qt.Vertical

		background: Rectangle {
			color: "transparent"

			HoverHandler {
				parent: parent
				cursorShape: Qt.DragMoveCursor
							
				acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
							
				onHoveredChanged: {
					slider.isHovered = hovered
				}
			}
		}
					
		enabled: true
				
		from: 3
		value: sliderValue
		to: height

		onMoved: {
			root.sliderValue = value;
			//console.log(value);
		}
					
		handle: Rectangle {
			width: parent.width
			anchors.bottom: parent.bottom
			anchors.bottomMargin: (slider.value / slider.to) * slider.height
			color: "#FFFFFF"

			opacity: slider.isHovered ? 1 : 0

			Behavior on opacity {
				PropertyAnimation {
					duration: 200
					easing.type: Easing.InSine
				}
			}

			height: 5
			radius: 10
		}
	}
}
