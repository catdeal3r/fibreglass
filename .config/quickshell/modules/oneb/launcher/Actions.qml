pragma Singleton

import "root:/scripts/fuzzysort.js" as Fuzzy
import Quickshell
import qs.services
import qs.modules.common

Singleton {
    id: root

    readonly property var actions: {
							var arr = [];
							arr.push({
								"name": "Toggle Wifi",
								"comment": "Toggle wifi on and off.",							
								"iconCode": "signal_wifi_4_bar",
								"execType": "external",
								"execute": Quickshell.shellDir + "/scripts/network.out",
								"closeOnRun": true
							},{
								"name": "Toggle Bluetooth",
								"comment": "Toggle bluetooth on and off.",							
								"iconCode": "bluetooth",
								"execType": "internal",
								"execute": () => Bluetooth.toggle(),
								"closeOnRun": true
							},{
								"name": "Toggle DND",
								"comment": "Toggle do not disturb on and off.",							
								"iconCode": "speaker_notes",
								"execType": "internal",
								"execute": () => Notifications.toggleDND(),
								"closeOnRun": true
							},{
								"name": "Suspend",
								"comment": "Suspend the computer to RAM.",							
								"iconCode": "sleep",
								"execType": "external",
								"execute": "systemctl suspend",
								"closeOnRun": true
							});
							return arr;
						}
    readonly property var preppedActions: actions.map(a => ({
        name: Fuzzy.prepare(a.name),
        comment: Fuzzy.prepare(a.comment),
        entry: a
    }))

    function fuzzyQuery(search: string): var {
        return Fuzzy.go(search, preppedActions, {
            all: true,
            keys: ["name", "comment"],
            scoreFn: r => r[0].score > 0 ? r[0].score * 0.9 + r[1].score * 0.1 : 0
        }).map(r => r.obj.entry);
    }
}
