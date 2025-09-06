#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>
#include <fstream>
#include <bits/stdc++.h>

class Fibreglass
{
	// Private Function definitions
	std::vector<std::string> splitStr(std::string str, std::string spliter);
	std::string getStdoutCmd (std::string cmd);
	std::string readFile(std::string filePath);
	int getWorkspaces();
	
	// Generic help message
	std::string helpStr = R"(Usage: fb.out [OPTIONS]
Options:
	--getWorkspaces: Get the current workspaces' status.
	--getHelp: Show this message.
	--getBluetooth: Get information about the system's bluetooth status
	--toggleBluetooth: Toggle bluetooth on and off.
	--getBattery: Get information about the battery. Requires a second argument of either:
		- 0: Gets the battery scale's class name
		- 1: Gets the battery's icon's class name
		- 2: Gets the battery's icon.
)";

	public:
	
	// Public Function definitions	
	int getWorkspacesLoop();
	int getBluetoothInfo();
	int toggleBluetooth();
	int getBatteryInfo(std::string type);
	int getNetworkInfo();
	int toggleNetwork();
	
	// Help function
	int getHelp(std::string incorrStr)
	{
		if (incorrStr == "NULL") 
		{
			std::cout << helpStr;
			return 0;
		}
		else
		{
			std::cout << incorrStr << "\n\n" << helpStr;
			return 0;
		}
	}
};

// Splits a string into a std::vector based on a demiliter.
std::vector<std::string> Fibreglass::splitStr(std::string str, std::string spliter)
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
std::string Fibreglass::getStdoutCmd (std::string cmd)
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


int Fibreglass::getWorkspaces()
{
	// Definition and initialization of buffer to hold final json.
	std::string buf = "[";
	
	// Get the current amount of workpaces -> Transfer into a std::vector for easy use
	std::vector<std::string> desks = Fibreglass::splitStr(Fibreglass::getStdoutCmd("bspc query -D --names"), "\n");
	
	// There's a extra value of "\n" added into the vector, so we remove that.
	desks.pop_back();
	
	// Get the desks/workspaces that are focused/occupied 
	std::string focusedDesk = Fibreglass::getStdoutCmd("bspc query -D -d focused --names");
	std::string occupiedDesks = Fibreglass::getStdoutCmd("bspc query -D -d .occupied --names");
	
	// Cycle through each workpace
	for (auto oneDesk: desks)
	{
		// Add to the buffer
		buf.append("\"");
		
		// Find whether the currently loaded desk is occupied or focused 
		std::size_t findFocused = focusedDesk.find(oneDesk);
		std::size_t findOccupied = occupiedDesks.find(oneDesk);
		
		if (findFocused != std::string::npos)
		{
			// If it is, append the relevant code to the buffer
			buf.append("wsf");
		}
		else if (findOccupied != std::string::npos)
		{
			// Same as above.
			buf.append("wso");
		}
		else
		{
			buf.append("ws");
		}
		// Finish by closing with a '"' and a ','
		buf.append("\",");
	}
	
	// Removes the extra ',' at the end of the buffer, then closes
	// it with a ']'
	buf.pop_back();
	buf.append("]");
	
	// Sends the json string to STD:OUT
	std::cout << buf << std::endl;
	return 0;
}


std::string Fibreglass::readFile(std::string filePath)
{
	std::string buf;
	std::ifstream f(filePath);
	if (f.is_open())
	{	
		std::string s;
		while (getline(f, s))
		{
			buf += s + "\n";
		}
		f.close();				
	}
	else
	{
		std::cout << "Failed to open file: " + filePath + "\n";
	}
	
	buf.pop_back();
	
	return buf;
}


