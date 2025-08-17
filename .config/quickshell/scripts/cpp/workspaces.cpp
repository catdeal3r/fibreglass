#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>
#include <bits/stdc++.h>
#include <fstream>

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

int getWorkspaces()
{
	// Definition and initialization of buffer to hold final json.
	std::string buf = "[";
	
	// Get the current amount of workpaces -> Transfer into a std::vector for easy use
	std::vector<std::string> desks = {"1", "2", "3", "4", "5", "6", "7", "8"};
	
	// Get the desks/workspaces that are focused/occupied 
	std::string focusedDesk = getStdoutCmd("swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name' | head -c+1");
	std::string occupiedDesks = getStdoutCmd("swaymsg -t get_workspaces | jq -r '.[] | select(.nodes).name'");
	
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
	
	//buf.append("\"");
	//buf.append(focusedDesk);
	//buf.append("\"");
	
	buf.pop_back();
	buf.append("]");
	
	// Sends the json string to STD:OUT
	std::cout << buf << std::endl;
	return 0;
}


// Simple function to loop and wait through the above workspace function
int getWorkspacesLoop() 
{
	// Run it once to update sooner, making the workspaces not look so
	// weird
	getWorkspaces();
	
	while (true)
	{
		// Special command to wait until there's a movement of either:
		// - Changing of workspace focus
		// - Moving of windows to a different workspace
		
		// Also, content is captured by the getStdoutCmd() function to
		// not clog up the STD:OUT
		std::string tempWait = getStdoutCmd("swaymsg -t subscribe '[\"workspace\"]'");
		
		// After the workspace focus has changed/a window has moved
		// workspace, run the json workspace generator once.
		getWorkspaces();
	}
}

int main() 
{
	getWorkspacesLoop();
	return 0;
}
