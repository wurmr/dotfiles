-- Look & feel: xwayland, general, scrolling, group, decoration, animations, misc.

local c = require("mocha")

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.config({
	general = {
		layout = "scrolling",
		border_size = 3,
		col = {
			active_border = { colors = { c.mauve, c.flamingo }, angle = 90 },
			inactive_border = c.subtext0,
		},
		resize_on_border = true,
		gaps_in = 5,
		gaps_out = 7,
		-- See https://wiki.hypr.land/Configuring/Tearing/ before enabling this.
		allow_tearing = true,
	},
})

hl.config({
	scrolling = {
		column_width = 0.5,
		focus_fit_method = 1, -- 1 = fit, 0 = center
		follow_focus = true,
		explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
		direction = "right",
		fullscreen_on_one_column = true,
	},
})

hl.config({
	group = {
		insert_after_current = true,
		focus_removed_window = true,
		col = {
			border_active = c.green,
			border_inactive = c.lavender,
			border_locked_active = 0x66ff5500,
			border_locked_inactive = 0x66775500,
		},
		groupbar = {
			enabled = true,
			font_family = "JetBrainsMono Nerd Font",
			font_size = 10,
			gradients = true,
			height = 14,
			priority = 3,
			render_titles = true,
			scrolling = true,
			text_color = c.text,
			col = {
				active = c.surface1,
				inactive = c.surface0,
				locked_active = c.surface1,
				locked_inactive = c.surface0,
			},
		},
	},
})

hl.config({
	decoration = {
		rounding = 15,
		rounding_power = 2,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})

hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("linear", { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })

hl.animation({ leaf = "borderangle", enabled = true, speed = 50, bezier = "linear", style = "loop" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default", style = "slide" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "default", style = "popin" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })

hl.config({
	misc = {
		font_family = "JetBrainsMono Nerd Font",
		vrr = 2,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})
