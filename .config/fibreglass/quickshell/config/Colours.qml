pragma Singleton

import QtQuick
import Quickshell

Singleton {
	readonly property Colours palette: Colours {}

	component Colours: QtObject {
	
		readonly property string background: "#13140c"
		readonly property string error: "#ffb4ab"
		readonly property string error_container: "#93000a"
		readonly property string inverse_on_surface: "#313128"
		readonly property string inverse_primary: "#5c631d"
		readonly property string inverse_surface: "#e5e3d6"
		readonly property string on_background: "#e5e3d6"
		readonly property string on_error: "#690005"
		readonly property string on_error_container: "#ffdad6"
		readonly property string on_primary: "#2f3300"
		readonly property string on_primary_container: "#e1e993"
		readonly property string on_primary_fixed: "#1a1d00"
		readonly property string on_primary_fixed_variant: "#454b04"
		readonly property string on_secondary: "#30321a"
		readonly property string on_secondary_container: "#e4e5c1"
		readonly property string on_secondary_fixed: "#1b1d07"
		readonly property string on_secondary_fixed_variant: "#46492e"
		readonly property string on_surface: "#e5e3d6"
		readonly property string on_surface_variant: "#c8c7b7"
		readonly property string on_tertiary: "#07372d"
		readonly property string on_tertiary_container: "#beecdc"
		readonly property string on_tertiary_fixed: "#002019"
		readonly property string on_tertiary_fixed_variant: "#234e43"
		readonly property string outline: "#929282"
		readonly property string outline_variant: "#47483b"
		readonly property string primary: "#c5cc7a"
		readonly property string primary_container: "#454b04"
		readonly property string primary_fixed: "#e1e993"
		readonly property string primary_fixed_dim: "#c5cc7a"
		readonly property string scrim: "#000000"
		readonly property string secondary: "#c7c9a6"
		readonly property string secondary_container: "#46492e"
		readonly property string secondary_fixed: "#e4e5c1"
		readonly property string secondary_fixed_dim: "#c7c9a6"
		readonly property string shadow: "#000000"
		readonly property string source_color: "#eceadc"
		readonly property string surface: "#13140c"
		readonly property string surface_bright: "#3a3a31"
		readonly property string surface_container: "#202018"
		readonly property string surface_container_high: "#2a2a22"
		readonly property string surface_container_highest: "#35352d"
		readonly property string surface_container_low: "#1c1c14"
		readonly property string surface_container_lowest: "#0e0f08"
		readonly property string surface_dim: "#13140c"
		readonly property string surface_tint: "#c5cc7a"
		readonly property string surface_variant: "#47483b"
		readonly property string tertiary: "#a2d0c1"
		readonly property string tertiary_container: "#234e43"
		readonly property string tertiary_fixed: "#beecdc"
		readonly property string tertiary_fixed_dim: "#a2d0c1"
	}
}
