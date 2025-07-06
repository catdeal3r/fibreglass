import Quickshell
import Quickshell.Io

import QtQuick
import "modules"
import "modules/dashboard"
import "modules/notificationslist"
import "modules/eyeprotection"
import "services"
import "config"

Scope {
	IPCLoader {}
	
	Component.onCompleted: {
		Notifications.dummyInit()
		SessionHandler.loadBasicSession()
	}
	
	NotificationList {}
	Dashboard {}
	EyeProtection {}
}
