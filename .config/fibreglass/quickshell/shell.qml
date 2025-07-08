//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import QtQuick
import "modules"
import "modules/dashboard"
import "modules/launcher"
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
	Launcher {}
	
	EyeProtection {}
}
