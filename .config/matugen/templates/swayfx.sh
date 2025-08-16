#!/bin/sh

swaymsg client.focused "{{colors.surface.default.hex}}" "{{colors.surface.default.hex}}" "{{colors.on_surface.default.hex}}" "{{colors.surface.default.hex}}"
swaymsg client.unfocused "{{colors.surface_container.default.hex}}" "{{colors.surface_container.default.hex}}" "{{colors.on_surface.default.hex}}" "{{colors.surface_container.default.hex}}"
swaymsg client.focused_inactive "{{colors.surface_container.default.hex}}" "{{colors.surface_container.default.hex}}" "{{colors.on_surface.default.hex}}" "{{colors.surface_container.default.hex}}"
swaymsg client.urgent "{{colors.surface.default.hex}}" "{{colors.surface.default.hex}}" "{{colors.on_surface.default.hex}}" "{{colors.surface.default.hex}}"
