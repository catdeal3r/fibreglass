//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import QtQuick
import qs.modules
import qs.modules.dashboard
import qs.modules.launcher
import qs.modules.notificationslist
import qs.modules.eyeprotection
import qs.services
import qs.config

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
