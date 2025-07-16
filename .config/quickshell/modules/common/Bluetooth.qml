pragma ComponentBehavior: Bound
pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import QtQuick

Singleton {
	id: root
	
	property string textLabel
	
	function getBool() {
       if (Bluetooth.defaultAdapter.state <= BluetoothAdapterState.Disabled) {
           return false;
       }
       
       const connectedDevices = Bluetooth.defaultAdapter.devices.values.filter(d => d.connected).length;
       
       if (Bluetooth.defaultAdapter.state == BluetoothAdapterState.Enabled && connectedDevices == 0) {
           return true;
       }
       
       return true;
	}
	
	function getIcon() {
       if (Bluetooth.defaultAdapter.state <= BluetoothAdapterState.Disabled) {
           textLabel = "Bluetooth Off";
           return "bluetooth_disabled";
       }
       
       const connectedDevices = Bluetooth.defaultAdapter.devices.values.filter(d => d.connected).length;
       
       if (Bluetooth.defaultAdapter.state == BluetoothAdapterState.Enabled && connectedDevices == 0) {
           textLabel = "Not Connected";
           return "bluetooth_searching";
       }
       
       textLabel = `${connectedDevices} Connection${connectedDevices > 1 ? 's' : ''}`;
       return "bluetooth";
	}
}
