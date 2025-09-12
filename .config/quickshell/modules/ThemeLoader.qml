import Quickshell
import Quickshell.Io

import QtQuick

import qs.config

import qs.modules.cavern
import qs.modules.windows11
import qs.modules.fibreglass
import qs.modules.wyvern
import qs.modules.resett
import qs.modules.oneb

Scope {
	id: root
	
	Loader {
		id: themeLoader
		active: true
		
		sourceComponent: {
			if (Config.settings.currentRice == "fibreglass") {
				return fibreglassTheme
			} else if (Config.settings.currentRice == "windows") {
				return windowsTheme
			} else if (Config.settings.currentRice == "cavern") {
				return cavernTheme
			} else if (Config.settings.currentRice == "wyvern") {
				return wyvernTheme
			} else if (Config.settings.currentRice == "resett") {
				return resettTheme
			} else {
				return onebTheme
			}
		}
		
		Component {
			id: fibreglassTheme
			
			TLoader {}
		}
		
		Component {
			id: windowsTheme
			
			TLoaderWindows {}
		}
		
		Component {
			id: cavernTheme
			
			TLoaderCavern {}
		}
		
		Component {
			id: wyvernTheme

			TLoaderWyvern {}
		}

		Component {
			id: resettTheme
			
			TLoaderResett {}
		}

		Component {
			id: onebTheme
			
			TLoaderOneb {}
		}
	}
}
