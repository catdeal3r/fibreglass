
pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config
import qs.services

Singleton {
	id: root
	
	readonly property var weatherIcons: ({
            "113": "☀️",
            "116": "⛅",
            "119": "☁️",
            "122": "☁️",
            "143": "🌫️",
            "176": "🌦️",
            "179": "🌧️",
            "182": "🌧️",
            "185": "🌧️",
            "200": "⛈️",
            "227": "🌨️",
            "230": "❄️",
            "248": "🌫️",
            "260": "🌫️",
            "263": "🌧️",
            "266": "🌧️",
            "281": "🌧️",
            "284": "🌧️",
            "293": "🌧️",
            "296": "🌧️",
            "299": "🌧️",
            "302": "❄️",
            "305": "🌧️",
            "308": "❄️",
            "311": "🌧️",
            "314": "🌧️",
            "317": "🌧️",
            "320": "🌨️",
            "323": "🌨️",
            "326": "🌨️",
            "329": "❄️",
            "332": "❄️",
            "335": "❄️",
            "338": "❄️",
            "350": "🌧️",
            "353": "🌧️",
            "356": "🌧️",
            "359": "❄️",
            "362": "🌧️",
            "365": "🌧️",
            "368": "🌨️",
            "371": "❄️",
            "374": "🌧️",
            "377": "🌧️",
            "386": "⛈️",
            "389": "⛈️",
            "392": "⛈️",
            "395": "❄️"
        })
        
    property string location
    property string icon
    property string description
    property string temp
    
        
    function getWeatherIcon(code: string): string {
        if (weatherIcons.hasOwnProperty(code))
            return weatherIcons[code];
        return "🍃";
    }
    
    
    function reload(): void {
        if (Config.settings.weatherLocation)
            location = Config.settings.weatherLocation;
        else if (!location)
            location = "REPLACE"
    }
    
    onLocationChanged: Requests.get(`https://wttr.in/${location}?format=j1`, text => {
		if (location == "REPLACE") {
			root.icon = "❌"
			root.description = "No location set."
			root.temp = "Error."
		}
        const json = JSON.parse(text).current_condition[0];
        root.icon = root.getWeatherIcon(json.weatherCode);
        root.description = json.weatherDesc[0].value;
        root.temp = `${parseFloat(json.temp_C)}°C`;
    })
    
    Component.onCompleted: reload()
    
    Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: root.reload()
	}

}
