//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import QtQuick
import qs.modules
import qs.modules.fibreglass.dashboard
import qs.modules.fibreglass.launcher
import qs.modules.fibreglass.notificationslist
import qs.modules.fibreglass.eyeprotection
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
