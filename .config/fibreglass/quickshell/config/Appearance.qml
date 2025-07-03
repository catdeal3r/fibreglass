
pragma Singleton

import Quickshell
import QtQuick
import "root:/config"

Singleton {
	id: root
	
	readonly property Colours colours: Colours {}
	readonly property string font: "SF Pro Display"
	readonly property string iconFont: "Material Symbols Rounded"
	readonly property int borderRadius: 15
	
	component Colours: QtObject {
		readonly property string fg: "#C5C8C9"
		readonly property string fgDim: "#b6babb"
		readonly property string fgDimTwo: "#a6abac"
		readonly property string fgDimThree: "#979c9d"
		
		readonly property string bg: "101012"
		readonly property string bgAlt: "#161719"
		readonly property string bgAltTwo: "#1c1d20"
		readonly property string bgAltThree: "#26272b"
		readonly property string bgAltFour: "#313237"
		readonly property string bgAltFive: "#424348"
		readonly property string bgAltSix: "#5a5b61"
		
		readonly property string accent: Accent.accent
		readonly property string disab: "#848585"
		
		readonly property string green: "#b4dbc0"
		readonly property string red: "#dbbbb4"
	}
}
