pragma Singleton

import QtQuick
import Quickshell

Singleton {
	readonly property Colours palette: Colours {}

	component Colours: QtObject {
	
		readonly property string background: "#0f1512"
		readonly property string error: "#ffb4ab"
		readonly property string error_container: "#93000a"
		readonly property string inverse_on_surface: "#2b322f"
		readonly property string inverse_primary: "#116b56"
		readonly property string inverse_surface: "#dee4e0"
		readonly property string on_background: "#dee4e0"
		readonly property string on_error: "#690005"
		readonly property string on_error_container: "#ffdad6"
		readonly property string on_primary: "#00382c"
		readonly property string on_primary_container: "#a3f2d8"
		readonly property string on_primary_fixed: "#002018"
		readonly property string on_primary_fixed_variant: "#005140"
		readonly property string on_secondary: "#1d352d"
		readonly property string on_secondary_container: "#cee9dd"
		readonly property string on_secondary_fixed: "#072019"
		readonly property string on_secondary_fixed_variant: "#344c43"
		readonly property string on_surface: "#dee4e0"
		readonly property string on_surface_variant: "#bfc9c3"
		readonly property string on_tertiary: "#0e3446"
		readonly property string on_tertiary_container: "#c4e7ff"
		readonly property string on_tertiary_fixed: "#001e2c"
		readonly property string on_tertiary_fixed_variant: "#284b5e"
		readonly property string outline: "#89938e"
		readonly property string outline_variant: "#3f4945"
		readonly property string primary: "#87d6bc"
		readonly property string primary_container: "#005140"
		readonly property string primary_fixed: "#a3f2d8"
		readonly property string primary_fixed_dim: "#87d6bc"
		readonly property string scrim: "#000000"
		readonly property string secondary: "#b2ccc2"
		readonly property string secondary_container: "#344c43"
		readonly property string secondary_fixed: "#cee9dd"
		readonly property string secondary_fixed_dim: "#b2ccc2"
		readonly property string shadow: "#000000"
		readonly property string source_color: "#535c58"
		readonly property string surface: "#0f1512"
		readonly property string surface_bright: "#343b38"
		readonly property string surface_container: "#1b211e"
		readonly property string surface_container_high: "#252b29"
		readonly property string surface_container_highest: "#303633"
		readonly property string surface_container_low: "#171d1a"
		readonly property string surface_container_lowest: "#090f0d"
		readonly property string surface_dim: "#0f1512"
		readonly property string surface_tint: "#87d6bc"
		readonly property string surface_variant: "#3f4945"
		readonly property string tertiary: "#a8cbe2"
		readonly property string tertiary_container: "#284b5e"
		readonly property string tertiary_fixed: "#c4e7ff"
		readonly property string tertiary_fixed_dim: "#a8cbe2"
	}
}
