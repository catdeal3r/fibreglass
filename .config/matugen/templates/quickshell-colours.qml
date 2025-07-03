pragma Singleton

import QtQuick
import Quickshell

Singleton {
	readonly property Colours palette: Colours {}

	component Colours: QtObject {
	<* for name, value in colors *>
		readonly property string {{name}}: "{{value.default.hex}}"<* endfor *>
	}
}
