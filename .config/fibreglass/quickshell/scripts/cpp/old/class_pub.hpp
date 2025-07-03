#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>
#include <fstream>
#include <bits/stdc++.h>
#include "class_pri.hpp"


// Function to pull information about bluetooth



int Fibreglass::getBatteryInfo(std::string type)
{
	int batteryPercen = std::stoi( Fibreglass::readFile("/sys/class/power_supply/BAT0/capacity") );
	std::string batteryStatus = Fibreglass::readFile("/sys/class/power_supply/BAT0/status");
	
	if (type == "0")
	{
		if (batteryPercen > 80 || batteryStatus == "Charging")
		{
			std::cout << "battery-scale_green\n";
		}
		else if (batteryPercen > 31)
		{
			std::cout << "battery-scale_orange\n";
		}
		else
		{
			std::cout << "battery-scale_red\n";
		}
	}
	else if (type == "1")
	{
		if (batteryPercen < 30 && batteryStatus != "Charging")
		{
			std::cout << "battery-icon_red\n";
		}
		else if (batteryPercen < 45 && batteryStatus == "Charging")
		{
			std::cout << "battery-icon_green\n";
		}
		else
		{
			std::cout << "battery-icon\n";
		}
	}
	else if (type == "2")
	{
		if (batteryStatus == "Charging" || batteryStatus == "Full")
		{
			std::cout << "󱐋\n";
		}
		else if (batteryPercen < 30)
		{
			std::cout << "󱈸\n";
		}
	}
	else
	{
		std::cout << "Wadaheck\n";
		return 1;
	}
	
	return 0;
}


int Fibreglass::getNetworkInfo()
{
	std::string finishBuf;
	
	std::string netStatus;
	std::string netIcon;
	std::string netSpecial;
	
	std::string netIsOn = Fibreglass::getStdoutCmd("nmcli networking connectivity");
	
	if (netIsOn == "limited\n" || netIsOn == "full\n")
	{
		netStatus = "On";
		netIcon = "󰤨";
	}
	else
	{
		netStatus = "Off";
		netIcon = "󰤭";
	}
	
	if (netStatus == "On")
	{
		std::string rawSSIDStr = Fibreglass::getStdoutCmd("nmcli c show --active");
		
		std::size_t loPos = rawSSIDStr.find("lo");
		std::size_t secondNewline = rawSSIDStr.find('\n', loPos);
		std::size_t firstNewline = rawSSIDStr.rfind('\n', loPos);
		
		rawSSIDStr.erase(firstNewline, secondNewline - firstNewline);
		
		std::size_t namePos = rawSSIDStr.find("NAME");
		secondNewline = rawSSIDStr.find('\n', namePos);
		firstNewline = 0;
		
		rawSSIDStr.erase(firstNewline, secondNewline - firstNewline + 1);
		
		std::vector<std::string> SSIDList = Fibreglass::splitStr(rawSSIDStr, " ");
		
		netSpecial = SSIDList[0];
	}
	else
	{
		std::string loString = Fibreglass::getStdoutCmd("nmcli c show --active");
		std::size_t findLo = loString.find("lo");
		
		if (findLo != std::string::npos)
		{
			netIcon = "󰤩";
			netStatus = "On";
			netSpecial = "Disconnected";
			
			finishBuf = "[\"" + netIcon + "\",\"" + netStatus + "\",\"" + netSpecial + "\"]";
			std::cout << finishBuf << std::endl;
			
			return 0;
		}
		netSpecial = "Turned Off";
	}
	
	
	finishBuf = "[\"" + netIcon + "\",\"" + netStatus + "\",\"" + netSpecial + "\"]";
	std::cout << finishBuf << std::endl;
	
	return 0;
}

int Fibreglass::toggleNetwork()
{
	std::string netIsOn = Fibreglass::getStdoutCmd("nmcli networking connectivity");
	
	std::string netInfo = Fibreglass::getStdoutCmd("nmcli c show --active");
	std::size_t findInfo = netInfo.find("lo");
	
	if (netIsOn == "limited" || netIsOn == "full")
	{
		Fibreglass::getStdoutCmd("nmcli networking off");
	}
	else
	{
		if (findInfo != std::string::npos)
		{
			Fibreglass::getStdoutCmd("nmcli networking off");
			return 0;
		}
		Fibreglass::getStdoutCmd("nmcli networking on");
	}
	
	return 0;
}
