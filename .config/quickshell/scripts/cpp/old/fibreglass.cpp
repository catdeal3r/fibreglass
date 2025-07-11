#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>
#include <bits/stdc++.h>
#include <fstream>
#include "class_pub.hpp"

// Just get command line arguments, create a Fibreglass class,
// then use the arguments.
int main(int argc, char* argv[]) 
{
	Fibreglass fb;
	
	
	if (argc <= 1) 
	{
		fb.getHelp("NULL");
		return 1;
	}
	
	std::string switchArg = argv[1];
	std::string extraArg;
	
	if (argc >= 3)
	{
		extraArg = argv[2];
	}
	
	if (switchArg == "--getWorkspaces")
	{
		fb.getWorkspacesLoop();
		return 0;
	} 
	else if (switchArg == "--getHelp")
	{
		fb.getHelp("NULL");
		return 0;
	}
	else if (switchArg == "--getBluetooth")
	{
		fb.getBluetoothInfo();
		return 0;
	}
	else if (switchArg == "--toggleBluetooth")
	{
		fb.toggleBluetooth();
		return 0;
	}
	else if (switchArg == "--getBattery")
	{
		if (argc != 3)
		{
			fb.getHelp("Invalid Option: \"\"");
			return 1;
		}
		else if (extraArg != "0" && extraArg != "1" && extraArg != "2")
		{
			std::string incorrectStr = "Invalid Option: \"" + extraArg + "\"";
			fb.getHelp(incorrectStr);
			return 1;
		}
		fb.getBatteryInfo(extraArg);
		return 0;
	}
	else if (switchArg == "--getNetwork")
	{
		fb.getNetworkInfo();
		return 0;
	}
	else if (switchArg == "--toggleNetwork")
	{
		fb.toggleNetwork();
		return 0;
	}
	else
	{
		std::string incorrectStr = "Invalid Option: \"" + switchArg + "\"";
		fb.getHelp(incorrectStr);
		return 1;
	}
	
	return 0;
}
