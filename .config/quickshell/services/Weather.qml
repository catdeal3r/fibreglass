
pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

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
    property string icon: ""
    
        
    function getWeatherIcon(code: string): string {
        if (weatherIcons.hasOwnProperty(code))
            return weatherIcons[code];
        return "🍃";
    }
    
    
    function reload(): void {
        if (Config.settings.weatherLocation)
            location = Config.services.weatherLocation;
        else if (!location)
            Requests.get("https://ipinfo.io/json", text => {
                location = JSON.parse(text).loc ?? "";
                timer.restart();
        });
    }
    
    onLocationChanged: {
		
	}
}
