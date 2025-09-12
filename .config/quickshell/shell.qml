//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import QtQuick
import qs.modules
import qs.modules.common.desktop
import qs.services
import qs.config

Scope {
	ThemeLoader {}
	
	Component.onCompleted: {
		Notifications.dummyInit()
		SessionHandler.loadBasicSession()
	}

	//Desktop {}
	
	EyeProtection {}
}
