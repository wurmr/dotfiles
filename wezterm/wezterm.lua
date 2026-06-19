local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- smart-splits.nvim integration: forward ctrl-hjkl to nvim when nvim is focused,
-- otherwise move between WezTerm panes
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = { h = "Left", j = "Down", k = "Up", l = "Right" }

local function split_nav(key)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({ SendKey = { key = key, mods = "CTRL" } }, pane)
			else
				win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
			end
		end),
	}
end

config.keys = {
	split_nav("h"),
	split_nav("j"),
	split_nav("k"),
	split_nav("l"),
	-- pane splitting
	{ key = "\\", mods = "CTRL|ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

return config
