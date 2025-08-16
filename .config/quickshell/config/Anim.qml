pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root

	readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
	readonly property list<real> bounce: [0.2, 0.4, 0.4, 0, 1, 1.2, 1.3, 1]
}
