-- Input, cursor, and per-device config.

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_rules = "",
		kb_options = "ctrl:nocaps",

		follow_mouse = 1,
		sensitivity = 1,
	},
})

hl.config({
	cursor = {
		no_hardware_cursors = true,
		use_cpu_buffer = true,
	},
})

-- ZSA Navigator (connects through the Voyager, hence the "voyager-touchpad" name).
hl.device({
	name = "zsa-technology-labs-voyager-touchpad",
	natural_scroll = true,
	clickfinger_behavior = true,
	scroll_method = "2fg",
	sensitivity = 0,
	scroll_factor = 0.25,
})
