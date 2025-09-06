
pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth
import QtQuick

Singleton {
	id: root
	
	property string textLabel
	
	function getBool() {
       if (Bluetooth.defaultAdapter.state <= BluetoothAdapterState.Disabled) {
           return false;
       }
       
       const connectedDevices = Bluetooth.defaultAdapter.devices.values.filter(d => d.connected);
        
       if (Bluetooth.defaultAdapter.state == BluetoothAdapterState.Enabled && connectedDevices.length == 0) {
           return true;
       }
       
       return true;
	}
	
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
	
	function toggle() {
		Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled
	}
}
