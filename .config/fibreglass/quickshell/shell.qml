import Quickshell
import Quickshell.Io

import QtQuick
import "modules"
import "modules/dashboard"
import "modules/notificationslist"
import "modules/eyeprotection"
import "services"

Scope {
	IPCLoader {}
	
	Component.onCompleted: {
		Notifications.dummyInit()
	}
	
	NotificationList {}
	Dashboard {}
	EyeProtection {}
}
