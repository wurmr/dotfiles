-- Input, cursor, and per-device config.

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_rules = "",
		kb_options = "ctrl:nocaps",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.config({
	cursor = {
		no_hardware_cursors = true,
		use_cpu_buffer = true,
	},
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
