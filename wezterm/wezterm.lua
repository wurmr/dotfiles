local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.keys = {
	-- pane splitting
	{ key = "\\", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

return config
