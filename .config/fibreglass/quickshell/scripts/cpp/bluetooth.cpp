#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>
#include <fstream>
#include <bits/stdc++.h>


std::vector<std::string> splitStr(std::string str, std::string spliter)
{
		// Setup some temporary variables
		std::vector<std::string> parts;
		size_t pos = 0;
		std::string part;
		
		// While there's still a demiliter; continue
		while ((pos = str.find(spliter)) != std::string::npos)
		{
			// Extract text
			part = str.substr(0, pos);
			// Push it into the std::vector
			parts.push_back(part);
			// Remove it from the original string, to keep searching.
			str.erase(0, pos + spliter.length());
		}
		// Put the last left over piece from the string into the vector
		parts.push_back(str);
	
		return parts;
}

// Get the content of a system() call
std::string getStdoutCmd (std::string cmd)
	{
		// String that will contain the command
		std::string data;
		
		// A 'fake' file to record the output into.
		FILE * stream;
		
		// Buffer to transfer it into the string
		const int max_buffer = 256;
		char buffer[max_buffer];
		
		// Needs this to not record the output of STD:ERROR
		cmd.append(" 2>&1");

		// 'Open' the command in the stream
		stream = popen(cmd.c_str(), "r");

		// If successful, transfer the data into the buffer, then into the final string
		if (stream) {
			while (!feof(stream))
			if (fgets(buffer, max_buffer, stream) != NULL) data.append(buffer);
			pclose(stream);
		}
		return data;
	}
	
int getBluetoothInfo()
{
	// Define variables
	std::string finishBuf;
	
	std::string blueSpecial;
	
	// Should change these for proper library syscalls instead of
	// system() syscalls -> not worth it
	
	
	// Get raw bluetooth info from syscalls
	std::string bluetoothIsOn = getStdoutCmd("bluetoothctl show");
	std::size_t powerStateLoc = bluetoothIsOn.find("PowerState");
	
	// Erase unneeded parts of the raw info, to allow for easier processing.
	bluetoothIsOn.erase(0, powerStateLoc + 12);
	bluetoothIsOn.erase(bluetoothIsOn.begin() + 3, bluetoothIsOn.end());
	bluetoothIsOn.pop_back();
	
	// Assign content to the variables
	if (bluetoothIsOn == "of")
	{
		blueSpecial = "Off";
	}
	else
	{
		blueSpecial = "On";
	}
	
	// If-else statement to get bluetooth info if bluetooth is turned on
	if (blueSpecial == "On")
	{
		int deviceConnected = system("bluetoothctl info > /dev/null");
		
		// If the device isn't connected, then return early.
		if (deviceConnected != 0)
		{
			blueSpecial = "Not connected";
			
			finishBuf = blueSpecial;
			std::cout << finishBuf << std::endl;
			return 0;
		}
		
		// Otherwise, get more info about it
		std::string deviceConnectedInfo = getStdoutCmd("bluetoothctl info");
		std::size_t connectedInfoLoc = deviceConnectedInfo.find("Alias");
		
		// Remove uneeded parts of the info
		deviceConnectedInfo.erase(0, connectedInfoLoc);
		
		// Get the device name
		{
			std::vector<std::string> deviceConnectedInfoList = splitStr(deviceConnectedInfo, " ");
			blueSpecial = deviceConnectedInfoList[1];
		}
		
		// Remove uneeded extra padding
		for (int i = 0; i < 8; i++)
		{
			blueSpecial.pop_back();
		}
	}
	else
	{
		blueSpecial = "Bluetooth Off";
	}
	
	// Finish formatting the buffer and print
	finishBuf = blueSpecial;
	std::cout << finishBuf << std::endl;
	
	return 0;
}

int toggleBluetooth()
{
	// Should change these for proper library syscalls instead of
	// system() syscalls -> not worth it.
	
	std::string bluetoothIsOn = getStdoutCmd("bluetoothctl show");
	std::size_t powerStateLoc = bluetoothIsOn.find("PowerState");
	
	bluetoothIsOn.erase(0, powerStateLoc + 12);
	bluetoothIsOn.erase(bluetoothIsOn.begin() + 3, bluetoothIsOn.end());
	bluetoothIsOn.pop_back();
	
	if (bluetoothIsOn == "of")
	{
		getStdoutCmd("bluetoothctl power on");
		return 0;
	}
	getStdoutCmd("bluetoothctl power off");
	
	return 0;
}


int main(int argc, char* argv[]) 
{
	if (argc > 1) {
		std::string switchArg = argv[1];
		
		if (switchArg == "--info")
		{
			getBluetoothInfo();
			return 0;
		}
	}
	else
	{
		toggleBluetooth();
		return 0;
	}
	
	return 0;
}
