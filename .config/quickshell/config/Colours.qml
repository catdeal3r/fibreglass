pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

	property var palette: jsonColoursContent

	FileView {
		id: jsonColoursSink
		path: `${Quickshell.configDir}/settings/colours.json`
		
		watchChanges: true
		onFileChanged: reload()
		
		onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }
        
        JsonAdapter {
			id: jsonColoursContent
			
			property string background: "#13140c"
			property string error: "#ffb4ab"
			property string error_container: "#93000a"
			property string inverse_on_surface: "#313128"
			property string inverse_primary: "#5c631d"
			property string inverse_surface: "#e5e3d6"
			property string on_background: "#e5e3d6"
			property string on_error: "#690005"
			property string on_error_container: "#ffdad6"
			property string on_primary: "#2f3300"
			property string on_primary_container: "#e1e993"
			property string on_primary_fixed: "#1a1d00"
			property string on_primary_fixed_variant: "#454b04"
			property string on_secondary: "#30321a"
			property string on_secondary_container: "#e4e5c1"
			property string on_secondary_fixed: "#1b1d07"
			property string on_secondary_fixed_variant: "#46492e"
			property string on_surface: "#e5e3d6"
			property string on_surface_variant: "#c8c7b7"
			property string on_tertiary: "#07372d"
			property string on_tertiary_container: "#beecdc"
			property string on_tertiary_fixed: "#002019"
			property string on_tertiary_fixed_variant: "#234e43"
			property string outline: "#929282"
			property string outline_variant: "#47483b"
			property string primary: "#c5cc7a"
			property string primary_container: "#454b04"
			property string primary_fixed: "#e1e993"
			property string primary_fixed_dim: "#c5cc7a"
			property string scrim: "#000000"
			property string secondary: "#c7c9a6"
			property string secondary_container: "#46492e"
			property string secondary_fixed: "#e4e5c1"
			property string secondary_fixed_dim: "#c7c9a6"
			property string shadow: "#000000"
			property string source_color: "#eceadc"
			property string surface: "#13140c"
			property string surface_bright: "#3a3a31"
			property string surface_container: "#202018"
			property string surface_container_high: "#2a2a22"
			property string surface_container_highest: "#35352d"
			property string surface_container_low: "#1c1c14"
			property string surface_container_lowest: "#0e0f08"
			property string surface_dim: "#13140c"
			property string surface_tint: "#c5cc7a"
			property string surface_variant: "#47483b"
			property string tertiary: "#a2d0c1"
			property string tertiary_container: "#234e43"
			property string tertiary_fixed: "#beecdc"
			property string tertiary_fixed_dim: "#a2d0c1"
		}
	}
}
