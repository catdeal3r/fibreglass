//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import QtQuick

import qs.bar
import qs.notificationslist

Scope {
    Bar {}
    NotificationList {}
}
