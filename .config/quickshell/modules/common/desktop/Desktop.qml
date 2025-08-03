import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.modules
import qs.modules.common.desktop
import qs.config
import qs.modules.common

Scope {
	signal finished();
	id: root
	
	Variants {
		model: Quickshell.screens;
  
		PanelWindow {
			id: desktopWindow
			
			property var modelData
			screen: modelData
			
			anchors {
				top: true
				bottom: true
				left: true
				right: true
			}

			color: "transparent"
			
			visible: true
