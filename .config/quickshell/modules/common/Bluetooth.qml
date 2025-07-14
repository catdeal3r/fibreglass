pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import QtQuick

Singleton {
    id: root
    property string textLabel

    function getIcon() {
        if (Bluetooth.defaultAdapter.state <= BluetoothAdapterState.Disabled) {
            textLabel = "Bluetooth Off";
            return "bluetooth_disabled";
        }
        const connectedDevices = Bluetooth.defaultAdapter.devices.values.filter(d => d.connected);
        if (Bluetooth.defaultAdapter.state == BluetoothAdapterState.Enabled && connectedDevices.length == 0) {
            textLabel = "Not Connected";
            return "bluetooth_searching";
        }
        if (connectedDevices.length == 1)
            textLabel = connectedDevices[0].name;
        else
            textLabel = `${connectedDevices.length} Connections`;
        return "bluetooth";
    }
}
