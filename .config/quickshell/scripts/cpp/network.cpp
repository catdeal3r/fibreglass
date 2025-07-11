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

int getNetworkInfo()
{
	std::string finishBuf;
	std::string netSpecial;
	
	std::string netIsOn = getStdoutCmd("nmcli networking connectivity");
	
	if (netIsOn == "limited\n" || netIsOn == "full\n")
	{
		netSpecial = "On";
	}
	else
	{
		netSpecial = "Off";
	}
	
	if (netSpecial == "On")
	{
		std::string rawSSIDStr = getStdoutCmd("nmcli c show --active");
		
		std::size_t loPos = rawSSIDStr.find("lo");
		std::size_t secondNewline = rawSSIDStr.find('\n', loPos);
		std::size_t firstNewline = rawSSIDStr.rfind('\n', loPos);
		
		rawSSIDStr.erase(firstNewline, secondNewline - firstNewline);
		
		std::size_t namePos = rawSSIDStr.find("NAME");
		secondNewline = rawSSIDStr.find('\n', namePos);
		firstNewline = 0;
		
		rawSSIDStr.erase(firstNewline, secondNewline - firstNewline + 1);
		
		std::vector<std::string> SSIDList = splitStr(rawSSIDStr, " ");
		
		netSpecial = SSIDList[0];
	}
	else
	{
		std::string loString = getStdoutCmd("nmcli c show --active");
		std::size_t findLo = loString.find("lo");
		
		if (findLo != std::string::npos)
		{
			netSpecial = "Disconnected";
			
			finishBuf = netSpecial;
			std::cout << finishBuf << std::endl;
	
			return 0;
		}
		netSpecial = "Network Off";
	}
	
	
	finishBuf = netSpecial;
	std::cout << finishBuf << std::endl;
	
	return 0;
}





int toggleNetwork()
{
	std::string netIsOn = getStdoutCmd("nmcli networking connectivity");
	
	std::string netInfo = getStdoutCmd("nmcli c show --active");
	std::size_t findInfo = netInfo.find("lo");
	
	if (netIsOn == "limited" || netIsOn == "full")
	{
		getStdoutCmd("nmcli networking off");
	}
	else
	{
		if (findInfo != std::string::npos)
		{
			getStdoutCmd("nmcli networking off");
			return 0;
		}
		getStdoutCmd("nmcli networking on");
	}
	
	return 0;
}


int main(int argc, char* argv[]) 
{
	if (argc > 1) {
		std::string switchArg = argv[1];
		
		if (switchArg == "--info")
		{
			getNetworkInfo();
			return 0;
		}
	}
	else
	{
		toggleNetwork();
		return 0;
	}
	
	return 0;
}
